#pragma once
#include "../include/simulator.h"

typedef float float_t;

typedef struct Message {
   // read-write
   float_t logMu[2];
   float_t logProductIn[2];
   float_t reverseLogMu[2];

   // read-only
   uint32_t i;
   uint32_t j;
   uint32_t enqueued_ts;

   // buffer for distance calculation.
   float_t residual;
   float_t lookAhead[2];

   float_t exp_buf[4];
} message_t;

typedef struct Node {
   float_t logNodePotentials[2];
   float_t logProductIn[2];
} node_t;

typedef struct Edge {
   float_t logPotentials[2][2];
} edge_t;