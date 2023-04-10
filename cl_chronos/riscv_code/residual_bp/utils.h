#include "math.h"
#include "types.h"

#define UINT32_MAX		      (4294967295U)

static inline uint32_t timestamp(float_t dist) {
   uint32_t SCALING_FACTOR = 1 << 31;
   float_t scaled = dist * SCALING_FACTOR;
   uint32_t ts = UINT32_MAX - 8 - ((uint32_t) scaled);
   return ts;
}

static inline float_t absval(float_t a) {
   if (a < 0) {
      return -a;
   } else {
      return a;
   }
}

static inline float_t distance(float_t *log1, float_t *log2) {
   float_t ans = 0.0;
   // split each expf into a task use direct cast to int value as id
   ans += absval(expf(log1[0]) - expf(log2[0]));
   ans += absval(expf(log1[1]) - expf(log2[1]));
   return ans;
}

// use direct cast to int of log1 + log2 as id
static inline float_t logSum(float_t log1, float_t log2) {
   float_t max = log1 > log2 ? log1 : log2;
   float_t min = log1 < log2 ? log1 : log2;
   float_t ans = max + logf(1.0 + expf(min - max));
   return ans;
}

uint32_t getReverseMessage(uint32_t m) {
   if ((m % 2) == 0) {
      return m + 1;
   } else {
      return m - 1;
   }
}