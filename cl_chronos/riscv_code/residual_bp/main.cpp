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

// CSR format of RBP graph
uint32_t numV;
uint32_t numE;
float_t sensitivity;

uint32_t *edge_indices;
uint32_t *edge_dest;
uint32_t *reverse_edge_indices;
uint32_t *reverse_edge_dest;
uint32_t *reverse_edge_id;
message_t *messages;
message_t *converged_messages;
node_t *nodes;
edge_t *edges;

void create_graph_from_file() {
   // Dereference the pointers to array base addresses.
   numE = *(reinterpret_cast<uint32_t*> (ADDR_BASE_NUME));
   edge_indices = reinterpret_cast<uint32_t*> ((*(reinterpret_cast<uint32_t*> (ADDR_BASE_EDGE_INDICES))) << 2);
   edge_dest = reinterpret_cast<uint32_t*> ((*(reinterpret_cast<uint32_t*> (ADDR_BASE_EDGE_DEST))) << 2);
   reverse_edge_indices = reinterpret_cast<uint32_t*> ((*(reinterpret_cast<uint32_t*> (ADDR_BASE_REVERSE_EDGE_INDICES))) << 2);
   reverse_edge_dest = reinterpret_cast<uint32_t*> ((*(reinterpret_cast<uint32_t*> (ADDR_BASE_REVERSE_EDGE_DEST))) << 2);
   reverse_edge_id = reinterpret_cast<uint32_t*> ((*(reinterpret_cast<uint32_t*> (ADDR_BASE_REVERSE_EDGE_ID))) << 2);
   messages = reinterpret_cast<message_t*> ((*(reinterpret_cast<uint32_t*> (ADDR_BASE_MESSAGES))) << 2);
   converged_messages = reinterpret_cast<message_t*> ((*(reinterpret_cast<uint32_t*> (ADDR_BASE_CONVERGED_MESSAGES))) << 2);
   nodes = reinterpret_cast<node_t*> ((*(reinterpret_cast<uint32_t*> (ADDR_BASE_NODES))) << 2);
   edges = reinterpret_cast<edge_t*> ((*(reinterpret_cast<uint32_t*> (ADDR_BASE_EDGES))) << 2);
   sensitivity = *(reinterpret_cast<float_t*> (ADDR_BASE_SENSITIVITY));
}

void init_task(uint ts) {
   for (uint32_t i = 0; i < 2 * numE; i++) {
      enq_task_arg0(PRIORITIZE_TASK, ts + 1, i);
   }
}

void prioritize_task(uint ts, uint m_id) {
   message_t *m = &messages[m_id];
   uint32_t i = m->i;

   uint32_t r_m_id = getReverseMessage(m_id);

   enq_task_arg1(FETCH_REVERSE_LOGMU_TASK, ts+1, r_m_id, m_id); // reverseLogMu and enqueue write to buffer task
   enq_task_arg1(FETCH_LOGPRODUCTIN_TASK, ts+1, i + (2 * numE), m_id); // fetch logProductIn and enqueue write to buffer task
   enq_task_arg0(UPDATE_PRIORITY_TASK, ts+3, m_id); // update lookAhead and enqueue update task
}

void fetch_reverse_logmu_task(uint ts, uint r_m_id, uint m_id) {
   message_t *r_m = &messages[r_m_id];

   // fetch reverse logMu
   float_t reverseLogMu[2];
   reverseLogMu[0] = r_m->logMu[0];
   reverseLogMu[1] = r_m->logMu[1];

   // enqueue write to buffer task
   enq_task_arg2(WRITE_REVERSE_LOGMU_TASK, ts+1, m_id, *(reinterpret_cast<uint*> (&reverseLogMu[0])), *(reinterpret_cast<uint*> (&reverseLogMu[1])));
}

void write_reverse_logmu_task(uint ts, uint m_id, uint reverseLogMu0, uint reverseLogMu1) {
   message_t *m = &messages[m_id];

   // undo log write
   undo_log_write(reinterpret_cast<uint*> (&(m->reverseLogMu[0])), *(reinterpret_cast<uint*> (&(m->reverseLogMu[0]))));
   undo_log_write(reinterpret_cast<uint*> (&(m->reverseLogMu[1])), *(reinterpret_cast<uint*> (&(m->reverseLogMu[1]))));

   // update reverseLogMu
   m->reverseLogMu[0] = *(reinterpret_cast<float_t*> (&reverseLogMu0));
   m->reverseLogMu[1] = *(reinterpret_cast<float_t*> (&reverseLogMu1));
}

