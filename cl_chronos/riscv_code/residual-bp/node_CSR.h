#pragma once

#include <array>
#include "edge_CSR.h"

typedef uint64_t node_id;

struct Node {
    static constexpr uint64_t LENGTH = Edge::LENGTH;

    std::array<double,LENGTH> logNodePotentials;
    std::array<double,LENGTH> logProductIn;
};