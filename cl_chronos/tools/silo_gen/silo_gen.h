/** $lic$
 * Copyright (C) 2014-2019 by Massachusetts Institute of Technology
 *
 * This file is part of the Chronos FPGA Acceleration Framework.
 *
 * Chronos is free software; you can redistribute it and/or modify it under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation, version 2.
 *
 * If you use this framework in your research, we request that you reference
 * the Chronos paper ("Chronos: Efficient Speculative Parallelism for
 * Accelerators", Abeydeera and Sanchez, ASPLOS-25, March 2020), and that
 * you send us a citation of your work.
 *
 * Chronos is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */


#include <random>
#include <stdio.h>
#include <string.h>
#include <vector>

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;

struct warehouse_ro {
   uint32_t w_tax;
};

struct district_ro {
   uint32_t d_tax;
   char addr[16];
};

struct district_rw {
   uint32_t d_next_o_id;
   uint32_t d_ytd;
};

struct customer_ro {
   uint32_t c_id : 24;
   uint32_t c_d_id : 5;
   uint32_t c_w_id : 3;
   uint32_t c_since;
   char c_credit[2];
   uint32_t c_credit_lim;
   uint32_t c_discount;
   char c_string_data[128];

};

struct customer_rw {
   uint32_t c_id : 24;
   uint32_t c_d_id : 5;
   uint32_t c_w_id : 3;
   uint32_t c_balance;
   uint32_t c_ytd_payment;
   uint32_t c_payment_cnt;
   uint32_t c_delivery_cnt;

   char c_data [450]; // to fit into a cache line
};

struct order{
   uint32_t o_id : 24;
   uint32_t o_d_id: 5;
   uint32_t o_w_id : 3;
   uint32_t o_c_id;
   uint32_t o_entry_d;
   uint8_t o_carrier_id;
   uint8_t o_ol_cnt;
   uint8_t o_all_local;
   uint8_t __padding__;
};

struct order_line {
   uint32_t ol_o_id : 20;
   uint32_t ol_d_id : 5;
   uint32_t ol_w_id : 3;
   uint32_t ol_number : 4;
   uint32_t ol_i_id;
   uint8_t ol_supply_w_id;
   uint8_t ol_quantity;
   uint16_t ol_amount;
   uint32_t ol_delivery_d;
   char ol_dist_info[24];
};

struct item {
   uint32_t i_id;
   uint32_t i_im_id;
   uint32_t i_price;
   char i_name[24];
   char i_data[50];
};

struct stock {
   uint32_t s_i_id : 28;
   uint32_t s_w_id: 4;
   uint32_t s_quantity;
   uint32_t s_order_cnt;
   uint32_t s_remote_cnt;
   uint32_t s_ytd;
};

struct new_order {
   uint32_t no_o_id : 24;
   uint32_t no_d_id : 5;
   uint32_t no_w_id : 3;
};

struct history {
   uint32_t h_c_id;
   uint8_t h_c_d_id;
   uint8_t h_c_w_id;
   uint8_t h_d_id;
   uint8_t h_w_id;
   uint32_t h_date;
   uint32_t h_amount;
   char h_data[24];
};

struct table_info {
   uint8_t log_bucket_size;
   uint8_t log_num_buckets;
   uint16_t record_size; // in bytes
   uint8_t* table_base;
};

struct fifo_table_info {
   uint8_t* fifo_base;
   uint32_t num_records;
   uint32_t record_size;
   uint32_t* addr_pointer;
};

struct tx_info_new_order {
   uint32_t tx_type : 4;
   uint32_t w_id : 4;
   uint32_t d_id : 4;
   uint32_t num_items : 4;
   uint32_t c_id : 16;
};
struct tx_info_new_order_item {
   uint32_t i_id : 24;
   uint32_t i_qty : 4;
   uint32_t i_s_wid: 4;
};

int size_of_field(int items, int size_of_item){ // in bytes
	const int CACHE_LINE_SIZE = 64;
	return ( (items * size_of_item + CACHE_LINE_SIZE-1) /CACHE_LINE_SIZE) * CACHE_LINE_SIZE ;
}


int RandomNumber(int min, int max)
{
 // [0, UINT64_MAX] -> (int) [min, max]
 int n = rand();
 int m = n % (max - min + 1);
 return min + (int) m;
}

int NonUniformRandom(int A, int C, int min, int max)
{
 return (((RandomNumber(0, A) | RandomNumber(min, max)) + C) % (max - min + 1)) + min;
}

uint32_t hash_key(uint32_t n) {
   uint32_t keys[] = {
      0xc4252fd6,
      0xfefae102,
      0x0893b429,
      0x6c6c8792,
      0xf48f4329,
      0xe507f162,
      0x53b8d2ce,
      0xfd90b3aa,
      0xc12fd5f1,
      0x01b1aea4,
      0xa12054b1,
      0xb6c529dc,
      0x6f84e59e,
      0x90b2164e,
      0xa19b2cfe,
      0x34600bf4,
      0x94f792e4,
      0x10f09caa,
      0x14671d06,
      0xa7516124,
      0xe02b122c,
      0x245254ca,
      0x452fa591,
      0x190a4e54,
      0x4c50401e,
      0x87a1574d,
      0x780e947e,
      0x3b613b60,
      0x2b0404f3,
      0x8c103276,
      0x615735a1,
      0x925e0a83
   };
   unsigned int res = 0;
   for (int i=0;i<32;i++) {
      uint32_t t = (keys[i] & n);
      int bits = 0;
      while (t!=0) {
         if (t&1) bits++;
         t >>=1;
      }
      if (bits &1)
      res |= (1<<i);
   }
   return res;

}