void fetch_logproductin_task(uint ts, uint i_id, uint m_id) {
   uint32_t i = i_id - (2 * numE);

   node_t *n = &nodes[i];

   // fetch logProductIn
   float_t logProductIn[2];
   logProductIn[0] = n->logProductIn[0];
   logProductIn[1] = n->logProductIn[1];

   // enqueue write to buffer task
   enq_task_arg2(WRITE_LOGPRODUCTIN_TASK, ts+1, m_id, *(reinterpret_cast<uint*> (&logProductIn[0])), *(reinterpret_cast<uint*> (&logProductIn[1])));
}

void write_logproductin_task(uint ts, uint m_id, uint logProductIn0, uint logProductIn1) {
   message_t *m = &messages[m_id];

   // undo log write
   undo_log_write(reinterpret_cast<uint*> (&(m->logProductIn[0])), *(reinterpret_cast<uint*> (&(m->logProductIn[0]))));
   undo_log_write(reinterpret_cast<uint*> (&(m->logProductIn[1])), *(reinterpret_cast<uint*> (&(m->logProductIn[1]))));

   // update logProductIn
   m->logProductIn[0] = *(reinterpret_cast<float_t*> (&logProductIn0));
   m->logProductIn[1] = *(reinterpret_cast<float_t*> (&logProductIn1));
}

void update_priority_task(uint ts, uint m_id) {
   uint update_ts;
   message_t *m = &messages[m_id];
   edge_t *e = &edges[m_id/2];

   uint32_t i = m->i;
   node_t *n = &nodes[i];

   float_t lookAhead[2];

   uint8_t forward;
   if (m_id % 2 == 0) {
      forward = 1;
   } else {
      forward = 0;
   }

   if (forward == 1) {
      for (uint32_t valj = 0; valj < 2; valj++) {
         float_t logsIn[2];
         for (uint32_t vali = 0; vali < 2; vali++) {
            logsIn[vali] = e->logPotentials[vali][valj]
                     + n->logNodePotentials[vali]
                     + (m->logProductIn[vali] - m->reverseLogMu[vali]);
         }
         lookAhead[valj] = logSum(logsIn[0], logsIn[1]);
      }
   } else {
      for (uint32_t valj = 0; valj < 2; valj++) {
         float_t logsIn[2];
         for (uint32_t vali = 0; vali < 2; vali++) {
            logsIn[vali] = e->logPotentials[valj][vali]
                     + n->logNodePotentials[vali]
                     + (m->logProductIn[vali] - m->reverseLogMu[vali]);
         }
         lookAhead[valj] = logSum(logsIn[0], logsIn[1]);
      }
   }
   float_t logTotalSum = logSum(lookAhead[0], lookAhead[1]);

   // normalization
   for (uint32_t valj = 0; valj < 2; valj++) {
      lookAhead[valj] -= logTotalSum;
   }

   float_t residual = distance(m->logMu, lookAhead);

   if (residual > sensitivity) {
      update_ts = timestamp(residual);
      
      if (update_ts > ts) {
         undo_log_write(reinterpret_cast<uint*> (&(m->enqueued_ts)), m->enqueued_ts);
         m->enqueued_ts = update_ts;
         enq_task_arg2(UPDATE_MESSAGE_TASK, update_ts, m_id, *(reinterpret_cast<uint*> (&(lookAhead[0]))), *(reinterpret_cast<uint*> (&(lookAhead[1]))));
      } else {
         undo_log_write(reinterpret_cast<uint*> (&(m->enqueued_ts)), m->enqueued_ts);
         m->enqueued_ts = ts + 1;
         enq_task_arg2(UPDATE_MESSAGE_TASK, ts + 1, m_id, *(reinterpret_cast<uint*> (&(lookAhead[0]))), *(reinterpret_cast<uint*> (&(lookAhead[1]))));
      }
   }
}

