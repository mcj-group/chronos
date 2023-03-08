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

#include "main.h"
#include "../include/chronos.h"

typedef float float_t;

typedef struct Message {
   uint32_t i;
   uint32_t j;

   float_t logMu[2];
   float_t lookAhead[2];

} message_t;


float_t sensitivity;
uint32_t numV;
uint32_t numE;

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
float_t* dist;
uint32_t* edge_offset;
uint32_t* edge_neighbors;
message_t* messages;

void update_message_task(uint ts, uint mid) {

   float_t old_logMu[2];

   for (uint32_t it = 0; it < 2; it++) {
      old_logMu[it] = messages[mid].logMu[it];
      messages[mid].logMu[it] = messages[mid].lookAhead[it];
      undo_log_write((uint *) &(messages[mid].logMu[it]), *((uint *) (&old_logMu[it])));
   }

   for ddd {
      enq_task_arg2(REPRIORITIZE_TASK, ts + 1, mid_prop, *((uint *) &delta_logMu[0]), *((uint *) &delta_logMu[1]));
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

   update_ts = timestamp(mid);

   enq_task_arg0(UPDATE_MESSAGE_TASK, update_ts, mid);
}

int main() {
   chronos_init();

   // Dereference the pointers to array base addresses.
   // ( The '<<2' is because graph_gen writes the word number, not the byte)
   dist = (float*) ((*(uint32_t *) (ADDR_BASE_DIST))<<2) ;
   edge_offset  =(uint32_t*) ((*(int *)(ADDR_BASE_EDGE_OFFSET))<<2) ;
   edge_neighbors  =(uint32_t*) ((*(int *)(ADDR_BASE_NEIGHBORS))<<2) ;

   for (uint32_t i = 0; i < num_messages; i++) {
      enq_task_arg0(INITIALIZE_TASK, 0, i); // initialize task calculates initial lookaheads for each message
   }

   // Dereference the pointers to array base addresses.
   // ( The '<<2' is because graph_gen writes the word number, not the byte)

   while (1) {
      uint32_t ttype, ts, object; 
      double arg0, arg1, arg2, arg3;
      deq_task_arg4(&ttype, &ts, &object, &arg0, &arg1, &arg2, &arg3);
      switch(ttype){
         case PRIORITIZE_TASK:
            prioritize_task(ts, (message_id) object);
            break;
         case FETCH_REVERSE_LOG_MU_0_TASK:
            fetch_reverse_log_mu_0_task(ts, (message_id) object, (message_id) arg0);
            break;
         case FETCH_LOG_PRODUCT_IN_0_TASK:
            fetch_log_product_in_0_task(ts, (node_id) object, (double) arg0, (message_id) arg1, (message_id) arg2);
            break;
         case FETCH_REVERSE_LOG_MU_1_TASK:
            fetch_reverse_log_mu_1_task(ts, (message_id) object, (double) arg0, arg1, (message_id) arg2);
            break;
         case FETCH_LOG_PRODUCT_IN_1_TASK:
            fetch_log_product_in_1_task(ts, (node_id) object, (double) arg0, (double) arg1, (message_id) arg2);
            break;
         case UPDATE_LOOKAHEAD_TASK:
            update_look_ahead_task(ts, (message_id) object, (double) arg0, (double) arg1);
            break;
         case ENQUEUE_UPDATE_TASK:
            enqueue_update_task(ts, (message_id) object, (double) arg0, (double) arg1);
            break;
         case UPDATE_TASK:
            update_task(ts, (message_id) object, (double) arg0, (double) arg1);
            break;
         case UPDATE_MESSAGE_TASK:
            update_message_task(ts, (message_id) object, (double) arg0, (double) arg1);
            break;
         case UPDATE_LOG_PRODUCT_IN_TASK:
            update_log_product_in_task(ts, (node_id) object, (double) arg0, (double) arg1, (double) arg2, (double) arg3);
            break;
         case PROPAGATE_TASK:
            propagate_task(ts, (node_id) object);
            break;
         default:
            return;
            break;
      }

      finish_task();
   }
}

