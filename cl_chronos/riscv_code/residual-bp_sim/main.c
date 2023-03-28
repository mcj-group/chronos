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

#include "../include/simulator.h"
#include "math.h"
#include "assert.h"
#include "stdio.h"

#define UINT32_MAX		      (4294967295U)

#define DONE                  (-1)
#define INIT_TASK             0
#define ENQUEUE_UPDATE_TASK   1
#define REPRIORITIZE_TASK     2
#define UPDATE_MESSAGE_TASK   3

typedef float float32_t;

typedef struct Message {
   uint32_t i;
   uint32_t j;

   float32_t logMu[2];
   float32_t lookAhead[2];

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
uint32_t numV;
uint32_t numE;
float32_t sensitivity;

uint32_t *edge_indices;
uint32_t *edge_dest;
uint32_t *reverse_edge_indices;
uint32_t *reverse_edge_dest;
uint32_t *reverse_edge_id;
message_t *messages;
message_t *converged_messages;

extern inline uint32_t timestamp(float32_t dist) {
   assert(dist > 0.0 && dist <= 1.0);
   uint32_t SCALING_FACTOR = 1 << 31;
   float32_t scaled = dist * SCALING_FACTOR;
   uint32_t ts = UINT32_MAX - 8 - ((uint32_t) scaled);
   return ts;
}

extern inline float32_t absval(float32_t a) {
   if (a < 0) {
      return -a;
   } else {
      return a;
   }
}

extern inline float32_t distance(float32_t *log1, float32_t *log2) {
   float32_t ans = 0.0;
   ans += absval(expf(log1[0]) - expf(log2[0]));
   ans += absval(expf(log1[1]) - expf(log2[1]));
   return ans;
}

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
   void *edge_indices_base;
   void *edge_dest_base;
   void *reverse_edge_indices_base;
   void *reverse_edge_dest_base;
   void *reverse_edge_id_base;
   void *messages_base;
   void *converged_base;

   fread(&edge_indices_base, sizeof(void *), 1, fp);
   fread(&edge_dest_base, sizeof(void *), 1, fp);
   fread(&reverse_edge_indices_base, sizeof(void *), 1, fp);
   fread(&reverse_edge_dest_base, sizeof(void *), 1, fp);
   fread(&reverse_edge_id_base, sizeof(void *), 1, fp);
   fread(&messages_base, sizeof(void *), 1, fp);
   fread(&converged_base, sizeof(void *), 1, fp);
   read_cnt += 7;

   // Print the base addresses.
   printf("edge_indices_base: %p, edge_dest_base: %p, reverse_edge_indices_base: %p, reverse_edge_dest_base: %p, reverse_edge_id_base: %p, messages_base: %p, converged_base: %p\n", 
         edge_indices_base, edge_dest_base, reverse_edge_indices_base, reverse_edge_dest_base, reverse_edge_id_base, messages_base, converged_base);

   // Read sensitivity.
   fread(&sensitivity, sizeof(float32_t), 1, fp);
   read_cnt += 1;

   // Print the sensitivity.
   printf("sensitivity: %hf\n", sensitivity);

   // Allocate memory for the graph.
   edge_indices = (uint32_t *) calloc(numV + 1, sizeof(uint32_t));
   edge_dest = (uint32_t *) calloc(numE, sizeof(uint32_t));
   reverse_edge_indices = (uint32_t *) calloc(numV + 1, sizeof(uint32_t));
   reverse_edge_dest = (uint32_t *) calloc(numE, sizeof(uint32_t));
   reverse_edge_id = (uint32_t *) calloc(numE, sizeof(uint32_t));
   messages = (message_t *) calloc(numE * 2, sizeof(message_t));
   converged_messages = (message_t *) calloc(numE * 2, sizeof(message_t));

   // Check if memory was allocated.
   if (edge_indices == NULL || edge_dest == NULL || reverse_edge_indices == NULL || reverse_edge_dest == NULL || reverse_edge_id == NULL || messages == NULL) {
      printf("Error: Could not allocate memory for the graph.");
   }

   // Read words until we reach the base address of the edge indices.
   for (;read_cnt < (uint32_t) edge_indices_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the edge indices.
   for (uint32_t i = 0; i < numV + 1; i++) {
      fread(&(edge_indices[i]), sizeof(uint32_t), 1, fp);
      read_cnt += 1;
   }
   
   // Read words until we reach the base address of the edge destinations.
   for (;read_cnt < (uint32_t) edge_dest_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }
   
   // Read the edge destinations.
   for (uint32_t i = 0; i < numE; i++) {
      fread(&(edge_dest[i]), sizeof(uint32_t), 1, fp);
      read_cnt += 1;
   }

   // Read words until we reach the base address of the reverse edge indices.
   for (;read_cnt < (uint32_t) reverse_edge_indices_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the reverse edge indices.
   for (uint32_t i = 0; i < numV + 1; i++) {
      fread(&(reverse_edge_indices[i]), sizeof(uint32_t), 1, fp);
      read_cnt += 1;
   }

   // Read words until we reach the base address of the reverse edge destinations.
   for (;read_cnt < (uint32_t) reverse_edge_dest_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the reverse edge destinations.
   for (uint32_t i = 0; i < numE; i++) {
      fread(&(reverse_edge_dest[i]), sizeof(uint32_t), 1, fp);
      read_cnt += 1;
   }

   // Read words until we reach the base address of the reverse edge ids.
   for (;read_cnt < (uint32_t) reverse_edge_id_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the reverse edge ids.
   for (uint32_t i = 0; i < numE; i++) {
      fread(&(reverse_edge_id[i]), sizeof(uint32_t), 1, fp);
      read_cnt += 1;
   }

   // Read words until we reach the base address of the messages.
   for (;read_cnt < (uint32_t) messages_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the messages.
   for (uint32_t i = 0; i < numE * 2; i++) {
      fread(&(messages[i].i), sizeof(uint32_t), 1, fp);
      fread(&(messages[i].j), sizeof(uint32_t), 1, fp);
      fread(&(messages[i].logMu[0]), sizeof(float32_t), 1, fp);
      fread(&(messages[i].logMu[1]), sizeof(float32_t), 1, fp);
      fread(&(messages[i].lookAhead[0]), sizeof(float32_t), 1, fp);
      fread(&(messages[i].lookAhead[1]), sizeof(float32_t), 1, fp);
      fread(&(messages[i].padding[0]), sizeof(uint32_t), 1, fp);
      fread(&(messages[i].padding[1]), sizeof(uint32_t), 1, fp);
      read_cnt += 8;
   }

   // Read words until we reach the base address of the converged messages.
   for (;read_cnt < (uint32_t) converged_base; read_cnt++) {
      fread(&dummy, sizeof(uint32_t), 1, fp);
   }

   // Read the converged messages.
   for (uint32_t i = 0; i < numE * 2; i++) {
      fread(&(converged_messages[i].i), sizeof(uint32_t), 1, fp);
      fread(&(converged_messages[i].j), sizeof(uint32_t), 1, fp);
      fread(&(converged_messages[i].logMu[0]), sizeof(float32_t), 1, fp);
      fread(&(converged_messages[i].logMu[1]), sizeof(float32_t), 1, fp);
      fread(&(converged_messages[i].lookAhead[0]), sizeof(float32_t), 1, fp);
      fread(&(converged_messages[i].lookAhead[1]), sizeof(float32_t), 1, fp);
      fread(&(converged_messages[i].padding[0]), sizeof(uint32_t), 1, fp);
      fread(&(converged_messages[i].padding[1]), sizeof(uint32_t), 1, fp);
      read_cnt += 8;
   }

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
      printf("Message %d: (%d, %d) = (%hf, %hf)\n", i, messages[i].i, messages[i].j, messages[i].logMu[0], messages[i].logMu[1]);
   }
   printf("\n");

   // Print the converged messages.
   for (uint32_t i = 0; i < 2 * numE; i++) {
      printf("Converged Message %d: (%d, %d) = (%hf, %hf)\n", i, converged_messages[i].i, converged_messages[i].j, converged_messages[i].logMu[0], converged_messages[i].logMu[1]);
   }
   printf("\n");
}

void init_task(uint ts) {
   printf("\nInit task\n");
   for (uint32_t i = 0; i < 2 * numE; i++) {
      enq_task_arg0(ENQUEUE_UPDATE_TASK, ts + i + 1, i);
   }
   printf("\n");
}

void enqueue_update_task(uint ts, uint mid) {
   printf("\nEnqueue update task: mid-%d\n", mid);
   float32_t residual = distance(messages[mid].logMu, messages[mid].lookAhead);

   if (residual > sensitivity) {
      uint update_ts = timestamp(residual);

      enq_task_arg2(UPDATE_MESSAGE_TASK, update_ts, mid, 
                  *((uint *) &(messages[mid].lookAhead[0])), 
                  *((uint *) &(messages[mid].lookAhead[1]))
                  );
   }
   printf("\n");
}

void update_message_task(uint ts, uint mid,  uint enqueued_lookAhead_0, uint enqueued_lookAhead_1) {
   printf("\nUpdate message task: mid-%d\n", mid);
   // check if enqueued version is the latest
   float32_t enqueued_lookAhead[2];
   enqueued_lookAhead[0] = *((float32_t *) &enqueued_lookAhead_0);
   enqueued_lookAhead[1] = *((float32_t *) &enqueued_lookAhead_1);
   if ((messages[mid].lookAhead[0] != enqueued_lookAhead[0]) || (messages[mid].lookAhead[1] != enqueued_lookAhead[1])) {
      // not most up-to-date copy of update task
      printf("aborted, not most up-to-date copy\n");
      return;
   }

   // update logMu
   float32_t old_logMu[2];

   old_logMu[0] = messages[mid].logMu[0];
   messages[mid].logMu[0] = enqueued_lookAhead[0];
   undo_log_write((uint *) &(messages[mid].logMu[0]), *((uint *) (&old_logMu[0])));

   old_logMu[1] = messages[mid].logMu[1];
   messages[mid].logMu[1] = enqueued_lookAhead[1];
   undo_log_write((uint *) &(messages[mid].logMu[1]), *((uint *) (&old_logMu[1])));
   printf("old logMu: (%hf, %hf)\n", old_logMu[0], old_logMu[1]);
   printf("new logMu: (%hf, %hf)\n", messages[mid].logMu[0], messages[mid].logMu[1]);

   // calculate change in logMu for propagation
   float32_t delta_logMu[2];
   delta_logMu[0] = messages[mid].logMu[0] - old_logMu[0];
   delta_logMu[1] = messages[mid].logMu[1] - old_logMu[1];

   printf("delta logMu: (%hf, %hf)\n", delta_logMu[0], delta_logMu[1]);

   // propagate 
   printf("propagate\n");
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
   printf("\n");
}

void reprioritize_task(uint ts, uint mid, uint delta_logMu_0, uint delta_logMu_1) {
   printf("\nReprioritize task: mid-%d, deltaLogMu: (%hf, %hf)\n", mid, *((float32_t *) &delta_logMu_0), *((float32_t *) &delta_logMu_1));
   float32_t old_lookAhead[2];
   uint update_ts;

   old_lookAhead[0] = messages[mid].lookAhead[0];
   messages[mid].lookAhead[0] = old_lookAhead[0] + *((float32_t *) &delta_logMu_0);
   undo_log_write((uint *) &(messages[mid].lookAhead[0]), *((uint *) (&old_lookAhead[0])));

   old_lookAhead[1] = messages[mid].lookAhead[1];
   messages[mid].lookAhead[1] = old_lookAhead[1] + *((float32_t *) &delta_logMu_1);
   undo_log_write((uint *) &(messages[mid].lookAhead[1]), *((uint *) (&old_lookAhead[1])));

   printf("old lookAhead: (%hf, %hf)\n", old_lookAhead[0], old_lookAhead[1]);
   printf("new lookAhead: (%hf, %hf)\n", messages[mid].lookAhead[0], messages[mid].lookAhead[1]);

   float32_t residual = distance(messages[mid].logMu, messages[mid].lookAhead);
   printf("residual: %hf\n", residual);

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
   } else {
      printf("residual < sensitivity, no update\n");
   }
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
         case ENQUEUE_UPDATE_TASK:
            enqueue_update_task(ts, object);
            break;
         case REPRIORITIZE_TASK:
            reprioritize_task(ts, object, arg0, arg1);
            break;
         case UPDATE_MESSAGE_TASK:
            update_message_task(ts, object, arg0, arg1);
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
   printf("\nGraph after\n\n");
   print_graph();
}