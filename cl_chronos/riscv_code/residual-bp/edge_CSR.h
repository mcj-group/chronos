/**
 * Created by vaksenov on 25.07.2019.
 * Ported to C++ by Mark Jeffrey 2021.04.26
 */
#pragma once

#include <array>
#include <cstdint>

class Edge {
  public:

    static constexpr uint64_t LENGTH = 2;
    using array2d_t = std::array<std::array<double,LENGTH>,LENGTH>;

  private:

    array2d_t logPotentials;

  public:

    void setPotential(array2d_t potentials);

    double getLogPotential(bool forward, uint64_t vi, uint64_t vj) const;
  
};
