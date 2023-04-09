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

#include "stdio.h"
#include "utils.h"
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
   FILE *fp;
   // Read the graph from a file.
   fp = fopen("input_graph.rbp", "rb");
   if (fp == NULL) {
      printf("Error opening file");
   }

   uint32_t read_cnt = 0;
   uint32_t dummy;

   // Check for first word
   uint32_t magic;
   fread(&magic, sizeof(uint32_t), 1, fp);
   read_cnt += 1;
   if (magic != 0x0000DEAD) {
      printf("Error: File is not an RBP file.");
   }

   // Read the number of edges and vertices.
   fread(&numV, sizeof(uint32_t), 1, fp);
   fread(&numE, sizeof(uint32_t), 1, fp);
   read_cnt += 2;

   // Print the number of edges and vertices.
   printf("Number of vertices: %d, Number of edges: %d\n", numV, numE);

   // Read base address of the graph.
   uint32_t edge_indices_base;
   uint32_t edge_dest_base;
   uint32_t reverse_edge_indices_base;
   uint32_t reverse_edge_dest_base;
   uint32_t reverse_edge_id_base;

   uint32_t messages_base;
   uint32_t converged_base;

   uint32_t nodes_base;
   uint32_t edges_base;

   fread(&edge_indices_base, sizeof(uint32_t), 1, fp);
   fread(&edge_dest_base, sizeof(uint32_t), 1, fp);
   fread(&reverse_edge_indices_base, sizeof(uint32_t), 1, fp);
   fread(&reverse_edge_dest_base, sizeof(uint32_t), 1, fp);
   fread(&reverse_edge_id_base, sizeof(uint32_t), 1, fp);
   fread(&messages_base, sizeof(uint32_t), 1, fp);
   fread(&converged_base, sizeof(uint32_t), 1, fp);
   fread(&nodes_base, sizeof(uint32_t), 1, fp);
   fread(&edges_base, sizeof(uint32_t), 1, fp);
   read_cnt += 9;

   // Print the base addresses.
   printf("edge_indices_base: %d, edge_dest_base: %d, reverse_edge_indices_base: %d, reverse_edge_dest_base: %d, reverse_edge_id_base: %d, messages_base: %d, converged_base: %d, nodes_base %d, edges_base: %d\n",
         edge_indices_base,
         edge_dest_base, 
         reverse_edge_indices_base, 
         reverse_edge_dest_base, 
         reverse_edge_id_base, 
         messages_base, 
         converged_base,
         nodes_base,
         edges_base);

   // Read sensitivity.
   fread(&sensitivity, sizeof(float_t), 1, fp);
   read_cnt += 1;

   // Print the sensitivity.
   printf("sensitivity: %f\n", sensitivity);

   // Allocate memory for the graph.
   edge_indices = (uint32_t *) calloc(numV + 1, sizeof(uint32_t));
   edge_dest = (uint32_t *) calloc(numE, sizeof(uint32_t));
   reverse_edge_indices = (uint32_t *) calloc(numV + 1, sizeof(uint32_t));
   reverse_edge_dest = (uint32_t *) calloc(numE, sizeof(uint32_t));
   reverse_edge_id = (uint32_t *) calloc(numE, sizeof(uint32_t));
   messages = (message_t *) calloc(numE * 2, sizeof(message_t));
   converged_messages = (message_t *) calloc(numE * 2, sizeof(message_t));
   nodes = (node_t *) calloc(numV, sizeof(node_t));
   edges = (edge_t *) calloc(numE, sizeof(edge_t));

   // Check if memory was allocated.
   if (edge_indices == NULL || edge_dest == NULL || reverse_edge_indices == NULL || reverse_edge_dest == NULL || reverse_edge_id == NULL || messages == NULL || converged_messages == NULL || nodes == NULL || edges == NULL) {
      printf("Error: Could not allocate memory for the graph.");
   }

   // Read words until we reach the base address of the edge indices.
   for (;read_cnt < (uint32_t) edge_indices_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the edge indices.
   printf("started reading edge indices at %d\n", read_cnt);
   for (uint32_t i = 0; i < numV + 1; i++) {
      fread(&(edge_indices[i]), sizeof(uint32_t), 1, fp);
      read_cnt += 1;
   }
   printf("finished reading edge indices at %d\n", read_cnt);
   
   // Read words until we reach the base address of the edge destinations.
   for (;read_cnt < (uint32_t) edge_dest_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }
   
   // Read the edge destinations.
   printf("started reading edge destinations at %d\n", read_cnt);
   for (uint32_t i = 0; i < numE; i++) {
      fread(&(edge_dest[i]), sizeof(uint32_t), 1, fp);
      read_cnt += 1;
   }
   printf("finished reading edge destinations at %d\n", read_cnt);

   // Read words until we reach the base address of the reverse edge indices.
   for (;read_cnt < (uint32_t) reverse_edge_indices_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the reverse edge indices.
   printf("started reading reverse edge indices at %d\n", read_cnt);
   for (uint32_t i = 0; i < numV + 1; i++) {
      fread(&(reverse_edge_indices[i]), sizeof(uint32_t), 1, fp);
      read_cnt += 1;
   }
   printf("finished reading reverse edge indices at %d\n", read_cnt);

   // Read words until we reach the base address of the reverse edge destinations.
   for (;read_cnt < (uint32_t) reverse_edge_dest_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the reverse edge destinations.
   printf("started reading reverse edge dests at %d\n", read_cnt);
   for (uint32_t i = 0; i < numE; i++) {
      fread(&(reverse_edge_dest[i]), sizeof(uint32_t), 1, fp);
      read_cnt += 1;
   }
   printf("finished reading reverse edge dests at %d\n", read_cnt);

   // Read words until we reach the base address of the reverse edge ids.
   for (;read_cnt < (uint32_t) reverse_edge_id_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the reverse edge ids.
   printf("started reading reverse edge ids at %d\n", read_cnt);
   for (uint32_t i = 0; i < numE; i++) {
      fread(&(reverse_edge_id[i]), sizeof(uint32_t), 1, fp);
      read_cnt += 1;
   }
   printf("finished reading reverse edge ids at %d\n", read_cnt);

   // Read words until we reach the base address of the messages.
   for (;read_cnt < (uint32_t) messages_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the messages.
   printf("started reading messages at %d\n", read_cnt);
   for (uint32_t i = 0; i < numE * 2; i++) {
      // message values
      fread(&(messages[i].logMu[0]), sizeof(float_t), 1, fp);
      fread(&(messages[i].logMu[1]), sizeof(float_t), 1, fp);

      // logProductIn buffer
      fread(&(messages[i].logProductIn[0]), sizeof(float_t), 1, fp);
      fread(&(messages[i].logProductIn[1]), sizeof(float_t), 1, fp);

      // reverseLogMu buffer
      fread(&(messages[i].reverseLogMu[0]), sizeof(float_t), 1, fp);
      fread(&(messages[i].reverseLogMu[1]), sizeof(float_t), 1, fp);

      // src and dest nodes
      fread(&(messages[i].i), sizeof(uint32_t), 1, fp);
      fread(&(messages[i].j), sizeof(uint32_t), 1, fp);

      // enqueued ts
      fread(&(messages[i].enqueued_ts), sizeof(uint32_t), 1, fp);

      // padding
      fread(&dummy, sizeof(float_t), 1, fp);
      fread(&dummy, sizeof(float_t), 1, fp);
      fread(&dummy, sizeof(float_t), 1, fp);
      fread(&dummy, sizeof(float_t), 1, fp);
      fread(&dummy, sizeof(float_t), 1, fp);
      fread(&dummy, sizeof(float_t), 1, fp);
      fread(&dummy, sizeof(float_t), 1, fp);

      read_cnt += 16;
   }
   printf("finished reading messages at %d\n", read_cnt);

   // Read words until we reach the base address of the converged messages.
   for (;read_cnt < (uint32_t) converged_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the converged messages.
   printf("started reading converged messages at %d\n", read_cnt);
   for (uint32_t i = 0; i < numE * 2; i++) {
      // message values
      fread(&(converged_messages[i].logMu[0]), sizeof(float_t), 1, fp);
      fread(&(converged_messages[i].logMu[1]), sizeof(float_t), 1, fp);

      // logProductIn buffer
      fread(&(converged_messages[i].logProductIn[0]), sizeof(float_t), 1, fp);
      fread(&(converged_messages[i].logProductIn[1]), sizeof(float_t), 1, fp);

      // reverseLogMu buffer
      fread(&(converged_messages[i].reverseLogMu[0]), sizeof(float_t), 1, fp);
      fread(&(converged_messages[i].reverseLogMu[1]), sizeof(float_t), 1, fp);

      // src and dest nodes
      fread(&(converged_messages[i].i), sizeof(uint32_t), 1, fp);
      fread(&(converged_messages[i].j), sizeof(uint32_t), 1, fp);

      // enqueued ts
      fread(&(converged_messages[i].enqueued_ts), sizeof(uint32_t), 1, fp);

      // padding
      fread(&dummy, sizeof(float_t), 1, fp);
      fread(&dummy, sizeof(float_t), 1, fp);
      fread(&dummy, sizeof(float_t), 1, fp);
      fread(&dummy, sizeof(float_t), 1, fp);
      fread(&dummy, sizeof(float_t), 1, fp);
      fread(&dummy, sizeof(float_t), 1, fp);
      fread(&dummy, sizeof(float_t), 1, fp);
      
      read_cnt += 16;
   }
   printf("finished reading converged messages at %d\n", read_cnt);

   // Read words until we reach the base address of the nodes.
   for (;read_cnt < (uint32_t) nodes_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the nodes.
   printf("started reading nodes at %d\n", read_cnt);
   for (uint32_t i = 0; i < numV; i++) {
      fread(&(nodes[i].logNodePotentials[0]), sizeof(float_t), 1, fp);
      fread(&(nodes[i].logNodePotentials[1]), sizeof(float_t), 1, fp);
      fread(&(nodes[i].logProductIn[0]), sizeof(float_t), 1, fp);
      fread(&(nodes[i].logProductIn[1]), sizeof(float_t), 1, fp);
      read_cnt += 4;
   }
   printf("finished reading nodes at %d\n", read_cnt);

   // read words until we reach the base address of the edges.
   for (;read_cnt < (uint32_t) edges_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the edges.
   printf("started reading edges at %d\n", read_cnt);
   for (uint32_t i = 0; i < numE; i++) {
      fread(&(edges[i].logPotentials[0][0]), sizeof(float_t), 1, fp);
      fread(&(edges[i].logPotentials[0][1]), sizeof(float_t), 1, fp);
      fread(&(edges[i].logPotentials[1][0]), sizeof(float_t), 1, fp);
      fread(&(edges[i].logPotentials[1][1]), sizeof(float_t), 1, fp);
      read_cnt += 4;
   }
   printf("finished reading edges at %d\n", read_cnt);

   // Close the file.
   fclose(fp);
}

void print_graph() {
   // Print the edge indices.
   printf("edge_indices: ");
   for (uint32_t i = 0; i < numV + 1; i++) {
      printf("%d ", edge_indices[i]);
   }
   printf("\n");

   // Print the edge destinations.
   printf("edge_dest: ");
   for (uint32_t i = 0; i < numE; i++) {
      printf("%d ", edge_dest[i]);
   }
   printf("\n");

   // Print the reverse edge indices.
   printf("reverse_edge_indices: ");
   for (uint32_t i = 0; i < numV + 1; i++) {
      printf("%d ", reverse_edge_indices[i]);
   }
   printf("\n");

   // Print the reverse edge destinations.
   printf("reverse_edge_dest: ");
   for (uint32_t i = 0; i < numE; i++) {
      printf("%d ", reverse_edge_dest[i]);
   }
   printf("\n");

   // Print the reverse edge ids.
   printf("reverse_edge_id: ");
   for (uint32_t i = 0; i < numE; i++) {
      printf("%d ", reverse_edge_id[i]);
   }
   printf("\n");

   // Print the messages.
   for (uint32_t i = 0; i < 2 * numE; i++) {
      printf("Message %d: (%d, %d) = (%f, %f)\n", i, messages[i].i, messages[i].j, messages[i].logMu[0], messages[i].logMu[1]);
   }
   printf("\n");

   // Print the converged messages.
   for (uint32_t i = 0; i < 2 * numE; i++) {
      printf("Converged Message %d: (%d, %d) = (%f, %f)\n", i, converged_messages[i].i, converged_messages[i].j, converged_messages[i].logMu[0], converged_messages[i].logMu[1]);
   }
   printf("\n");

   // Print the nodes.
   for (uint32_t i = 0; i < numV; i++) {
      printf("Node %d: (%f, %f)\n", i, nodes[i].logNodePotentials[0], nodes[i].logNodePotentials[1]);
   }
   printf("\n");

   // Print the edges.
   for (uint32_t i = 0; i < numE; i++) {
      printf("Edge %d: (%f, %f) (%f, %f)\n" , i, edges[i].logPotentials[0][0], edges[i].logPotentials[0][1], edges[i].logPotentials[1][0], edges[i].logPotentials[1][1]);
   }
   printf("\n");
}

void verify_results() {
   printf("\n\nVerifying results... \n");
   // Verify the messages.
   uint8_t failed = 0;
   float_t check_sensitivity = 0.0001;
   for (uint32_t i = 0; i < 2 * numE; i++) {
      if ((absval(messages[i].logMu[0] - converged_messages[i].logMu[0]) > check_sensitivity) || (absval(messages[i].logMu[1] - converged_messages[i].logMu[1]) > check_sensitivity)) {
         printf("Message %d: (%d, %d) = (%f, %f) != (%f, %f) ref\n", i, messages[i].i, messages[i].j, messages[i].logMu[0], messages[i].logMu[1], converged_messages[i].logMu[0], converged_messages[i].logMu[1]);
         failed = 1;
      }
   }
   if (failed == 0) {
      printf("PASSED\n");
   } else {
      printf("FAILED\n");
   }
}

void init_task(uint ts) {
   printf("\nInit task\n");
   for (uint32_t i = 0; i < 2 * numE; i++) {
      enq_task_arg0(PRIORITIZE_TASK, ts + 1, i);
   }
   printf("\n");
}

void prioritize_task(uint ts, uint m_id) {
   printf("\nPrioritize task: m_id-%d\n", m_id);

   message_t *m = &messages[m_id];
   uint32_t i = m->i;

   uint32_t r_m_id = getReverseMessage(m_id);

   enq_task_arg1(FETCH_REVERSE_LOGMU_TASK, ts+1, r_m_id, m_id); // reverseLogMu and enqueue write to buffer task
   enq_task_arg1(FETCH_LOGPRODUCTIN_TASK, ts+1, i + (2 * numE), m_id); // fetch logProductIn and enqueue write to buffer task
   enq_task_arg0(UPDATE_PRIORITY_TASK, ts+3, m_id); // update lookAhead and enqueue update task
}

void fetch_reverse_logmu_task(uint ts, uint r_m_id, uint m_id) {
   printf("\nFetch reverse logMu task: r_m_id-%d, m_id-%d\n", r_m_id, m_id);

   message_t *r_m = &messages[r_m_id];
   message_t *m = &messages[m_id];

   // fetch reverse logMu
   float_t reverseLogMu[2];
   reverseLogMu[0] = r_m->logMu[0];
   reverseLogMu[1] = r_m->logMu[1];

   // enqueue write to buffer task
   enq_task_arg2(WRITE_REVERSE_LOGMU_TASK, ts+1, m_id, *((uint *) (&reverseLogMu[0])), *((uint *) (&reverseLogMu[1])));
}

void write_reverse_logmu_task(uint ts, uint m_id, uint reverseLogMu0, uint reverseLogMu1) {
   printf("\nWrite reverse logMu task: m_id-%d\n", m_id);

   message_t *m = &messages[m_id];

   // undo log write
   undo_log_write((uint *) &(m->reverseLogMu[0]), *((uint *) &(m->reverseLogMu[0])));
   undo_log_write((uint *) &(m->reverseLogMu[1]), *((uint *) &(m->reverseLogMu[1])));

   // update reverseLogMu
   m->reverseLogMu[0] = *((float_t *) (&reverseLogMu0));
   m->reverseLogMu[1] = *((float_t *) (&reverseLogMu1));
}

void fetch_logproductin_task(uint ts, uint i_id, uint m_id) {
   uint32_t i = i_id - (2 * numE);

   printf("\nFetch logProductIn task: i-%d, m_id-%d\n", i, m_id);
   node_t *n = &nodes[i];
   message_t *m = &messages[m_id];

   // fetch logProductIn
   float_t logProductIn[2];
   logProductIn[0] = n->logProductIn[0];
   logProductIn[1] = n->logProductIn[1];

   // enqueue write to buffer task
   enq_task_arg2(WRITE_LOGPRODUCTIN_TASK, ts+1, m_id, *((uint *) (&logProductIn[0])), *((uint *) (&logProductIn[1])));
}

void write_logproductin_task(uint ts, uint m_id, uint logProductIn0, uint logProductIn1) {
   printf("\nWrite logProductIn task: m_id-%d\n", m_id);

   message_t *m = &messages[m_id];

   // undo log write
   undo_log_write((uint *) &(m->logProductIn[0]), *((uint *) &(m->logProductIn[0])));
   undo_log_write((uint *) &(m->logProductIn[1]), *((uint *) &(m->logProductIn[1])));

   // update logProductIn
   m->logProductIn[0] = *((float_t *) (&logProductIn0));
   m->logProductIn[1] = *((float_t *) (&logProductIn1));
}

void update_priority_task(uint ts, uint m_id) {
   printf("\nUpdate priority task: m_id-%d\n", m_id);

   uint update_ts;
   message_t *m = &messages[m_id];
   edge_t *e = &edges[m_id/2];

   uint32_t i = m->i;
   node_t *n = &nodes[i];

   float_t lookAhead[2];

   bool forward;
   if (m_id % 2 == 0) {
      forward = true;
   } else {
      forward = false;
   }

   if (forward) {
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
   printf("residual: %f\n", residual);

   if (residual > sensitivity) {
      update_ts = timestamp(residual);
      // printf("update_ts: %d\n", update_ts);

      if (update_ts > ts) {
         undo_log_write((uint *) &(m->enqueued_ts), m->enqueued_ts);
         m->enqueued_ts = update_ts;
         enq_task_arg2(UPDATE_MESSAGE_TASK, update_ts, m_id, *((uint *) &(lookAhead[0])), *((uint *) &(lookAhead[1])));
      } else {
         undo_log_write((uint *) &(m->enqueued_ts), m->enqueued_ts);
         m->enqueued_ts = ts + 1;
         enq_task_arg2(UPDATE_MESSAGE_TASK, ts + 1, m_id, *((uint *) &(lookAhead[0])), *((uint *) &(lookAhead[1])));
      }
   } else {
      printf("residual < sensitivity, no update\n");
   }
   printf("\n");
}

void update_message_task(uint ts, uint m_id, uint lookAhead0, uint lookAhead1) {
   printf("\nUpdate message task: m_id-%d\n", m_id);
   message_t *m = &messages[m_id];
   // check if enqueued version is the latest
   if (m->enqueued_ts != ts) {
      // not most up-to-date copy of update task
      printf("aborted, not most up-to-date copy\n");
      return;
   }

   // update logProductIn
   float_t diff[2];
   diff[0] = *((float_t *) (&lookAhead0)) - m->logMu[0];
   diff[1] = *((float_t *) (&lookAhead1)) - m->logMu[1];
   enq_task_arg2(UPDATE_LOGPRODUCTIN_TASK, ts+1, (m->j) + (2 * numE), *((uint *) (&diff[0])), *((uint *) (&diff[1])));

   // update logMu
   printf("old logMu: (%f, %f)\n", m->logMu[0], m->logMu[1]);
   undo_log_write((uint *) &(m->logMu[0]), *((uint *) &(m->logMu[0])));
   undo_log_write((uint *) &(m->logMu[1]), *((uint *) &(m->logMu[1])));

   float lookAhead[2];
   lookAhead[0] = *((float_t *) (&lookAhead0));
   lookAhead[1] = *((float_t *) (&lookAhead1));

   m->logMu[0] = lookAhead[0];
   m->logMu[1] = lookAhead[1];
   printf("new logMu: (%f, %f)\n", m->logMu[0], m->logMu[1]);

   // propagate -> enqueue new prioritize tasks (ts + 1) id = affected_mid
   printf("propagate\n");
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
   printf("\n");
}

void update_logproductin_task(uint ts, uint j_id, uint diff0, uint diff1) {
   uint32_t j = j_id - (2 * numE);
   printf("\nUpdate logProductIn task: j-%d\n", j);
   node_t *n = &nodes[j];
   float_t diff[2];
   diff[0] = *((float_t *) (&diff0));
   diff[1] = *((float_t *) (&diff1));

   printf("old logProductIn: (%f, %f)\n", n->logProductIn[0], n->logProductIn[1]);
   undo_log_write((uint *) &(n->logProductIn[0]), *((uint *) &(n->logProductIn[0])));
   undo_log_write((uint *) &(n->logProductIn[1]), *((uint *) &(n->logProductIn[1])));
   n->logProductIn[0] += diff[0];
   n->logProductIn[1] += diff[1];
   printf("new logProductIn: (%f, %f)\n", n->logProductIn[0], n->logProductIn[1]);
   printf("\n");
}

int main() {
   chronos_init();

   create_graph_from_file();

   printf("Graph created\n");

   print_graph();
   printf("\n");

   enq_task_arg0(INIT_TASK, 0, 0);

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
         case DONE:
            goto done;
            break;
         default:
            break;
      }

      finish_task();
   }

done:
   verify_results();
}