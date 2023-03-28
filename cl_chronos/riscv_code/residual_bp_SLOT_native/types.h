#pragma once
#include "../include/simulator.h"

typedef float float32_t;

typedef struct Message {
   uint32_t i;
   uint32_t j;

   float32_t logMu[2];
   float32_t lookAhead[2];

   float32_t logIn[2][2]; 
} message_t;