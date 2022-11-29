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

#include <array>
#include <stdint.h>
#include "main_rbp.h"

double sensitivity;
MRF_CSR* mrf;

void prioritize_task(uint64_t ts, message_id m_id) {
   message_id reverse_m_id = mrf->getReverseMessage(m_id);
   enq_task_arg1(FETCH_REVERSE_LOG_MU_0_TASK, ts, (uint64_t) reverse_m_id, (double) m_id);
}

void fetch_reverse_log_mu_0_task(uint64_t ts, message_id reverse_m_id, message_id m_id) {
   double reverse_log_mu_0 = mrf->getMessageVal(reverse_m_id)[0];
   node_id dest = mrf->getDest(m_id);
   enq_task_arg3(FETCH_LOG_PRODUCT_IN_0_TASK, ts, (uint64_t) dest, (double) reverse_log_mu_0, (double) reverse_m_id, (double) m_id);
   return;
}

void fetch_log_product_in_0_task(uint64_t ts, node_id dest, double reverse_log_mu_0, message_id reverse_m_id, message_id m_id) {
   double log_product_in_0 = mrf->getLogProductIn(dest)[0];
   double difference_0 = log_product_in_0 - reverse_log_mu_0;
   enq_task_arg3(FETCH_REVERSE_LOG_MU_1_TASK, ts, (uint64_t) reverse_m_id, (double) difference_0, (double) dest, (double) m_id);
   return;
}

void fetch_reverse_log_mu_1_task(uint64_t ts, message_id reverse_m_id, double difference_0, node_id dest, message_id m_id) {
   double reverse_log_mu_1 = mrf->getMessageVal(reverse_m_id)[1];
   enq_task_arg3(FETCH_LOG_PRODUCT_IN_1_TASK, ts, (uint64_t) dest, (double) difference_0, (double) reverse_log_mu_1, (double) m_id);
   return;
}

void fetch_log_product_in_1_task(uint64_t ts, node_id dest, double difference_0, double reverse_log_mu_1, message_id m_id) {
   double log_product_in_1 = mrf->getLogProductIn(dest)[1];
   double difference_1 = log_product_in_1 - reverse_log_mu_1;
   enq_task_arg2(UPDATE_LOOKAHEAD_TASK, ts, (uint64_t) m_id, (double) difference_0, (double) difference_1);
   return;
}

void update_look_ahead_task(uint64_t ts, message_id m_id, double difference_0, double difference_1) {
   Edge *e = mrf->getEdge(m_id/2);
   node_id src = mrf->getSource(m_id);
   Node *n = mrf->getNode(src);

   bool forward;
   if (m_id % 2 == 0) {
      forward = true;
   } else {
      forward = false;
   }

   std::array<double,LENGTH> result;
   for (uint64_t valj = 0; valj < LENGTH; valj++) {
      std::array<double,LENGTH> logsIn;
      logsIn[0] = e->getLogPotential(forward, 0, valj) + n->logNodePotentials[0] + difference_0;
      logsIn[1] = e->getLogPotential(forward, 1, valj) + n->logNodePotentials[1] + difference_1;
      result[valj] = utils::logSum(logsIn);
   }
   double logTotalSum = utils::logSum(result);

   // normalization
   for (uint64_t valj = 0; valj < LENGTH; valj++) {
      result[valj] -= logTotalSum;
   }

   // record in undo log
   Message* m = mrf->getMessage(m_id);
   undo_log_write((uint64_t *) &(m->lookAhead[0]), m->lookAhead[0]);
   undo_log_write((uint64_t *) &(m->lookAhead[1]), m->lookAhead[1]);

   // update lookahead
   mrf->updateLookAhead(m_id, result);

   enq_task_arg2(ENQUEUE_UPDATE_TASK, ts, (uint64_t) m_id, (double) result[0], (double) result[1]);
   return;
}

