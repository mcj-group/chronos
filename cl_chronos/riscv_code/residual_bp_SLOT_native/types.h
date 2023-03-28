#pragma once
#include "../include/simulator.h"

typedef float float_t;

typedef struct Message {
   uint32_t i;
   uint32_t j;

   float_t logMu[2];
   float_t lookAhead[2];

   float_t logsIn[2][2]; 
} message_t;