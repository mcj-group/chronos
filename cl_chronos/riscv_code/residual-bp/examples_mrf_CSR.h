/**
 * Created by vaksenov on 24.07.2019.
 */
#pragma once

#include <cstdint>

class MRF_CSR;

namespace examples_mrf_CSR {

MRF_CSR* isingMRF(uint64_t n, uint64_t m, uint64_t C, uint64_t seed);

MRF_CSR* pottsMRF(uint64_t n, uint64_t C, uint64_t seed);

MRF_CSR* randomTree(uint64_t n, uint64_t C, uint64_t seed);

MRF_CSR* deterministicTree(uint64_t n);

} // namespace examples_mrf
