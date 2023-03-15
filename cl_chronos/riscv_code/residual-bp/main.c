/** $lic$
 * Copyright (C) 2014-2019 by Massachusetts Institute of Technology
 *
 * This file is part of the Chronos FPGA Acceleration Framework.
 *
 * Chronos is free software; you can redistribute it and/or modify it under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation, version 2.
 *
 * If you use this framework in your research, we request that you reference
 * the Chronos paper ("Chronos: Efficient Speculative Parallelism for
 * Accelerators", Abeydeera and Sanchez, ASPLOS-25, March 2020), and that
 * you send us a citation of your work.
 *
 * Chronos is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <math.h>
#include "../include/chronos.h"

#define UINT32_MAX		      (4294967295U)

#define INIT_TASK             0
#define REPRIORITIZE_TASK     1
#define UPDATE_MESSAGE_TASK   2

typedef float float_t;

typedef struct Message {
   uint32_t i;
   uint32_t j;

   float_t logMu[2];
   float_t lookAhead[2];

} message_t;

typedef struct Node {
   float_t logNodePotentials[2];
} node_t;

typedef struct Edge {
   float_t logPotentials[4];
} edge_t;

uint32_t *data;

float_t sensitivity;
uint32_t numV;
uint32_t numE;
uint32_t numM;

uint32_t BASE_EDGE_INDICES;
uint32_t BASE_EDGE_DEST;
uint32_t BASE_EDGES;
uint32_t BASE_REVERSE_EDGE_INDICES;
uint32_t BASE_REVERSE_EDGE_DEST;
uint32_t BASE_REVERSE_EDGE_ID;
uint32_t BASE_NODES;
uint32_t BASE_MESSAGES;
uint32_t BASE_CONVERGED;

uint32_t BASE_END;

// CSR format of RBP graph
uint32_t *edge_indices;
uint32_t *edge_dest;
uint32_t *reverse_edge_indices;
uint32_t *reverse_edge_dest;
uint32_t *reverse_edge_id;
message_t *messages;
edge_t *edges;
node_t *nodes;
message_t *converged_messages;

uint32_t timestamp(float_t dist) {
   uint32_t SCALING_FACTOR = 1 << 29;
   float_t scaled = dist * SCALING_FACTOR;
   uint32_t ts = UINT32_MAX - 8 - ((uint32_t) scaled);
   return ts;
}

float_t distance(float_t *log1, float_t *log2) {
   float_t ans = 0.0;
   for (uint32_t i = 0; i < 2; i++) {
      ans += abs(exp(log1[i]) - exp(log2[i]));
   }
   return ans;
}

void init_task(uint ts, uint mid) {
   float_t residual = distance(messages[mid].logMu, messages[mid].lookAhead);

   if (residual > sensitivity) {
      uint update_ts = timestamp(residual);

      enq_task_arg2(UPDATE_MESSAGE_TASK, update_ts, mid, 
                  *((uint *) &(messages[mid].lookAhead[0])), 
                  *((uint *) &(messages[mid].lookAhead[1]))
                  );
   }
}

void update_message_task(uint ts, uint mid,  uint enqueued_lookAhead_0, uint enqueued_lookAhead_1) {
   // check if enqueued version is the latest
   float_t enqueued_lookAhead[2];
   enqueued_lookAhead[0] = *((float_t *) &enqueued_lookAhead_0);
   enqueued_lookAhead[1] = *((float_t *) &enqueued_lookAhead_1);
   if ((messages[mid].lookAhead[0] != enqueued_lookAhead[0]) || (messages[mid].lookAhead[1] != enqueued_lookAhead[1])) {
      // not most up-to-date copy of update task
      return;
   }

   // update logMu
   float_t old_logMu[2];

   old_logMu[0] = messages[mid].logMu[0];
   messages[mid].logMu[0] = enqueued_lookAhead[0];
   undo_log_write((uint *) &(messages[mid].logMu[0]), *((uint *) (&old_logMu[0])));

   old_logMu[1] = messages[mid].logMu[1];
   messages[mid].logMu[1] = enqueued_lookAhead[1];
   undo_log_write((uint *) &(messages[mid].logMu[1]), *((uint *) (&old_logMu[1])));

   // calculate change in logMu for propagation
   float_t delta_logMu[2];
   delta_logMu[0] = messages[mid].logMu[0] - old_logMu[0];
   delta_logMu[1] = messages[mid].logMu[1] - old_logMu[1];

   // propagate 
   uint32_t j = messages[mid].j;
   uint32_t CSR_position = edge_indices[j];
   uint32_t CSR_end = edge_indices[j + 1];
   uint32_t CSC_position = reverse_edge_indices[j];
   uint32_t CSC_end = reverse_edge_indices[j + 1];
   
   uint32_t affected_mid = 0;
   while ((CSR_position < CSR_end) || (CSC_position < CSC_end)) {
      if (CSR_position < CSR_end) {
         affected_mid = CSR_position * 2;
         CSR_position++;
      } else {
         affected_mid = reverse_edge_id[CSC_position] * 2 + 1;
         CSC_position++;
      }
      enq_task_arg2(REPRIORITIZE_TASK, ts + 1, affected_mid, *((uint *) &delta_logMu[0]), *((uint *) &delta_logMu[1]));
   }
}

void reprioritize_task(uint ts, uint mid, uint delta_logMu_0, uint delta_logMu_1) {
   
   float_t old_lookAhead[2];
   uint update_ts;

   old_lookAhead[0] = messages[mid].lookAhead[0];
   messages[mid].lookAhead[0] = old_lookAhead[0] + *((float_t *) &delta_logMu_0);
   undo_log_write((uint *) &(messages[mid].lookAhead[0]), *((uint *) (&old_lookAhead[0])));

   old_lookAhead[1] = messages[mid].lookAhead[1];
   messages[mid].lookAhead[0] = old_lookAhead[1] + *((float_t *) &delta_logMu_1);
   undo_log_write((uint *) &(messages[mid].lookAhead[1]), *((uint *) (&old_lookAhead[1])));

   float_t residual = distance(messages[mid].logMu, messages[mid].lookAhead);

   if (residual > sensitivity) {
      update_ts = timestamp(residual);

      enq_task_arg2(UPDATE_MESSAGE_TASK, update_ts, mid, 
                  *((uint *) &(messages[mid].lookAhead[0])), 
                  *((uint *) &(messages[mid].lookAhead[1]))
                  );
   }
}

int main() {
   chronos_init();

   data = 0;

   // Extract base addresses from input file
   numV = data[0];
   numE = data[1];
   numM = 2 * numE;
   BASE_EDGE_INDICES = data[3];
   BASE_EDGE_DEST = data[4];
   BASE_EDGES = data[5];
   BASE_REVERSE_EDGE_INDICES = data[6];
   BASE_REVERSE_EDGE_DEST = data[7];
   BASE_REVERSE_EDGE_ID = data[8];
   BASE_NODES = data[9];
   BASE_MESSAGES = data[10];
   BASE_CONVERGED = data[11];
   sensitivity = *((float *) (&data[12]));
   BASE_END = data[12];

   // Dereference the pointers to array base addresses.
   edge_indices = &data[BASE_EDGE_INDICES];
   edge_dest = &data[BASE_EDGE_DEST];
   reverse_edge_indices = &data[BASE_REVERSE_EDGE_INDICES];
   reverse_edge_dest = &data[BASE_REVERSE_EDGE_DEST];
   reverse_edge_id = &data[BASE_REVERSE_EDGE_ID];
   messages = (message_t *) &data[BASE_MESSAGES];
   edges = (edge_t *) &data[BASE_EDGES];
   nodes = (node_t *) &data[BASE_NODES];
   converged_messages = (message_t *) &data[BASE_CONVERGED];

   for (uint32_t i = 0; i < numM; i++) {
      enq_task_arg0(INIT_TASK, 0, i); // initialize task calculates initial lookaheads for each message
   }
   // Dereference the pointers to array base addresses.
   // ( The '<<2' is because graph_gen writes the word number, not the byte)

   while (1) {
      uint ttype, ts, object; 
      uint arg0, arg1;
      deq_task_arg2(&ttype, &ts, &object, &arg0, &arg1);
      switch(ttype){
         case INIT_TASK:
            init_task(ts, object);
            break;
         case REPRIORITIZE_TASK:
            reprioritize_task(ts, object, arg0, arg1);
            break;
         case UPDATE_MESSAGE_TASK:
            update_message_task(ts, object, arg0, arg1);
            break;
         default:
            break;
      }

      finish_task();
   }
}

