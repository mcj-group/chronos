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

`ifdef XILINX_SIMULATOR
   `define DEBUG
`endif
import chronos::*;

module maxflow_discharge
#(
) (
   input ap_clk,
   input ap_rst_n,

   input ap_start,
   output logic ap_done,
   output logic ap_idle,
   output logic ap_ready,

   input [TQ_WIDTH-1:0] task_in, 

   output logic [TQ_WIDTH-1:0] task_out_V_TDATA,
   output logic task_out_V_TVALID,
   input task_out_V_TREADY,
        
   output logic [UNDO_LOG_ADDR_WIDTH + UNDO_LOG_DATA_WIDTH -1:0] undo_log_entry,
   output logic undo_log_entry_ap_vld,
   input undo_log_entry_ap_rdy,
   
   output logic         m_axi_l1_V_AWVALID ,
   input                m_axi_l1_V_AWREADY,
   output logic [31:0]  m_axi_l1_V_AWADDR ,
   output logic [7:0]   m_axi_l1_V_AWLEN  ,
   output logic [2:0]   m_axi_l1_V_AWSIZE ,
   output logic         m_axi_l1_V_WVALID ,
   input                m_axi_l1_V_WREADY ,
   output logic [31:0]  m_axi_l1_V_WDATA  ,
   output logic [3:0]   m_axi_l1_V_WSTRB  ,
   output logic         m_axi_l1_V_WLAST  ,
   output logic         m_axi_l1_V_ARVALID,
   input                m_axi_l1_V_ARREADY,
   output logic [31:0]  m_axi_l1_V_ARADDR ,
   output logic [7:0]   m_axi_l1_V_ARLEN  ,
   output logic [2:0]   m_axi_l1_V_ARSIZE ,
   input                m_axi_l1_V_RVALID ,
   output logic         m_axi_l1_V_RREADY ,
   input [63:0]         m_axi_l1_V_RDATA  ,
   input                m_axi_l1_V_RLAST  ,
   input                m_axi_l1_V_RID    ,
   input [1:0]          m_axi_l1_V_RRESP  ,
   input                m_axi_l1_V_BVALID ,
   output logic         m_axi_l1_V_BREADY ,
   input [1:0]          m_axi_l1_V_BRESP  ,
   input                m_axi_l1_V_BID,

   output logic [31:0]  ap_state
);

localparam DISCHARGE_TASK = 0;
localparam GET_HEIGHT_TASK = 1;
localparam PUSH_TASK = 2;
localparam RECEIVE_TASK = 3;
localparam BFS_TASK = 4;

localparam VID_EXCESS_OFFSET = 0;
localparam VID_COUNTER_MIN_HEIGHT_OFFSET = 4;
localparam VID_HEIGHT_OFFSET = 8;
localparam VID_VISITED_OFFSET = 12;

localparam EDGE_DEST_OFFSET = 0;
localparam EDGE_CAPACITY_OFFSET = 4;
localparam EDGE_REV_INDEX_OFFSET = 8;

localparam RO_OFFSET = 0;

typedef enum logic[3:0] {
      NEXT_TASK,
      READ_HEADERS, WAIT_HEADERS,
      // 3
      DISCHARGE_LAUNCH_GR_SINK,
      DISCHARGE_LAUNCH_GR_SOURCE,
      DISCHARGE_REENQUEUE,
      // 6
      DISCHARGE_READ_OFFSET, DISCHARGE_WAIT_OFFSET,
      DISCHARGE_READ_VID, DISCHARGE_WAIT_VID, // read active, counter, min_height
      DISCHARGE_UNDO_LOG_WRITE_COUNTER,
      DISCHARGE_WRITE_COUNTER,
      // 12
      DISCHARGE_READ_NEIGHBORS, DISCHARGE_WAIT_NEIGHBORS, 
      DISCHARGE_ENQ_NEIGHBORS,
      // 15
      FINISH_TASK
   } maxflow_state_t;


task_t task_rdata, task_wdata; 
assign {task_rdata.args, task_rdata.ttype, task_rdata.object, task_rdata.ts} = task_in; 

assign task_out_V_TDATA = 
      {task_wdata.args, task_wdata.ttype, task_wdata.object, task_wdata.ts}; 

logic clk, rstn;
assign clk = ap_clk;
assign rstn = ap_rst_n;

undo_log_addr_t undo_log_addr;
undo_log_data_t undo_log_data;

maxflow_state_t state, state_next;
task_t cur_task;

assign ap_state = state;

// next expected read word in a burst read
logic [3:0] word_id;
always_ff @(posedge clk) begin
   if (!rstn) begin
      word_id <= 0;
   end else begin
      if (m_axi_l1_V_ARVALID) begin
         word_id <= 0;
      end else if (m_axi_l1_V_RVALID) begin
         word_id <= word_id + 1;
      end
   end
end

// headers
logic [31:0] numV, numE;
logic [31:0] base_edge_offset;
logic [31:0] base_neighbors;
logic [31:0] base_vertex_data;
logic [31:0] sourceNode, sinkNode;
logic [31:0] global_relabel_mask;
logic [31:0] iteration_no_mask;
logic ordered_edges;

logic [31:0] eo_begin, eo_end;

// vertex data
logic signed [31:0] vid_excess;
logic [3:0] vid_counter;
logic [23:0] vid_min_neighbor_height;
logic [31:0] vid_height;
logic [31:0] vid_visited;
logic signed [31:0] edge_flow;

logic [23:0] edge_dest [0:15];
logic signed [31:0] edge_capacity;
logic [ 7:0] edge_rev_index [0:15];

logic [3:0] neighbor_offset;
logic [31:0] neighbor_edge_offset;
always_ff @(posedge clk) begin
   if (m_axi_l1_V_RVALID) begin
      case (state) 
         WAIT_HEADERS: begin
            case (word_id)
               0: begin
                  numV <= m_axi_l1_V_RDATA[63:32];
               end
               1: begin
                  numE <= m_axi_l1_V_RDATA[31:0];
                  base_edge_offset <= {m_axi_l1_V_RDATA[61:32], 2'b00};
               end
               2: begin
                  base_neighbors <= {m_axi_l1_V_RDATA[29:0], 2'b00};
                  base_vertex_data <= {m_axi_l1_V_RDATA[61:32], 2'b00};
               end
               3: begin
                  sourceNode <= m_axi_l1_V_RDATA[63:32];
               end
               4: begin
                  sinkNode <= m_axi_l1_V_RDATA[63:32];
               end
               5: begin
                  global_relabel_mask <= m_axi_l1_V_RDATA[63:32];
               end
               6: begin
                  iteration_no_mask <= m_axi_l1_V_RDATA[31:0];
                  ordered_edges <= m_axi_l1_V_RDATA[32];
               end
               /*
               1: numV <= m_axi_l1_V_RDATA;
               2: numE <= m_axi_l1_V_RDATA;
               3: base_edge_offset <= {m_axi_l1_V_RDATA[30:0], 2'b00};
               4: base_neighbors <= {m_axi_l1_V_RDATA[30:0], 2'b00};
               5: base_vertex_data <= {m_axi_l1_V_RDATA[30:0], 2'b00};
               7: sourceNode <= m_axi_l1_V_RDATA;
               9: sinkNode <= m_axi_l1_V_RDATA;
               11: global_relabel_mask <= m_axi_l1_V_RDATA;
               12: iteration_no_mask <= m_axi_l1_V_RDATA;
               13: ordered_edges <= m_axi_l1_V_RDATA[0];
               */
            endcase
         end
         DISCHARGE_WAIT_OFFSET: begin
            case (word_id)
               0: eo_begin <= m_axi_l1_V_RDATA; 
               1: eo_end <= m_axi_l1_V_RDATA;
            endcase
         end
         DISCHARGE_WAIT_NEIGHBORS: begin
            edge_dest[word_id] <= m_axi_l1_V_RDATA[23:0];
         end
         DISCHARGE_WAIT_VID: begin
            vid_counter <= m_axi_l1_V_RDATA[31:24];
            vid_min_neighbor_height <= m_axi_l1_V_RDATA[23:0];
         end

      endcase
   end 
end

always_ff @(posedge clk) begin
   if (state == NEXT_TASK) begin
      neighbor_offset <= 0;
   end else if (state == DISCHARGE_ENQ_NEIGHBORS
      && task_out_V_TVALID & task_out_V_TREADY) begin
      neighbor_offset <= neighbor_offset + 1;
   end 
end


assign ap_done = (state == FINISH_TASK);
assign ap_idle = (state == NEXT_TASK);
assign ap_ready = (state == NEXT_TASK);

assign m_axi_l1_V_RREADY = ( 
                     (state == WAIT_HEADERS) 
                   | (state == DISCHARGE_WAIT_OFFSET) 
                   | (state == DISCHARGE_WAIT_VID) 
                   | (state == DISCHARGE_WAIT_NEIGHBORS) 
                     );

logic initialized;

always_ff @(posedge clk) begin
   if (!rstn) begin
      initialized <= 1'b0;
   end else if (state == WAIT_HEADERS) begin
      initialized <= 1'b1;
   end
end

assign cur_task = task_rdata;

assign m_axi_l1_V_AWSIZE  = 3'b010; // 32 bits
assign m_axi_l1_V_AWLEN   = 0; // 1 beat
assign m_axi_l1_V_WVALID = m_axi_l1_V_AWVALID;
assign m_axi_l1_V_WSTRB   = 4'b1111; 
assign m_axi_l1_V_WLAST   = m_axi_l1_V_AWVALID;

logic [31:0] cur_vertex_addr;
assign cur_vertex_addr = (base_vertex_data + (cur_task.object[30:0] << 6));

logic [31:0] cur_arg_0;
logic signed [31:0] cur_arg_1;
assign cur_arg_0 = cur_task.args[31:0];
assign cur_arg_1 = cur_task.args[63:32];

logic [3:0] push_to_index;
assign push_to_index = cur_arg_1[3:0];

logic signed [31:0] push_flow_amt, push_flow_amt_reg;
always_comb begin
   if (vid_excess > (edge_capacity - edge_flow)) begin
      push_flow_amt = edge_capacity - edge_flow;
   end else begin
      push_flow_amt = vid_excess;
   end
end

maxflow_state_t task_begin_state;
always_comb begin
   case (cur_task.ttype)
      0: begin
         if ((cur_task.ts & global_relabel_mask) == 0) begin
            task_begin_state = DISCHARGE_LAUNCH_GR_SINK;
         end else begin
            task_begin_state = DISCHARGE_READ_OFFSET;
         end
      end
      default: task_begin_state = FINISH_TASK;
   endcase
end

always_comb begin
   m_axi_l1_V_ARLEN   = 0; // 1 beat
   m_axi_l1_V_ARVALID = 1'b0;
   m_axi_l1_V_ARADDR  = 64'h0;

   task_out_V_TVALID = 1'b0;
   task_wdata  = 'x;

   undo_log_entry_ap_vld = 1'b0;
   undo_log_addr = 'x;
   undo_log_data = 'x;
   
   m_axi_l1_V_AWVALID = 0;
   m_axi_l1_V_AWADDR  = 0;
   m_axi_l1_V_WDATA   = 'x;
   
   m_axi_l1_V_ARSIZE  = 3'b010; // 32 bits
   state_next = state;

   case(state)
      NEXT_TASK: begin
         if (ap_start) begin
            state_next = initialized ? task_begin_state : READ_HEADERS;
         end
      end
      READ_HEADERS: begin
         m_axi_l1_V_ARADDR = 0;
         m_axi_l1_V_ARVALID = 1'b1;
         m_axi_l1_V_ARSIZE  = 3'b011; // 64 bits
         m_axi_l1_V_ARLEN = 6;
         if (m_axi_l1_V_ARREADY) begin
            state_next = WAIT_HEADERS;
         end
      end
      WAIT_HEADERS: begin
         if (m_axi_l1_V_RVALID & m_axi_l1_V_RLAST) begin
            state_next = task_begin_state;  
         end
      end
      DISCHARGE_LAUNCH_GR_SINK: begin
         if ((cur_task.ts & 32'hf0) == 0) begin // tile == 0
            task_wdata.ttype = BFS_TASK;
            task_wdata.object = sinkNode ; // vid
            task_wdata.ts = cur_task.ts; 
            task_out_V_TVALID = 1'b1;
            if (task_out_V_TREADY) begin
               state_next = DISCHARGE_LAUNCH_GR_SOURCE;
            end 
         end else begin
            state_next = DISCHARGE_REENQUEUE;
         end
      end
      DISCHARGE_LAUNCH_GR_SOURCE: begin
         task_wdata.ttype = BFS_TASK;
         task_wdata.object = sourceNode;
         task_wdata.ts = cur_task.ts | (1<<11); 
         task_out_V_TVALID = 1'b1;
         if (task_out_V_TREADY) begin
            state_next = DISCHARGE_REENQUEUE;
         end 
      end
      DISCHARGE_REENQUEUE: begin
         task_wdata = cur_task;
         task_out_V_TVALID = 1'b1;
         if (task_out_V_TREADY) begin
            state_next = FINISH_TASK;
         end 
      end
      DISCHARGE_READ_OFFSET: begin
         m_axi_l1_V_ARADDR = base_edge_offset + (cur_task.object << 2);
         m_axi_l1_V_ARLEN = 1;
         m_axi_l1_V_ARVALID = 1'b1;
         if (m_axi_l1_V_ARREADY) begin
            state_next = DISCHARGE_WAIT_OFFSET;
         end
      end
      DISCHARGE_WAIT_OFFSET: begin
         if (m_axi_l1_V_RVALID & m_axi_l1_V_RLAST) begin
            state_next = DISCHARGE_READ_VID;
         end
      end
      DISCHARGE_READ_VID: begin // counter, min_height
         m_axi_l1_V_ARADDR = cur_vertex_addr | VID_COUNTER_MIN_HEIGHT_OFFSET;
         m_axi_l1_V_ARLEN = 0;
         m_axi_l1_V_ARVALID = 1'b1;
         if (m_axi_l1_V_ARREADY) begin
            state_next = DISCHARGE_WAIT_VID;
         end
      end
      DISCHARGE_WAIT_VID: begin
         if (m_axi_l1_V_RVALID & m_axi_l1_V_RLAST) begin
            state_next = DISCHARGE_UNDO_LOG_WRITE_COUNTER;
         end
      end
      DISCHARGE_UNDO_LOG_WRITE_COUNTER: begin
         undo_log_entry_ap_vld = 1'b1;
         undo_log_addr = cur_vertex_addr | VID_COUNTER_MIN_HEIGHT_OFFSET;
         undo_log_data[31:24] = vid_counter;
         undo_log_data[23:0] = vid_min_neighbor_height;
         if (undo_log_entry_ap_rdy) begin
            state_next = DISCHARGE_WRITE_COUNTER;
         end
      end
      DISCHARGE_WRITE_COUNTER: begin
         m_axi_l1_V_AWADDR = cur_vertex_addr | VID_COUNTER_MIN_HEIGHT_OFFSET; 
         m_axi_l1_V_WDATA[31:24] = eo_end - eo_begin;
         m_axi_l1_V_WDATA[23: 0] = 2 * numV;
         m_axi_l1_V_AWVALID = 1'b1;
         if (m_axi_l1_V_AWREADY) begin
            state_next = DISCHARGE_READ_NEIGHBORS;
         end
      end
      DISCHARGE_READ_NEIGHBORS: begin
         // assert (degree > 0)
         m_axi_l1_V_ARADDR = base_neighbors + (eo_begin << 3);
         m_axi_l1_V_ARLEN = eo_end - eo_begin - 1;
         m_axi_l1_V_ARSIZE  = 3'b011; // 64 bits
         m_axi_l1_V_ARVALID = 1'b1;
         if (m_axi_l1_V_ARREADY) begin
            state_next = DISCHARGE_WAIT_NEIGHBORS;
         end
      end
      DISCHARGE_WAIT_NEIGHBORS: begin
         if (m_axi_l1_V_RVALID & m_axi_l1_V_RLAST) begin
            state_next = DISCHARGE_ENQ_NEIGHBORS;
         end
      end
      DISCHARGE_ENQ_NEIGHBORS: begin
         task_wdata.ttype = GET_HEIGHT_TASK;
         task_wdata.object = edge_dest[neighbor_offset] | RO_OFFSET;
         task_wdata.args[31:0] = cur_task.object; 
         task_wdata.args[63:32] = neighbor_offset; 
         task_wdata.ts = cur_task.ts | (ordered_edges ? neighbor_offset: 0); 
         task_out_V_TVALID = 1'b1;
         if (task_out_V_TREADY) begin
            if (neighbor_offset + 1 == (eo_end - eo_begin)) begin
               state_next = FINISH_TASK;
            end
         end 
      end

      FINISH_TASK: begin
         state_next = NEXT_TASK;
      end
   endcase
end

assign m_axi_l1_V_BREADY  = 1'b1;
assign undo_log_entry = {undo_log_data, undo_log_addr};


always_ff @(posedge clk) begin
   if (~rstn) begin
      state <= NEXT_TASK;
   end else begin
      state <= state_next;
   end
end




endmodule
