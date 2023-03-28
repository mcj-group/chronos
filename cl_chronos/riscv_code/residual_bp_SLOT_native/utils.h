#pragma once
#include "math.h"
#include "types.h"
#include "assert.h"
#include "../include/simulator.h"

#define UINT32_MAX		      (4294967295U)

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

extern inline float32_t logSum(float32_t log1, float32_t log2) {
   float32_t max = log1 > log2 ? log1 : log2;
   float32_t min = log1 < log2 ? log1 : log2;
   float32_t ans = max + logf(1.0 + expf(min - max));
   return ans;
}