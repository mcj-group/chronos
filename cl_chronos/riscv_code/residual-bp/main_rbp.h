#include "../include/simulator_fpu.h"
#include "mrf_CSR.h"

#define PRIORITIZE_TASK    1
#define FETCH_REVERSE_LOG_MU_0_TASK    2
#define FETCH_LOG_PRODUCT_IN_0_TASK   3
#define FETCH_REVERSE_LOG_MU_1_TASK    4
#define FETCH_LOG_PRODUCT_IN_1_TASK   5
#define UPDATE_LOOKAHEAD_TASK    6
#define ENQUEUE_UPDATE_TASK   7
#define UPDATE_TASK  8
#define UPDATE_MESSAGE_TASK 9
#define UPDATE_LOG_PRODUCT_IN_TASK 10
#define PROPAGATE_TASK  11

static constexpr uint64_t LENGTH = MRF_CSR::LENGTH;

void solve_rbp(MRF_CSR *mrf_in, double sensitivity);

// read reverse log mu
void prioritize_task(uint64_t ts, message_id m_id);

// reverse log mu
void fetch_reverse_log_mu_0_task(uint64_t ts, message_id reverse_m_id, message_id m_id);

// reverse log product in
void fetch_log_product_in_0_task(uint64_t ts, node_id dest, double reverse_log_mu_0, message_id reverse_m_id, message_id m_id);

void fetch_reverse_log_mu_1_task(uint64_t ts, message_id reverse_m_id, double difference_0, node_id dest, message_id m_id);

void fetch_log_product_in_1_task(uint64_t ts, node_id dest, double difference_0, double reverse_log_mu_1, message_id m_id);

void update_look_ahead_task(uint64_t ts, message_id m_id, double difference_0, double difference_1);

// calculate priority, writes to lookahead, and enqueue update task
void enqueue_update_task(uint64_t ts, message_id m_id, double result_0, double result_1);

uint64_t timeline(double priority);

void update_task(uint64_t ts, message_id m_id, double result_0, double result_1);

void update_message_task(uint64_t ts, message_id m_id, double result_0, double result_1);

void update_log_product_in_task(uint64_t ts, node_id n_id, double old_log_mu_0, double old_log_mu_1, double new_log_mu_0, double new_log_mu_1);

void propagate_task(uint64_t ts, node_id n_id);
