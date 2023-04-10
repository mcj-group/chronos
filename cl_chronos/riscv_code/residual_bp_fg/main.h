#include "utils.h"

#define INIT_TASK                           0
#define PRIORITIZE_TASK                     1
#define FETCH_REVERSE_LOGMU_TASK            2
#define WRITE_REVERSE_LOGMU_TASK            3
#define FETCH_LOGPRODUCTIN_TASK             4
#define WRITE_LOGPRODUCTIN_TASK             5
#define UPDATE_PRIORITY_TASK                6
#define LOGSUM_TASK                         7
#define WRITE_LOGSUM_TASK                   8
#define UPDATE_LOOKAHEAD_TASK               9
#define EXP_TASK                            10
#define WRITE_EXP_TASK                      11
#define CALCULATE_RESIDUAL_TASK             12
#define ENQ_UPDATE_MESSAGE_TASK             13
#define UPDATE_MESSAGE_TASK                 14
#define UPDATE_LOGPRODUCTIN_TASK            15

// The location pointing to the base of each of the arrays
const int ADDR_BASE_NUMV = 1 << 2;
const int ADDR_BASE_NUME = 2 << 2;
const int ADDR_BASE_EDGE_INDICES = 3 << 2;
const int ADDR_BASE_EDGE_DEST = 4 << 2;
const int ADDR_BASE_REVERSE_EDGE_INDICES = 5 << 2;
const int ADDR_BASE_REVERSE_EDGE_DEST = 6 << 2;
const int ADDR_BASE_REVERSE_EDGE_ID = 7 << 2;
const int ADDR_BASE_MESSAGES = 8 << 2;
const int ADDR_BASE_CONVERGED_MESSAGES = 9 << 2;
const int ADDR_BASE_NODES = 10 << 2;
const int ADDR_BASE_EDGES = 11 << 2;
const int ADDR_BASE_SENSITIVITY = 12 << 2;
const int ADDR_BASE_END = 13 << 2;

