#include <array>
#include "edge_CSR.h"

typedef uint32_t node_id;

struct Node {
    std::array<float_t,2> logNodePotentials;
    std::array<float_t,2> logProductIn;
};