void update_message_task(uint ts, uint m_id, uint lookAhead0, uint lookAhead1) {
   message_t *m = &messages[m_id];
   // check if enqueued version is the latest
   if (m->enqueued_ts != ts) {
      // not most up-to-date copy of update task
      return;
   }

   // update logProductIn
   float_t diff[2];
   diff[0] = *(reinterpret_cast<float_t*> (&lookAhead0)) - m->logMu[0];
   diff[1] = *(reinterpret_cast<float_t*> (&lookAhead1)) - m->logMu[1];
   enq_task_arg2(UPDATE_LOGPRODUCTIN_TASK, ts+1, (m->j) + (2 * numE), *(reinterpret_cast<uint*> (&diff[0])), *(reinterpret_cast<uint*> (&diff[1])));

   // update logMu
   undo_log_write(reinterpret_cast<uint*> (&(m->logMu[0])), *(reinterpret_cast<uint*> (&(m->logMu[0]))));
   undo_log_write(reinterpret_cast<uint*> (&(m->logMu[1])), *(reinterpret_cast<uint*> (&(m->logMu[1]))));

   float lookAhead[2];
   lookAhead[0] = *(reinterpret_cast<float_t*> (&lookAhead0));
   lookAhead[1] = *(reinterpret_cast<float_t*> (&lookAhead1));

   m->logMu[0] = lookAhead[0];
   m->logMu[1] = lookAhead[1];

   // propagate -> enqueue new prioritize tasks (ts + 1) id = affected_mid
   uint32_t j = m->j;
   uint32_t CSR_position = edge_indices[j];
   uint32_t CSR_end = edge_indices[j + 1];
   uint32_t CSC_position = reverse_edge_indices[j];
   uint32_t CSC_end = reverse_edge_indices[j + 1];
   uint32_t affected_mid = 0;

   uint32_t reverse_mid;

   if (m_id % 2 == 0) {
      reverse_mid = m_id + 1;
   } else {
      reverse_mid = m_id - 1;
   }

   while ((CSR_position < CSR_end) || (CSC_position < CSC_end)) {
      if (CSR_position < CSR_end) {
         affected_mid = CSR_position * 2;
         CSR_position++;
      } else {
         affected_mid = reverse_edge_id[CSC_position] * 2 + 1;
         CSC_position++;
      }
      if (affected_mid != reverse_mid) {
         enq_task_arg0(PRIORITIZE_TASK, ts + 1, affected_mid);
      }
   }
}

void update_logproductin_task(uint ts, uint j_id, uint diff0, uint diff1) {
   uint32_t j = j_id - (2 * numE);
   node_t *n = &nodes[j];
   float_t diff[2];
   diff[0] = *(reinterpret_cast<float_t*> (&diff0));
   diff[1] = *(reinterpret_cast<float_t*> (&diff1));

   undo_log_write(reinterpret_cast<uint*> (&(n->logProductIn[0])), *(reinterpret_cast<uint*> (&(n->logProductIn[0]))));
   undo_log_write(reinterpret_cast<uint*> (&(n->logProductIn[1])), *(reinterpret_cast<uint*> (&(n->logProductIn[1]))));
   n->logProductIn[0] += diff[0];
   n->logProductIn[1] += diff[1];
}

int main() {
   chronos_init();

   create_graph_from_file();

   while (1) {
      uint ttype, ts, object;
      uint arg0, arg1;
      deq_task_arg2(&ttype, &ts, &object, &arg0, &arg1);
      switch(ttype){
         case INIT_TASK:
            init_task(ts);
            break;
         case PRIORITIZE_TASK:
            prioritize_task(ts, object);
            break;
         case FETCH_REVERSE_LOGMU_TASK:
            fetch_reverse_logmu_task(ts, object, arg0);
            break;
         case WRITE_REVERSE_LOGMU_TASK:
            write_reverse_logmu_task(ts, object, arg0, arg1);
            break;
         case FETCH_LOGPRODUCTIN_TASK:
            fetch_logproductin_task(ts, object, arg0);
            break;
         case WRITE_LOGPRODUCTIN_TASK:
            write_logproductin_task(ts, object, arg0, arg1);
            break;
         case UPDATE_PRIORITY_TASK:
            update_priority_task(ts, object);
            break;
         case UPDATE_MESSAGE_TASK:
            update_message_task(ts, object, arg0, arg1);
            break;
         case UPDATE_LOGPRODUCTIN_TASK:
            update_logproductin_task(ts, object, arg0, arg1);
            break;
         default:
            break;
      }

      finish_task();
   }
}