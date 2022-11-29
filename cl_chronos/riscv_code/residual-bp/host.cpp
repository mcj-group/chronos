#include <cassert>
#include <iostream>

#include <cmath>
#include <string>
#include <fstream>
#include <vector>
#include <array>

#include "main_rbp.cpp"
#include "examples_mrf_CSR.cpp"
#include "mrf_CSR.cpp"

using Results = std::vector<std::array<double,2>>;

int main(int argc, const char** argv) {
    if (argc < 4) {
        std::cerr << "Usage: "
                  << argv[0]
                  << " <algorithm>"
                  << " <mrf>"
                  << " <size>"
                  << " [<threads>]"
                  << std::endl;
        return -1;
    }

    std::string algorithm(argv[1]);
    std::string mrfName(argv[2]);
    uint64_t size = atol(argv[3]);
    assert(size > 0);

    assert(argc == 4 || algorithm == "relaxed-rbp");

    MRF_CSR* mrf = nullptr;
    if (mrfName == "ising") {
        mrf = examples_mrf_CSR::isingMRF(size, size, 2, 1);
    } else if (mrfName == "potts") {
        mrf = examples_mrf_CSR::pottsMRF(size, 5, 1);
    } else if (mrfName == "tree") {
        mrf = examples_mrf_CSR::randomTree(size, 5, 1);
    } else if (mrfName == "deterministic_tree") {
        mrf = examples_mrf_CSR::deterministicTree(size);
    } else {
        std::cerr << "Unrecognized MRF: " << mrfName << std::endl;
        return 1;
    }

    assert(mrf);
    std::cout << "The " << mrfName << " model has been set up" << std::endl;

    double sensitivity = 1e-5;
    Results res;

    if (algorithm == "residual") {
        solve_rbp(mrf, sensitivity);
    } else {
        std::cerr << "Unrecognized algorithm: " << algorithm << std::endl;
        return 1;
    }

    mrf->getNodeProbabilities(&res);

    delete mrf;
    assert(!res.empty());

    if (mrfName == "deterministic_tree") {
        for (uint64_t i = 0; i < size; i++) {
            if (std::abs (res[i][0] - 0.1) > 0.001) {
                std::cerr << "Something is wrong with vertex "
                          << i << std::endl;
                return 1;
            }
        }
        std::cout << "Everything is fine\n";
    }

    std::string arg3 = std::to_string(size);
    std::string filename("output-" + mrfName + "-" + arg3);
    uint64_t len = res.size();
    uint64_t wid = res[0].size();
    if (algorithm == "residual") {
        std::ofstream ostrm(filename);
        for (uint64_t i = 0; i < len; i++) {
            for (uint64_t j = 0; j < wid; j++) {
                ostrm << res[i][j] << " ";
            }
            ostrm << "\n";
        }
    } else {
        std::ifstream istrm(filename);
        if (! istrm.good()) {
            std::cerr <<  "Correctness-checking file does not exist "
                      << filename << std::endl;
            return 1;
        }

        Results jury(res.size());

        for (uint64_t i = 0; i < len; i++) {
            for (uint64_t j = 0; j < wid; j++) {
                double d1;
                istrm >> d1;
                jury[i][j] = d1;
            }
        }

        double accuracy = 0;
        double accuracyMax = 0;
        for (uint64_t i = 0; i < len; i++) {
            double L1 = 0;
            for (uint64_t j = 0; j < wid; j++) {
                L1 += std::abs(jury[i][j] - res[i][j]);
            }
            accuracy += L1;
            accuracyMax = std::max(accuracyMax, L1);
        }
        std::cout << "Accuracy:" << std::to_string(accuracy / res.size()) << std::endl;
        std::cout << "AccuracyMax:" << std::to_string(accuracyMax) << std::endl;
    }
    std::cout << "The first results are "
              << res[0][0]
              << " and "
              << res[0][1]
              << std::endl;

    // TODO(mcj) results to file like the Java version.

    return 0;
}