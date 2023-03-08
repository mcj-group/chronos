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

#define MAGIC_OP 0xdead
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#include <algorithm>
#include <cmath>
#include <fstream>
#include <iostream>
#include <stdlib.h>
#include <tuple>
#include <utility>
#include <vector>
#include <set>
#include <map>
#include <unordered_set>
#include <queue>
#include <random>
#include <numeric>

struct Node {
   uint32_t vid;
   float_t dist;
   float_t bucket;
};

#define APP_SSSP 0

struct Vertex;

struct Adj {
   uint32_t n;
   float_t d_cm; // edge weight
   uint32_t index; // index of the reverse edge
};

struct Vertex {
   double lat, lon;  // in RADIANS
   std::vector<Adj> adj;
};

Vertex* graph;
uint32_t numV;
uint32_t numE;
uint32_t startNode;
uint32_t endNode;

int app = APP_SSSP;

uint32_t* csr_offset;
Adj* csr_neighbors;
float_t* csr_dist;

void GenerateGridGraph(uint32_t n) {
   numV = n*n;
   numE = 2 * n * (n-1) ;
   graph = new Vertex[numV];
   bool debug = true;
   srand(0);
   for (uint32_t i=0;i<n;i++){
      for (uint32_t j=0;j<n;j++){
         uint32_t vid = i*n+j;
         if (i < n-1) {
            Adj e;
            e.n = (vid+n);
            e.d_cm = (float_t) (rand() % 10);
            graph[vid].adj.push_back(e);
            if(debug) printf("%d->%d %f\n", vid, e.n, e.d_cm);
         }
         if (j < n-1) {
            Adj e;
            e.n = (vid+1);
            e.d_cm = (float_t) (rand() % 10);
            graph[vid].adj.push_back(e);
            if(debug) printf("%d->%d %f\n", vid, e.n, e.d_cm);
         }
      }
   }
}

std::set<uint32_t>* edges;

void ConvertToCSR() {
   numE = 0;
   for (uint32_t i = 0; i < numV; i++) numE += graph[i].adj.size();
   printf("Read %d nodes, %d adjacencies\n", numV, numE);

   csr_offset = (uint32_t*)(malloc (sizeof(uint32_t) * (numV+1)));
   csr_neighbors = (Adj*)(malloc (sizeof(Adj) * (numE)));
   csr_dist = (float_t*)(malloc (sizeof(float_t) * numV));
   numE = 0;
   for (uint32_t i=0;i<numV;i++){
      csr_offset[i] = numE;
      for (uint32_t a=0;a<graph[i].adj.size();a++){
         csr_neighbors[numE++] = graph[i].adj[a];
      }
      csr_dist[i] = 0x7fffffff; // max possible float32 val
   }
   csr_offset[numV] = numE;

}

struct compare_node {
   bool operator() (const Node &a, const Node &b) const {
      return a.bucket > b.bucket;
   }
};
void ComputeReference(){
   float_t  delta = 1;
   printf("Compute Reference\n");
   std::priority_queue<Node, std::vector<Node>, compare_node> pq;

    // cache flush
#if 0
    const int size = 20*1024*1024;
    char *c = (char *) malloc(size);
    for (int i=0;i<0xff;i++) {
       // printf("%d\n", i);

        for (int j=0;j<size;j++)
            c[j] = i*j;
    }
#endif
   uint32_t max_pq_size = 0;
   int edges_traversed = 0;

   clock_t t = clock();
   Node v = {startNode, 0, 0};
   pq.push(v);
   while(!pq.empty()){
      Node n = pq.top();
      uint32_t vid = n.vid;
      float_t dist = n.dist;
      printf("visit %d %f\n", vid, dist);
      pq.pop();
      max_pq_size = pq.size() < max_pq_size ?  max_pq_size : pq.size();
      edges_traversed++;
      if (csr_dist[vid] > dist) {
         csr_dist[vid] = dist;

         uint32_t ngh = csr_offset[vid];
         uint32_t nghEnd = csr_offset[vid+1];

         while(ngh != nghEnd) {
            Adj a = csr_neighbors[ngh++];
            Node e = {a.n, dist +  a.d_cm, (dist+a.d_cm)/delta};
            //printf(" -> %d %d\n", a.n, dist+ a.d_cm);
            pq.push(e);
         }
      }
   }
   t = clock() -t;
   printf("Time taken :%f msec\n", ((float)t * 1000)/CLOCKS_PER_SEC);
   printf("Node %d dist:%f\n", numV -1, csr_dist[numV-1]);
   printf("Max PQ size %d\n", max_pq_size);
   printf("edges traversed %d\n", edges_traversed);
}

