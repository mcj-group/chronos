/**
 * Created by vaksenov on 23.07.2019.
 * Ported to C++ by Mark Jeffrey 2021.04.26
 */
#pragma once

#include <array>
#include "edge_CSR.h"

struct Message {
    static constexpr uint64_t LENGTH = Edge::LENGTH;

    uint64_t i;
    uint64_t j;

    std::array<double,LENGTH> logMu;
    std::array<double,LENGTH> lookAhead;

};
