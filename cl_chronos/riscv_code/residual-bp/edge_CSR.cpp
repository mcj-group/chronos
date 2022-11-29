#include <cmath>

#include "edge_CSR.h"

void Edge::setPotential(array2d_t potentials) {
    for (uint64_t i = 0; i < LENGTH; i++) {
        for (uint64_t j = 0; j < LENGTH; j++) {
            logPotentials[i][j] = std::log(potentials[i][j]);
        }
    }
}

double Edge::getLogPotential(bool forward, uint64_t vi, uint64_t vj) const {
    if (forward) {
        return logPotentials[vi][vj];
    } else {
        return logPotentials[vj][vi];
    }
}
