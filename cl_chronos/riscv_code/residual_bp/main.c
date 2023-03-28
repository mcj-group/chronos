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

#include "../include/chronos.h"

#define UINT32_MAX		      (4294967295U)

#define INIT_TASK             0
#define ENQUEUE_UPDATE_TASK   1
#define REPRIORITIZE_TASK     2
#define UPDATE_MESSAGE_TASK   3
#define DUMMY_TASK            4

typedef float float_t;

typedef struct Message {
   uint32_t i;
   uint32_t j;

   float_t logMu[2];
   float_t lookAhead[2];

   uint32_t padding[2]; // padding for cache line alignment

} message_t;

// The location pointing to the base of each of the arrays
const int ADDR_BASE_NUMV = 1 << 2;
const int ADDR_BASE_NUME = 2 << 2;
const int ADDR_BASE_EDGE_INDICES = 3 << 2;
const int ADDR_BASE_EDGE_DEST = 4 << 2;
const int ADDR_BASE_REVERSE_EDGE_INDICES = 5 << 2;
const int ADDR_BASE_REVERSE_EDGE_DEST = 6 << 2;
const int ADDR_BASE_REVERSE_EDGE_ID = 7 << 2;
const int ADDR_BASE_MESSAGES = 8 << 2;
const int ADDR_BASE_SENSITIVITY = 10 << 2;

// CSR format of RBP graph
uint32_t numE;
float_t sensitivity;

uint32_t *edge_indices;
uint32_t pad;
uint32_t pad0;
uint32_t *edge_dest;
uint32_t *reverse_edge_indices;
uint32_t *reverse_edge_dest;
uint32_t *reverse_edge_id;
message_t *messages;

extern inline uint32_t timestamp(float_t dist) {
   uint32_t SCALING_FACTOR = 1 << 29;
   float_t scaled = dist * SCALING_FACTOR;
   uint32_t ts = UINT32_MAX - 8 - ((uint32_t) scaled);
   return ts;
}

extern inline float_t absval(float_t a) {
   if (a < 0) {
      return -a;
   } else {
      return a;
   }
}

extern inline float_t distance(float_t *log1, float_t *log2) {
   float_t ans = 0.0;
   ans += absval(log1[0] - log2[0]);
   ans += absval(log1[1] - log2[1]);
   return ans;
}

void init_task(uint ts) {
   // enq_task_arg0(DUMMY_TASK, 0xffffffff, (uint) numE);
   // enq_task_arg0(DUMMY_TASK, 0xfffffffe, (uint) edge_indices);
   // enq_task_arg0(DUMMY_TASK, 0xfffffffe, (uint) edge_dest);
   // enq_task_arg0(DUMMY_TASK, 0xffffffff, (uint) reverse_edge_indices);
   // enq_task_arg0(DUMMY_TASK, 0xffffffff, (uint) reverse_edge_dest);
   // enq_task_arg0(DUMMY_TASK, 0xffffffff, (uint) reverse_edge_id);
   // enq_task_arg0(DUMMY_TASK, 0xffffffff, (uint) messages);
   // enq_task_arg0(DUMMY_TASK, 0xffffffff, (uint) sensitivity);

   for (uint32_t i = 0; i < 2 * numE; i++) {
      enq_task_arg0(ENQUEUE_UPDATE_TASK, ts + i + 1, i);
   }
}

void enqueue_update_task(uint ts, uint mid) {
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
   // enq_task_arg0(DUMMY_TASK, ts + 1, (uint) edge_indices);
   // enq_task_arg0(DUMMY_TASK, ts + 1, j);
   // enq_task_arg0(DUMMY_TASK, ts + 1, CSR_position);
   // enq_task_arg0(DUMMY_TASK, ts + 1, CSR_end);
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
   messages[mid].lookAhead[1] = old_lookAhead[1] + *((float_t *) &delta_logMu_1);
   undo_log_write((uint *) &(messages[mid].lookAhead[1]), *((uint *) (&old_lookAhead[1])));

   float_t residual = distance(messages[mid].logMu, messages[mid].lookAhead);

   if (residual > sensitivity) {
      update_ts = timestamp(residual);

      if (update_ts > ts) {
         enq_task_arg2(UPDATE_MESSAGE_TASK, update_ts, mid, 
                  *((uint *) &(messages[mid].lookAhead[0])), 
                  *((uint *) &(messages[mid].lookAhead[1]))
                  );
      } else {
         enq_task_arg2(UPDATE_MESSAGE_TASK, ts + 1, mid, 
                  *((uint *) &(messages[mid].lookAhead[0])), 
                  *((uint *) &(messages[mid].lookAhead[1]))
                  );
      }
   }
}

int main() {
   chronos_init();

   // Dereference the pointers to array base addresses.
   numE = *((uint32_t *) (ADDR_BASE_NUME));
   edge_indices = (uint32_t *) ((*((uint32_t *) (ADDR_BASE_EDGE_INDICES))) << 2);
   edge_dest = (uint32_t *) ((*((uint32_t *) (ADDR_BASE_EDGE_DEST))) << 2);
   reverse_edge_indices = (uint32_t *) ((*((uint32_t *) (ADDR_BASE_REVERSE_EDGE_INDICES))) << 2);
   reverse_edge_dest = (uint32_t *) ((*((uint32_t *) (ADDR_BASE_REVERSE_EDGE_DEST))) << 2);
   reverse_edge_id = (uint32_t *) ((*((uint32_t *) (ADDR_BASE_REVERSE_EDGE_ID))) << 2);
   messages = (message_t *) ((*((uint32_t *) (ADDR_BASE_MESSAGES))) << 2);
   sensitivity = *((float_t *) (ADDR_BASE_SENSITIVITY));

   while (1) {
      uint ttype, ts, object; 
      uint arg0, arg1;
      deq_task_arg2(&ttype, &ts, &object, &arg0, &arg1);
      switch(ttype){
         case INIT_TASK:
            init_task(ts);
            break;
         case ENQUEUE_UPDATE_TASK:
            enqueue_update_task(ts, object);
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