void WriteOutput(FILE* fp) {
   // all offsets are in units of uint32_t. i.e 16 per cache line

   int SIZE_DIST =((numV+15)/16)*16;
   int SIZE_EDGE_OFFSET =( (numV+1 +15)/ 16) * 16;
   int SIZE_NEIGHBORS =(( (numE* 8)+ 63)/64 ) * 16;
   int SIZE_GROUND_TRUTH =((numV+15)/16)*16;

   int BASE_DIST = 16;
   int BASE_EDGE_OFFSET = BASE_DIST + SIZE_DIST;
   int BASE_NEIGHBORS = BASE_EDGE_OFFSET + SIZE_EDGE_OFFSET;
   int BASE_GROUND_TRUTH = BASE_NEIGHBORS + SIZE_NEIGHBORS;

   int BASE_END = BASE_GROUND_TRUTH + SIZE_GROUND_TRUTH;

   uint32_t* data = (uint32_t*) calloc(BASE_END, sizeof(uint32_t));

   data[0] = MAGIC_OP;
   data[1] = numV;
   data[2] = numE;
   data[3] = BASE_EDGE_OFFSET;
   data[4] = BASE_NEIGHBORS;
   data[5] = BASE_DIST;
   data[6] = BASE_GROUND_TRUTH;
   data[7] = startNode;
   data[8] = BASE_END;

   for (int i=0;i<9;i++) {
      printf("header %d: %d\n", i, data[i]);
   }

   uint32_t max_int = 0xFFFFFFFF;
   for (uint32_t i=0;i<numV;i++) {
      data[BASE_EDGE_OFFSET +i] = csr_offset[i];
      data[BASE_DIST+i] = max_int;
      data[BASE_GROUND_TRUTH +i] = *((uint32_t *) (&csr_dist[i]));
      //printf("gt %d %d\n", i, csr_dist[i]);
   }
   data[BASE_EDGE_OFFSET +numV] = csr_offset[numV];

   for (uint32_t i=0;i<numE;i++) {
      data[ BASE_NEIGHBORS +2*i ] = csr_neighbors[i].n;
      data[ BASE_NEIGHBORS +2*i+1] = *((uint32_t *) (&csr_neighbors[i].d_cm));
      // printf("%8x, %8x\n", data[ BASE_NEIGHBORS +2*i+1], *((uint32_t *) (&(csr_neighbors[i].d_cm))));
      // printf("sizeof(float_t) = %ld\n", sizeof(float_t));
   }

   printf("Writing file \n");
   fwrite(data, 4, BASE_END, fp);
   fclose(fp);

   free(data);

}


int main(int argc, char *argv[]) {

   char out_file[50];
   char ext[30];
   if (argc < 3) {
      printf("Usage: graph_gen app type=<latlon,grid,gr,color> type_args\n");
      exit(0);
   }
   if (strcmp(argv[1], "sssp") ==0) {
      app = APP_SSSP;
      sprintf(ext, "%s", "sssp");
   }

   startNode = 0;
   if (strcmp(argv[2], "grid") == 0) {
      int r, c;
      r = atoi(argv[3]);
      c = r;
      GenerateGridGraph(r);
      sprintf(out_file, "grid_fs_%dx%d.%s", r,c, ext);
   }

   ConvertToCSR();

   if (app == APP_SSSP) {
      ComputeReference();
   }

   FILE* fp;
   fp = fopen(out_file, "wb");
   printf("Writing file %s %p\n", out_file, fp);
   if (app == APP_SSSP) {
      WriteOutput(fp);
   }
   return 0;
}