void enqueue_update_task(uint64_t ts, message_id m_id, double result_0, double result_1) {
   // calculate priority
   std::array<double,LENGTH> result;
   result[0] = result_0;
   result[1] = result_1;
   double priority = utils::distance(result, mrf->getMessageVal(m_id));

   if (priority < sensitivity) {
      return;
   }

   uint64_t update_ts = timeline(priority);

   enq_task_arg2(UPDATE_TASK, update_ts, (uint64_t) m_id, (double) result_0, (double) result_1);
   return;
}

uint64_t timeline(double priority) {
   assert(priority > 0.0 && priority <= 1.0);
   constexpr uint64_t SCALING_FACTOR = 1ul << 61;
   double scaled = priority * SCALING_FACTOR;
   return UINT64_MAX - 8 - static_cast<uint64_t>(scaled);
}

void update_task(uint64_t ts, message_id m_id, double result_0, double result_1) {
   std::array<double,LENGTH> new_log_mu = mrf->getLookAhead(m_id);
   if ((new_log_mu[0] != result_0) || (new_log_mu[1] != result_1)) {
      // there is more up to date enqueued 
      return;
   }

   enq_task_arg2(UPDATE_MESSAGE_TASK, ts, (uint64_t) m_id, (double) new_log_mu[0], (double) new_log_mu[1]);
}

void update_message_task(uint64_t ts, message_id m_id, double result_0, double result_1) {
   std::array<double,LENGTH> old_log_mu = mrf->getMessageVal(m_id);
   std::array<double,LENGTH> new_log_mu;
   new_log_mu[0] = result_0;
   new_log_mu[1] = result_1;
   // record in undo log
   Message* m = mrf->getMessage(m_id);
   undo_log_write((uint64_t *) &(m->logMu[0]), m->logMu[0]);
   undo_log_write((uint64_t *) &(m->logMu[1]), m->logMu[1]);

   mrf->updateMessage(m_id, new_log_mu);

   node_id dest = mrf->getDest(m_id);

   enq_task_arg4(UPDATE_LOG_PRODUCT_IN_TASK, ts, (uint64_t) dest, (double) old_log_mu[0], (double) old_log_mu[1], (double) new_log_mu[0], (double) new_log_mu[1]);

   return;
}

void update_log_product_in_task(uint64_t ts, node_id n_id, double old_log_mu_0, double old_log_mu_1, double new_log_mu_0, double new_log_mu_1) {
   std::array<double,LENGTH> old_log_product_in = mrf->getLogProductIn(n_id);
   std::array<double,LENGTH> new_log_product_in;
	new_log_product_in[0] += -old_log_mu_0 + new_log_mu_0;
   new_log_product_in[1] += -old_log_mu_1 + new_log_mu_1;

   // record in undo log
   Node *n = mrf->getNode(n_id);
   undo_log_write((uint64_t *) &(n->logProductIn[0]), n->logProductIn[0]);
   undo_log_write((uint64_t *) &(n->logProductIn[1]), n->logProductIn[1]);

   mrf->updateLogProductIn(n_id, new_log_product_in);
   enq_task_arg0(PROPAGATE_TASK, ts, (uint64_t) n_id);

   return;
}

void propagate_task(uint64_t ts, node_id n_id) {
   IteratorMessagesFrom affected_messages = mrf->getMessagesFrom(n_id);
   message_id m_id;
   while (affected_messages.hasNext()) {
      m_id = affected_messages.getNext();
      enq_task_arg0(PRIORITIZE_TASK, ts, (uint64_t) m_id);
   }
   return;
}


void solve_rbp(MRF_CSR *mrf_in, double sensitivity_in) {
   chronos_init();

   mrf = mrf_in;
   sensitivity = sensitivity_in;

   uint64_t num_messages = mrf->getNumMessages();

   for (uint64_t i = 0; i < num_messages; i++) {
      enq_task_arg0(PRIORITIZE_TASK, 0, i);
   }

   // Dereference the pointers to array base addresses.
   // ( The '<<2' is because graph_gen writes the word number, not the byte)

   while (1) {
      uint64_t ttype, ts, object; 
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

