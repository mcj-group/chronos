// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : VexRiscv
// Git hash  : c8dff13391fb0c58aa6316a3ad111fe093e9f5a3

`timescale 1ns/1ps

module VexRiscv (
  output              dBus_cmd_valid,
  input               dBus_cmd_ready,
  output              dBus_cmd_payload_wr,
  output              dBus_cmd_payload_uncached,
  output     [31:0]   dBus_cmd_payload_address,
  output     [31:0]   dBus_cmd_payload_data,
  output     [3:0]    dBus_cmd_payload_mask,
  output     [1:0]    dBus_cmd_payload_size,
  output              dBus_cmd_payload_last,
  input               dBus_rsp_valid,
  input               dBus_rsp_payload_last,
  input      [31:0]   dBus_rsp_payload_data,
  input               dBus_rsp_payload_error,
  input               timerInterrupt,
  input               externalInterrupt,
  input               softwareInterrupt,
  input               debug_bus_cmd_valid,
  output reg          debug_bus_cmd_ready,
  input               debug_bus_cmd_payload_wr,
  input      [7:0]    debug_bus_cmd_payload_address,
  input      [31:0]   debug_bus_cmd_payload_data,
  output reg [31:0]   debug_bus_rsp_data,
  output              debug_resetOut,
  output              iBus_cmd_valid,
  input               iBus_cmd_ready,
  output reg [31:0]   iBus_cmd_payload_address,
  output     [2:0]    iBus_cmd_payload_size,
  input               iBus_rsp_valid,
  input      [31:0]   iBus_rsp_payload_data,
  input               iBus_rsp_payload_error,
  input               clk,
  input               reset,
  input               debugReset
);
  localparam ShiftCtrlEnum_DISABLE_1 = 2'd0;
  localparam ShiftCtrlEnum_SLL_1 = 2'd1;
  localparam ShiftCtrlEnum_SRL_1 = 2'd2;
  localparam ShiftCtrlEnum_SRA_1 = 2'd3;
  localparam FpuOpcode_LOAD = 4'd0;
  localparam FpuOpcode_STORE = 4'd1;
  localparam FpuOpcode_MUL = 4'd2;
  localparam FpuOpcode_ADD = 4'd3;
  localparam FpuOpcode_FMA = 4'd4;
  localparam FpuOpcode_I2F = 4'd5;
  localparam FpuOpcode_F2I = 4'd6;
  localparam FpuOpcode_CMP = 4'd7;
  localparam FpuOpcode_DIV = 4'd8;
  localparam FpuOpcode_SQRT = 4'd9;
  localparam FpuOpcode_MIN_MAX = 4'd10;
  localparam FpuOpcode_SGNJ = 4'd11;
  localparam FpuOpcode_FMV_X_W = 4'd12;
  localparam FpuOpcode_FMV_W_X = 4'd13;
  localparam FpuOpcode_FCLASS = 4'd14;
  localparam FpuOpcode_FCVT_X_X = 4'd15;
  localparam BranchCtrlEnum_INC = 2'd0;
  localparam BranchCtrlEnum_B = 2'd1;
  localparam BranchCtrlEnum_JAL = 2'd2;
  localparam BranchCtrlEnum_JALR = 2'd3;
  localparam EnvCtrlEnum_NONE = 1'd0;
  localparam EnvCtrlEnum_XRET = 1'd1;
  localparam AluBitwiseCtrlEnum_XOR_1 = 2'd0;
  localparam AluBitwiseCtrlEnum_OR_1 = 2'd1;
  localparam AluBitwiseCtrlEnum_AND_1 = 2'd2;
  localparam Src2CtrlEnum_RS = 2'd0;
  localparam Src2CtrlEnum_IMI = 2'd1;
  localparam Src2CtrlEnum_IMS = 2'd2;
  localparam Src2CtrlEnum_PC = 2'd3;
  localparam AluCtrlEnum_ADD_SUB = 2'd0;
  localparam AluCtrlEnum_SLT_SLTU = 2'd1;
  localparam AluCtrlEnum_BITWISE = 2'd2;
  localparam Src1CtrlEnum_RS = 2'd0;
  localparam Src1CtrlEnum_IMU = 2'd1;
  localparam Src1CtrlEnum_PC_INCREMENT = 2'd2;
  localparam Src1CtrlEnum_URS1 = 2'd3;
  localparam FpuFormat_FLOAT = 1'd0;
  localparam FpuFormat_DOUBLE = 1'd1;
  localparam FpuRoundMode_RNE = 3'd0;
  localparam FpuRoundMode_RTZ = 3'd1;
  localparam FpuRoundMode_RDN = 3'd2;
  localparam FpuRoundMode_RUP = 3'd3;
  localparam FpuRoundMode_RMM = 3'd4;

  wire                IBusCachedPlugin_cache_io_flush;
  wire                IBusCachedPlugin_cache_io_cpu_prefetch_isValid;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_isValid;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_isStuck;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_isRemoved;
  wire                IBusCachedPlugin_cache_io_cpu_decode_isValid;
  wire                IBusCachedPlugin_cache_io_cpu_decode_isStuck;
  wire                IBusCachedPlugin_cache_io_cpu_decode_isUser;
  reg                 IBusCachedPlugin_cache_io_cpu_fill_valid;
  wire                dataCache_1_io_cpu_execute_isValid;
  wire       [31:0]   dataCache_1_io_cpu_execute_address;
  wire                dataCache_1_io_cpu_memory_isValid;
  wire       [31:0]   dataCache_1_io_cpu_memory_address;
  reg                 dataCache_1_io_cpu_memory_mmuRsp_isIoAccess;
  reg                 dataCache_1_io_cpu_writeBack_isValid;
  wire                dataCache_1_io_cpu_writeBack_isUser;
  reg        [31:0]   dataCache_1_io_cpu_writeBack_storeData;
  wire       [31:0]   dataCache_1_io_cpu_writeBack_address;
  wire                dataCache_1_io_cpu_writeBack_fence_SW;
  wire                dataCache_1_io_cpu_writeBack_fence_SR;
  wire                dataCache_1_io_cpu_writeBack_fence_SO;
  wire                dataCache_1_io_cpu_writeBack_fence_SI;
  wire                dataCache_1_io_cpu_writeBack_fence_PW;
  wire                dataCache_1_io_cpu_writeBack_fence_PR;
  wire                dataCache_1_io_cpu_writeBack_fence_PO;
  wire                dataCache_1_io_cpu_writeBack_fence_PI;
  wire       [3:0]    dataCache_1_io_cpu_writeBack_fence_FM;
  wire                dataCache_1_io_cpu_flush_valid;
  wire                dataCache_1_io_cpu_flush_payload_singleLine;
  reg        [31:0]   _zz_RegFilePlugin_regFile_port0;
  reg        [31:0]   _zz_RegFilePlugin_regFile_port1;
  wire                IBusCachedPlugin_cache_io_cpu_prefetch_haltIt;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_fetch_data;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress;
  wire                IBusCachedPlugin_cache_io_cpu_decode_error;
  wire                IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling;
  wire                IBusCachedPlugin_cache_io_cpu_decode_mmuException;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_decode_data;
  wire                IBusCachedPlugin_cache_io_cpu_decode_cacheMiss;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_decode_physicalAddress;
  wire                IBusCachedPlugin_cache_io_mem_cmd_valid;
  wire       [31:0]   IBusCachedPlugin_cache_io_mem_cmd_payload_address;
  wire       [2:0]    IBusCachedPlugin_cache_io_mem_cmd_payload_size;
  wire                dataCache_1_io_cpu_execute_haltIt;
  wire                dataCache_1_io_cpu_execute_refilling;
  wire                dataCache_1_io_cpu_memory_isWrite;
  wire                dataCache_1_io_cpu_writeBack_haltIt;
  wire       [31:0]   dataCache_1_io_cpu_writeBack_data;
  wire                dataCache_1_io_cpu_writeBack_mmuException;
  wire                dataCache_1_io_cpu_writeBack_unalignedAccess;
  wire                dataCache_1_io_cpu_writeBack_accessError;
  wire                dataCache_1_io_cpu_writeBack_isWrite;
  wire                dataCache_1_io_cpu_writeBack_keepMemRspData;
  wire                dataCache_1_io_cpu_writeBack_exclusiveOk;
  wire                dataCache_1_io_cpu_flush_ready;
  wire                dataCache_1_io_cpu_redo;
  wire                dataCache_1_io_mem_cmd_valid;
  wire                dataCache_1_io_mem_cmd_payload_wr;
  wire                dataCache_1_io_mem_cmd_payload_uncached;
  wire       [31:0]   dataCache_1_io_mem_cmd_payload_address;
  wire       [31:0]   dataCache_1_io_mem_cmd_payload_data;
  wire       [3:0]    dataCache_1_io_mem_cmd_payload_mask;
  wire       [1:0]    dataCache_1_io_mem_cmd_payload_size;
  wire                dataCache_1_io_mem_cmd_payload_last;
  wire                FpuPlugin_fpu_io_port_0_cmd_ready;
  wire                FpuPlugin_fpu_io_port_0_commit_ready;
  wire                FpuPlugin_fpu_io_port_0_rsp_valid;
  wire       [31:0]   FpuPlugin_fpu_io_port_0_rsp_payload_value;
  wire                FpuPlugin_fpu_io_port_0_rsp_payload_NV;
  wire                FpuPlugin_fpu_io_port_0_rsp_payload_NX;
  wire                FpuPlugin_fpu_io_port_0_completion_valid;
  wire                FpuPlugin_fpu_io_port_0_completion_payload_flags_NX;
  wire                FpuPlugin_fpu_io_port_0_completion_payload_flags_UF;
  wire                FpuPlugin_fpu_io_port_0_completion_payload_flags_OF;
  wire                FpuPlugin_fpu_io_port_0_completion_payload_flags_DZ;
  wire                FpuPlugin_fpu_io_port_0_completion_payload_flags_NV;
  wire                FpuPlugin_fpu_io_port_0_completion_payload_written;
  wire       [31:0]   _zz_execute_SHIFT_RIGHT;
  wire       [32:0]   _zz_execute_SHIFT_RIGHT_1;
  wire       [32:0]   _zz_execute_SHIFT_RIGHT_2;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_1;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_2;
  wire                _zz_decode_LEGAL_INSTRUCTION_3;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_4;
  wire       [20:0]   _zz_decode_LEGAL_INSTRUCTION_5;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_6;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_7;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_8;
  wire                _zz_decode_LEGAL_INSTRUCTION_9;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_10;
  wire       [14:0]   _zz_decode_LEGAL_INSTRUCTION_11;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_12;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_13;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_14;
  wire                _zz_decode_LEGAL_INSTRUCTION_15;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_16;
  wire       [8:0]    _zz_decode_LEGAL_INSTRUCTION_17;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_18;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_19;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_20;
  wire                _zz_decode_LEGAL_INSTRUCTION_21;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_22;
  wire       [2:0]    _zz_decode_LEGAL_INSTRUCTION_23;
  wire       [3:0]    _zz__zz_IBusCachedPlugin_jump_pcLoad_payload_1;
  reg        [31:0]   _zz_IBusCachedPlugin_jump_pcLoad_payload_5;
  wire       [1:0]    _zz_IBusCachedPlugin_jump_pcLoad_payload_6;
  wire       [31:0]   _zz_IBusCachedPlugin_fetchPc_pc;
  wire       [2:0]    _zz_IBusCachedPlugin_fetchPc_pc_1;
  wire       [11:0]   _zz__zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
  wire       [31:0]   _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_2;
  wire       [19:0]   _zz__zz_2;
  wire       [11:0]   _zz__zz_4;
  wire       [31:0]   _zz__zz_6;
  wire       [31:0]   _zz__zz_6_1;
  wire       [19:0]   _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload;
  wire       [11:0]   _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
  wire                _zz_IBusCachedPlugin_predictionJumpInterface_payload_4;
  wire                _zz_IBusCachedPlugin_predictionJumpInterface_payload_5;
  wire                _zz_IBusCachedPlugin_predictionJumpInterface_payload_6;
  wire       [2:0]    _zz_DBusCachedPlugin_exceptionBus_payload_code;
  wire       [2:0]    _zz_DBusCachedPlugin_exceptionBus_payload_code_1;
  reg        [7:0]    _zz_writeBack_DBusCachedPlugin_rspShifted;
  wire       [1:0]    _zz_writeBack_DBusCachedPlugin_rspShifted_1;
  reg        [7:0]    _zz_writeBack_DBusCachedPlugin_rspShifted_2;
  wire       [0:0]    _zz_writeBack_DBusCachedPlugin_rspShifted_3;
  wire       [31:0]   _zz__zz_decode_IS_CSR;
  wire       [31:0]   _zz__zz_decode_IS_CSR_1;
  wire       [31:0]   _zz__zz_decode_IS_CSR_2;
  wire       [31:0]   _zz__zz_decode_IS_CSR_3;
  wire                _zz__zz_decode_IS_CSR_4;
  wire       [0:0]    _zz__zz_decode_IS_CSR_5;
  wire                _zz__zz_decode_IS_CSR_6;
  wire       [31:0]   _zz__zz_decode_IS_CSR_7;
  wire       [31:0]   _zz__zz_decode_IS_CSR_8;
  wire       [31:0]   _zz__zz_decode_IS_CSR_9;
  wire       [31:0]   _zz__zz_decode_IS_CSR_10;
  wire       [0:0]    _zz__zz_decode_IS_CSR_11;
  wire                _zz__zz_decode_IS_CSR_12;
  wire       [31:0]   _zz__zz_decode_IS_CSR_13;
  wire       [0:0]    _zz__zz_decode_IS_CSR_14;
  wire       [2:0]    _zz__zz_decode_IS_CSR_15;
  wire       [31:0]   _zz__zz_decode_IS_CSR_16;
  wire       [31:0]   _zz__zz_decode_IS_CSR_17;
  wire                _zz__zz_decode_IS_CSR_18;
  wire       [31:0]   _zz__zz_decode_IS_CSR_19;
  wire                _zz__zz_decode_IS_CSR_20;
  wire       [31:0]   _zz__zz_decode_IS_CSR_21;
  wire                _zz__zz_decode_IS_CSR_22;
  wire                _zz__zz_decode_IS_CSR_23;
  wire       [31:0]   _zz__zz_decode_IS_CSR_24;
  wire       [0:0]    _zz__zz_decode_IS_CSR_25;
  wire       [31:0]   _zz__zz_decode_IS_CSR_26;
  wire       [31:0]   _zz__zz_decode_IS_CSR_27;
  wire       [0:0]    _zz__zz_decode_IS_CSR_28;
  wire       [31:0]   _zz__zz_decode_IS_CSR_29;
  wire       [31:0]   _zz__zz_decode_IS_CSR_30;
  wire       [0:0]    _zz__zz_decode_IS_CSR_31;
  wire       [0:0]    _zz__zz_decode_IS_CSR_32;
  wire       [31:0]   _zz__zz_decode_IS_CSR_33;
  wire       [31:0]   _zz__zz_decode_IS_CSR_34;
  wire       [0:0]    _zz__zz_decode_IS_CSR_35;
  wire       [31:0]   _zz__zz_decode_IS_CSR_36;
  wire       [31:0]   _zz__zz_decode_IS_CSR_37;
  wire       [27:0]   _zz__zz_decode_IS_CSR_38;
  wire       [3:0]    _zz__zz_decode_IS_CSR_39;
  wire                _zz__zz_decode_IS_CSR_40;
  wire       [31:0]   _zz__zz_decode_IS_CSR_41;
  wire       [0:0]    _zz__zz_decode_IS_CSR_42;
  wire       [31:0]   _zz__zz_decode_IS_CSR_43;
  wire       [31:0]   _zz__zz_decode_IS_CSR_44;
  wire       [1:0]    _zz__zz_decode_IS_CSR_45;
  wire                _zz__zz_decode_IS_CSR_46;
  wire       [31:0]   _zz__zz_decode_IS_CSR_47;
  wire                _zz__zz_decode_IS_CSR_48;
  wire       [31:0]   _zz__zz_decode_IS_CSR_49;
  wire                _zz__zz_decode_IS_CSR_50;
  wire       [0:0]    _zz__zz_decode_IS_CSR_51;
  wire       [3:0]    _zz__zz_decode_IS_CSR_52;
  wire                _zz__zz_decode_IS_CSR_53;
  wire       [31:0]   _zz__zz_decode_IS_CSR_54;
  wire       [0:0]    _zz__zz_decode_IS_CSR_55;
  wire       [31:0]   _zz__zz_decode_IS_CSR_56;
  wire       [31:0]   _zz__zz_decode_IS_CSR_57;
  wire       [1:0]    _zz__zz_decode_IS_CSR_58;
  wire                _zz__zz_decode_IS_CSR_59;
  wire       [31:0]   _zz__zz_decode_IS_CSR_60;
  wire                _zz__zz_decode_IS_CSR_61;
  wire       [31:0]   _zz__zz_decode_IS_CSR_62;
  wire       [0:0]    _zz__zz_decode_IS_CSR_63;
  wire       [1:0]    _zz__zz_decode_IS_CSR_64;
  wire       [24:0]   _zz__zz_decode_IS_CSR_65;
  wire                _zz__zz_decode_IS_CSR_66;
  wire       [0:0]    _zz__zz_decode_IS_CSR_67;
  wire       [31:0]   _zz__zz_decode_IS_CSR_68;
  wire       [31:0]   _zz__zz_decode_IS_CSR_69;
  wire       [1:0]    _zz__zz_decode_IS_CSR_70;
  wire                _zz__zz_decode_IS_CSR_71;
  wire       [31:0]   _zz__zz_decode_IS_CSR_72;
  wire                _zz__zz_decode_IS_CSR_73;
  wire       [31:0]   _zz__zz_decode_IS_CSR_74;
  wire       [0:0]    _zz__zz_decode_IS_CSR_75;
  wire       [1:0]    _zz__zz_decode_IS_CSR_76;
  wire                _zz__zz_decode_IS_CSR_77;
  wire       [31:0]   _zz__zz_decode_IS_CSR_78;
  wire                _zz__zz_decode_IS_CSR_79;
  wire       [31:0]   _zz__zz_decode_IS_CSR_80;
  wire       [22:0]   _zz__zz_decode_IS_CSR_81;
  wire                _zz__zz_decode_IS_CSR_82;
  wire                _zz__zz_decode_IS_CSR_83;
  wire       [31:0]   _zz__zz_decode_IS_CSR_84;
  wire       [0:0]    _zz__zz_decode_IS_CSR_85;
  wire       [1:0]    _zz__zz_decode_IS_CSR_86;
  wire                _zz__zz_decode_IS_CSR_87;
  wire                _zz__zz_decode_IS_CSR_88;
  wire       [20:0]   _zz__zz_decode_IS_CSR_89;
  wire                _zz__zz_decode_IS_CSR_90;
  wire                _zz__zz_decode_IS_CSR_91;
  wire       [0:0]    _zz__zz_decode_IS_CSR_92;
  wire       [0:0]    _zz__zz_decode_IS_CSR_93;
  wire       [18:0]   _zz__zz_decode_IS_CSR_94;
  wire                _zz__zz_decode_IS_CSR_95;
  wire       [31:0]   _zz__zz_decode_IS_CSR_96;
  wire       [0:0]    _zz__zz_decode_IS_CSR_97;
  wire                _zz__zz_decode_IS_CSR_98;
  wire                _zz__zz_decode_IS_CSR_99;
  wire       [16:0]   _zz__zz_decode_IS_CSR_100;
  wire                _zz__zz_decode_IS_CSR_101;
  wire       [1:0]    _zz__zz_decode_IS_CSR_102;
  wire       [31:0]   _zz__zz_decode_IS_CSR_103;
  wire       [31:0]   _zz__zz_decode_IS_CSR_104;
  wire       [31:0]   _zz__zz_decode_IS_CSR_105;
  wire       [31:0]   _zz__zz_decode_IS_CSR_106;
  wire                _zz__zz_decode_IS_CSR_107;
  wire                _zz__zz_decode_IS_CSR_108;
  wire       [0:0]    _zz__zz_decode_IS_CSR_109;
  wire       [0:0]    _zz__zz_decode_IS_CSR_110;
  wire       [0:0]    _zz__zz_decode_IS_CSR_111;
  wire       [12:0]   _zz__zz_decode_IS_CSR_112;
  wire       [1:0]    _zz__zz_decode_IS_CSR_113;
  wire                _zz__zz_decode_IS_CSR_114;
  wire                _zz__zz_decode_IS_CSR_115;
  wire       [31:0]   _zz__zz_decode_IS_CSR_116;
  wire                _zz__zz_decode_IS_CSR_117;
  wire       [31:0]   _zz__zz_decode_IS_CSR_118;
  wire       [0:0]    _zz__zz_decode_IS_CSR_119;
  wire       [0:0]    _zz__zz_decode_IS_CSR_120;
  wire       [4:0]    _zz__zz_decode_IS_CSR_121;
  wire                _zz__zz_decode_IS_CSR_122;
  wire       [31:0]   _zz__zz_decode_IS_CSR_123;
  wire       [0:0]    _zz__zz_decode_IS_CSR_124;
  wire       [31:0]   _zz__zz_decode_IS_CSR_125;
  wire       [31:0]   _zz__zz_decode_IS_CSR_126;
  wire       [2:0]    _zz__zz_decode_IS_CSR_127;
  wire       [0:0]    _zz__zz_decode_IS_CSR_128;
  wire       [31:0]   _zz__zz_decode_IS_CSR_129;
  wire       [0:0]    _zz__zz_decode_IS_CSR_130;
  wire       [31:0]   _zz__zz_decode_IS_CSR_131;
  wire       [9:0]    _zz__zz_decode_IS_CSR_132;
  wire       [0:0]    _zz__zz_decode_IS_CSR_133;
  wire       [2:0]    _zz__zz_decode_IS_CSR_134;
  wire       [0:0]    _zz__zz_decode_IS_CSR_135;
  wire       [0:0]    _zz__zz_decode_IS_CSR_136;
  wire       [31:0]   _zz__zz_decode_IS_CSR_137;
  wire       [31:0]   _zz__zz_decode_IS_CSR_138;
  wire       [2:0]    _zz__zz_decode_IS_CSR_139;
  wire       [0:0]    _zz__zz_decode_IS_CSR_140;
  wire       [31:0]   _zz__zz_decode_IS_CSR_141;
  wire       [31:0]   _zz__zz_decode_IS_CSR_142;
  wire       [0:0]    _zz__zz_decode_IS_CSR_143;
  wire                _zz__zz_decode_IS_CSR_144;
  wire                _zz__zz_decode_IS_CSR_145;
  wire       [31:0]   _zz__zz_decode_IS_CSR_146;
  wire       [0:0]    _zz__zz_decode_IS_CSR_147;
  wire       [0:0]    _zz__zz_decode_IS_CSR_148;
  wire       [31:0]   _zz__zz_decode_IS_CSR_149;
  wire       [31:0]   _zz__zz_decode_IS_CSR_150;
  wire       [5:0]    _zz__zz_decode_IS_CSR_151;
  wire                _zz__zz_decode_IS_CSR_152;
  wire       [0:0]    _zz__zz_decode_IS_CSR_153;
  wire       [31:0]   _zz__zz_decode_IS_CSR_154;
  wire       [5:0]    _zz__zz_decode_IS_CSR_155;
  wire       [31:0]   _zz__zz_decode_IS_CSR_156;
  wire       [31:0]   _zz__zz_decode_IS_CSR_157;
  wire                _zz__zz_decode_IS_CSR_158;
  wire       [0:0]    _zz__zz_decode_IS_CSR_159;
  wire       [2:0]    _zz__zz_decode_IS_CSR_160;
  wire       [31:0]   _zz__zz_decode_IS_CSR_161;
  wire       [31:0]   _zz__zz_decode_IS_CSR_162;
  wire                _zz__zz_decode_IS_CSR_163;
  wire                _zz__zz_decode_IS_CSR_164;
  wire       [0:0]    _zz__zz_decode_IS_CSR_165;
  wire       [0:0]    _zz__zz_decode_IS_CSR_166;
  wire       [3:0]    _zz__zz_decode_IS_CSR_167;
  wire                _zz__zz_decode_IS_CSR_168;
  wire                _zz__zz_decode_IS_CSR_169;
  wire       [0:0]    _zz__zz_decode_IS_CSR_170;
  wire       [31:0]   _zz__zz_decode_IS_CSR_171;
  wire       [0:0]    _zz__zz_decode_IS_CSR_172;
  wire       [31:0]   _zz__zz_decode_IS_CSR_173;
  wire       [0:0]    _zz__zz_decode_IS_CSR_174;
  wire       [0:0]    _zz__zz_decode_IS_CSR_175;
  wire       [1:0]    _zz__zz_decode_IS_CSR_176;
  wire       [31:0]   _zz__zz_decode_IS_CSR_177;
  wire       [31:0]   _zz__zz_decode_IS_CSR_178;
  wire       [1:0]    _zz__zz_decode_IS_CSR_179;
  wire       [1:0]    _zz__zz_decode_IS_CSR_180;
  wire       [0:0]    _zz__zz_decode_IS_CSR_181;
  wire       [31:0]   _zz__zz_decode_IS_CSR_182;
  wire                _zz_RegFilePlugin_regFile_port;
  wire                _zz_decode_RegFilePlugin_rs1Data;
  wire                _zz_RegFilePlugin_regFile_port_1;
  wire                _zz_decode_RegFilePlugin_rs2Data;
  wire       [0:0]    _zz__zz_execute_REGFILE_WRITE_DATA;
  wire       [2:0]    _zz__zz_execute_SRC1;
  wire       [4:0]    _zz__zz_execute_SRC1_1;
  wire       [11:0]   _zz__zz_execute_SRC2_2;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_1;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_2;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_3;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_4;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_5;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_6;
  wire       [5:0]    _zz_FpuPlugin_pendings;
  wire       [5:0]    _zz_FpuPlugin_pendings_1;
  wire       [5:0]    _zz_FpuPlugin_pendings_2;
  wire       [0:0]    _zz_FpuPlugin_pendings_3;
  wire       [5:0]    _zz_FpuPlugin_pendings_4;
  wire       [0:0]    _zz_FpuPlugin_pendings_5;
  wire       [5:0]    _zz_FpuPlugin_pendings_6;
  wire       [0:0]    _zz_FpuPlugin_pendings_7;
  wire       [1:0]    _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1;
  wire       [1:0]    _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1_1;
  wire                _zz_when;
  wire       [19:0]   _zz__zz_execute_BranchPlugin_missAlignedTarget_2;
  wire       [11:0]   _zz__zz_execute_BranchPlugin_missAlignedTarget_4;
  wire       [31:0]   _zz__zz_execute_BranchPlugin_missAlignedTarget_6;
  wire       [31:0]   _zz__zz_execute_BranchPlugin_missAlignedTarget_6_1;
  wire       [31:0]   _zz__zz_execute_BranchPlugin_missAlignedTarget_6_2;
  wire       [19:0]   _zz__zz_execute_BranchPlugin_branch_src2_2;
  wire       [11:0]   _zz__zz_execute_BranchPlugin_branch_src2_4;
  wire                _zz_execute_BranchPlugin_branch_src2_6;
  wire                _zz_execute_BranchPlugin_branch_src2_7;
  wire                _zz_execute_BranchPlugin_branch_src2_8;
  wire       [2:0]    _zz_execute_BranchPlugin_branch_src2_9;
  wire       [31:0]   writeBack_MEMORY_LOAD_DATA;
  wire       [31:0]   execute_SHIFT_RIGHT;
  wire       [31:0]   execute_REGFILE_WRITE_DATA;
  wire       [31:0]   memory_MEMORY_STORE_DATA_RF;
  wire       [31:0]   execute_MEMORY_STORE_DATA_RF;
  wire                decode_PREDICTION_HAD_BRANCHED2;
  wire                decode_DO_EBREAK;
  wire                decode_CSR_READ_OPCODE;
  wire                decode_CSR_WRITE_OPCODE;
  wire                memory_FPU_COMMIT_LOAD;
  wire                execute_FPU_COMMIT_LOAD;
  wire                decode_FPU_COMMIT_LOAD;
  wire                memory_FPU_FORKED;
  wire                execute_FPU_FORKED;
  wire                decode_FPU_FORKED;
  wire                decode_SRC2_FORCE_ZERO;
  wire       [31:0]   memory_RS1;
  wire       [1:0]    _zz_decode_to_execute_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_to_execute_BRANCH_CTRL_1;
  wire       [0:0]    _zz_memory_to_writeBack_ENV_CTRL;
  wire       [0:0]    _zz_memory_to_writeBack_ENV_CTRL_1;
  wire       [0:0]    _zz_execute_to_memory_ENV_CTRL;
  wire       [0:0]    _zz_execute_to_memory_ENV_CTRL_1;
  wire       [0:0]    decode_ENV_CTRL;
  wire       [0:0]    _zz_decode_ENV_CTRL;
  wire       [0:0]    _zz_decode_to_execute_ENV_CTRL;
  wire       [0:0]    _zz_decode_to_execute_ENV_CTRL_1;
  wire                decode_IS_CSR;
  wire       [3:0]    memory_FPU_OPCODE;
  wire       [3:0]    _zz_memory_FPU_OPCODE;
  wire       [3:0]    _zz_memory_to_writeBack_FPU_OPCODE;
  wire       [3:0]    _zz_memory_to_writeBack_FPU_OPCODE_1;
  wire       [3:0]    execute_FPU_OPCODE;
  wire       [3:0]    _zz_execute_FPU_OPCODE;
  wire       [3:0]    _zz_execute_to_memory_FPU_OPCODE;
  wire       [3:0]    _zz_execute_to_memory_FPU_OPCODE_1;
  wire       [3:0]    _zz_decode_to_execute_FPU_OPCODE;
  wire       [3:0]    _zz_decode_to_execute_FPU_OPCODE_1;
  wire                memory_FPU_RSP;
  wire                execute_FPU_RSP;
  wire                decode_FPU_RSP;
  wire                memory_FPU_COMMIT;
  wire                execute_FPU_COMMIT;
  wire                decode_FPU_COMMIT;
  wire                memory_FPU_ENABLE;
  wire                execute_FPU_ENABLE;
  wire       [1:0]    _zz_execute_to_memory_SHIFT_CTRL;
  wire       [1:0]    _zz_execute_to_memory_SHIFT_CTRL_1;
  wire       [1:0]    decode_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SHIFT_CTRL_1;
  wire       [1:0]    decode_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  wire                decode_SRC_LESS_UNSIGNED;
  wire                decode_MEMORY_MANAGMENT;
  wire                memory_MEMORY_WR;
  wire                decode_MEMORY_WR;
  wire                execute_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_EXECUTE_STAGE;
  wire       [1:0]    decode_SRC2_CTRL;
  wire       [1:0]    _zz_decode_SRC2_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SRC2_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SRC2_CTRL_1;
  wire       [1:0]    decode_ALU_CTRL;
  wire       [1:0]    _zz_decode_ALU_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_CTRL_1;
  wire       [1:0]    decode_SRC1_CTRL;
  wire       [1:0]    _zz_decode_SRC1_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SRC1_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SRC1_CTRL_1;
  wire                decode_MEMORY_FORCE_CONSTISTENCY;
  wire       [31:0]   writeBack_FORMAL_PC_NEXT;
  wire       [31:0]   memory_FORMAL_PC_NEXT;
  wire       [31:0]   execute_FORMAL_PC_NEXT;
  wire       [31:0]   decode_FORMAL_PC_NEXT;
  wire       [31:0]   memory_PC;
  wire       [31:0]   execute_BRANCH_CALC;
  wire                execute_BRANCH_DO;
  wire                execute_PREDICTION_HAD_BRANCHED2;
  wire                execute_BRANCH_COND_RESULT;
  wire       [1:0]    execute_BRANCH_CTRL;
  wire       [1:0]    _zz_execute_BRANCH_CTRL;
  wire       [31:0]   execute_PC;
  wire                execute_DO_EBREAK;
  wire                decode_IS_EBREAK;
  wire                execute_CSR_READ_OPCODE;
  wire                execute_CSR_WRITE_OPCODE;
  wire       [0:0]    memory_ENV_CTRL;
  wire       [0:0]    _zz_memory_ENV_CTRL;
  wire       [0:0]    execute_ENV_CTRL;
  wire       [0:0]    _zz_execute_ENV_CTRL;
  wire       [0:0]    writeBack_ENV_CTRL;
  wire       [0:0]    _zz_writeBack_ENV_CTRL;
  reg                 _zz_memory_to_writeBack_FPU_FORKED;
  reg                 _zz_execute_to_memory_FPU_FORKED;
  reg                 _zz_decode_to_execute_FPU_FORKED;
  wire       [31:0]   writeBack_RS1;
  wire                writeBack_FPU_COMMIT_LOAD;
  reg                 DBusBypass0_cond;
  wire                writeBack_FPU_COMMIT;
  wire                writeBack_FPU_RSP;
  wire                writeBack_FPU_FORKED;
  wire       [1:0]    decode_FPU_ARG;
  wire       [3:0]    decode_FPU_OPCODE;
  wire       [3:0]    _zz_decode_FPU_OPCODE;
  wire                decode_FPU_ENABLE;
  wire       [3:0]    writeBack_FPU_OPCODE;
  wire       [3:0]    _zz_writeBack_FPU_OPCODE;
  wire                writeBack_FPU_ENABLE;
  wire                execute_IS_CSR;
  wire                decode_RS2_USE;
  wire                decode_RS1_USE;
  reg        [31:0]   _zz_decode_RS2;
  wire                execute_REGFILE_WRITE_VALID;
  wire                execute_BYPASSABLE_EXECUTE_STAGE;
  wire                memory_REGFILE_WRITE_VALID;
  wire       [31:0]   memory_INSTRUCTION;
  wire                memory_BYPASSABLE_MEMORY_STAGE;
  wire                writeBack_REGFILE_WRITE_VALID;
  reg        [31:0]   decode_RS2;
  reg        [31:0]   decode_RS1;
  wire       [31:0]   memory_SHIFT_RIGHT;
  reg        [31:0]   _zz_decode_RS2_1;
  wire       [1:0]    memory_SHIFT_CTRL;
  wire       [1:0]    _zz_memory_SHIFT_CTRL;
  wire       [1:0]    execute_SHIFT_CTRL;
  wire       [1:0]    _zz_execute_SHIFT_CTRL;
  wire                execute_SRC_LESS_UNSIGNED;
  wire                execute_SRC2_FORCE_ZERO;
  wire                execute_SRC_USE_SUB_LESS;
  wire       [31:0]   _zz_execute_to_memory_PC;
  wire       [1:0]    execute_SRC2_CTRL;
  wire       [1:0]    _zz_execute_SRC2_CTRL;
  wire       [31:0]   _zz_execute_to_memory_RS1;
  wire       [1:0]    execute_SRC1_CTRL;
  wire       [1:0]    _zz_execute_SRC1_CTRL;
  wire                decode_SRC_USE_SUB_LESS;
  wire                decode_SRC_ADD_ZERO;
  wire       [31:0]   execute_SRC_ADD_SUB;
  wire                execute_SRC_LESS;
  wire       [1:0]    execute_ALU_CTRL;
  wire       [1:0]    _zz_execute_ALU_CTRL;
  wire       [31:0]   execute_SRC2;
  wire       [31:0]   execute_SRC1;
  wire       [1:0]    execute_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_execute_ALU_BITWISE_CTRL;
  wire       [31:0]   _zz_lastStageRegFileWrite_payload_address;
  wire                _zz_lastStageRegFileWrite_valid;
  reg                 _zz_1;
  wire       [31:0]   decode_INSTRUCTION_ANTICIPATED;
  reg                 decode_REGFILE_WRITE_VALID;
  wire                decode_LEGAL_INSTRUCTION;
  wire       [1:0]    _zz_decode_BRANCH_CTRL;
  wire       [0:0]    _zz_decode_ENV_CTRL_1;
  wire       [3:0]    _zz_decode_FPU_OPCODE_1;
  wire       [1:0]    _zz_decode_SHIFT_CTRL_1;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL_1;
  wire       [1:0]    _zz_decode_SRC2_CTRL_1;
  wire       [1:0]    _zz_decode_ALU_CTRL_1;
  wire       [1:0]    _zz_decode_SRC1_CTRL_1;
  reg        [31:0]   _zz_decode_RS2_2;
  wire                writeBack_MEMORY_WR;
  wire       [31:0]   writeBack_MEMORY_STORE_DATA_RF;
  wire       [31:0]   writeBack_REGFILE_WRITE_DATA;
  wire                writeBack_MEMORY_ENABLE;
  wire       [31:0]   memory_REGFILE_WRITE_DATA;
  wire                memory_MEMORY_ENABLE;
  wire                execute_MEMORY_FORCE_CONSTISTENCY;
  wire       [31:0]   execute_RS1;
  wire                execute_MEMORY_MANAGMENT;
  wire       [31:0]   execute_RS2;
  wire                execute_MEMORY_WR;
  wire       [31:0]   execute_SRC_ADD;
  wire                execute_MEMORY_ENABLE;
  wire       [31:0]   execute_INSTRUCTION;
  wire                decode_MEMORY_ENABLE;
  wire                decode_FLUSH_ALL;
  reg                 IBusCachedPlugin_rsp_issueDetected_4;
  reg                 IBusCachedPlugin_rsp_issueDetected_3;
  reg                 IBusCachedPlugin_rsp_issueDetected_2;
  reg                 IBusCachedPlugin_rsp_issueDetected_1;
  wire       [1:0]    decode_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_BRANCH_CTRL_1;
  wire       [31:0]   decode_INSTRUCTION;
  reg        [31:0]   _zz_execute_to_memory_FORMAL_PC_NEXT;
  reg        [31:0]   _zz_decode_to_execute_FORMAL_PC_NEXT;
  wire       [31:0]   decode_PC;
  wire       [31:0]   writeBack_PC;
  wire       [31:0]   writeBack_INSTRUCTION;
  reg                 decode_arbitration_haltItself;
  reg                 decode_arbitration_haltByOther;
  reg                 decode_arbitration_removeIt;
  wire                decode_arbitration_flushIt;
  reg                 decode_arbitration_flushNext;
  reg                 decode_arbitration_isValid;
  wire                decode_arbitration_isStuck;
  wire                decode_arbitration_isStuckByOthers;
  wire                decode_arbitration_isFlushed;
  wire                decode_arbitration_isMoving;
  wire                decode_arbitration_isFiring;
  reg                 execute_arbitration_haltItself;
  reg                 execute_arbitration_haltByOther;
  reg                 execute_arbitration_removeIt;
  reg                 execute_arbitration_flushIt;
  reg                 execute_arbitration_flushNext;
  reg                 execute_arbitration_isValid;
  wire                execute_arbitration_isStuck;
  wire                execute_arbitration_isStuckByOthers;
  wire                execute_arbitration_isFlushed;
  wire                execute_arbitration_isMoving;
  wire                execute_arbitration_isFiring;
  wire                memory_arbitration_haltItself;
  wire                memory_arbitration_haltByOther;
  reg                 memory_arbitration_removeIt;
  wire                memory_arbitration_flushIt;
  wire                memory_arbitration_flushNext;
  reg                 memory_arbitration_isValid;
  wire                memory_arbitration_isStuck;
  wire                memory_arbitration_isStuckByOthers;
  wire                memory_arbitration_isFlushed;
  wire                memory_arbitration_isMoving;
  wire                memory_arbitration_isFiring;
  reg                 writeBack_arbitration_haltItself;
  reg                 writeBack_arbitration_haltByOther;
  reg                 writeBack_arbitration_removeIt;
  reg                 writeBack_arbitration_flushIt;
  reg                 writeBack_arbitration_flushNext;
  reg                 writeBack_arbitration_isValid;
  wire                writeBack_arbitration_isStuck;
  wire                writeBack_arbitration_isStuckByOthers;
  wire                writeBack_arbitration_isFlushed;
  wire                writeBack_arbitration_isMoving;
  wire                writeBack_arbitration_isFiring;
  wire       [31:0]   lastStageInstruction /* verilator public */ ;
  wire       [31:0]   lastStagePc /* verilator public */ ;
  wire                lastStageIsValid /* verilator public */ ;
  wire                lastStageIsFiring /* verilator public */ ;
  reg                 IBusCachedPlugin_fetcherHalt;
  wire                IBusCachedPlugin_forceNoDecodeCond;
  reg                 IBusCachedPlugin_incomingInstruction;
  wire                IBusCachedPlugin_predictionJumpInterface_valid;
  (* keep , syn_keep *) wire       [31:0]   IBusCachedPlugin_predictionJumpInterface_payload /* synthesis syn_keep = 1 */ ;
  reg                 IBusCachedPlugin_decodePrediction_cmd_hadBranch;
  wire                IBusCachedPlugin_decodePrediction_rsp_wasWrong;
  wire                IBusCachedPlugin_pcValids_0;
  wire                IBusCachedPlugin_pcValids_1;
  wire                IBusCachedPlugin_pcValids_2;
  wire                IBusCachedPlugin_pcValids_3;
  reg                 IBusCachedPlugin_decodeExceptionPort_valid;
  reg        [3:0]    IBusCachedPlugin_decodeExceptionPort_payload_code;
  wire       [31:0]   IBusCachedPlugin_decodeExceptionPort_payload_badAddr;
  wire                IBusCachedPlugin_mmuBus_cmd_0_isValid;
  wire                IBusCachedPlugin_mmuBus_cmd_0_isStuck;
  wire       [31:0]   IBusCachedPlugin_mmuBus_cmd_0_virtualAddress;
  wire                IBusCachedPlugin_mmuBus_cmd_0_bypassTranslation;
  wire       [31:0]   IBusCachedPlugin_mmuBus_rsp_physicalAddress;
  wire                IBusCachedPlugin_mmuBus_rsp_isIoAccess;
  wire                IBusCachedPlugin_mmuBus_rsp_isPaging;
  wire                IBusCachedPlugin_mmuBus_rsp_allowRead;
  wire                IBusCachedPlugin_mmuBus_rsp_allowWrite;
  wire                IBusCachedPlugin_mmuBus_rsp_allowExecute;
  wire                IBusCachedPlugin_mmuBus_rsp_exception;
  wire                IBusCachedPlugin_mmuBus_rsp_refilling;
  wire                IBusCachedPlugin_mmuBus_rsp_bypassTranslation;
  wire                IBusCachedPlugin_mmuBus_end;
  wire                IBusCachedPlugin_mmuBus_busy;
  wire                DBusCachedPlugin_mmuBus_cmd_0_isValid;
  wire                DBusCachedPlugin_mmuBus_cmd_0_isStuck;
  wire       [31:0]   DBusCachedPlugin_mmuBus_cmd_0_virtualAddress;
  wire                DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation;
  wire       [31:0]   DBusCachedPlugin_mmuBus_rsp_physicalAddress;
  wire                DBusCachedPlugin_mmuBus_rsp_isIoAccess;
  wire                DBusCachedPlugin_mmuBus_rsp_isPaging;
  wire                DBusCachedPlugin_mmuBus_rsp_allowRead;
  wire                DBusCachedPlugin_mmuBus_rsp_allowWrite;
  wire                DBusCachedPlugin_mmuBus_rsp_allowExecute;
  wire                DBusCachedPlugin_mmuBus_rsp_exception;
  wire                DBusCachedPlugin_mmuBus_rsp_refilling;
  wire                DBusCachedPlugin_mmuBus_rsp_bypassTranslation;
  wire                DBusCachedPlugin_mmuBus_end;
  wire                DBusCachedPlugin_mmuBus_busy;
  reg                 DBusCachedPlugin_redoBranch_valid;
  wire       [31:0]   DBusCachedPlugin_redoBranch_payload;
  reg                 DBusCachedPlugin_exceptionBus_valid;
  reg        [3:0]    DBusCachedPlugin_exceptionBus_payload_code;
  wire       [31:0]   DBusCachedPlugin_exceptionBus_payload_badAddr;
  reg                 _zz_when_DBusCachedPlugin_l393;
  wire                decodeExceptionPort_valid;
  wire       [3:0]    decodeExceptionPort_payload_code;
  wire       [31:0]   decodeExceptionPort_payload_badAddr;
  wire                FpuPlugin_port_cmd_valid /* verilator public */ ;
  wire                FpuPlugin_port_cmd_ready /* verilator public */ ;
  wire       [3:0]    FpuPlugin_port_cmd_payload_opcode /* verilator public */ ;
  wire       [1:0]    FpuPlugin_port_cmd_payload_arg /* verilator public */ ;
  wire       [4:0]    FpuPlugin_port_cmd_payload_rs1 /* verilator public */ ;
  wire       [4:0]    FpuPlugin_port_cmd_payload_rs2 /* verilator public */ ;
  wire       [4:0]    FpuPlugin_port_cmd_payload_rs3 /* verilator public */ ;
  wire       [4:0]    FpuPlugin_port_cmd_payload_rd /* verilator public */ ;
  wire       [0:0]    FpuPlugin_port_cmd_payload_format /* verilator public */ ;
  wire       [2:0]    FpuPlugin_port_cmd_payload_roundMode /* verilator public */ ;
  wire                FpuPlugin_port_commit_valid /* verilator public */ ;
  wire                FpuPlugin_port_commit_ready /* verilator public */ ;
  wire       [3:0]    FpuPlugin_port_commit_payload_opcode /* verilator public */ ;
  wire       [4:0]    FpuPlugin_port_commit_payload_rd /* verilator public */ ;
  wire                FpuPlugin_port_commit_payload_write /* verilator public */ ;
  wire       [31:0]   FpuPlugin_port_commit_payload_value /* verilator public */ ;
  wire                FpuPlugin_port_rsp_valid /* verilator public */ ;
  reg                 FpuPlugin_port_rsp_ready /* verilator public */ ;
  wire       [31:0]   FpuPlugin_port_rsp_payload_value /* verilator public */ ;
  wire                FpuPlugin_port_rsp_payload_NV /* verilator public */ ;
  wire                FpuPlugin_port_rsp_payload_NX /* verilator public */ ;
  wire                FpuPlugin_port_completion_valid /* verilator public */ ;
  wire                FpuPlugin_port_completion_payload_flags_NX /* verilator public */ ;
  wire                FpuPlugin_port_completion_payload_flags_UF /* verilator public */ ;
  wire                FpuPlugin_port_completion_payload_flags_OF /* verilator public */ ;
  wire                FpuPlugin_port_completion_payload_flags_DZ /* verilator public */ ;
  wire                FpuPlugin_port_completion_payload_flags_NV /* verilator public */ ;
  wire                FpuPlugin_port_completion_payload_written /* verilator public */ ;
  wire       [31:0]   CsrPlugin_csrMapping_readDataSignal;
  wire       [31:0]   CsrPlugin_csrMapping_readDataInit;
  wire       [31:0]   CsrPlugin_csrMapping_writeDataSignal;
  wire                CsrPlugin_csrMapping_allowCsrSignal;
  wire                CsrPlugin_csrMapping_hazardFree;
  wire                CsrPlugin_inWfi /* verilator public */ ;
  reg                 CsrPlugin_thirdPartyWake;
  reg                 CsrPlugin_jumpInterface_valid;
  reg        [31:0]   CsrPlugin_jumpInterface_payload;
  wire                CsrPlugin_exceptionPendings_0;
  wire                CsrPlugin_exceptionPendings_1;
  wire                CsrPlugin_exceptionPendings_2;
  wire                CsrPlugin_exceptionPendings_3;
  wire                contextSwitching;
  reg        [1:0]    CsrPlugin_privilege;
  reg                 CsrPlugin_forceMachineWire;
  reg                 CsrPlugin_allowInterrupts;
  reg                 CsrPlugin_allowException;
  reg                 CsrPlugin_allowEbreakException;
  wire                CsrPlugin_xretAwayFromMachine;
  reg                 IBusCachedPlugin_injectionPort_valid;
  reg                 IBusCachedPlugin_injectionPort_ready;
  wire       [31:0]   IBusCachedPlugin_injectionPort_payload;
  wire                BranchPlugin_jumpInterface_valid;
  wire       [31:0]   BranchPlugin_jumpInterface_payload;
  reg                 BranchPlugin_branchExceptionPort_valid;
  wire       [3:0]    BranchPlugin_branchExceptionPort_payload_code;
  wire       [31:0]   BranchPlugin_branchExceptionPort_payload_badAddr;
  reg                 BranchPlugin_inDebugNoFetchFlag;
  wire                IBusCachedPlugin_externalFlush;
  wire                IBusCachedPlugin_jump_pcLoad_valid;
  wire       [31:0]   IBusCachedPlugin_jump_pcLoad_payload;
  wire       [3:0]    _zz_IBusCachedPlugin_jump_pcLoad_payload;
  wire       [3:0]    _zz_IBusCachedPlugin_jump_pcLoad_payload_1;
  wire                _zz_IBusCachedPlugin_jump_pcLoad_payload_2;
  wire                _zz_IBusCachedPlugin_jump_pcLoad_payload_3;
  wire                _zz_IBusCachedPlugin_jump_pcLoad_payload_4;
  wire                IBusCachedPlugin_fetchPc_output_valid;
  wire                IBusCachedPlugin_fetchPc_output_ready;
  wire       [31:0]   IBusCachedPlugin_fetchPc_output_payload;
  reg        [31:0]   IBusCachedPlugin_fetchPc_pcReg /* verilator public */ ;
  reg                 IBusCachedPlugin_fetchPc_correction;
  reg                 IBusCachedPlugin_fetchPc_correctionReg;
  wire                IBusCachedPlugin_fetchPc_output_fire;
  wire                IBusCachedPlugin_fetchPc_corrected;
  reg                 IBusCachedPlugin_fetchPc_pcRegPropagate;
  reg                 IBusCachedPlugin_fetchPc_booted;
  reg                 IBusCachedPlugin_fetchPc_inc;
  wire                when_Fetcher_l134;
  wire                IBusCachedPlugin_fetchPc_output_fire_1;
  wire                when_Fetcher_l134_1;
  reg        [31:0]   IBusCachedPlugin_fetchPc_pc;
  wire                IBusCachedPlugin_fetchPc_redo_valid;
  wire       [31:0]   IBusCachedPlugin_fetchPc_redo_payload;
  reg                 IBusCachedPlugin_fetchPc_flushed;
  wire                when_Fetcher_l161;
  reg                 IBusCachedPlugin_iBusRsp_redoFetch;
  wire                IBusCachedPlugin_iBusRsp_stages_0_input_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  wire                IBusCachedPlugin_iBusRsp_stages_0_output_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_0_output_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_0_output_payload;
  reg                 IBusCachedPlugin_iBusRsp_stages_0_halt;
  wire                IBusCachedPlugin_iBusRsp_stages_1_input_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_1_input_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  wire                IBusCachedPlugin_iBusRsp_stages_1_output_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_1_output_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_1_output_payload;
  reg                 IBusCachedPlugin_iBusRsp_stages_1_halt;
  wire                IBusCachedPlugin_iBusRsp_stages_2_input_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_2_input_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_2_input_payload;
  wire                IBusCachedPlugin_iBusRsp_stages_2_output_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_2_output_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_2_output_payload;
  reg                 IBusCachedPlugin_iBusRsp_stages_2_halt;
  wire                _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  wire                _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready;
  wire                _zz_IBusCachedPlugin_iBusRsp_stages_2_input_ready;
  wire                IBusCachedPlugin_iBusRsp_flush;
  wire                _zz_IBusCachedPlugin_iBusRsp_stages_0_output_ready;
  wire                _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid;
  reg                 _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid_1;
  wire                IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_payload;
  reg                 _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid;
  reg        [31:0]   _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_payload;
  reg                 IBusCachedPlugin_iBusRsp_readyForError;
  wire                IBusCachedPlugin_iBusRsp_output_valid;
  wire                IBusCachedPlugin_iBusRsp_output_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_output_payload_pc;
  wire                IBusCachedPlugin_iBusRsp_output_payload_rsp_error;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
  wire                IBusCachedPlugin_iBusRsp_output_payload_isRvc;
  wire                when_Fetcher_l243;
  wire                when_Fetcher_l323;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_0;
  wire                when_Fetcher_l332;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_1;
  wire                when_Fetcher_l332_1;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_2;
  wire                when_Fetcher_l332_2;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_3;
  wire                when_Fetcher_l332_3;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_4;
  wire                when_Fetcher_l332_4;
  wire                _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
  reg        [18:0]   _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1;
  wire                _zz_2;
  reg        [10:0]   _zz_3;
  wire                _zz_4;
  reg        [18:0]   _zz_5;
  reg                 _zz_6;
  wire                _zz_IBusCachedPlugin_predictionJumpInterface_payload;
  reg        [10:0]   _zz_IBusCachedPlugin_predictionJumpInterface_payload_1;
  wire                _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
  reg        [18:0]   _zz_IBusCachedPlugin_predictionJumpInterface_payload_3;
  reg        [31:0]   IBusCachedPlugin_rspCounter;
  wire                IBusCachedPlugin_s0_tightlyCoupledHit;
  reg                 IBusCachedPlugin_s1_tightlyCoupledHit;
  reg                 IBusCachedPlugin_s2_tightlyCoupledHit;
  wire                IBusCachedPlugin_rsp_iBusRspOutputHalt;
  wire                IBusCachedPlugin_rsp_issueDetected;
  reg                 IBusCachedPlugin_rsp_redoFetch;
  wire                when_IBusCachedPlugin_l239;
  wire                when_IBusCachedPlugin_l244;
  wire                when_IBusCachedPlugin_l250;
  wire                when_IBusCachedPlugin_l256;
  wire                when_IBusCachedPlugin_l267;
  reg        [31:0]   DBusCachedPlugin_rspCounter;
  wire                when_DBusCachedPlugin_l308;
  wire       [1:0]    execute_DBusCachedPlugin_size;
  reg        [31:0]   _zz_execute_MEMORY_STORE_DATA_RF;
  wire                toplevel_dataCache_1_io_cpu_flush_isStall;
  wire                when_DBusCachedPlugin_l350;
  wire                when_DBusCachedPlugin_l366;
  wire                when_DBusCachedPlugin_l393;
  wire                when_DBusCachedPlugin_l446;
  wire                when_DBusCachedPlugin_l466;
  wire       [7:0]    writeBack_DBusCachedPlugin_rspSplits_0;
  wire       [7:0]    writeBack_DBusCachedPlugin_rspSplits_1;
  wire       [7:0]    writeBack_DBusCachedPlugin_rspSplits_2;
  wire       [7:0]    writeBack_DBusCachedPlugin_rspSplits_3;
  reg        [31:0]   writeBack_DBusCachedPlugin_rspShifted;
  wire       [31:0]   writeBack_DBusCachedPlugin_rspRf;
  wire       [1:0]    switch_Misc_l226;
  wire                _zz_writeBack_DBusCachedPlugin_rspFormated;
  reg        [31:0]   _zz_writeBack_DBusCachedPlugin_rspFormated_1;
  wire                _zz_writeBack_DBusCachedPlugin_rspFormated_2;
  reg        [31:0]   _zz_writeBack_DBusCachedPlugin_rspFormated_3;
  reg        [31:0]   writeBack_DBusCachedPlugin_rspFormated;
  wire                when_DBusCachedPlugin_l492;
  wire       [37:0]   _zz_decode_IS_CSR;
  wire                _zz_decode_IS_CSR_1;
  wire                _zz_decode_IS_CSR_2;
  wire                _zz_decode_IS_CSR_3;
  wire                _zz_decode_IS_CSR_4;
  wire                _zz_decode_IS_CSR_5;
  wire                _zz_decode_IS_CSR_6;
  wire                _zz_decode_IS_CSR_7;
  wire                _zz_decode_IS_CSR_8;
  wire                _zz_decode_IS_CSR_9;
  wire                _zz_decode_IS_CSR_10;
  wire       [1:0]    _zz_decode_SRC1_CTRL_2;
  wire       [1:0]    _zz_decode_ALU_CTRL_2;
  wire       [1:0]    _zz_decode_SRC2_CTRL_2;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL_2;
  wire       [1:0]    _zz_decode_SHIFT_CTRL_2;
  wire       [3:0]    _zz_decode_FPU_OPCODE_2;
  wire       [0:0]    _zz_decode_ENV_CTRL_2;
  wire       [1:0]    _zz_decode_BRANCH_CTRL_2;
  wire                when_RegFilePlugin_l63;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress1;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress2;
  wire       [31:0]   decode_RegFilePlugin_rs1Data;
  wire       [31:0]   decode_RegFilePlugin_rs2Data;
  reg                 lastStageRegFileWrite_valid /* verilator public */ ;
  reg        [4:0]    lastStageRegFileWrite_payload_address /* verilator public */ ;
  reg        [31:0]   lastStageRegFileWrite_payload_data /* verilator public */ ;
  reg                 _zz_7;
  reg        [31:0]   execute_IntAluPlugin_bitwise;
  reg        [31:0]   _zz_execute_REGFILE_WRITE_DATA;
  reg        [31:0]   _zz_execute_SRC1;
  wire                _zz_execute_SRC2;
  reg        [19:0]   _zz_execute_SRC2_1;
  wire                _zz_execute_SRC2_2;
  reg        [19:0]   _zz_execute_SRC2_3;
  reg        [31:0]   _zz_execute_SRC2_4;
  reg        [31:0]   execute_SrcPlugin_addSub;
  wire                execute_SrcPlugin_less;
  wire       [4:0]    execute_FullBarrelShifterPlugin_amplitude;
  reg        [31:0]   _zz_execute_FullBarrelShifterPlugin_reversed;
  wire       [31:0]   execute_FullBarrelShifterPlugin_reversed;
  reg        [31:0]   _zz_decode_RS2_3;
  reg                 HazardSimplePlugin_src0Hazard;
  reg                 HazardSimplePlugin_src1Hazard;
  wire                HazardSimplePlugin_writeBackWrites_valid;
  wire       [4:0]    HazardSimplePlugin_writeBackWrites_payload_address;
  wire       [31:0]   HazardSimplePlugin_writeBackWrites_payload_data;
  reg                 HazardSimplePlugin_writeBackBuffer_valid;
  reg        [4:0]    HazardSimplePlugin_writeBackBuffer_payload_address;
  reg        [31:0]   HazardSimplePlugin_writeBackBuffer_payload_data;
  wire                HazardSimplePlugin_addr0Match;
  wire                HazardSimplePlugin_addr1Match;
  wire                when_HazardSimplePlugin_l47;
  wire                when_HazardSimplePlugin_l48;
  wire                when_HazardSimplePlugin_l51;
  wire                when_HazardSimplePlugin_l45;
  wire                when_HazardSimplePlugin_l57;
  wire                when_HazardSimplePlugin_l58;
  wire                when_HazardSimplePlugin_l48_1;
  wire                when_HazardSimplePlugin_l51_1;
  wire                when_HazardSimplePlugin_l45_1;
  wire                when_HazardSimplePlugin_l57_1;
  wire                when_HazardSimplePlugin_l58_1;
  wire                when_HazardSimplePlugin_l48_2;
  wire                when_HazardSimplePlugin_l51_2;
  wire                when_HazardSimplePlugin_l45_2;
  wire                when_HazardSimplePlugin_l57_2;
  wire                when_HazardSimplePlugin_l58_2;
  wire                when_HazardSimplePlugin_l105;
  wire                when_HazardSimplePlugin_l108;
  wire                when_HazardSimplePlugin_l113;
  reg        [5:0]    FpuPlugin_pendings;
  wire                FpuPlugin_port_cmd_fire;
  wire                FpuPlugin_port_rsp_fire;
  wire                FpuPlugin_hasPending;
  reg                 FpuPlugin_flags_NX;
  reg                 FpuPlugin_flags_UF;
  reg                 FpuPlugin_flags_OF;
  reg                 FpuPlugin_flags_DZ;
  reg                 FpuPlugin_flags_NV;
  wire                when_FpuPlugin_l199;
  wire                when_FpuPlugin_l200;
  wire                when_FpuPlugin_l201;
  wire                when_FpuPlugin_l202;
  wire                when_FpuPlugin_l203;
  reg        [2:0]    FpuPlugin_rm;
  wire                FpuPlugin_csrActive;
  wire                when_FpuPlugin_l214;
  reg        [1:0]    FpuPlugin_fs;
  wire                FpuPlugin_sd;
  wire                when_FpuPlugin_l219;
  reg                 _zz_when_FpuPlugin_l222;
  reg                 _zz_when_FpuPlugin_l222_1;
  reg                 _zz_when_FpuPlugin_l222_2;
  wire                when_FpuPlugin_l222;
  reg                 decode_FpuPlugin_forked;
  wire                FpuPlugin_port_cmd_fire_1;
  wire                when_FpuPlugin_l237;
  wire                decode_FpuPlugin_hazard;
  wire                when_FpuPlugin_l241;
  wire                FpuPlugin_port_cmd_isStall;
  wire       [2:0]    decode_FpuPlugin_iRoundMode;
  wire       [2:0]    decode_FpuPlugin_roundMode;
  wire       [2:0]    _zz_FpuPlugin_port_cmd_payload_roundMode;
  wire       [2:0]    _zz_FpuPlugin_port_cmd_payload_roundMode_1;
  wire                FpuPlugin_port_cmd_fire_2;
  wire                writeBack_FpuPlugin_isRsp;
  wire                writeBack_FpuPlugin_isCommit;
  wire       [31:0]   writeBack_FpuPlugin_storeFormated;
  wire       [31:0]   DBusBypass0_value;
  wire                when_FpuPlugin_l283;
  wire                when_FpuPlugin_l288;
  wire                when_FpuPlugin_l290;
  wire                writeBack_FpuPlugin_commit_valid /* verilator public */ ;
  wire                writeBack_FpuPlugin_commit_ready /* verilator public */ ;
  wire       [3:0]    writeBack_FpuPlugin_commit_payload_opcode /* verilator public */ ;
  wire       [4:0]    writeBack_FpuPlugin_commit_payload_rd /* verilator public */ ;
  wire                writeBack_FpuPlugin_commit_payload_write /* verilator public */ ;
  wire       [31:0]   writeBack_FpuPlugin_commit_payload_value /* verilator public */ ;
  wire                when_FpuPlugin_l304;
  wire                writeBack_FpuPlugin_commit_s2mPipe_valid;
  wire                writeBack_FpuPlugin_commit_s2mPipe_ready;
  wire       [3:0]    writeBack_FpuPlugin_commit_s2mPipe_payload_opcode;
  wire       [4:0]    writeBack_FpuPlugin_commit_s2mPipe_payload_rd;
  wire                writeBack_FpuPlugin_commit_s2mPipe_payload_write;
  wire       [31:0]   writeBack_FpuPlugin_commit_s2mPipe_payload_value;
  reg                 writeBack_FpuPlugin_commit_rValid;
  reg        [3:0]    writeBack_FpuPlugin_commit_rData_opcode;
  reg        [4:0]    writeBack_FpuPlugin_commit_rData_rd;
  reg                 writeBack_FpuPlugin_commit_rData_write;
  reg        [31:0]   writeBack_FpuPlugin_commit_rData_value;
  wire       [3:0]    _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode;
  wire       [1:0]    CsrPlugin_misa_base;
  wire       [25:0]   CsrPlugin_misa_extensions;
  wire       [1:0]    CsrPlugin_mtvec_mode;
  wire       [29:0]   CsrPlugin_mtvec_base;
  reg        [31:0]   CsrPlugin_mepc;
  reg                 CsrPlugin_mstatus_MIE;
  reg                 CsrPlugin_mstatus_MPIE;
  reg        [1:0]    CsrPlugin_mstatus_MPP;
  reg                 CsrPlugin_mip_MEIP;
  reg                 CsrPlugin_mip_MTIP;
  reg                 CsrPlugin_mip_MSIP;
  reg                 CsrPlugin_mie_MEIE;
  reg                 CsrPlugin_mie_MTIE;
  reg                 CsrPlugin_mie_MSIE;
  reg                 CsrPlugin_mcause_interrupt;
  reg        [3:0]    CsrPlugin_mcause_exceptionCode;
  reg        [31:0]   CsrPlugin_mtval;
  reg        [63:0]   CsrPlugin_mcycle;
  reg        [63:0]   CsrPlugin_minstret;
  wire                _zz_when_CsrPlugin_l1222;
  wire                _zz_when_CsrPlugin_l1222_1;
  wire                _zz_when_CsrPlugin_l1222_2;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg        [3:0]    CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg        [31:0]   CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
  wire       [1:0]    _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  wire                _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1;
  wire                when_CsrPlugin_l1179;
  wire                when_CsrPlugin_l1179_1;
  wire                when_CsrPlugin_l1179_2;
  wire                when_CsrPlugin_l1179_3;
  wire                when_CsrPlugin_l1192;
  reg                 CsrPlugin_interrupt_valid;
  reg        [3:0]    CsrPlugin_interrupt_code /* verilator public */ ;
  reg        [1:0]    CsrPlugin_interrupt_targetPrivilege;
  wire                when_CsrPlugin_l1216;
  wire                when_CsrPlugin_l1222;
  wire                when_CsrPlugin_l1222_1;
  wire                when_CsrPlugin_l1222_2;
  wire                CsrPlugin_exception;
  wire                CsrPlugin_lastStageWasWfi;
  reg                 CsrPlugin_pipelineLiberator_pcValids_0;
  reg                 CsrPlugin_pipelineLiberator_pcValids_1;
  reg                 CsrPlugin_pipelineLiberator_pcValids_2;
  wire                CsrPlugin_pipelineLiberator_active;
  wire                when_CsrPlugin_l1255;
  wire                when_CsrPlugin_l1255_1;
  wire                when_CsrPlugin_l1255_2;
  wire                when_CsrPlugin_l1260;
  reg                 CsrPlugin_pipelineLiberator_done;
  wire                when_CsrPlugin_l1266;
  wire                CsrPlugin_interruptJump /* verilator public */ ;
  reg                 CsrPlugin_hadException /* verilator public */ ;
  reg        [1:0]    CsrPlugin_targetPrivilege;
  reg        [3:0]    CsrPlugin_trapCause;
  wire                CsrPlugin_trapCauseEbreakDebug;
  reg        [1:0]    CsrPlugin_xtvec_mode;
  reg        [29:0]   CsrPlugin_xtvec_base;
  wire                CsrPlugin_trapEnterDebug;
  wire                when_CsrPlugin_l1310;
  wire                when_CsrPlugin_l1318;
  wire                when_CsrPlugin_l1376;
  wire       [1:0]    switch_CsrPlugin_l1380;
  reg                 execute_CsrPlugin_wfiWake;
  wire                when_CsrPlugin_l1447;
  wire                execute_CsrPlugin_blockedBySideEffects;
  reg                 execute_CsrPlugin_illegalAccess;
  reg                 execute_CsrPlugin_illegalInstruction;
  wire                when_CsrPlugin_l1467;
  wire                when_CsrPlugin_l1468;
  reg                 execute_CsrPlugin_writeInstruction;
  reg                 execute_CsrPlugin_readInstruction;
  wire                execute_CsrPlugin_writeEnable;
  wire                execute_CsrPlugin_readEnable;
  wire       [31:0]   execute_CsrPlugin_readToWriteData;
  wire                switch_Misc_l226_1;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_writeDataSignal;
  wire                when_CsrPlugin_l1507;
  wire                when_CsrPlugin_l1511;
  wire       [11:0]   execute_CsrPlugin_csrAddress;
  reg                 DebugPlugin_firstCycle;
  reg                 DebugPlugin_secondCycle;
  reg                 DebugPlugin_resetIt;
  reg                 DebugPlugin_haltIt;
  reg                 DebugPlugin_stepIt;
  reg                 DebugPlugin_isPipBusy;
  reg                 DebugPlugin_godmode;
  wire                when_DebugPlugin_l238;
  reg                 DebugPlugin_haltedByBreak;
  reg                 DebugPlugin_debugUsed /* verilator public */ ;
  reg                 DebugPlugin_disableEbreak;
  wire                DebugPlugin_allowEBreak;
  reg        [31:0]   DebugPlugin_busReadDataReg;
  reg                 _zz_when_DebugPlugin_l257;
  wire                when_DebugPlugin_l257;
  wire       [5:0]    switch_DebugPlugin_l280;
  wire                when_DebugPlugin_l284;
  wire                when_DebugPlugin_l284_1;
  wire                when_DebugPlugin_l285;
  wire                when_DebugPlugin_l285_1;
  wire                when_DebugPlugin_l286;
  wire                when_DebugPlugin_l287;
  wire                when_DebugPlugin_l288;
  wire                when_DebugPlugin_l288_1;
  wire                when_DebugPlugin_l308;
  wire                when_DebugPlugin_l311;
  wire                when_DebugPlugin_l324;
  reg                 DebugPlugin_resetIt_regNext;
  wire                when_DebugPlugin_l344;
  wire                execute_BranchPlugin_eq;
  wire       [2:0]    switch_Misc_l226_2;
  reg                 _zz_execute_BRANCH_COND_RESULT;
  reg                 _zz_execute_BRANCH_COND_RESULT_1;
  wire                _zz_execute_BranchPlugin_missAlignedTarget;
  reg        [19:0]   _zz_execute_BranchPlugin_missAlignedTarget_1;
  wire                _zz_execute_BranchPlugin_missAlignedTarget_2;
  reg        [10:0]   _zz_execute_BranchPlugin_missAlignedTarget_3;
  wire                _zz_execute_BranchPlugin_missAlignedTarget_4;
  reg        [18:0]   _zz_execute_BranchPlugin_missAlignedTarget_5;
  reg                 _zz_execute_BranchPlugin_missAlignedTarget_6;
  wire                execute_BranchPlugin_missAlignedTarget;
  reg        [31:0]   execute_BranchPlugin_branch_src1;
  reg        [31:0]   execute_BranchPlugin_branch_src2;
  wire                _zz_execute_BranchPlugin_branch_src2;
  reg        [19:0]   _zz_execute_BranchPlugin_branch_src2_1;
  wire                _zz_execute_BranchPlugin_branch_src2_2;
  reg        [10:0]   _zz_execute_BranchPlugin_branch_src2_3;
  wire                _zz_execute_BranchPlugin_branch_src2_4;
  reg        [18:0]   _zz_execute_BranchPlugin_branch_src2_5;
  wire       [31:0]   execute_BranchPlugin_branchAdder;
  wire                when_BranchPlugin_l302;
  wire                when_Pipeline_l124;
  reg        [31:0]   decode_to_execute_PC;
  wire                when_Pipeline_l124_1;
  reg        [31:0]   execute_to_memory_PC;
  wire                when_Pipeline_l124_2;
  reg        [31:0]   memory_to_writeBack_PC;
  wire                when_Pipeline_l124_3;
  reg        [31:0]   decode_to_execute_INSTRUCTION;
  wire                when_Pipeline_l124_4;
  reg        [31:0]   execute_to_memory_INSTRUCTION;
  wire                when_Pipeline_l124_5;
  reg        [31:0]   memory_to_writeBack_INSTRUCTION;
  wire                when_Pipeline_l124_6;
  reg        [31:0]   decode_to_execute_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_7;
  reg        [31:0]   execute_to_memory_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_8;
  reg        [31:0]   memory_to_writeBack_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_9;
  reg                 decode_to_execute_MEMORY_FORCE_CONSTISTENCY;
  wire                when_Pipeline_l124_10;
  reg        [1:0]    decode_to_execute_SRC1_CTRL;
  wire                when_Pipeline_l124_11;
  reg                 decode_to_execute_SRC_USE_SUB_LESS;
  wire                when_Pipeline_l124_12;
  reg                 decode_to_execute_MEMORY_ENABLE;
  wire                when_Pipeline_l124_13;
  reg                 execute_to_memory_MEMORY_ENABLE;
  wire                when_Pipeline_l124_14;
  reg                 memory_to_writeBack_MEMORY_ENABLE;
  wire                when_Pipeline_l124_15;
  reg        [1:0]    decode_to_execute_ALU_CTRL;
  wire                when_Pipeline_l124_16;
  reg        [1:0]    decode_to_execute_SRC2_CTRL;
  wire                when_Pipeline_l124_17;
  reg                 decode_to_execute_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_18;
  reg                 execute_to_memory_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_19;
  reg                 memory_to_writeBack_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_20;
  reg                 decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  wire                when_Pipeline_l124_21;
  reg                 decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_22;
  reg                 execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_23;
  reg                 decode_to_execute_MEMORY_WR;
  wire                when_Pipeline_l124_24;
  reg                 execute_to_memory_MEMORY_WR;
  wire                when_Pipeline_l124_25;
  reg                 memory_to_writeBack_MEMORY_WR;
  wire                when_Pipeline_l124_26;
  reg                 decode_to_execute_MEMORY_MANAGMENT;
  wire                when_Pipeline_l124_27;
  reg                 decode_to_execute_SRC_LESS_UNSIGNED;
  wire                when_Pipeline_l124_28;
  reg        [1:0]    decode_to_execute_ALU_BITWISE_CTRL;
  wire                when_Pipeline_l124_29;
  reg        [1:0]    decode_to_execute_SHIFT_CTRL;
  wire                when_Pipeline_l124_30;
  reg        [1:0]    execute_to_memory_SHIFT_CTRL;
  wire                when_Pipeline_l124_31;
  reg                 decode_to_execute_FPU_ENABLE;
  wire                when_Pipeline_l124_32;
  reg                 execute_to_memory_FPU_ENABLE;
  wire                when_Pipeline_l124_33;
  reg                 memory_to_writeBack_FPU_ENABLE;
  wire                when_Pipeline_l124_34;
  reg                 decode_to_execute_FPU_COMMIT;
  wire                when_Pipeline_l124_35;
  reg                 execute_to_memory_FPU_COMMIT;
  wire                when_Pipeline_l124_36;
  reg                 memory_to_writeBack_FPU_COMMIT;
  wire                when_Pipeline_l124_37;
  reg                 decode_to_execute_FPU_RSP;
  wire                when_Pipeline_l124_38;
  reg                 execute_to_memory_FPU_RSP;
  wire                when_Pipeline_l124_39;
  reg                 memory_to_writeBack_FPU_RSP;
  wire                when_Pipeline_l124_40;
  reg        [3:0]    decode_to_execute_FPU_OPCODE;
  wire                when_Pipeline_l124_41;
  reg        [3:0]    execute_to_memory_FPU_OPCODE;
  wire                when_Pipeline_l124_42;
  reg        [3:0]    memory_to_writeBack_FPU_OPCODE;
  wire                when_Pipeline_l124_43;
  reg                 decode_to_execute_IS_CSR;
  wire                when_Pipeline_l124_44;
  reg        [0:0]    decode_to_execute_ENV_CTRL;
  wire                when_Pipeline_l124_45;
  reg        [0:0]    execute_to_memory_ENV_CTRL;
  wire                when_Pipeline_l124_46;
  reg        [0:0]    memory_to_writeBack_ENV_CTRL;
  wire                when_Pipeline_l124_47;
  reg        [1:0]    decode_to_execute_BRANCH_CTRL;
  wire                when_Pipeline_l124_48;
  reg        [31:0]   decode_to_execute_RS1;
  wire                when_Pipeline_l124_49;
  reg        [31:0]   execute_to_memory_RS1;
  wire                when_Pipeline_l124_50;
  reg        [31:0]   memory_to_writeBack_RS1;
  wire                when_Pipeline_l124_51;
  reg        [31:0]   decode_to_execute_RS2;
  wire                when_Pipeline_l124_52;
  reg                 decode_to_execute_SRC2_FORCE_ZERO;
  wire                when_Pipeline_l124_53;
  reg                 decode_to_execute_FPU_FORKED;
  wire                when_Pipeline_l124_54;
  reg                 execute_to_memory_FPU_FORKED;
  wire                when_Pipeline_l124_55;
  reg                 memory_to_writeBack_FPU_FORKED;
  wire                when_Pipeline_l124_56;
  reg                 decode_to_execute_FPU_COMMIT_LOAD;
  wire                when_Pipeline_l124_57;
  reg                 execute_to_memory_FPU_COMMIT_LOAD;
  wire                when_Pipeline_l124_58;
  reg                 memory_to_writeBack_FPU_COMMIT_LOAD;
  wire                when_Pipeline_l124_59;
  reg                 decode_to_execute_CSR_WRITE_OPCODE;
  wire                when_Pipeline_l124_60;
  reg                 decode_to_execute_CSR_READ_OPCODE;
  wire                when_Pipeline_l124_61;
  reg                 decode_to_execute_DO_EBREAK;
  wire                when_Pipeline_l124_62;
  reg                 decode_to_execute_PREDICTION_HAD_BRANCHED2;
  wire                when_Pipeline_l124_63;
  reg        [31:0]   execute_to_memory_MEMORY_STORE_DATA_RF;
  wire                when_Pipeline_l124_64;
  reg        [31:0]   memory_to_writeBack_MEMORY_STORE_DATA_RF;
  wire                when_Pipeline_l124_65;
  reg        [31:0]   execute_to_memory_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_66;
  reg        [31:0]   memory_to_writeBack_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_67;
  reg        [31:0]   execute_to_memory_SHIFT_RIGHT;
  wire                when_Pipeline_l151;
  wire                when_Pipeline_l154;
  wire                when_Pipeline_l151_1;
  wire                when_Pipeline_l154_1;
  wire                when_Pipeline_l151_2;
  wire                when_Pipeline_l154_2;
  reg        [2:0]    switch_Fetcher_l365;
  wire                when_Fetcher_l381;
  wire                when_CsrPlugin_l1589;
  reg                 execute_CsrPlugin_csr_3;
  wire                when_CsrPlugin_l1589_1;
  reg                 execute_CsrPlugin_csr_2;
  wire                when_CsrPlugin_l1589_2;
  reg                 execute_CsrPlugin_csr_1;
  wire                when_CsrPlugin_l1589_3;
  reg                 execute_CsrPlugin_csr_256;
  wire                when_CsrPlugin_l1589_4;
  reg                 execute_CsrPlugin_csr_768;
  wire                when_CsrPlugin_l1589_5;
  reg                 execute_CsrPlugin_csr_836;
  wire                when_CsrPlugin_l1589_6;
  reg                 execute_CsrPlugin_csr_772;
  wire                when_CsrPlugin_l1589_7;
  reg                 execute_CsrPlugin_csr_833;
  wire                when_CsrPlugin_l1589_8;
  reg                 execute_CsrPlugin_csr_834;
  wire                when_CsrPlugin_l1589_9;
  reg                 execute_CsrPlugin_csr_835;
  wire       [4:0]    _zz_FpuPlugin_flags_NX;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_1;
  wire       [4:0]    _zz_FpuPlugin_flags_NX_1;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_2;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_3;
  wire       [1:0]    switch_CsrPlugin_l980;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_4;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_5;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_6;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_7;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_8;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_9;
  reg                 when_CsrPlugin_l1625;
  wire                when_CsrPlugin_l1623;
  wire                when_CsrPlugin_l1631;
  `ifndef SYNTHESIS
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_1_string;
  reg [31:0] _zz_memory_to_writeBack_ENV_CTRL_string;
  reg [31:0] _zz_memory_to_writeBack_ENV_CTRL_1_string;
  reg [31:0] _zz_execute_to_memory_ENV_CTRL_string;
  reg [31:0] _zz_execute_to_memory_ENV_CTRL_1_string;
  reg [31:0] decode_ENV_CTRL_string;
  reg [31:0] _zz_decode_ENV_CTRL_string;
  reg [31:0] _zz_decode_to_execute_ENV_CTRL_string;
  reg [31:0] _zz_decode_to_execute_ENV_CTRL_1_string;
  reg [63:0] memory_FPU_OPCODE_string;
  reg [63:0] _zz_memory_FPU_OPCODE_string;
  reg [63:0] _zz_memory_to_writeBack_FPU_OPCODE_string;
  reg [63:0] _zz_memory_to_writeBack_FPU_OPCODE_1_string;
  reg [63:0] execute_FPU_OPCODE_string;
  reg [63:0] _zz_execute_FPU_OPCODE_string;
  reg [63:0] _zz_execute_to_memory_FPU_OPCODE_string;
  reg [63:0] _zz_execute_to_memory_FPU_OPCODE_1_string;
  reg [63:0] _zz_decode_to_execute_FPU_OPCODE_string;
  reg [63:0] _zz_decode_to_execute_FPU_OPCODE_1_string;
  reg [71:0] _zz_execute_to_memory_SHIFT_CTRL_string;
  reg [71:0] _zz_execute_to_memory_SHIFT_CTRL_1_string;
  reg [71:0] decode_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_to_execute_SHIFT_CTRL_1_string;
  reg [39:0] decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string;
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_decode_SRC2_CTRL_string;
  reg [23:0] _zz_decode_to_execute_SRC2_CTRL_string;
  reg [23:0] _zz_decode_to_execute_SRC2_CTRL_1_string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_1_string;
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_decode_SRC1_CTRL_string;
  reg [95:0] _zz_decode_to_execute_SRC1_CTRL_string;
  reg [95:0] _zz_decode_to_execute_SRC1_CTRL_1_string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_execute_BRANCH_CTRL_string;
  reg [31:0] memory_ENV_CTRL_string;
  reg [31:0] _zz_memory_ENV_CTRL_string;
  reg [31:0] execute_ENV_CTRL_string;
  reg [31:0] _zz_execute_ENV_CTRL_string;
  reg [31:0] writeBack_ENV_CTRL_string;
  reg [31:0] _zz_writeBack_ENV_CTRL_string;
  reg [63:0] decode_FPU_OPCODE_string;
  reg [63:0] _zz_decode_FPU_OPCODE_string;
  reg [63:0] writeBack_FPU_OPCODE_string;
  reg [63:0] _zz_writeBack_FPU_OPCODE_string;
  reg [71:0] memory_SHIFT_CTRL_string;
  reg [71:0] _zz_memory_SHIFT_CTRL_string;
  reg [71:0] execute_SHIFT_CTRL_string;
  reg [71:0] _zz_execute_SHIFT_CTRL_string;
  reg [23:0] execute_SRC2_CTRL_string;
  reg [23:0] _zz_execute_SRC2_CTRL_string;
  reg [95:0] execute_SRC1_CTRL_string;
  reg [95:0] _zz_execute_SRC1_CTRL_string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_execute_ALU_CTRL_string;
  reg [39:0] execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_execute_ALU_BITWISE_CTRL_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_ENV_CTRL_1_string;
  reg [63:0] _zz_decode_FPU_OPCODE_1_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_1_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_1_string;
  reg [23:0] _zz_decode_SRC2_CTRL_1_string;
  reg [63:0] _zz_decode_ALU_CTRL_1_string;
  reg [95:0] _zz_decode_SRC1_CTRL_1_string;
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_1_string;
  reg [63:0] FpuPlugin_port_cmd_payload_opcode_string;
  reg [47:0] FpuPlugin_port_cmd_payload_format_string;
  reg [23:0] FpuPlugin_port_cmd_payload_roundMode_string;
  reg [63:0] FpuPlugin_port_commit_payload_opcode_string;
  reg [95:0] _zz_decode_SRC1_CTRL_2_string;
  reg [63:0] _zz_decode_ALU_CTRL_2_string;
  reg [23:0] _zz_decode_SRC2_CTRL_2_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_2_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_2_string;
  reg [63:0] _zz_decode_FPU_OPCODE_2_string;
  reg [31:0] _zz_decode_ENV_CTRL_2_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_2_string;
  reg [23:0] _zz_FpuPlugin_port_cmd_payload_roundMode_string;
  reg [23:0] _zz_FpuPlugin_port_cmd_payload_roundMode_1_string;
  reg [63:0] writeBack_FpuPlugin_commit_payload_opcode_string;
  reg [63:0] writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string;
  reg [63:0] writeBack_FpuPlugin_commit_rData_opcode_string;
  reg [63:0] _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string;
  reg [95:0] decode_to_execute_SRC1_CTRL_string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [23:0] decode_to_execute_SRC2_CTRL_string;
  reg [39:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [71:0] decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] execute_to_memory_SHIFT_CTRL_string;
  reg [63:0] decode_to_execute_FPU_OPCODE_string;
  reg [63:0] execute_to_memory_FPU_OPCODE_string;
  reg [63:0] memory_to_writeBack_FPU_OPCODE_string;
  reg [31:0] decode_to_execute_ENV_CTRL_string;
  reg [31:0] execute_to_memory_ENV_CTRL_string;
  reg [31:0] memory_to_writeBack_ENV_CTRL_string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  `endif

  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;

  assign _zz_when = ({decodeExceptionPort_valid,IBusCachedPlugin_decodeExceptionPort_valid} != 2'b00);
  assign _zz_execute_SHIFT_RIGHT_1 = ($signed(_zz_execute_SHIFT_RIGHT_2) >>> execute_FullBarrelShifterPlugin_amplitude);
  assign _zz_execute_SHIFT_RIGHT = _zz_execute_SHIFT_RIGHT_1[31 : 0];
  assign _zz_execute_SHIFT_RIGHT_2 = {((execute_SHIFT_CTRL == ShiftCtrlEnum_SRA_1) && execute_FullBarrelShifterPlugin_reversed[31]),execute_FullBarrelShifterPlugin_reversed};
  assign _zz__zz_IBusCachedPlugin_jump_pcLoad_payload_1 = (_zz_IBusCachedPlugin_jump_pcLoad_payload - 4'b0001);
  assign _zz_IBusCachedPlugin_fetchPc_pc_1 = {IBusCachedPlugin_fetchPc_inc,2'b00};
  assign _zz_IBusCachedPlugin_fetchPc_pc = {29'd0, _zz_IBusCachedPlugin_fetchPc_pc_1};
  assign _zz__zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_2 = {{_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz__zz_2 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz__zz_4 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz__zz_6 = {{_zz_3,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]}},1'b0};
  assign _zz__zz_6_1 = {{_zz_5,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload_2 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_DBusCachedPlugin_exceptionBus_payload_code = (writeBack_MEMORY_WR ? 3'b111 : 3'b101);
  assign _zz_DBusCachedPlugin_exceptionBus_payload_code_1 = (writeBack_MEMORY_WR ? 3'b110 : 3'b100);
  assign _zz__zz_execute_REGFILE_WRITE_DATA = execute_SRC_LESS;
  assign _zz__zz_execute_SRC1 = 3'b100;
  assign _zz__zz_execute_SRC1_1 = execute_INSTRUCTION[19 : 15];
  assign _zz__zz_execute_SRC2_2 = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_execute_SrcPlugin_addSub = ($signed(_zz_execute_SrcPlugin_addSub_1) + $signed(_zz_execute_SrcPlugin_addSub_4));
  assign _zz_execute_SrcPlugin_addSub_1 = ($signed(_zz_execute_SrcPlugin_addSub_2) + $signed(_zz_execute_SrcPlugin_addSub_3));
  assign _zz_execute_SrcPlugin_addSub_2 = execute_SRC1;
  assign _zz_execute_SrcPlugin_addSub_3 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_execute_SrcPlugin_addSub_4 = (execute_SRC_USE_SUB_LESS ? _zz_execute_SrcPlugin_addSub_5 : _zz_execute_SrcPlugin_addSub_6);
  assign _zz_execute_SrcPlugin_addSub_5 = 32'h00000001;
  assign _zz_execute_SrcPlugin_addSub_6 = 32'h0;
  assign _zz_FpuPlugin_pendings = (_zz_FpuPlugin_pendings_1 - _zz_FpuPlugin_pendings_4);
  assign _zz_FpuPlugin_pendings_1 = (FpuPlugin_pendings + _zz_FpuPlugin_pendings_2);
  assign _zz_FpuPlugin_pendings_3 = FpuPlugin_port_cmd_fire;
  assign _zz_FpuPlugin_pendings_2 = {5'd0, _zz_FpuPlugin_pendings_3};
  assign _zz_FpuPlugin_pendings_5 = FpuPlugin_port_completion_valid;
  assign _zz_FpuPlugin_pendings_4 = {5'd0, _zz_FpuPlugin_pendings_5};
  assign _zz_FpuPlugin_pendings_7 = FpuPlugin_port_rsp_fire;
  assign _zz_FpuPlugin_pendings_6 = {5'd0, _zz_FpuPlugin_pendings_7};
  assign _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 = (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code & (~ _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1_1));
  assign _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1_1 = (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code - 2'b01);
  assign _zz__zz_execute_BranchPlugin_missAlignedTarget_2 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz__zz_execute_BranchPlugin_missAlignedTarget_4 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz__zz_execute_BranchPlugin_missAlignedTarget_6 = {_zz_execute_BranchPlugin_missAlignedTarget_1,execute_INSTRUCTION[31 : 20]};
  assign _zz__zz_execute_BranchPlugin_missAlignedTarget_6_1 = {{_zz_execute_BranchPlugin_missAlignedTarget_3,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
  assign _zz__zz_execute_BranchPlugin_missAlignedTarget_6_2 = {{_zz_execute_BranchPlugin_missAlignedTarget_5,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz__zz_execute_BranchPlugin_branch_src2_2 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz__zz_execute_BranchPlugin_branch_src2_4 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_execute_BranchPlugin_branch_src2_9 = 3'b100;
  assign _zz_decode_RegFilePlugin_rs1Data = 1'b1;
  assign _zz_decode_RegFilePlugin_rs2Data = 1'b1;
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_6 = {_zz_IBusCachedPlugin_jump_pcLoad_payload_4,_zz_IBusCachedPlugin_jump_pcLoad_payload_3};
  assign _zz_writeBack_DBusCachedPlugin_rspShifted_1 = dataCache_1_io_cpu_writeBack_address[1 : 0];
  assign _zz_writeBack_DBusCachedPlugin_rspShifted_3 = dataCache_1_io_cpu_writeBack_address[1 : 1];
  assign _zz_decode_LEGAL_INSTRUCTION = 32'h0000107f;
  assign _zz_decode_LEGAL_INSTRUCTION_1 = (decode_INSTRUCTION & 32'h0000207f);
  assign _zz_decode_LEGAL_INSTRUCTION_2 = 32'h00002073;
  assign _zz_decode_LEGAL_INSTRUCTION_3 = ((decode_INSTRUCTION & 32'h0000407f) == 32'h00004063);
  assign _zz_decode_LEGAL_INSTRUCTION_4 = ((decode_INSTRUCTION & 32'h0000207f) == 32'h00002013);
  assign _zz_decode_LEGAL_INSTRUCTION_5 = {((decode_INSTRUCTION & 32'h0000705b) == 32'h00002003),{((decode_INSTRUCTION & 32'h0000107f) == 32'h00000013),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_6) == 32'h00000023),{(_zz_decode_LEGAL_INSTRUCTION_7 == _zz_decode_LEGAL_INSTRUCTION_8),{_zz_decode_LEGAL_INSTRUCTION_9,{_zz_decode_LEGAL_INSTRUCTION_10,_zz_decode_LEGAL_INSTRUCTION_11}}}}}};
  assign _zz_decode_LEGAL_INSTRUCTION_6 = 32'h0000603f;
  assign _zz_decode_LEGAL_INSTRUCTION_7 = (decode_INSTRUCTION & 32'h0000207f);
  assign _zz_decode_LEGAL_INSTRUCTION_8 = 32'h00000003;
  assign _zz_decode_LEGAL_INSTRUCTION_9 = ((decode_INSTRUCTION & 32'h0000707b) == 32'h00000063);
  assign _zz_decode_LEGAL_INSTRUCTION_10 = ((decode_INSTRUCTION & 32'h0000607f) == 32'h0000000f);
  assign _zz_decode_LEGAL_INSTRUCTION_11 = {((decode_INSTRUCTION & 32'he600007f) == 32'h00000053),{((decode_INSTRUCTION & 32'hfe00007f) == 32'h00000033),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_12) == 32'h0000500f),{(_zz_decode_LEGAL_INSTRUCTION_13 == _zz_decode_LEGAL_INSTRUCTION_14),{_zz_decode_LEGAL_INSTRUCTION_15,{_zz_decode_LEGAL_INSTRUCTION_16,_zz_decode_LEGAL_INSTRUCTION_17}}}}}};
  assign _zz_decode_LEGAL_INSTRUCTION_12 = 32'h01f0707f;
  assign _zz_decode_LEGAL_INSTRUCTION_13 = (decode_INSTRUCTION & 32'h7e00507f);
  assign _zz_decode_LEGAL_INSTRUCTION_14 = 32'h20000053;
  assign _zz_decode_LEGAL_INSTRUCTION_15 = ((decode_INSTRUCTION & 32'hf600607f) == 32'h20000053);
  assign _zz_decode_LEGAL_INSTRUCTION_16 = ((decode_INSTRUCTION & 32'hbe00705f) == 32'h00005013);
  assign _zz_decode_LEGAL_INSTRUCTION_17 = {((decode_INSTRUCTION & 32'h7e00607f) == 32'h20000053),{((decode_INSTRUCTION & 32'hfe00305f) == 32'h00001013),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_18) == 32'h00000033),{(_zz_decode_LEGAL_INSTRUCTION_19 == _zz_decode_LEGAL_INSTRUCTION_20),{_zz_decode_LEGAL_INSTRUCTION_21,{_zz_decode_LEGAL_INSTRUCTION_22,_zz_decode_LEGAL_INSTRUCTION_23}}}}}};
  assign _zz_decode_LEGAL_INSTRUCTION_18 = 32'hbe00707f;
  assign _zz_decode_LEGAL_INSTRUCTION_19 = (decode_INSTRUCTION & 32'hefe0007f);
  assign _zz_decode_LEGAL_INSTRUCTION_20 = 32'hc0000053;
  assign _zz_decode_LEGAL_INSTRUCTION_21 = ((decode_INSTRUCTION & 32'hfff0007f) == 32'h58000053);
  assign _zz_decode_LEGAL_INSTRUCTION_22 = ((decode_INSTRUCTION & 32'heff0707f) == 32'he0000053);
  assign _zz_decode_LEGAL_INSTRUCTION_23 = {((decode_INSTRUCTION & 32'hfff0607f) == 32'he0000053),{((decode_INSTRUCTION & 32'hdfffffff) == 32'h10200073),((decode_INSTRUCTION & 32'hffffffff) == 32'h00100073)}};
  assign _zz_IBusCachedPlugin_predictionJumpInterface_payload_4 = decode_INSTRUCTION[31];
  assign _zz_IBusCachedPlugin_predictionJumpInterface_payload_5 = decode_INSTRUCTION[31];
  assign _zz_IBusCachedPlugin_predictionJumpInterface_payload_6 = decode_INSTRUCTION[7];
  assign _zz__zz_decode_IS_CSR = (decode_INSTRUCTION & 32'h00002034);
  assign _zz__zz_decode_IS_CSR_1 = 32'h00000024;
  assign _zz__zz_decode_IS_CSR_2 = (decode_INSTRUCTION & 32'h00000078);
  assign _zz__zz_decode_IS_CSR_3 = 32'h00000060;
  assign _zz__zz_decode_IS_CSR_4 = ((decode_INSTRUCTION & 32'h10003070) == 32'h00000070);
  assign _zz__zz_decode_IS_CSR_5 = ((decode_INSTRUCTION & 32'h10003034) == 32'h10000030);
  assign _zz__zz_decode_IS_CSR_6 = (|{(_zz__zz_decode_IS_CSR_7 == _zz__zz_decode_IS_CSR_8),(_zz__zz_decode_IS_CSR_9 == _zz__zz_decode_IS_CSR_10)});
  assign _zz__zz_decode_IS_CSR_11 = (|{_zz_decode_IS_CSR_9,_zz__zz_decode_IS_CSR_12});
  assign _zz__zz_decode_IS_CSR_13 = {(|{_zz__zz_decode_IS_CSR_14,_zz__zz_decode_IS_CSR_15}),{1'b0,{_zz__zz_decode_IS_CSR_22,{_zz__zz_decode_IS_CSR_31,_zz__zz_decode_IS_CSR_38}}}};
  assign _zz__zz_decode_IS_CSR_7 = (decode_INSTRUCTION & 32'h00001070);
  assign _zz__zz_decode_IS_CSR_8 = 32'h00001070;
  assign _zz__zz_decode_IS_CSR_9 = (decode_INSTRUCTION & 32'h00002070);
  assign _zz__zz_decode_IS_CSR_10 = 32'h00002070;
  assign _zz__zz_decode_IS_CSR_12 = ((decode_INSTRUCTION & 32'h20002010) == 32'h20002010);
  assign _zz__zz_decode_IS_CSR_14 = _zz_decode_IS_CSR_3;
  assign _zz__zz_decode_IS_CSR_15 = {(_zz__zz_decode_IS_CSR_16 == _zz__zz_decode_IS_CSR_17),{_zz__zz_decode_IS_CSR_18,_zz__zz_decode_IS_CSR_20}};
  assign _zz__zz_decode_IS_CSR_22 = (|{_zz__zz_decode_IS_CSR_23,{_zz__zz_decode_IS_CSR_25,_zz__zz_decode_IS_CSR_28}});
  assign _zz__zz_decode_IS_CSR_31 = (|{_zz__zz_decode_IS_CSR_32,_zz__zz_decode_IS_CSR_35});
  assign _zz__zz_decode_IS_CSR_38 = {(|_zz__zz_decode_IS_CSR_39),{_zz__zz_decode_IS_CSR_50,{_zz__zz_decode_IS_CSR_63,_zz__zz_decode_IS_CSR_65}}};
  assign _zz__zz_decode_IS_CSR_16 = (decode_INSTRUCTION & 32'h20001010);
  assign _zz__zz_decode_IS_CSR_17 = 32'h20001010;
  assign _zz__zz_decode_IS_CSR_18 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_19) == 32'h08000010);
  assign _zz__zz_decode_IS_CSR_20 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_21) == 32'h80000010);
  assign _zz__zz_decode_IS_CSR_23 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_24) == 32'h60000010);
  assign _zz__zz_decode_IS_CSR_25 = (_zz__zz_decode_IS_CSR_26 == _zz__zz_decode_IS_CSR_27);
  assign _zz__zz_decode_IS_CSR_28 = (_zz__zz_decode_IS_CSR_29 == _zz__zz_decode_IS_CSR_30);
  assign _zz__zz_decode_IS_CSR_32 = (_zz__zz_decode_IS_CSR_33 == _zz__zz_decode_IS_CSR_34);
  assign _zz__zz_decode_IS_CSR_35 = (_zz__zz_decode_IS_CSR_36 == _zz__zz_decode_IS_CSR_37);
  assign _zz__zz_decode_IS_CSR_39 = {_zz__zz_decode_IS_CSR_40,{_zz__zz_decode_IS_CSR_42,_zz__zz_decode_IS_CSR_45}};
  assign _zz__zz_decode_IS_CSR_50 = (|{_zz__zz_decode_IS_CSR_51,_zz__zz_decode_IS_CSR_52});
  assign _zz__zz_decode_IS_CSR_63 = (|_zz__zz_decode_IS_CSR_64);
  assign _zz__zz_decode_IS_CSR_65 = {_zz__zz_decode_IS_CSR_66,{_zz__zz_decode_IS_CSR_75,_zz__zz_decode_IS_CSR_81}};
  assign _zz__zz_decode_IS_CSR_19 = 32'h28000010;
  assign _zz__zz_decode_IS_CSR_21 = 32'ha0100010;
  assign _zz__zz_decode_IS_CSR_24 = 32'h60000010;
  assign _zz__zz_decode_IS_CSR_26 = (decode_INSTRUCTION & 32'h18000010);
  assign _zz__zz_decode_IS_CSR_27 = 32'h18000010;
  assign _zz__zz_decode_IS_CSR_29 = (decode_INSTRUCTION & 32'ha0000010);
  assign _zz__zz_decode_IS_CSR_30 = 32'h20000010;
  assign _zz__zz_decode_IS_CSR_33 = (decode_INSTRUCTION & 32'h80000004);
  assign _zz__zz_decode_IS_CSR_34 = 32'h80000000;
  assign _zz__zz_decode_IS_CSR_36 = (decode_INSTRUCTION & 32'h00000050);
  assign _zz__zz_decode_IS_CSR_37 = 32'h00000040;
  assign _zz__zz_decode_IS_CSR_40 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_41) == 32'h00001010);
  assign _zz__zz_decode_IS_CSR_42 = (_zz__zz_decode_IS_CSR_43 == _zz__zz_decode_IS_CSR_44);
  assign _zz__zz_decode_IS_CSR_45 = {_zz__zz_decode_IS_CSR_46,_zz__zz_decode_IS_CSR_48};
  assign _zz__zz_decode_IS_CSR_51 = _zz_decode_IS_CSR_10;
  assign _zz__zz_decode_IS_CSR_52 = {_zz__zz_decode_IS_CSR_53,{_zz__zz_decode_IS_CSR_55,_zz__zz_decode_IS_CSR_58}};
  assign _zz__zz_decode_IS_CSR_64 = {_zz_decode_IS_CSR_10,_zz_decode_IS_CSR_6};
  assign _zz__zz_decode_IS_CSR_66 = (|{_zz__zz_decode_IS_CSR_67,_zz__zz_decode_IS_CSR_70});
  assign _zz__zz_decode_IS_CSR_75 = (|_zz__zz_decode_IS_CSR_76);
  assign _zz__zz_decode_IS_CSR_81 = {_zz__zz_decode_IS_CSR_82,{_zz__zz_decode_IS_CSR_85,_zz__zz_decode_IS_CSR_89}};
  assign _zz__zz_decode_IS_CSR_41 = 32'h10001010;
  assign _zz__zz_decode_IS_CSR_43 = (decode_INSTRUCTION & 32'h30000010);
  assign _zz__zz_decode_IS_CSR_44 = 32'h00000010;
  assign _zz__zz_decode_IS_CSR_46 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_47) == 32'h00000010);
  assign _zz__zz_decode_IS_CSR_48 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_49) == 32'h00000010);
  assign _zz__zz_decode_IS_CSR_53 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_54) == 32'h90000010);
  assign _zz__zz_decode_IS_CSR_55 = (_zz__zz_decode_IS_CSR_56 == _zz__zz_decode_IS_CSR_57);
  assign _zz__zz_decode_IS_CSR_58 = {_zz__zz_decode_IS_CSR_59,_zz__zz_decode_IS_CSR_61};
  assign _zz__zz_decode_IS_CSR_67 = (_zz__zz_decode_IS_CSR_68 == _zz__zz_decode_IS_CSR_69);
  assign _zz__zz_decode_IS_CSR_70 = {_zz__zz_decode_IS_CSR_71,_zz__zz_decode_IS_CSR_73};
  assign _zz__zz_decode_IS_CSR_76 = {_zz__zz_decode_IS_CSR_77,_zz__zz_decode_IS_CSR_79};
  assign _zz__zz_decode_IS_CSR_82 = (|_zz__zz_decode_IS_CSR_83);
  assign _zz__zz_decode_IS_CSR_85 = (|_zz__zz_decode_IS_CSR_86);
  assign _zz__zz_decode_IS_CSR_89 = {_zz__zz_decode_IS_CSR_90,{_zz__zz_decode_IS_CSR_92,_zz__zz_decode_IS_CSR_94}};
  assign _zz__zz_decode_IS_CSR_47 = 32'h88000010;
  assign _zz__zz_decode_IS_CSR_49 = 32'h50000010;
  assign _zz__zz_decode_IS_CSR_54 = 32'h90000010;
  assign _zz__zz_decode_IS_CSR_56 = (decode_INSTRUCTION & 32'hc0000010);
  assign _zz__zz_decode_IS_CSR_57 = 32'h40000010;
  assign _zz__zz_decode_IS_CSR_59 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_60) == 32'h00000010);
  assign _zz__zz_decode_IS_CSR_61 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_62) == 32'h00000010);
  assign _zz__zz_decode_IS_CSR_68 = (decode_INSTRUCTION & 32'h10000020);
  assign _zz__zz_decode_IS_CSR_69 = 32'h10000000;
  assign _zz__zz_decode_IS_CSR_71 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_72) == 32'h0);
  assign _zz__zz_decode_IS_CSR_73 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_74) == 32'h0);
  assign _zz__zz_decode_IS_CSR_77 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_78) == 32'h00000040);
  assign _zz__zz_decode_IS_CSR_79 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_80) == 32'h00000004);
  assign _zz__zz_decode_IS_CSR_83 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_84) == 32'h00005010);
  assign _zz__zz_decode_IS_CSR_86 = {_zz__zz_decode_IS_CSR_87,_zz__zz_decode_IS_CSR_88};
  assign _zz__zz_decode_IS_CSR_90 = (|_zz__zz_decode_IS_CSR_91);
  assign _zz__zz_decode_IS_CSR_92 = (|_zz__zz_decode_IS_CSR_93);
  assign _zz__zz_decode_IS_CSR_94 = {_zz__zz_decode_IS_CSR_95,{_zz__zz_decode_IS_CSR_97,_zz__zz_decode_IS_CSR_100}};
  assign _zz__zz_decode_IS_CSR_60 = 32'h58000010;
  assign _zz__zz_decode_IS_CSR_62 = 32'hb0000010;
  assign _zz__zz_decode_IS_CSR_72 = 32'h80000020;
  assign _zz__zz_decode_IS_CSR_74 = 32'h00000030;
  assign _zz__zz_decode_IS_CSR_78 = 32'h00000060;
  assign _zz__zz_decode_IS_CSR_80 = 32'h0000005c;
  assign _zz__zz_decode_IS_CSR_84 = 32'h00007054;
  assign _zz__zz_decode_IS_CSR_87 = ((decode_INSTRUCTION & 32'h40003054) == 32'h40001010);
  assign _zz__zz_decode_IS_CSR_88 = ((decode_INSTRUCTION & 32'h00007054) == 32'h00001010);
  assign _zz__zz_decode_IS_CSR_91 = ((decode_INSTRUCTION & 32'h00000034) == 32'h00000034);
  assign _zz__zz_decode_IS_CSR_93 = ((decode_INSTRUCTION & 32'h00001000) == 32'h00001000);
  assign _zz__zz_decode_IS_CSR_95 = (|((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_96) == 32'h00002000));
  assign _zz__zz_decode_IS_CSR_97 = (|{_zz__zz_decode_IS_CSR_98,_zz__zz_decode_IS_CSR_99});
  assign _zz__zz_decode_IS_CSR_100 = {(|_zz__zz_decode_IS_CSR_101),{(|_zz__zz_decode_IS_CSR_102),{_zz__zz_decode_IS_CSR_107,{_zz__zz_decode_IS_CSR_111,_zz__zz_decode_IS_CSR_112}}}};
  assign _zz__zz_decode_IS_CSR_96 = 32'h00003000;
  assign _zz__zz_decode_IS_CSR_98 = ((decode_INSTRUCTION & 32'h00002010) == 32'h00002000);
  assign _zz__zz_decode_IS_CSR_99 = ((decode_INSTRUCTION & 32'h00005000) == 32'h00001000);
  assign _zz__zz_decode_IS_CSR_101 = ((decode_INSTRUCTION & 32'h00004048) == 32'h00004008);
  assign _zz__zz_decode_IS_CSR_102 = {(_zz__zz_decode_IS_CSR_103 == _zz__zz_decode_IS_CSR_104),(_zz__zz_decode_IS_CSR_105 == _zz__zz_decode_IS_CSR_106)};
  assign _zz__zz_decode_IS_CSR_107 = (|{_zz__zz_decode_IS_CSR_108,{_zz__zz_decode_IS_CSR_109,_zz__zz_decode_IS_CSR_110}});
  assign _zz__zz_decode_IS_CSR_111 = (|_zz_decode_IS_CSR_10);
  assign _zz__zz_decode_IS_CSR_112 = {(|_zz__zz_decode_IS_CSR_113),{_zz__zz_decode_IS_CSR_114,{_zz__zz_decode_IS_CSR_119,_zz__zz_decode_IS_CSR_132}}};
  assign _zz__zz_decode_IS_CSR_103 = (decode_INSTRUCTION & 32'h00000034);
  assign _zz__zz_decode_IS_CSR_104 = 32'h00000020;
  assign _zz__zz_decode_IS_CSR_105 = (decode_INSTRUCTION & 32'h00000064);
  assign _zz__zz_decode_IS_CSR_106 = 32'h00000020;
  assign _zz__zz_decode_IS_CSR_108 = ((decode_INSTRUCTION & 32'h00000030) == 32'h00000020);
  assign _zz__zz_decode_IS_CSR_109 = _zz_decode_IS_CSR_4;
  assign _zz__zz_decode_IS_CSR_110 = ((decode_INSTRUCTION & 32'h10003024) == 32'h10000020);
  assign _zz__zz_decode_IS_CSR_113 = {_zz_decode_IS_CSR_10,_zz_decode_IS_CSR_7};
  assign _zz__zz_decode_IS_CSR_114 = (|{_zz_decode_IS_CSR_9,{_zz__zz_decode_IS_CSR_115,_zz__zz_decode_IS_CSR_117}});
  assign _zz__zz_decode_IS_CSR_119 = (|{_zz_decode_IS_CSR_8,{_zz__zz_decode_IS_CSR_120,_zz__zz_decode_IS_CSR_121}});
  assign _zz__zz_decode_IS_CSR_132 = {(|{_zz__zz_decode_IS_CSR_133,_zz__zz_decode_IS_CSR_134}),{(|_zz__zz_decode_IS_CSR_139),{_zz__zz_decode_IS_CSR_144,{_zz__zz_decode_IS_CSR_147,_zz__zz_decode_IS_CSR_151}}}};
  assign _zz__zz_decode_IS_CSR_115 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_116) == 32'h00002010);
  assign _zz__zz_decode_IS_CSR_117 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_118) == 32'h00000010);
  assign _zz__zz_decode_IS_CSR_120 = _zz_decode_IS_CSR_7;
  assign _zz__zz_decode_IS_CSR_121 = {_zz__zz_decode_IS_CSR_122,{_zz__zz_decode_IS_CSR_124,_zz__zz_decode_IS_CSR_127}};
  assign _zz__zz_decode_IS_CSR_133 = _zz_decode_IS_CSR_3;
  assign _zz__zz_decode_IS_CSR_134 = {_zz_decode_IS_CSR_2,{_zz__zz_decode_IS_CSR_135,_zz__zz_decode_IS_CSR_136}};
  assign _zz__zz_decode_IS_CSR_139 = {_zz_decode_IS_CSR_3,{_zz__zz_decode_IS_CSR_140,_zz__zz_decode_IS_CSR_143}};
  assign _zz__zz_decode_IS_CSR_144 = (|_zz__zz_decode_IS_CSR_145);
  assign _zz__zz_decode_IS_CSR_147 = (|_zz__zz_decode_IS_CSR_148);
  assign _zz__zz_decode_IS_CSR_151 = {_zz__zz_decode_IS_CSR_152,{_zz__zz_decode_IS_CSR_165,_zz__zz_decode_IS_CSR_167}};
  assign _zz__zz_decode_IS_CSR_116 = 32'h00002050;
  assign _zz__zz_decode_IS_CSR_118 = 32'h00001050;
  assign _zz__zz_decode_IS_CSR_122 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_123) == 32'h00001030);
  assign _zz__zz_decode_IS_CSR_124 = (_zz__zz_decode_IS_CSR_125 == _zz__zz_decode_IS_CSR_126);
  assign _zz__zz_decode_IS_CSR_127 = {_zz_decode_IS_CSR_6,{_zz__zz_decode_IS_CSR_128,_zz__zz_decode_IS_CSR_130}};
  assign _zz__zz_decode_IS_CSR_135 = _zz_decode_IS_CSR_5;
  assign _zz__zz_decode_IS_CSR_136 = (_zz__zz_decode_IS_CSR_137 == _zz__zz_decode_IS_CSR_138);
  assign _zz__zz_decode_IS_CSR_140 = (_zz__zz_decode_IS_CSR_141 == _zz__zz_decode_IS_CSR_142);
  assign _zz__zz_decode_IS_CSR_143 = _zz_decode_IS_CSR_5;
  assign _zz__zz_decode_IS_CSR_145 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_146) == 32'h00004010);
  assign _zz__zz_decode_IS_CSR_148 = (_zz__zz_decode_IS_CSR_149 == _zz__zz_decode_IS_CSR_150);
  assign _zz__zz_decode_IS_CSR_152 = (|{_zz__zz_decode_IS_CSR_153,_zz__zz_decode_IS_CSR_155});
  assign _zz__zz_decode_IS_CSR_165 = (|_zz__zz_decode_IS_CSR_166);
  assign _zz__zz_decode_IS_CSR_167 = {_zz__zz_decode_IS_CSR_168,{_zz__zz_decode_IS_CSR_174,_zz__zz_decode_IS_CSR_179}};
  assign _zz__zz_decode_IS_CSR_123 = 32'h00001030;
  assign _zz__zz_decode_IS_CSR_125 = (decode_INSTRUCTION & 32'h00002030);
  assign _zz__zz_decode_IS_CSR_126 = 32'h00002030;
  assign _zz__zz_decode_IS_CSR_128 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_129) == 32'h00000024);
  assign _zz__zz_decode_IS_CSR_130 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_131) == 32'h0);
  assign _zz__zz_decode_IS_CSR_137 = (decode_INSTRUCTION & 32'h00000070);
  assign _zz__zz_decode_IS_CSR_138 = 32'h00000020;
  assign _zz__zz_decode_IS_CSR_141 = (decode_INSTRUCTION & 32'h00000020);
  assign _zz__zz_decode_IS_CSR_142 = 32'h0;
  assign _zz__zz_decode_IS_CSR_146 = 32'h00004014;
  assign _zz__zz_decode_IS_CSR_149 = (decode_INSTRUCTION & 32'h00006014);
  assign _zz__zz_decode_IS_CSR_150 = 32'h00002010;
  assign _zz__zz_decode_IS_CSR_153 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_154) == 32'h0);
  assign _zz__zz_decode_IS_CSR_155 = {(_zz__zz_decode_IS_CSR_156 == _zz__zz_decode_IS_CSR_157),{_zz__zz_decode_IS_CSR_158,{_zz__zz_decode_IS_CSR_159,_zz__zz_decode_IS_CSR_160}}};
  assign _zz__zz_decode_IS_CSR_166 = _zz_decode_IS_CSR_4;
  assign _zz__zz_decode_IS_CSR_168 = (|{_zz__zz_decode_IS_CSR_169,{_zz__zz_decode_IS_CSR_170,_zz__zz_decode_IS_CSR_172}});
  assign _zz__zz_decode_IS_CSR_174 = (|{_zz__zz_decode_IS_CSR_175,_zz__zz_decode_IS_CSR_176});
  assign _zz__zz_decode_IS_CSR_179 = {(|_zz__zz_decode_IS_CSR_180),(|_zz__zz_decode_IS_CSR_181)};
  assign _zz__zz_decode_IS_CSR_129 = 32'h00002024;
  assign _zz__zz_decode_IS_CSR_131 = 32'h00000064;
  assign _zz__zz_decode_IS_CSR_154 = 32'h00000044;
  assign _zz__zz_decode_IS_CSR_156 = (decode_INSTRUCTION & 32'h00000038);
  assign _zz__zz_decode_IS_CSR_157 = 32'h00000020;
  assign _zz__zz_decode_IS_CSR_158 = ((decode_INSTRUCTION & 32'h00004050) == 32'h00004000);
  assign _zz__zz_decode_IS_CSR_159 = _zz_decode_IS_CSR_4;
  assign _zz__zz_decode_IS_CSR_160 = {(_zz__zz_decode_IS_CSR_161 == _zz__zz_decode_IS_CSR_162),{_zz__zz_decode_IS_CSR_163,_zz__zz_decode_IS_CSR_164}};
  assign _zz__zz_decode_IS_CSR_169 = ((decode_INSTRUCTION & 32'h00000044) == 32'h00000040);
  assign _zz__zz_decode_IS_CSR_170 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_171) == 32'h00002010);
  assign _zz__zz_decode_IS_CSR_172 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_173) == 32'h40000030);
  assign _zz__zz_decode_IS_CSR_175 = _zz_decode_IS_CSR_3;
  assign _zz__zz_decode_IS_CSR_176 = {_zz_decode_IS_CSR_1,(_zz__zz_decode_IS_CSR_177 == _zz__zz_decode_IS_CSR_178)};
  assign _zz__zz_decode_IS_CSR_180 = {_zz_decode_IS_CSR_2,_zz_decode_IS_CSR_1};
  assign _zz__zz_decode_IS_CSR_181 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_182) == 32'h00001008);
  assign _zz__zz_decode_IS_CSR_161 = (decode_INSTRUCTION & 32'h00006024);
  assign _zz__zz_decode_IS_CSR_162 = 32'h00002020;
  assign _zz__zz_decode_IS_CSR_163 = ((decode_INSTRUCTION & 32'h00005024) == 32'h00001020);
  assign _zz__zz_decode_IS_CSR_164 = ((decode_INSTRUCTION & 32'h90000034) == 32'h90000010);
  assign _zz__zz_decode_IS_CSR_171 = 32'h00002014;
  assign _zz__zz_decode_IS_CSR_173 = 32'h40000034;
  assign _zz__zz_decode_IS_CSR_177 = (decode_INSTRUCTION & 32'h00002014);
  assign _zz__zz_decode_IS_CSR_178 = 32'h00000004;
  assign _zz__zz_decode_IS_CSR_182 = 32'h00005048;
  assign _zz_execute_BranchPlugin_branch_src2_6 = execute_INSTRUCTION[31];
  assign _zz_execute_BranchPlugin_branch_src2_7 = execute_INSTRUCTION[31];
  assign _zz_execute_BranchPlugin_branch_src2_8 = execute_INSTRUCTION[7];
  initial begin
    $readmemb("VexRiscv.v_toplevel_RegFilePlugin_regFile.bin",RegFilePlugin_regFile);
  end
  always @(posedge clk) begin
    if(_zz_decode_RegFilePlugin_rs1Data) begin
      _zz_RegFilePlugin_regFile_port0 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @(posedge clk) begin
    if(_zz_decode_RegFilePlugin_rs2Data) begin
      _zz_RegFilePlugin_regFile_port1 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  always @(posedge clk) begin
    if(_zz_1) begin
      RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
    end
  end

  InstructionCache IBusCachedPlugin_cache (
    .io_flush                              (IBusCachedPlugin_cache_io_flush                           ), //i
    .io_cpu_prefetch_isValid               (IBusCachedPlugin_cache_io_cpu_prefetch_isValid            ), //i
    .io_cpu_prefetch_haltIt                (IBusCachedPlugin_cache_io_cpu_prefetch_haltIt             ), //o
    .io_cpu_prefetch_pc                    (IBusCachedPlugin_iBusRsp_stages_0_input_payload[31:0]     ), //i
    .io_cpu_fetch_isValid                  (IBusCachedPlugin_cache_io_cpu_fetch_isValid               ), //i
    .io_cpu_fetch_isStuck                  (IBusCachedPlugin_cache_io_cpu_fetch_isStuck               ), //i
    .io_cpu_fetch_isRemoved                (IBusCachedPlugin_cache_io_cpu_fetch_isRemoved             ), //i
    .io_cpu_fetch_pc                       (IBusCachedPlugin_iBusRsp_stages_1_input_payload[31:0]     ), //i
    .io_cpu_fetch_data                     (IBusCachedPlugin_cache_io_cpu_fetch_data[31:0]            ), //o
    .io_cpu_fetch_mmuRsp_physicalAddress   (IBusCachedPlugin_mmuBus_rsp_physicalAddress[31:0]         ), //i
    .io_cpu_fetch_mmuRsp_isIoAccess        (IBusCachedPlugin_mmuBus_rsp_isIoAccess                    ), //i
    .io_cpu_fetch_mmuRsp_isPaging          (IBusCachedPlugin_mmuBus_rsp_isPaging                      ), //i
    .io_cpu_fetch_mmuRsp_allowRead         (IBusCachedPlugin_mmuBus_rsp_allowRead                     ), //i
    .io_cpu_fetch_mmuRsp_allowWrite        (IBusCachedPlugin_mmuBus_rsp_allowWrite                    ), //i
    .io_cpu_fetch_mmuRsp_allowExecute      (IBusCachedPlugin_mmuBus_rsp_allowExecute                  ), //i
    .io_cpu_fetch_mmuRsp_exception         (IBusCachedPlugin_mmuBus_rsp_exception                     ), //i
    .io_cpu_fetch_mmuRsp_refilling         (IBusCachedPlugin_mmuBus_rsp_refilling                     ), //i
    .io_cpu_fetch_mmuRsp_bypassTranslation (IBusCachedPlugin_mmuBus_rsp_bypassTranslation             ), //i
    .io_cpu_fetch_physicalAddress          (IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress[31:0] ), //o
    .io_cpu_decode_isValid                 (IBusCachedPlugin_cache_io_cpu_decode_isValid              ), //i
    .io_cpu_decode_isStuck                 (IBusCachedPlugin_cache_io_cpu_decode_isStuck              ), //i
    .io_cpu_decode_pc                      (IBusCachedPlugin_iBusRsp_stages_2_input_payload[31:0]     ), //i
    .io_cpu_decode_physicalAddress         (IBusCachedPlugin_cache_io_cpu_decode_physicalAddress[31:0]), //o
    .io_cpu_decode_data                    (IBusCachedPlugin_cache_io_cpu_decode_data[31:0]           ), //o
    .io_cpu_decode_cacheMiss               (IBusCachedPlugin_cache_io_cpu_decode_cacheMiss            ), //o
    .io_cpu_decode_error                   (IBusCachedPlugin_cache_io_cpu_decode_error                ), //o
    .io_cpu_decode_mmuRefilling            (IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling         ), //o
    .io_cpu_decode_mmuException            (IBusCachedPlugin_cache_io_cpu_decode_mmuException         ), //o
    .io_cpu_decode_isUser                  (IBusCachedPlugin_cache_io_cpu_decode_isUser               ), //i
    .io_cpu_fill_valid                     (IBusCachedPlugin_cache_io_cpu_fill_valid                  ), //i
    .io_cpu_fill_payload                   (IBusCachedPlugin_cache_io_cpu_decode_physicalAddress[31:0]), //i
    .io_mem_cmd_valid                      (IBusCachedPlugin_cache_io_mem_cmd_valid                   ), //o
    .io_mem_cmd_ready                      (iBus_cmd_ready                                            ), //i
    .io_mem_cmd_payload_address            (IBusCachedPlugin_cache_io_mem_cmd_payload_address[31:0]   ), //o
    .io_mem_cmd_payload_size               (IBusCachedPlugin_cache_io_mem_cmd_payload_size[2:0]       ), //o
    .io_mem_rsp_valid                      (iBus_rsp_valid                                            ), //i
    .io_mem_rsp_payload_data               (iBus_rsp_payload_data[31:0]                               ), //i
    .io_mem_rsp_payload_error              (iBus_rsp_payload_error                                    ), //i
    ._zz_when_Fetcher_l401                 (switch_Fetcher_l365[2:0]                                  ), //i
    ._zz_decodeStage_hit_data_1            (IBusCachedPlugin_injectionPort_payload[31:0]              ), //i
    .clk                                   (clk                                                       ), //i
    .reset                                 (reset                                                     )  //i
  );
  DataCache dataCache_1 (
    .io_cpu_execute_isValid                 (dataCache_1_io_cpu_execute_isValid               ), //i
    .io_cpu_execute_address                 (dataCache_1_io_cpu_execute_address[31:0]         ), //i
    .io_cpu_execute_haltIt                  (dataCache_1_io_cpu_execute_haltIt                ), //o
    .io_cpu_execute_args_wr                 (execute_MEMORY_WR                                ), //i
    .io_cpu_execute_args_size               (execute_DBusCachedPlugin_size[1:0]               ), //i
    .io_cpu_execute_args_totalyConsistent   (execute_MEMORY_FORCE_CONSTISTENCY                ), //i
    .io_cpu_execute_refilling               (dataCache_1_io_cpu_execute_refilling             ), //o
    .io_cpu_memory_isValid                  (dataCache_1_io_cpu_memory_isValid                ), //i
    .io_cpu_memory_isStuck                  (memory_arbitration_isStuck                       ), //i
    .io_cpu_memory_isWrite                  (dataCache_1_io_cpu_memory_isWrite                ), //o
    .io_cpu_memory_address                  (dataCache_1_io_cpu_memory_address[31:0]          ), //i
    .io_cpu_memory_mmuRsp_physicalAddress   (DBusCachedPlugin_mmuBus_rsp_physicalAddress[31:0]), //i
    .io_cpu_memory_mmuRsp_isIoAccess        (dataCache_1_io_cpu_memory_mmuRsp_isIoAccess      ), //i
    .io_cpu_memory_mmuRsp_isPaging          (DBusCachedPlugin_mmuBus_rsp_isPaging             ), //i
    .io_cpu_memory_mmuRsp_allowRead         (DBusCachedPlugin_mmuBus_rsp_allowRead            ), //i
    .io_cpu_memory_mmuRsp_allowWrite        (DBusCachedPlugin_mmuBus_rsp_allowWrite           ), //i
    .io_cpu_memory_mmuRsp_allowExecute      (DBusCachedPlugin_mmuBus_rsp_allowExecute         ), //i
    .io_cpu_memory_mmuRsp_exception         (DBusCachedPlugin_mmuBus_rsp_exception            ), //i
    .io_cpu_memory_mmuRsp_refilling         (DBusCachedPlugin_mmuBus_rsp_refilling            ), //i
    .io_cpu_memory_mmuRsp_bypassTranslation (DBusCachedPlugin_mmuBus_rsp_bypassTranslation    ), //i
    .io_cpu_writeBack_isValid               (dataCache_1_io_cpu_writeBack_isValid             ), //i
    .io_cpu_writeBack_isStuck               (writeBack_arbitration_isStuck                    ), //i
    .io_cpu_writeBack_isFiring              (writeBack_arbitration_isFiring                   ), //i
    .io_cpu_writeBack_isUser                (dataCache_1_io_cpu_writeBack_isUser              ), //i
    .io_cpu_writeBack_haltIt                (dataCache_1_io_cpu_writeBack_haltIt              ), //o
    .io_cpu_writeBack_isWrite               (dataCache_1_io_cpu_writeBack_isWrite             ), //o
    .io_cpu_writeBack_storeData             (dataCache_1_io_cpu_writeBack_storeData[31:0]     ), //i
    .io_cpu_writeBack_data                  (dataCache_1_io_cpu_writeBack_data[31:0]          ), //o
    .io_cpu_writeBack_address               (dataCache_1_io_cpu_writeBack_address[31:0]       ), //i
    .io_cpu_writeBack_mmuException          (dataCache_1_io_cpu_writeBack_mmuException        ), //o
    .io_cpu_writeBack_unalignedAccess       (dataCache_1_io_cpu_writeBack_unalignedAccess     ), //o
    .io_cpu_writeBack_accessError           (dataCache_1_io_cpu_writeBack_accessError         ), //o
    .io_cpu_writeBack_keepMemRspData        (dataCache_1_io_cpu_writeBack_keepMemRspData      ), //o
    .io_cpu_writeBack_fence_SW              (dataCache_1_io_cpu_writeBack_fence_SW            ), //i
    .io_cpu_writeBack_fence_SR              (dataCache_1_io_cpu_writeBack_fence_SR            ), //i
    .io_cpu_writeBack_fence_SO              (dataCache_1_io_cpu_writeBack_fence_SO            ), //i
    .io_cpu_writeBack_fence_SI              (dataCache_1_io_cpu_writeBack_fence_SI            ), //i
    .io_cpu_writeBack_fence_PW              (dataCache_1_io_cpu_writeBack_fence_PW            ), //i
    .io_cpu_writeBack_fence_PR              (dataCache_1_io_cpu_writeBack_fence_PR            ), //i
    .io_cpu_writeBack_fence_PO              (dataCache_1_io_cpu_writeBack_fence_PO            ), //i
    .io_cpu_writeBack_fence_PI              (dataCache_1_io_cpu_writeBack_fence_PI            ), //i
    .io_cpu_writeBack_fence_FM              (dataCache_1_io_cpu_writeBack_fence_FM[3:0]       ), //i
    .io_cpu_writeBack_exclusiveOk           (dataCache_1_io_cpu_writeBack_exclusiveOk         ), //o
    .io_cpu_redo                            (dataCache_1_io_cpu_redo                          ), //o
    .io_cpu_flush_valid                     (dataCache_1_io_cpu_flush_valid                   ), //i
    .io_cpu_flush_ready                     (dataCache_1_io_cpu_flush_ready                   ), //o
    .io_cpu_flush_payload_singleLine        (dataCache_1_io_cpu_flush_payload_singleLine      ), //i
    .io_mem_cmd_valid                       (dataCache_1_io_mem_cmd_valid                     ), //o
    .io_mem_cmd_ready                       (dBus_cmd_ready                                   ), //i
    .io_mem_cmd_payload_wr                  (dataCache_1_io_mem_cmd_payload_wr                ), //o
    .io_mem_cmd_payload_uncached            (dataCache_1_io_mem_cmd_payload_uncached          ), //o
    .io_mem_cmd_payload_address             (dataCache_1_io_mem_cmd_payload_address[31:0]     ), //o
    .io_mem_cmd_payload_data                (dataCache_1_io_mem_cmd_payload_data[31:0]        ), //o
    .io_mem_cmd_payload_mask                (dataCache_1_io_mem_cmd_payload_mask[3:0]         ), //o
    .io_mem_cmd_payload_size                (dataCache_1_io_mem_cmd_payload_size[1:0]         ), //o
    .io_mem_cmd_payload_last                (dataCache_1_io_mem_cmd_payload_last              ), //o
    .io_mem_rsp_valid                       (dBus_rsp_valid                                   ), //i
    .io_mem_rsp_payload_last                (dBus_rsp_payload_last                            ), //i
    .io_mem_rsp_payload_data                (dBus_rsp_payload_data[31:0]                      ), //i
    .io_mem_rsp_payload_error               (dBus_rsp_payload_error                           ), //i
    .clk                                    (clk                                              ), //i
    .reset                                  (reset                                            )  //i
  );
  FpuCore FpuPlugin_fpu (
    .io_port_0_cmd_valid                   (FpuPlugin_port_cmd_valid                           ), //i
    .io_port_0_cmd_ready                   (FpuPlugin_fpu_io_port_0_cmd_ready                  ), //o
    .io_port_0_cmd_payload_opcode          (FpuPlugin_port_cmd_payload_opcode[3:0]             ), //i
    .io_port_0_cmd_payload_arg             (FpuPlugin_port_cmd_payload_arg[1:0]                ), //i
    .io_port_0_cmd_payload_rs1             (FpuPlugin_port_cmd_payload_rs1[4:0]                ), //i
    .io_port_0_cmd_payload_rs2             (FpuPlugin_port_cmd_payload_rs2[4:0]                ), //i
    .io_port_0_cmd_payload_rs3             (FpuPlugin_port_cmd_payload_rs3[4:0]                ), //i
    .io_port_0_cmd_payload_rd              (FpuPlugin_port_cmd_payload_rd[4:0]                 ), //i
    .io_port_0_cmd_payload_format          (FpuPlugin_port_cmd_payload_format                  ), //i
    .io_port_0_cmd_payload_roundMode       (FpuPlugin_port_cmd_payload_roundMode[2:0]          ), //i
    .io_port_0_commit_valid                (FpuPlugin_port_commit_valid                        ), //i
    .io_port_0_commit_ready                (FpuPlugin_fpu_io_port_0_commit_ready               ), //o
    .io_port_0_commit_payload_opcode       (FpuPlugin_port_commit_payload_opcode[3:0]          ), //i
    .io_port_0_commit_payload_rd           (FpuPlugin_port_commit_payload_rd[4:0]              ), //i
    .io_port_0_commit_payload_write        (FpuPlugin_port_commit_payload_write                ), //i
    .io_port_0_commit_payload_value        (FpuPlugin_port_commit_payload_value[31:0]          ), //i
    .io_port_0_rsp_valid                   (FpuPlugin_fpu_io_port_0_rsp_valid                  ), //o
    .io_port_0_rsp_ready                   (FpuPlugin_port_rsp_ready                           ), //i
    .io_port_0_rsp_payload_value           (FpuPlugin_fpu_io_port_0_rsp_payload_value[31:0]    ), //o
    .io_port_0_rsp_payload_NV              (FpuPlugin_fpu_io_port_0_rsp_payload_NV             ), //o
    .io_port_0_rsp_payload_NX              (FpuPlugin_fpu_io_port_0_rsp_payload_NX             ), //o
    .io_port_0_completion_valid            (FpuPlugin_fpu_io_port_0_completion_valid           ), //o
    .io_port_0_completion_payload_flags_NX (FpuPlugin_fpu_io_port_0_completion_payload_flags_NX), //o
    .io_port_0_completion_payload_flags_UF (FpuPlugin_fpu_io_port_0_completion_payload_flags_UF), //o
    .io_port_0_completion_payload_flags_OF (FpuPlugin_fpu_io_port_0_completion_payload_flags_OF), //o
    .io_port_0_completion_payload_flags_DZ (FpuPlugin_fpu_io_port_0_completion_payload_flags_DZ), //o
    .io_port_0_completion_payload_flags_NV (FpuPlugin_fpu_io_port_0_completion_payload_flags_NV), //o
    .io_port_0_completion_payload_written  (FpuPlugin_fpu_io_port_0_completion_payload_written ), //o
    .clk                                   (clk                                                ), //i
    .reset                                 (reset                                              )  //i
  );
  always @(*) begin
    case(_zz_IBusCachedPlugin_jump_pcLoad_payload_6)
      2'b00 : _zz_IBusCachedPlugin_jump_pcLoad_payload_5 = DBusCachedPlugin_redoBranch_payload;
      2'b01 : _zz_IBusCachedPlugin_jump_pcLoad_payload_5 = CsrPlugin_jumpInterface_payload;
      2'b10 : _zz_IBusCachedPlugin_jump_pcLoad_payload_5 = BranchPlugin_jumpInterface_payload;
      default : _zz_IBusCachedPlugin_jump_pcLoad_payload_5 = IBusCachedPlugin_predictionJumpInterface_payload;
    endcase
  end

  always @(*) begin
    case(_zz_writeBack_DBusCachedPlugin_rspShifted_1)
      2'b00 : _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_0;
      2'b01 : _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_1;
      2'b10 : _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_2;
      default : _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_3;
    endcase
  end

  always @(*) begin
    case(_zz_writeBack_DBusCachedPlugin_rspShifted_3)
      1'b0 : _zz_writeBack_DBusCachedPlugin_rspShifted_2 = writeBack_DBusCachedPlugin_rspSplits_1;
      default : _zz_writeBack_DBusCachedPlugin_rspShifted_2 = writeBack_DBusCachedPlugin_rspSplits_3;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_decode_to_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_to_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_to_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL_1)
      BranchCtrlEnum_INC : _zz_decode_to_execute_BRANCH_CTRL_1_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_to_execute_BRANCH_CTRL_1_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_memory_to_writeBack_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : _zz_memory_to_writeBack_ENV_CTRL_string = "XRET";
      default : _zz_memory_to_writeBack_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_memory_to_writeBack_ENV_CTRL_1_string = "NONE";
      EnvCtrlEnum_XRET : _zz_memory_to_writeBack_ENV_CTRL_1_string = "XRET";
      default : _zz_memory_to_writeBack_ENV_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_execute_to_memory_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : _zz_execute_to_memory_ENV_CTRL_string = "XRET";
      default : _zz_execute_to_memory_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_execute_to_memory_ENV_CTRL_1_string = "NONE";
      EnvCtrlEnum_XRET : _zz_execute_to_memory_ENV_CTRL_1_string = "XRET";
      default : _zz_execute_to_memory_ENV_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_ENV_CTRL)
      EnvCtrlEnum_NONE : decode_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : decode_ENV_CTRL_string = "XRET";
      default : decode_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_decode_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : _zz_decode_ENV_CTRL_string = "XRET";
      default : _zz_decode_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_decode_to_execute_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : _zz_decode_to_execute_ENV_CTRL_string = "XRET";
      default : _zz_decode_to_execute_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_decode_to_execute_ENV_CTRL_1_string = "NONE";
      EnvCtrlEnum_XRET : _zz_decode_to_execute_ENV_CTRL_1_string = "XRET";
      default : _zz_decode_to_execute_ENV_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(memory_FPU_OPCODE)
      FpuOpcode_LOAD : memory_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : memory_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : memory_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : memory_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : memory_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : memory_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : memory_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : memory_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : memory_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : memory_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : memory_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : memory_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : memory_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : memory_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : memory_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : memory_FPU_OPCODE_string = "FCVT_X_X";
      default : memory_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_FPU_OPCODE)
      FpuOpcode_LOAD : _zz_memory_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : _zz_memory_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : _zz_memory_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : _zz_memory_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : _zz_memory_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : _zz_memory_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : _zz_memory_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : _zz_memory_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : _zz_memory_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : _zz_memory_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_memory_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_memory_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_memory_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_memory_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_memory_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_memory_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_memory_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_FPU_OPCODE)
      FpuOpcode_LOAD : _zz_memory_to_writeBack_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : _zz_memory_to_writeBack_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : _zz_memory_to_writeBack_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : _zz_memory_to_writeBack_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : _zz_memory_to_writeBack_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : _zz_memory_to_writeBack_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : _zz_memory_to_writeBack_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : _zz_memory_to_writeBack_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : _zz_memory_to_writeBack_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : _zz_memory_to_writeBack_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_memory_to_writeBack_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_memory_to_writeBack_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_memory_to_writeBack_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_memory_to_writeBack_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_memory_to_writeBack_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_memory_to_writeBack_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_memory_to_writeBack_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_FPU_OPCODE_1)
      FpuOpcode_LOAD : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "LOAD    ";
      FpuOpcode_STORE : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "STORE   ";
      FpuOpcode_MUL : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "MUL     ";
      FpuOpcode_ADD : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "ADD     ";
      FpuOpcode_FMA : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "FMA     ";
      FpuOpcode_I2F : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "I2F     ";
      FpuOpcode_F2I : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "F2I     ";
      FpuOpcode_CMP : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "CMP     ";
      FpuOpcode_DIV : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "DIV     ";
      FpuOpcode_SQRT : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "FCVT_X_X";
      default : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_FPU_OPCODE)
      FpuOpcode_LOAD : execute_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : execute_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : execute_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : execute_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : execute_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : execute_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : execute_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : execute_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : execute_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : execute_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : execute_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : execute_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : execute_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : execute_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : execute_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : execute_FPU_OPCODE_string = "FCVT_X_X";
      default : execute_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_FPU_OPCODE)
      FpuOpcode_LOAD : _zz_execute_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : _zz_execute_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : _zz_execute_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : _zz_execute_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : _zz_execute_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : _zz_execute_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : _zz_execute_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : _zz_execute_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : _zz_execute_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : _zz_execute_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_execute_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_execute_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_execute_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_execute_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_execute_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_execute_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_execute_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_FPU_OPCODE)
      FpuOpcode_LOAD : _zz_execute_to_memory_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : _zz_execute_to_memory_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : _zz_execute_to_memory_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : _zz_execute_to_memory_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : _zz_execute_to_memory_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : _zz_execute_to_memory_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : _zz_execute_to_memory_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : _zz_execute_to_memory_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : _zz_execute_to_memory_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : _zz_execute_to_memory_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_execute_to_memory_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_execute_to_memory_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_execute_to_memory_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_execute_to_memory_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_execute_to_memory_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_execute_to_memory_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_execute_to_memory_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_FPU_OPCODE_1)
      FpuOpcode_LOAD : _zz_execute_to_memory_FPU_OPCODE_1_string = "LOAD    ";
      FpuOpcode_STORE : _zz_execute_to_memory_FPU_OPCODE_1_string = "STORE   ";
      FpuOpcode_MUL : _zz_execute_to_memory_FPU_OPCODE_1_string = "MUL     ";
      FpuOpcode_ADD : _zz_execute_to_memory_FPU_OPCODE_1_string = "ADD     ";
      FpuOpcode_FMA : _zz_execute_to_memory_FPU_OPCODE_1_string = "FMA     ";
      FpuOpcode_I2F : _zz_execute_to_memory_FPU_OPCODE_1_string = "I2F     ";
      FpuOpcode_F2I : _zz_execute_to_memory_FPU_OPCODE_1_string = "F2I     ";
      FpuOpcode_CMP : _zz_execute_to_memory_FPU_OPCODE_1_string = "CMP     ";
      FpuOpcode_DIV : _zz_execute_to_memory_FPU_OPCODE_1_string = "DIV     ";
      FpuOpcode_SQRT : _zz_execute_to_memory_FPU_OPCODE_1_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_execute_to_memory_FPU_OPCODE_1_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_execute_to_memory_FPU_OPCODE_1_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_execute_to_memory_FPU_OPCODE_1_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_execute_to_memory_FPU_OPCODE_1_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_execute_to_memory_FPU_OPCODE_1_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_execute_to_memory_FPU_OPCODE_1_string = "FCVT_X_X";
      default : _zz_execute_to_memory_FPU_OPCODE_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_FPU_OPCODE)
      FpuOpcode_LOAD : _zz_decode_to_execute_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : _zz_decode_to_execute_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : _zz_decode_to_execute_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : _zz_decode_to_execute_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : _zz_decode_to_execute_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : _zz_decode_to_execute_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : _zz_decode_to_execute_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : _zz_decode_to_execute_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : _zz_decode_to_execute_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : _zz_decode_to_execute_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_decode_to_execute_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_decode_to_execute_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_decode_to_execute_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_decode_to_execute_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_decode_to_execute_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_decode_to_execute_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_decode_to_execute_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_FPU_OPCODE_1)
      FpuOpcode_LOAD : _zz_decode_to_execute_FPU_OPCODE_1_string = "LOAD    ";
      FpuOpcode_STORE : _zz_decode_to_execute_FPU_OPCODE_1_string = "STORE   ";
      FpuOpcode_MUL : _zz_decode_to_execute_FPU_OPCODE_1_string = "MUL     ";
      FpuOpcode_ADD : _zz_decode_to_execute_FPU_OPCODE_1_string = "ADD     ";
      FpuOpcode_FMA : _zz_decode_to_execute_FPU_OPCODE_1_string = "FMA     ";
      FpuOpcode_I2F : _zz_decode_to_execute_FPU_OPCODE_1_string = "I2F     ";
      FpuOpcode_F2I : _zz_decode_to_execute_FPU_OPCODE_1_string = "F2I     ";
      FpuOpcode_CMP : _zz_decode_to_execute_FPU_OPCODE_1_string = "CMP     ";
      FpuOpcode_DIV : _zz_decode_to_execute_FPU_OPCODE_1_string = "DIV     ";
      FpuOpcode_SQRT : _zz_decode_to_execute_FPU_OPCODE_1_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_decode_to_execute_FPU_OPCODE_1_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_decode_to_execute_FPU_OPCODE_1_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_decode_to_execute_FPU_OPCODE_1_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_decode_to_execute_FPU_OPCODE_1_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_decode_to_execute_FPU_OPCODE_1_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_decode_to_execute_FPU_OPCODE_1_string = "FCVT_X_X";
      default : _zz_decode_to_execute_FPU_OPCODE_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_execute_to_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_execute_to_memory_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : decode_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : decode_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : decode_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : decode_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : decode_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL_1)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "AND_1";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_SRC2_CTRL)
      Src2CtrlEnum_RS : decode_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : decode_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : decode_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : decode_SRC2_CTRL_string = "PC ";
      default : decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_string = "PC ";
      default : _zz_decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SRC2_CTRL)
      Src2CtrlEnum_RS : _zz_decode_to_execute_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_to_execute_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_to_execute_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_to_execute_SRC2_CTRL_string = "PC ";
      default : _zz_decode_to_execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SRC2_CTRL_1)
      Src2CtrlEnum_RS : _zz_decode_to_execute_SRC2_CTRL_1_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_to_execute_SRC2_CTRL_1_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_to_execute_SRC2_CTRL_1_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_to_execute_SRC2_CTRL_1_string = "PC ";
      default : _zz_decode_to_execute_SRC2_CTRL_1_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : decode_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : decode_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : decode_ALU_CTRL_string = "BITWISE ";
      default : decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL_1)
      AluCtrlEnum_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_1_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_1_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_to_execute_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_SRC1_CTRL)
      Src1CtrlEnum_RS : decode_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : decode_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : decode_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : decode_SRC1_CTRL_string = "URS1        ";
      default : decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SRC1_CTRL)
      Src1CtrlEnum_RS : _zz_decode_to_execute_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_to_execute_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_to_execute_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_to_execute_SRC1_CTRL_string = "URS1        ";
      default : _zz_decode_to_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SRC1_CTRL_1)
      Src1CtrlEnum_RS : _zz_decode_to_execute_SRC1_CTRL_1_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_to_execute_SRC1_CTRL_1_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_to_execute_SRC1_CTRL_1_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_to_execute_SRC1_CTRL_1_string = "URS1        ";
      default : _zz_decode_to_execute_SRC1_CTRL_1_string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : execute_BRANCH_CTRL_string = "JALR";
      default : execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(memory_ENV_CTRL)
      EnvCtrlEnum_NONE : memory_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : memory_ENV_CTRL_string = "XRET";
      default : memory_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_memory_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : _zz_memory_ENV_CTRL_string = "XRET";
      default : _zz_memory_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(execute_ENV_CTRL)
      EnvCtrlEnum_NONE : execute_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : execute_ENV_CTRL_string = "XRET";
      default : execute_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_execute_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : _zz_execute_ENV_CTRL_string = "XRET";
      default : _zz_execute_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : writeBack_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : writeBack_ENV_CTRL_string = "XRET";
      default : writeBack_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_writeBack_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : _zz_writeBack_ENV_CTRL_string = "XRET";
      default : _zz_writeBack_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_FPU_OPCODE)
      FpuOpcode_LOAD : decode_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : decode_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : decode_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : decode_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : decode_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : decode_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : decode_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : decode_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : decode_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : decode_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : decode_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : decode_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : decode_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : decode_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : decode_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : decode_FPU_OPCODE_string = "FCVT_X_X";
      default : decode_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_FPU_OPCODE)
      FpuOpcode_LOAD : _zz_decode_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : _zz_decode_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : _zz_decode_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : _zz_decode_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : _zz_decode_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : _zz_decode_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : _zz_decode_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : _zz_decode_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : _zz_decode_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : _zz_decode_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_decode_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_decode_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_decode_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_decode_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_decode_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_decode_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_decode_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(writeBack_FPU_OPCODE)
      FpuOpcode_LOAD : writeBack_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : writeBack_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : writeBack_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : writeBack_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : writeBack_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : writeBack_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : writeBack_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : writeBack_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : writeBack_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : writeBack_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : writeBack_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : writeBack_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : writeBack_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : writeBack_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : writeBack_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : writeBack_FPU_OPCODE_string = "FCVT_X_X";
      default : writeBack_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_writeBack_FPU_OPCODE)
      FpuOpcode_LOAD : _zz_writeBack_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : _zz_writeBack_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : _zz_writeBack_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : _zz_writeBack_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : _zz_writeBack_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : _zz_writeBack_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : _zz_writeBack_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : _zz_writeBack_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : _zz_writeBack_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : _zz_writeBack_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_writeBack_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_writeBack_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_writeBack_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_writeBack_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_writeBack_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_writeBack_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_writeBack_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : memory_SHIFT_CTRL_string = "SRA_1    ";
      default : memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : execute_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SRC2_CTRL)
      Src2CtrlEnum_RS : execute_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : execute_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : execute_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : execute_SRC2_CTRL_string = "PC ";
      default : execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SRC2_CTRL)
      Src2CtrlEnum_RS : _zz_execute_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : _zz_execute_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : _zz_execute_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : _zz_execute_SRC2_CTRL_string = "PC ";
      default : _zz_execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(execute_SRC1_CTRL)
      Src1CtrlEnum_RS : execute_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : execute_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : execute_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : execute_SRC1_CTRL_string = "URS1        ";
      default : execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SRC1_CTRL)
      Src1CtrlEnum_RS : _zz_execute_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_execute_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_execute_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_execute_SRC1_CTRL_string = "URS1        ";
      default : _zz_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : execute_ALU_CTRL_string = "BITWISE ";
      default : execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_decode_ENV_CTRL_1_string = "NONE";
      EnvCtrlEnum_XRET : _zz_decode_ENV_CTRL_1_string = "XRET";
      default : _zz_decode_ENV_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_FPU_OPCODE_1)
      FpuOpcode_LOAD : _zz_decode_FPU_OPCODE_1_string = "LOAD    ";
      FpuOpcode_STORE : _zz_decode_FPU_OPCODE_1_string = "STORE   ";
      FpuOpcode_MUL : _zz_decode_FPU_OPCODE_1_string = "MUL     ";
      FpuOpcode_ADD : _zz_decode_FPU_OPCODE_1_string = "ADD     ";
      FpuOpcode_FMA : _zz_decode_FPU_OPCODE_1_string = "FMA     ";
      FpuOpcode_I2F : _zz_decode_FPU_OPCODE_1_string = "I2F     ";
      FpuOpcode_F2I : _zz_decode_FPU_OPCODE_1_string = "F2I     ";
      FpuOpcode_CMP : _zz_decode_FPU_OPCODE_1_string = "CMP     ";
      FpuOpcode_DIV : _zz_decode_FPU_OPCODE_1_string = "DIV     ";
      FpuOpcode_SQRT : _zz_decode_FPU_OPCODE_1_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_decode_FPU_OPCODE_1_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_decode_FPU_OPCODE_1_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_decode_FPU_OPCODE_1_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_decode_FPU_OPCODE_1_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_decode_FPU_OPCODE_1_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_decode_FPU_OPCODE_1_string = "FCVT_X_X";
      default : _zz_decode_FPU_OPCODE_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_1)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_1)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_1_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_1_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_1_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_1_string = "PC ";
      default : _zz_decode_SRC2_CTRL_1_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_1)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_1_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_1_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_1)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_1_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_1_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_1_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_1_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_1_string = "????????????";
    endcase
  end
  always @(*) begin
    case(decode_BRANCH_CTRL)
      BranchCtrlEnum_INC : decode_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : decode_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : decode_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : decode_BRANCH_CTRL_string = "JALR";
      default : decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_1)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_1_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_1_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_1_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(FpuPlugin_port_cmd_payload_opcode)
      FpuOpcode_LOAD : FpuPlugin_port_cmd_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : FpuPlugin_port_cmd_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : FpuPlugin_port_cmd_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : FpuPlugin_port_cmd_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : FpuPlugin_port_cmd_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : FpuPlugin_port_cmd_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : FpuPlugin_port_cmd_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : FpuPlugin_port_cmd_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : FpuPlugin_port_cmd_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : FpuPlugin_port_cmd_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : FpuPlugin_port_cmd_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : FpuPlugin_port_cmd_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : FpuPlugin_port_cmd_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : FpuPlugin_port_cmd_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : FpuPlugin_port_cmd_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : FpuPlugin_port_cmd_payload_opcode_string = "FCVT_X_X";
      default : FpuPlugin_port_cmd_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(FpuPlugin_port_cmd_payload_format)
      FpuFormat_FLOAT : FpuPlugin_port_cmd_payload_format_string = "FLOAT ";
      FpuFormat_DOUBLE : FpuPlugin_port_cmd_payload_format_string = "DOUBLE";
      default : FpuPlugin_port_cmd_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(FpuPlugin_port_cmd_payload_roundMode)
      FpuRoundMode_RNE : FpuPlugin_port_cmd_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : FpuPlugin_port_cmd_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : FpuPlugin_port_cmd_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : FpuPlugin_port_cmd_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : FpuPlugin_port_cmd_payload_roundMode_string = "RMM";
      default : FpuPlugin_port_cmd_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(FpuPlugin_port_commit_payload_opcode)
      FpuOpcode_LOAD : FpuPlugin_port_commit_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : FpuPlugin_port_commit_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : FpuPlugin_port_commit_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : FpuPlugin_port_commit_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : FpuPlugin_port_commit_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : FpuPlugin_port_commit_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : FpuPlugin_port_commit_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : FpuPlugin_port_commit_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : FpuPlugin_port_commit_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : FpuPlugin_port_commit_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : FpuPlugin_port_commit_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : FpuPlugin_port_commit_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : FpuPlugin_port_commit_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : FpuPlugin_port_commit_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : FpuPlugin_port_commit_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : FpuPlugin_port_commit_payload_opcode_string = "FCVT_X_X";
      default : FpuPlugin_port_commit_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_2)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_2_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_2_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_2_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_2_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_2_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_2)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_2_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_2_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_2_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_2_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_2)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_2_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_2_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_2_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_2_string = "PC ";
      default : _zz_decode_SRC2_CTRL_2_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_2)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_2_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_2)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_2_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_2_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_2_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_2_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_2_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_FPU_OPCODE_2)
      FpuOpcode_LOAD : _zz_decode_FPU_OPCODE_2_string = "LOAD    ";
      FpuOpcode_STORE : _zz_decode_FPU_OPCODE_2_string = "STORE   ";
      FpuOpcode_MUL : _zz_decode_FPU_OPCODE_2_string = "MUL     ";
      FpuOpcode_ADD : _zz_decode_FPU_OPCODE_2_string = "ADD     ";
      FpuOpcode_FMA : _zz_decode_FPU_OPCODE_2_string = "FMA     ";
      FpuOpcode_I2F : _zz_decode_FPU_OPCODE_2_string = "I2F     ";
      FpuOpcode_F2I : _zz_decode_FPU_OPCODE_2_string = "F2I     ";
      FpuOpcode_CMP : _zz_decode_FPU_OPCODE_2_string = "CMP     ";
      FpuOpcode_DIV : _zz_decode_FPU_OPCODE_2_string = "DIV     ";
      FpuOpcode_SQRT : _zz_decode_FPU_OPCODE_2_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_decode_FPU_OPCODE_2_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_decode_FPU_OPCODE_2_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_decode_FPU_OPCODE_2_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_decode_FPU_OPCODE_2_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_decode_FPU_OPCODE_2_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_decode_FPU_OPCODE_2_string = "FCVT_X_X";
      default : _zz_decode_FPU_OPCODE_2_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL_2)
      EnvCtrlEnum_NONE : _zz_decode_ENV_CTRL_2_string = "NONE";
      EnvCtrlEnum_XRET : _zz_decode_ENV_CTRL_2_string = "XRET";
      default : _zz_decode_ENV_CTRL_2_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_2)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_2_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_2_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_2_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_2_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_2_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_FpuPlugin_port_cmd_payload_roundMode)
      FpuRoundMode_RNE : _zz_FpuPlugin_port_cmd_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : _zz_FpuPlugin_port_cmd_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : _zz_FpuPlugin_port_cmd_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : _zz_FpuPlugin_port_cmd_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : _zz_FpuPlugin_port_cmd_payload_roundMode_string = "RMM";
      default : _zz_FpuPlugin_port_cmd_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_FpuPlugin_port_cmd_payload_roundMode_1)
      FpuRoundMode_RNE : _zz_FpuPlugin_port_cmd_payload_roundMode_1_string = "RNE";
      FpuRoundMode_RTZ : _zz_FpuPlugin_port_cmd_payload_roundMode_1_string = "RTZ";
      FpuRoundMode_RDN : _zz_FpuPlugin_port_cmd_payload_roundMode_1_string = "RDN";
      FpuRoundMode_RUP : _zz_FpuPlugin_port_cmd_payload_roundMode_1_string = "RUP";
      FpuRoundMode_RMM : _zz_FpuPlugin_port_cmd_payload_roundMode_1_string = "RMM";
      default : _zz_FpuPlugin_port_cmd_payload_roundMode_1_string = "???";
    endcase
  end
  always @(*) begin
    case(writeBack_FpuPlugin_commit_payload_opcode)
      FpuOpcode_LOAD : writeBack_FpuPlugin_commit_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : writeBack_FpuPlugin_commit_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : writeBack_FpuPlugin_commit_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : writeBack_FpuPlugin_commit_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : writeBack_FpuPlugin_commit_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : writeBack_FpuPlugin_commit_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : writeBack_FpuPlugin_commit_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : writeBack_FpuPlugin_commit_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : writeBack_FpuPlugin_commit_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : writeBack_FpuPlugin_commit_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : writeBack_FpuPlugin_commit_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : writeBack_FpuPlugin_commit_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : writeBack_FpuPlugin_commit_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : writeBack_FpuPlugin_commit_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : writeBack_FpuPlugin_commit_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : writeBack_FpuPlugin_commit_payload_opcode_string = "FCVT_X_X";
      default : writeBack_FpuPlugin_commit_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(writeBack_FpuPlugin_commit_s2mPipe_payload_opcode)
      FpuOpcode_LOAD : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FCVT_X_X";
      default : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(writeBack_FpuPlugin_commit_rData_opcode)
      FpuOpcode_LOAD : writeBack_FpuPlugin_commit_rData_opcode_string = "LOAD    ";
      FpuOpcode_STORE : writeBack_FpuPlugin_commit_rData_opcode_string = "STORE   ";
      FpuOpcode_MUL : writeBack_FpuPlugin_commit_rData_opcode_string = "MUL     ";
      FpuOpcode_ADD : writeBack_FpuPlugin_commit_rData_opcode_string = "ADD     ";
      FpuOpcode_FMA : writeBack_FpuPlugin_commit_rData_opcode_string = "FMA     ";
      FpuOpcode_I2F : writeBack_FpuPlugin_commit_rData_opcode_string = "I2F     ";
      FpuOpcode_F2I : writeBack_FpuPlugin_commit_rData_opcode_string = "F2I     ";
      FpuOpcode_CMP : writeBack_FpuPlugin_commit_rData_opcode_string = "CMP     ";
      FpuOpcode_DIV : writeBack_FpuPlugin_commit_rData_opcode_string = "DIV     ";
      FpuOpcode_SQRT : writeBack_FpuPlugin_commit_rData_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : writeBack_FpuPlugin_commit_rData_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : writeBack_FpuPlugin_commit_rData_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : writeBack_FpuPlugin_commit_rData_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : writeBack_FpuPlugin_commit_rData_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : writeBack_FpuPlugin_commit_rData_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : writeBack_FpuPlugin_commit_rData_opcode_string = "FCVT_X_X";
      default : writeBack_FpuPlugin_commit_rData_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode)
      FpuOpcode_LOAD : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FCVT_X_X";
      default : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC1_CTRL)
      Src1CtrlEnum_RS : decode_to_execute_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : decode_to_execute_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : decode_to_execute_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : decode_to_execute_SRC1_CTRL_string = "URS1        ";
      default : decode_to_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC2_CTRL)
      Src2CtrlEnum_RS : decode_to_execute_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : decode_to_execute_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : decode_to_execute_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : decode_to_execute_SRC2_CTRL_string = "PC ";
      default : decode_to_execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : execute_to_memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : execute_to_memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : execute_to_memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : execute_to_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_to_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_FPU_OPCODE)
      FpuOpcode_LOAD : decode_to_execute_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : decode_to_execute_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : decode_to_execute_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : decode_to_execute_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : decode_to_execute_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : decode_to_execute_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : decode_to_execute_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : decode_to_execute_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : decode_to_execute_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : decode_to_execute_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : decode_to_execute_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : decode_to_execute_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : decode_to_execute_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : decode_to_execute_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : decode_to_execute_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : decode_to_execute_FPU_OPCODE_string = "FCVT_X_X";
      default : decode_to_execute_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_FPU_OPCODE)
      FpuOpcode_LOAD : execute_to_memory_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : execute_to_memory_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : execute_to_memory_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : execute_to_memory_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : execute_to_memory_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : execute_to_memory_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : execute_to_memory_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : execute_to_memory_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : execute_to_memory_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : execute_to_memory_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : execute_to_memory_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : execute_to_memory_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : execute_to_memory_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : execute_to_memory_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : execute_to_memory_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : execute_to_memory_FPU_OPCODE_string = "FCVT_X_X";
      default : execute_to_memory_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(memory_to_writeBack_FPU_OPCODE)
      FpuOpcode_LOAD : memory_to_writeBack_FPU_OPCODE_string = "LOAD    ";
      FpuOpcode_STORE : memory_to_writeBack_FPU_OPCODE_string = "STORE   ";
      FpuOpcode_MUL : memory_to_writeBack_FPU_OPCODE_string = "MUL     ";
      FpuOpcode_ADD : memory_to_writeBack_FPU_OPCODE_string = "ADD     ";
      FpuOpcode_FMA : memory_to_writeBack_FPU_OPCODE_string = "FMA     ";
      FpuOpcode_I2F : memory_to_writeBack_FPU_OPCODE_string = "I2F     ";
      FpuOpcode_F2I : memory_to_writeBack_FPU_OPCODE_string = "F2I     ";
      FpuOpcode_CMP : memory_to_writeBack_FPU_OPCODE_string = "CMP     ";
      FpuOpcode_DIV : memory_to_writeBack_FPU_OPCODE_string = "DIV     ";
      FpuOpcode_SQRT : memory_to_writeBack_FPU_OPCODE_string = "SQRT    ";
      FpuOpcode_MIN_MAX : memory_to_writeBack_FPU_OPCODE_string = "MIN_MAX ";
      FpuOpcode_SGNJ : memory_to_writeBack_FPU_OPCODE_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : memory_to_writeBack_FPU_OPCODE_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : memory_to_writeBack_FPU_OPCODE_string = "FMV_W_X ";
      FpuOpcode_FCLASS : memory_to_writeBack_FPU_OPCODE_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : memory_to_writeBack_FPU_OPCODE_string = "FCVT_X_X";
      default : memory_to_writeBack_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ENV_CTRL)
      EnvCtrlEnum_NONE : decode_to_execute_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : decode_to_execute_ENV_CTRL_string = "XRET";
      default : decode_to_execute_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_ENV_CTRL)
      EnvCtrlEnum_NONE : execute_to_memory_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : execute_to_memory_ENV_CTRL_string = "XRET";
      default : execute_to_memory_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(memory_to_writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : memory_to_writeBack_ENV_CTRL_string = "NONE";
      EnvCtrlEnum_XRET : memory_to_writeBack_ENV_CTRL_string = "XRET";
      default : memory_to_writeBack_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  `endif

  assign writeBack_MEMORY_LOAD_DATA = writeBack_DBusCachedPlugin_rspShifted; // @[Stage.scala 30:13]
  assign execute_SHIFT_RIGHT = _zz_execute_SHIFT_RIGHT; // @[Stage.scala 30:13]
  assign execute_REGFILE_WRITE_DATA = _zz_execute_REGFILE_WRITE_DATA; // @[Stage.scala 30:13]
  assign memory_MEMORY_STORE_DATA_RF = execute_to_memory_MEMORY_STORE_DATA_RF; // @[Stage.scala 30:13]
  assign execute_MEMORY_STORE_DATA_RF = _zz_execute_MEMORY_STORE_DATA_RF; // @[Stage.scala 30:13]
  assign decode_PREDICTION_HAD_BRANCHED2 = IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Stage.scala 30:13]
  assign decode_DO_EBREAK = (((! DebugPlugin_haltIt) && (decode_IS_EBREAK || 1'b0)) && DebugPlugin_allowEBreak); // @[Stage.scala 30:13]
  assign decode_CSR_READ_OPCODE = (decode_INSTRUCTION[13 : 7] != 7'h20); // @[Stage.scala 30:13]
  assign decode_CSR_WRITE_OPCODE = (! (((decode_INSTRUCTION[14 : 13] == 2'b01) && (decode_INSTRUCTION[19 : 15] == 5'h0)) || ((decode_INSTRUCTION[14 : 13] == 2'b11) && (decode_INSTRUCTION[19 : 15] == 5'h0)))); // @[Stage.scala 30:13]
  assign memory_FPU_COMMIT_LOAD = execute_to_memory_FPU_COMMIT_LOAD; // @[Stage.scala 30:13]
  assign execute_FPU_COMMIT_LOAD = decode_to_execute_FPU_COMMIT_LOAD; // @[Stage.scala 30:13]
  assign decode_FPU_COMMIT_LOAD = (decode_FPU_OPCODE == FpuOpcode_LOAD); // @[Stage.scala 30:13]
  assign memory_FPU_FORKED = execute_to_memory_FPU_FORKED; // @[Stage.scala 30:13]
  assign execute_FPU_FORKED = decode_to_execute_FPU_FORKED; // @[Stage.scala 30:13]
  assign decode_FPU_FORKED = (decode_FpuPlugin_forked || FpuPlugin_port_cmd_fire_2); // @[Stage.scala 30:13]
  assign decode_SRC2_FORCE_ZERO = (decode_SRC_ADD_ZERO && (! decode_SRC_USE_SUB_LESS)); // @[Stage.scala 30:13]
  assign memory_RS1 = execute_to_memory_RS1; // @[Stage.scala 30:13]
  assign _zz_decode_to_execute_BRANCH_CTRL = _zz_decode_to_execute_BRANCH_CTRL_1; // @[Stage.scala 39:14]
  assign _zz_memory_to_writeBack_ENV_CTRL = _zz_memory_to_writeBack_ENV_CTRL_1; // @[Stage.scala 39:14]
  assign _zz_execute_to_memory_ENV_CTRL = _zz_execute_to_memory_ENV_CTRL_1; // @[Stage.scala 39:14]
  assign decode_ENV_CTRL = _zz_decode_ENV_CTRL; // @[Stage.scala 30:13]
  assign _zz_decode_to_execute_ENV_CTRL = _zz_decode_to_execute_ENV_CTRL_1; // @[Stage.scala 39:14]
  assign decode_IS_CSR = _zz_decode_IS_CSR[33]; // @[Stage.scala 30:13]
  assign memory_FPU_OPCODE = _zz_memory_FPU_OPCODE; // @[Stage.scala 30:13]
  assign _zz_memory_to_writeBack_FPU_OPCODE = _zz_memory_to_writeBack_FPU_OPCODE_1; // @[Stage.scala 39:14]
  assign execute_FPU_OPCODE = _zz_execute_FPU_OPCODE; // @[Stage.scala 30:13]
  assign _zz_execute_to_memory_FPU_OPCODE = _zz_execute_to_memory_FPU_OPCODE_1; // @[Stage.scala 39:14]
  assign _zz_decode_to_execute_FPU_OPCODE = _zz_decode_to_execute_FPU_OPCODE_1; // @[Stage.scala 39:14]
  assign memory_FPU_RSP = execute_to_memory_FPU_RSP; // @[Stage.scala 30:13]
  assign execute_FPU_RSP = decode_to_execute_FPU_RSP; // @[Stage.scala 30:13]
  assign decode_FPU_RSP = _zz_decode_IS_CSR[25]; // @[Stage.scala 30:13]
  assign memory_FPU_COMMIT = execute_to_memory_FPU_COMMIT; // @[Stage.scala 30:13]
  assign execute_FPU_COMMIT = decode_to_execute_FPU_COMMIT; // @[Stage.scala 30:13]
  assign decode_FPU_COMMIT = _zz_decode_IS_CSR[24]; // @[Stage.scala 30:13]
  assign memory_FPU_ENABLE = execute_to_memory_FPU_ENABLE; // @[Stage.scala 30:13]
  assign execute_FPU_ENABLE = decode_to_execute_FPU_ENABLE; // @[Stage.scala 30:13]
  assign _zz_execute_to_memory_SHIFT_CTRL = _zz_execute_to_memory_SHIFT_CTRL_1; // @[Stage.scala 39:14]
  assign decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL; // @[Stage.scala 30:13]
  assign _zz_decode_to_execute_SHIFT_CTRL = _zz_decode_to_execute_SHIFT_CTRL_1; // @[Stage.scala 39:14]
  assign decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL; // @[Stage.scala 30:13]
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL = _zz_decode_to_execute_ALU_BITWISE_CTRL_1; // @[Stage.scala 39:14]
  assign decode_SRC_LESS_UNSIGNED = _zz_decode_IS_CSR[17]; // @[Stage.scala 30:13]
  assign decode_MEMORY_MANAGMENT = _zz_decode_IS_CSR[16]; // @[Stage.scala 30:13]
  assign memory_MEMORY_WR = execute_to_memory_MEMORY_WR; // @[Stage.scala 30:13]
  assign decode_MEMORY_WR = _zz_decode_IS_CSR[13]; // @[Stage.scala 30:13]
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE; // @[Stage.scala 30:13]
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_decode_IS_CSR[12]; // @[Stage.scala 30:13]
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_decode_IS_CSR[11]; // @[Stage.scala 30:13]
  assign decode_SRC2_CTRL = _zz_decode_SRC2_CTRL; // @[Stage.scala 30:13]
  assign _zz_decode_to_execute_SRC2_CTRL = _zz_decode_to_execute_SRC2_CTRL_1; // @[Stage.scala 39:14]
  assign decode_ALU_CTRL = _zz_decode_ALU_CTRL; // @[Stage.scala 30:13]
  assign _zz_decode_to_execute_ALU_CTRL = _zz_decode_to_execute_ALU_CTRL_1; // @[Stage.scala 39:14]
  assign decode_SRC1_CTRL = _zz_decode_SRC1_CTRL; // @[Stage.scala 30:13]
  assign _zz_decode_to_execute_SRC1_CTRL = _zz_decode_to_execute_SRC1_CTRL_1; // @[Stage.scala 39:14]
  assign decode_MEMORY_FORCE_CONSTISTENCY = 1'b0; // @[Stage.scala 30:13]
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT; // @[Stage.scala 30:13]
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT; // @[Stage.scala 30:13]
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT; // @[Stage.scala 30:13]
  assign decode_FORMAL_PC_NEXT = (decode_PC + 32'h00000004); // @[Stage.scala 30:13]
  assign memory_PC = execute_to_memory_PC; // @[Stage.scala 30:13]
  assign execute_BRANCH_CALC = {execute_BranchPlugin_branchAdder[31 : 1],1'b0}; // @[Stage.scala 30:13]
  assign execute_BRANCH_DO = ((execute_PREDICTION_HAD_BRANCHED2 != execute_BRANCH_COND_RESULT) || execute_BranchPlugin_missAlignedTarget); // @[Stage.scala 30:13]
  assign execute_PREDICTION_HAD_BRANCHED2 = decode_to_execute_PREDICTION_HAD_BRANCHED2; // @[Stage.scala 30:13]
  assign execute_BRANCH_COND_RESULT = _zz_execute_BRANCH_COND_RESULT_1; // @[Stage.scala 30:13]
  assign execute_BRANCH_CTRL = _zz_execute_BRANCH_CTRL; // @[Stage.scala 30:13]
  assign execute_PC = decode_to_execute_PC; // @[Stage.scala 30:13]
  assign execute_DO_EBREAK = decode_to_execute_DO_EBREAK; // @[Stage.scala 30:13]
  assign decode_IS_EBREAK = _zz_decode_IS_CSR[35]; // @[Stage.scala 30:13]
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE; // @[Stage.scala 30:13]
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE; // @[Stage.scala 30:13]
  assign memory_ENV_CTRL = _zz_memory_ENV_CTRL; // @[Stage.scala 30:13]
  assign execute_ENV_CTRL = _zz_execute_ENV_CTRL; // @[Stage.scala 30:13]
  assign writeBack_ENV_CTRL = _zz_writeBack_ENV_CTRL; // @[Stage.scala 30:13]
  always @(*) begin
    _zz_memory_to_writeBack_FPU_FORKED = memory_FPU_FORKED; // @[Stage.scala 39:14]
    if(memory_arbitration_isStuck) begin
      _zz_memory_to_writeBack_FPU_FORKED = 1'b0; // @[FpuPlugin.scala 311:68]
    end
  end

  always @(*) begin
    _zz_execute_to_memory_FPU_FORKED = execute_FPU_FORKED; // @[Stage.scala 39:14]
    if(execute_arbitration_isStuck) begin
      _zz_execute_to_memory_FPU_FORKED = 1'b0; // @[FpuPlugin.scala 311:68]
    end
  end

  always @(*) begin
    _zz_decode_to_execute_FPU_FORKED = decode_FPU_FORKED; // @[Stage.scala 39:14]
    if(decode_arbitration_isStuck) begin
      _zz_decode_to_execute_FPU_FORKED = 1'b0; // @[FpuPlugin.scala 311:68]
    end
  end

  assign writeBack_RS1 = memory_to_writeBack_RS1; // @[Stage.scala 30:13]
  assign writeBack_FPU_COMMIT_LOAD = memory_to_writeBack_FPU_COMMIT_LOAD; // @[Stage.scala 30:13]
  always @(*) begin
    DBusBypass0_cond = 1'b0; // @[when.scala 47:16]
    if(writeBack_FpuPlugin_isRsp) begin
      if(writeBack_arbitration_isValid) begin
        DBusBypass0_cond = 1'b1; // @[when.scala 52:10]
      end
    end
  end

  assign writeBack_FPU_COMMIT = memory_to_writeBack_FPU_COMMIT; // @[Stage.scala 30:13]
  assign writeBack_FPU_RSP = memory_to_writeBack_FPU_RSP; // @[Stage.scala 30:13]
  assign writeBack_FPU_FORKED = memory_to_writeBack_FPU_FORKED; // @[Stage.scala 30:13]
  assign decode_FPU_ARG = _zz_decode_IS_CSR[32 : 31]; // @[Stage.scala 30:13]
  assign decode_FPU_OPCODE = _zz_decode_FPU_OPCODE; // @[Stage.scala 30:13]
  assign decode_FPU_ENABLE = _zz_decode_IS_CSR[23]; // @[Stage.scala 30:13]
  assign writeBack_FPU_OPCODE = _zz_writeBack_FPU_OPCODE; // @[Stage.scala 30:13]
  assign writeBack_FPU_ENABLE = memory_to_writeBack_FPU_ENABLE; // @[Stage.scala 30:13]
  assign execute_IS_CSR = decode_to_execute_IS_CSR; // @[Stage.scala 30:13]
  assign decode_RS2_USE = _zz_decode_IS_CSR[15]; // @[Stage.scala 30:13]
  assign decode_RS1_USE = _zz_decode_IS_CSR[5]; // @[Stage.scala 30:13]
  always @(*) begin
    _zz_decode_RS2 = execute_REGFILE_WRITE_DATA; // @[Stage.scala 39:14]
    if(when_CsrPlugin_l1507) begin
      _zz_decode_RS2 = CsrPlugin_csrMapping_readDataSignal; // @[CsrPlugin.scala 1508:59]
    end
  end

  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID; // @[Stage.scala 30:13]
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE; // @[Stage.scala 30:13]
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID; // @[Stage.scala 30:13]
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION; // @[Stage.scala 30:13]
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE; // @[Stage.scala 30:13]
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID; // @[Stage.scala 30:13]
  always @(*) begin
    decode_RS2 = decode_RegFilePlugin_rs2Data; // @[Stage.scala 30:13]
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr1Match) begin
        decode_RS2 = HazardSimplePlugin_writeBackBuffer_payload_data; // @[HazardSimplePlugin.scala 87:34]
      end
    end
    if(when_HazardSimplePlugin_l45) begin
      if(when_HazardSimplePlugin_l47) begin
        if(when_HazardSimplePlugin_l51) begin
          decode_RS2 = _zz_decode_RS2_2; // @[HazardSimplePlugin.scala 52:38]
        end
      end
    end
    if(when_HazardSimplePlugin_l45_1) begin
      if(memory_BYPASSABLE_MEMORY_STAGE) begin
        if(when_HazardSimplePlugin_l51_1) begin
          decode_RS2 = _zz_decode_RS2_1; // @[HazardSimplePlugin.scala 52:38]
        end
      end
    end
    if(when_HazardSimplePlugin_l45_2) begin
      if(execute_BYPASSABLE_EXECUTE_STAGE) begin
        if(when_HazardSimplePlugin_l51_2) begin
          decode_RS2 = _zz_decode_RS2; // @[HazardSimplePlugin.scala 52:38]
        end
      end
    end
  end

  always @(*) begin
    decode_RS1 = decode_RegFilePlugin_rs1Data; // @[Stage.scala 30:13]
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr0Match) begin
        decode_RS1 = HazardSimplePlugin_writeBackBuffer_payload_data; // @[HazardSimplePlugin.scala 84:34]
      end
    end
    if(when_HazardSimplePlugin_l45) begin
      if(when_HazardSimplePlugin_l47) begin
        if(when_HazardSimplePlugin_l48) begin
          decode_RS1 = _zz_decode_RS2_2; // @[HazardSimplePlugin.scala 49:38]
        end
      end
    end
    if(when_HazardSimplePlugin_l45_1) begin
      if(memory_BYPASSABLE_MEMORY_STAGE) begin
        if(when_HazardSimplePlugin_l48_1) begin
          decode_RS1 = _zz_decode_RS2_1; // @[HazardSimplePlugin.scala 49:38]
        end
      end
    end
    if(when_HazardSimplePlugin_l45_2) begin
      if(execute_BYPASSABLE_EXECUTE_STAGE) begin
        if(when_HazardSimplePlugin_l48_2) begin
          decode_RS1 = _zz_decode_RS2; // @[HazardSimplePlugin.scala 49:38]
        end
      end
    end
  end

  assign memory_SHIFT_RIGHT = execute_to_memory_SHIFT_RIGHT; // @[Stage.scala 30:13]
  always @(*) begin
    _zz_decode_RS2_1 = memory_REGFILE_WRITE_DATA; // @[Stage.scala 39:14]
    if(memory_arbitration_isValid) begin
      case(memory_SHIFT_CTRL)
        ShiftCtrlEnum_SLL_1 : begin
          _zz_decode_RS2_1 = _zz_decode_RS2_3; // @[ShiftPlugins.scala 75:40]
        end
        ShiftCtrlEnum_SRL_1, ShiftCtrlEnum_SRA_1 : begin
          _zz_decode_RS2_1 = memory_SHIFT_RIGHT; // @[ShiftPlugins.scala 78:40]
        end
        default : begin
        end
      endcase
    end
  end

  assign memory_SHIFT_CTRL = _zz_memory_SHIFT_CTRL; // @[Stage.scala 30:13]
  assign execute_SHIFT_CTRL = _zz_execute_SHIFT_CTRL; // @[Stage.scala 30:13]
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED; // @[Stage.scala 30:13]
  assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO; // @[Stage.scala 30:13]
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS; // @[Stage.scala 30:13]
  assign _zz_execute_to_memory_PC = execute_PC; // @[Stage.scala 39:14]
  assign execute_SRC2_CTRL = _zz_execute_SRC2_CTRL; // @[Stage.scala 30:13]
  assign _zz_execute_to_memory_RS1 = execute_RS1; // @[Stage.scala 39:14]
  assign execute_SRC1_CTRL = _zz_execute_SRC1_CTRL; // @[Stage.scala 30:13]
  assign decode_SRC_USE_SUB_LESS = _zz_decode_IS_CSR[3]; // @[Stage.scala 30:13]
  assign decode_SRC_ADD_ZERO = _zz_decode_IS_CSR[20]; // @[Stage.scala 30:13]
  assign execute_SRC_ADD_SUB = execute_SrcPlugin_addSub; // @[Stage.scala 30:13]
  assign execute_SRC_LESS = execute_SrcPlugin_less; // @[Stage.scala 30:13]
  assign execute_ALU_CTRL = _zz_execute_ALU_CTRL; // @[Stage.scala 30:13]
  assign execute_SRC2 = _zz_execute_SRC2_4; // @[Stage.scala 30:13]
  assign execute_SRC1 = _zz_execute_SRC1; // @[Stage.scala 30:13]
  assign execute_ALU_BITWISE_CTRL = _zz_execute_ALU_BITWISE_CTRL; // @[Stage.scala 30:13]
  assign _zz_lastStageRegFileWrite_payload_address = writeBack_INSTRUCTION; // @[Stage.scala 39:14]
  assign _zz_lastStageRegFileWrite_valid = writeBack_REGFILE_WRITE_VALID; // @[Stage.scala 39:14]
  always @(*) begin
    _zz_1 = 1'b0; // @[when.scala 47:16]
    if(lastStageRegFileWrite_valid) begin
      _zz_1 = 1'b1; // @[when.scala 52:10]
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = (decode_arbitration_isStuck ? decode_INSTRUCTION : IBusCachedPlugin_cache_io_cpu_fetch_data); // @[Stage.scala 30:13]
  always @(*) begin
    decode_REGFILE_WRITE_VALID = _zz_decode_IS_CSR[10]; // @[Stage.scala 30:13]
    if(when_RegFilePlugin_l63) begin
      decode_REGFILE_WRITE_VALID = 1'b0; // @[RegFilePlugin.scala 64:41]
    end
  end

  assign decode_LEGAL_INSTRUCTION = (|{((decode_INSTRUCTION & 32'h0000005f) == 32'h00000017),{((decode_INSTRUCTION & 32'h0000007f) == 32'h0000006f),{((decode_INSTRUCTION & 32'h06000073) == 32'h00000043),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION) == 32'h00001073),{(_zz_decode_LEGAL_INSTRUCTION_1 == _zz_decode_LEGAL_INSTRUCTION_2),{_zz_decode_LEGAL_INSTRUCTION_3,{_zz_decode_LEGAL_INSTRUCTION_4,_zz_decode_LEGAL_INSTRUCTION_5}}}}}}}); // @[Stage.scala 30:13]
  always @(*) begin
    _zz_decode_RS2_2 = writeBack_REGFILE_WRITE_DATA; // @[Stage.scala 39:14]
    if(when_DBusCachedPlugin_l492) begin
      _zz_decode_RS2_2 = writeBack_DBusCachedPlugin_rspFormated; // @[DBusCachedPlugin.scala 493:36]
    end
    if(writeBack_FpuPlugin_isRsp) begin
      if(writeBack_arbitration_isValid) begin
        _zz_decode_RS2_2 = FpuPlugin_port_rsp_payload_value[31 : 0]; // @[FpuPlugin.scala 282:38]
      end
    end
  end

  assign writeBack_MEMORY_WR = memory_to_writeBack_MEMORY_WR; // @[Stage.scala 30:13]
  assign writeBack_MEMORY_STORE_DATA_RF = memory_to_writeBack_MEMORY_STORE_DATA_RF; // @[Stage.scala 30:13]
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA; // @[Stage.scala 30:13]
  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE; // @[Stage.scala 30:13]
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA; // @[Stage.scala 30:13]
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE; // @[Stage.scala 30:13]
  assign execute_MEMORY_FORCE_CONSTISTENCY = decode_to_execute_MEMORY_FORCE_CONSTISTENCY; // @[Stage.scala 30:13]
  assign execute_RS1 = decode_to_execute_RS1; // @[Stage.scala 30:13]
  assign execute_MEMORY_MANAGMENT = decode_to_execute_MEMORY_MANAGMENT; // @[Stage.scala 30:13]
  assign execute_RS2 = decode_to_execute_RS2; // @[Stage.scala 30:13]
  assign execute_MEMORY_WR = decode_to_execute_MEMORY_WR; // @[Stage.scala 30:13]
  assign execute_SRC_ADD = execute_SrcPlugin_addSub; // @[Stage.scala 30:13]
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE; // @[Stage.scala 30:13]
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION; // @[Stage.scala 30:13]
  assign decode_MEMORY_ENABLE = _zz_decode_IS_CSR[4]; // @[Stage.scala 30:13]
  assign decode_FLUSH_ALL = _zz_decode_IS_CSR[0]; // @[Stage.scala 30:13]
  always @(*) begin
    IBusCachedPlugin_rsp_issueDetected_4 = IBusCachedPlugin_rsp_issueDetected_3; // @[Data.scala 57:9]
    if(when_IBusCachedPlugin_l256) begin
      IBusCachedPlugin_rsp_issueDetected_4 = 1'b1; // @[Data.scala 63:9]
    end
  end

  always @(*) begin
    IBusCachedPlugin_rsp_issueDetected_3 = IBusCachedPlugin_rsp_issueDetected_2; // @[Data.scala 57:9]
    if(when_IBusCachedPlugin_l250) begin
      IBusCachedPlugin_rsp_issueDetected_3 = 1'b1; // @[Data.scala 63:9]
    end
  end

  always @(*) begin
    IBusCachedPlugin_rsp_issueDetected_2 = IBusCachedPlugin_rsp_issueDetected_1; // @[Data.scala 57:9]
    if(when_IBusCachedPlugin_l244) begin
      IBusCachedPlugin_rsp_issueDetected_2 = 1'b1; // @[Data.scala 63:9]
    end
  end

  always @(*) begin
    IBusCachedPlugin_rsp_issueDetected_1 = IBusCachedPlugin_rsp_issueDetected; // @[Data.scala 57:9]
    if(when_IBusCachedPlugin_l239) begin
      IBusCachedPlugin_rsp_issueDetected_1 = 1'b1; // @[Data.scala 63:9]
    end
  end

  assign decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL_1; // @[Stage.scala 30:13]
  assign decode_INSTRUCTION = IBusCachedPlugin_iBusRsp_output_payload_rsp_inst; // @[Stage.scala 30:13]
  always @(*) begin
    _zz_execute_to_memory_FORMAL_PC_NEXT = execute_FORMAL_PC_NEXT; // @[Stage.scala 39:14]
    if(BranchPlugin_jumpInterface_valid) begin
      _zz_execute_to_memory_FORMAL_PC_NEXT = BranchPlugin_jumpInterface_payload; // @[Fetcher.scala 437:47]
    end
  end

  always @(*) begin
    _zz_decode_to_execute_FORMAL_PC_NEXT = decode_FORMAL_PC_NEXT; // @[Stage.scala 39:14]
    if(IBusCachedPlugin_predictionJumpInterface_valid) begin
      _zz_decode_to_execute_FORMAL_PC_NEXT = IBusCachedPlugin_predictionJumpInterface_payload; // @[Fetcher.scala 437:47]
    end
  end

  assign decode_PC = IBusCachedPlugin_iBusRsp_output_payload_pc; // @[Stage.scala 30:13]
  assign writeBack_PC = memory_to_writeBack_PC; // @[Stage.scala 30:13]
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION; // @[Stage.scala 30:13]
  always @(*) begin
    decode_arbitration_haltItself = 1'b0; // @[Stage.scala 49:23]
    if(when_DBusCachedPlugin_l308) begin
      decode_arbitration_haltItself = 1'b1; // @[DBusCachedPlugin.scala 309:32]
    end
    if(when_FpuPlugin_l241) begin
      decode_arbitration_haltItself = 1'b1; // @[FpuPlugin.scala 241:30]
    end
    if(FpuPlugin_port_cmd_isStall) begin
      decode_arbitration_haltItself = 1'b1; // @[FpuPlugin.scala 242:30]
    end
    case(switch_Fetcher_l365)
      3'b010 : begin
        decode_arbitration_haltItself = 1'b1; // @[Fetcher.scala 376:45]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    decode_arbitration_haltByOther = 1'b0; // @[Stage.scala 50:23]
    if(when_HazardSimplePlugin_l113) begin
      decode_arbitration_haltByOther = 1'b1; // @[HazardSimplePlugin.scala 114:43]
    end
    if(CsrPlugin_pipelineLiberator_active) begin
      decode_arbitration_haltByOther = 1'b1; // @[CsrPlugin.scala 1253:42]
    end
    if(when_CsrPlugin_l1447) begin
      decode_arbitration_haltByOther = 1'b1; // @[CsrPlugin.scala 1447:38]
    end
  end

  always @(*) begin
    decode_arbitration_removeIt = 1'b0; // @[Stage.scala 51:23]
    if(_zz_when) begin
      decode_arbitration_removeIt = 1'b1; // @[CsrPlugin.scala 1171:40]
    end
    if(decode_arbitration_isFlushed) begin
      decode_arbitration_removeIt = 1'b1; // @[Pipeline.scala 134:36]
    end
  end

  assign decode_arbitration_flushIt = 1'b0; // @[Stage.scala 52:22]
  always @(*) begin
    decode_arbitration_flushNext = 1'b0; // @[Stage.scala 53:24]
    if(IBusCachedPlugin_predictionJumpInterface_valid) begin
      decode_arbitration_flushNext = 1'b1; // @[Fetcher.scala 515:38]
    end
    if(_zz_when) begin
      decode_arbitration_flushNext = 1'b1; // @[CsrPlugin.scala 1170:41]
    end
  end

  always @(*) begin
    execute_arbitration_haltItself = 1'b0; // @[Stage.scala 49:23]
    if(when_DBusCachedPlugin_l350) begin
      execute_arbitration_haltItself = 1'b1; // @[DBusCachedPlugin.scala 350:30]
    end
    if(when_CsrPlugin_l1511) begin
      if(execute_CsrPlugin_blockedBySideEffects) begin
        execute_arbitration_haltItself = 1'b1; // @[CsrPlugin.scala 1512:34]
      end
    end
  end

  always @(*) begin
    execute_arbitration_haltByOther = 1'b0; // @[Stage.scala 50:23]
    if(when_DBusCachedPlugin_l366) begin
      execute_arbitration_haltByOther = 1'b1; // @[DBusCachedPlugin.scala 367:33]
    end
    if(when_FpuPlugin_l214) begin
      execute_arbitration_haltByOther = 1'b1; // @[FpuPlugin.scala 214:39]
    end
    if(when_DebugPlugin_l308) begin
      execute_arbitration_haltByOther = 1'b1; // @[DebugPlugin.scala 309:41]
    end
  end

  always @(*) begin
    execute_arbitration_removeIt = 1'b0; // @[Stage.scala 51:23]
    if(BranchPlugin_branchExceptionPort_valid) begin
      execute_arbitration_removeIt = 1'b1; // @[CsrPlugin.scala 1171:40]
    end
    if(execute_arbitration_isFlushed) begin
      execute_arbitration_removeIt = 1'b1; // @[Pipeline.scala 134:36]
    end
  end

  always @(*) begin
    execute_arbitration_flushIt = 1'b0; // @[Stage.scala 52:22]
    if(when_DebugPlugin_l308) begin
      if(when_DebugPlugin_l311) begin
        execute_arbitration_flushIt = 1'b1; // @[DebugPlugin.scala 313:41]
      end
    end
  end

  always @(*) begin
    execute_arbitration_flushNext = 1'b0; // @[Stage.scala 53:24]
    if(BranchPlugin_branchExceptionPort_valid) begin
      execute_arbitration_flushNext = 1'b1; // @[CsrPlugin.scala 1170:41]
    end
    if(when_DebugPlugin_l308) begin
      if(when_DebugPlugin_l311) begin
        execute_arbitration_flushNext = 1'b1; // @[DebugPlugin.scala 314:41]
      end
    end
    if(BranchPlugin_jumpInterface_valid) begin
      execute_arbitration_flushNext = 1'b1; // @[BranchPlugin.scala 294:29]
    end
  end

  assign memory_arbitration_haltItself = 1'b0; // @[Stage.scala 49:23]
  assign memory_arbitration_haltByOther = 1'b0; // @[Stage.scala 50:23]
  always @(*) begin
    memory_arbitration_removeIt = 1'b0; // @[Stage.scala 51:23]
    if(memory_arbitration_isFlushed) begin
      memory_arbitration_removeIt = 1'b1; // @[Pipeline.scala 134:36]
    end
  end

  assign memory_arbitration_flushIt = 1'b0; // @[Stage.scala 52:22]
  assign memory_arbitration_flushNext = 1'b0; // @[Stage.scala 53:24]
  always @(*) begin
    writeBack_arbitration_haltItself = 1'b0; // @[Stage.scala 49:23]
    if(when_DBusCachedPlugin_l466) begin
      writeBack_arbitration_haltItself = 1'b1; // @[DBusCachedPlugin.scala 466:37]
    end
  end

  always @(*) begin
    writeBack_arbitration_haltByOther = 1'b0; // @[Stage.scala 50:23]
    if(writeBack_FpuPlugin_isRsp) begin
      if(when_FpuPlugin_l288) begin
        writeBack_arbitration_haltByOther = 1'b1; // @[FpuPlugin.scala 289:35]
      end
    end
    if(when_FpuPlugin_l304) begin
      writeBack_arbitration_haltByOther = 1'b1; // @[FpuPlugin.scala 305:33]
    end
  end

  always @(*) begin
    writeBack_arbitration_removeIt = 1'b0; // @[Stage.scala 51:23]
    if(DBusCachedPlugin_exceptionBus_valid) begin
      writeBack_arbitration_removeIt = 1'b1; // @[CsrPlugin.scala 1171:40]
    end
    if(writeBack_arbitration_isFlushed) begin
      writeBack_arbitration_removeIt = 1'b1; // @[Pipeline.scala 134:36]
    end
  end

  always @(*) begin
    writeBack_arbitration_flushIt = 1'b0; // @[Stage.scala 52:22]
    if(DBusCachedPlugin_redoBranch_valid) begin
      writeBack_arbitration_flushIt = 1'b1; // @[DBusCachedPlugin.scala 436:27]
    end
  end

  always @(*) begin
    writeBack_arbitration_flushNext = 1'b0; // @[Stage.scala 53:24]
    if(DBusCachedPlugin_redoBranch_valid) begin
      writeBack_arbitration_flushNext = 1'b1; // @[DBusCachedPlugin.scala 437:29]
    end
    if(DBusCachedPlugin_exceptionBus_valid) begin
      writeBack_arbitration_flushNext = 1'b1; // @[CsrPlugin.scala 1170:41]
    end
    if(when_CsrPlugin_l1310) begin
      writeBack_arbitration_flushNext = 1'b1; // @[CsrPlugin.scala 1316:41]
    end
    if(when_CsrPlugin_l1376) begin
      writeBack_arbitration_flushNext = 1'b1; // @[CsrPlugin.scala 1379:43]
    end
  end

  assign lastStageInstruction = writeBack_INSTRUCTION; // @[Misc.scala 552:9]
  assign lastStagePc = writeBack_PC; // @[Misc.scala 552:9]
  assign lastStageIsValid = writeBack_arbitration_isValid; // @[Misc.scala 552:9]
  assign lastStageIsFiring = writeBack_arbitration_isFiring; // @[Misc.scala 552:9]
  always @(*) begin
    IBusCachedPlugin_fetcherHalt = 1'b0; // @[Fetcher.scala 67:19]
    if(when_CsrPlugin_l1192) begin
      IBusCachedPlugin_fetcherHalt = 1'b1; // @[Fetcher.scala 53:45]
    end
    if(when_CsrPlugin_l1310) begin
      IBusCachedPlugin_fetcherHalt = 1'b1; // @[Fetcher.scala 53:45]
    end
    if(when_CsrPlugin_l1376) begin
      IBusCachedPlugin_fetcherHalt = 1'b1; // @[Fetcher.scala 53:45]
    end
    if(when_DebugPlugin_l308) begin
      if(when_DebugPlugin_l311) begin
        IBusCachedPlugin_fetcherHalt = 1'b1; // @[Fetcher.scala 53:45]
      end
    end
    if(DebugPlugin_haltIt) begin
      IBusCachedPlugin_fetcherHalt = 1'b1; // @[Fetcher.scala 53:45]
    end
    if(when_DebugPlugin_l324) begin
      IBusCachedPlugin_fetcherHalt = 1'b1; // @[Fetcher.scala 53:45]
    end
  end

  assign IBusCachedPlugin_forceNoDecodeCond = 1'b0; // @[Fetcher.scala 68:25]
  always @(*) begin
    IBusCachedPlugin_incomingInstruction = 1'b0; // @[Fetcher.scala 69:27]
    if(when_Fetcher_l243) begin
      IBusCachedPlugin_incomingInstruction = 1'b1; // @[Fetcher.scala 243:27]
    end
  end

  always @(*) begin
    _zz_when_DBusCachedPlugin_l393 = 1'b0; // @[DBusCachedPlugin.scala 252:41]
    if(DebugPlugin_godmode) begin
      _zz_when_DBusCachedPlugin_l393 = 1'b1; // @[DebugPlugin.scala 362:87]
    end
  end

  assign CsrPlugin_csrMapping_allowCsrSignal = 1'b0; // @[CsrPlugin.scala 358:24]
  assign CsrPlugin_csrMapping_readDataSignal = CsrPlugin_csrMapping_readDataInit; // @[CsrPlugin.scala 361:18]
  assign CsrPlugin_inWfi = 1'b0; // @[CsrPlugin.scala 552:13]
  always @(*) begin
    CsrPlugin_thirdPartyWake = 1'b0; // @[CsrPlugin.scala 554:22]
    if(decode_FpuPlugin_forked) begin
      CsrPlugin_thirdPartyWake = 1'b1; // @[CsrPlugin.scala 479:49]
    end
    if(DebugPlugin_haltIt) begin
      CsrPlugin_thirdPartyWake = 1'b1; // @[CsrPlugin.scala 479:49]
    end
  end

  always @(*) begin
    CsrPlugin_jumpInterface_valid = 1'b0; // @[CsrPlugin.scala 596:25]
    if(when_CsrPlugin_l1310) begin
      CsrPlugin_jumpInterface_valid = 1'b1; // @[CsrPlugin.scala 1314:37]
    end
    if(when_CsrPlugin_l1376) begin
      CsrPlugin_jumpInterface_valid = 1'b1; // @[CsrPlugin.scala 1378:31]
    end
  end

  always @(*) begin
    CsrPlugin_jumpInterface_payload = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; // @[UInt.scala 467:20]
    if(when_CsrPlugin_l1310) begin
      CsrPlugin_jumpInterface_payload = {CsrPlugin_xtvec_base,2'b00}; // @[CsrPlugin.scala 1315:37]
    end
    if(when_CsrPlugin_l1376) begin
      case(switch_CsrPlugin_l1380)
        2'b11 : begin
          CsrPlugin_jumpInterface_payload = CsrPlugin_mepc; // @[CsrPlugin.scala 1385:37]
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    CsrPlugin_forceMachineWire = 1'b0; // @[CsrPlugin.scala 615:24]
    if(DebugPlugin_godmode) begin
      CsrPlugin_forceMachineWire = 1'b1; // @[CsrPlugin.scala 651:56]
    end
  end

  always @(*) begin
    CsrPlugin_allowInterrupts = 1'b1; // @[CsrPlugin.scala 620:23]
    if(when_DebugPlugin_l344) begin
      CsrPlugin_allowInterrupts = 1'b0; // @[CsrPlugin.scala 644:53]
    end
  end

  always @(*) begin
    CsrPlugin_allowException = 1'b1; // @[CsrPlugin.scala 621:22]
    if(DebugPlugin_godmode) begin
      CsrPlugin_allowException = 1'b0; // @[CsrPlugin.scala 645:53]
    end
  end

  always @(*) begin
    CsrPlugin_allowEbreakException = 1'b1; // @[CsrPlugin.scala 622:28]
    if(DebugPlugin_allowEBreak) begin
      CsrPlugin_allowEbreakException = 1'b0; // @[CsrPlugin.scala 646:65]
    end
  end

  assign CsrPlugin_xretAwayFromMachine = 1'b0; // @[CsrPlugin.scala 637:27]
  always @(*) begin
    BranchPlugin_inDebugNoFetchFlag = 1'b0; // @[BranchPlugin.scala 155:26]
    if(DebugPlugin_godmode) begin
      BranchPlugin_inDebugNoFetchFlag = 1'b1; // @[BranchPlugin.scala 90:60]
    end
  end

  assign IBusCachedPlugin_externalFlush = ({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,{execute_arbitration_flushNext,decode_arbitration_flushNext}}} != 4'b0000); // @[BaseType.scala 305:24]
  assign IBusCachedPlugin_jump_pcLoad_valid = ({BranchPlugin_jumpInterface_valid,{CsrPlugin_jumpInterface_valid,{DBusCachedPlugin_redoBranch_valid,IBusCachedPlugin_predictionJumpInterface_valid}}} != 4'b0000); // @[Fetcher.scala 116:20]
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload = {IBusCachedPlugin_predictionJumpInterface_valid,{BranchPlugin_jumpInterface_valid,{CsrPlugin_jumpInterface_valid,DBusCachedPlugin_redoBranch_valid}}}; // @[BaseType.scala 318:22]
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_1 = (_zz_IBusCachedPlugin_jump_pcLoad_payload & (~ _zz__zz_IBusCachedPlugin_jump_pcLoad_payload_1)); // @[Bits.scala 133:56]
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_2 = _zz_IBusCachedPlugin_jump_pcLoad_payload_1[3]; // @[BaseType.scala 305:24]
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_3 = (_zz_IBusCachedPlugin_jump_pcLoad_payload_1[1] || _zz_IBusCachedPlugin_jump_pcLoad_payload_2); // @[BaseType.scala 305:24]
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_4 = (_zz_IBusCachedPlugin_jump_pcLoad_payload_1[2] || _zz_IBusCachedPlugin_jump_pcLoad_payload_2); // @[BaseType.scala 305:24]
  assign IBusCachedPlugin_jump_pcLoad_payload = _zz_IBusCachedPlugin_jump_pcLoad_payload_5; // @[Fetcher.scala 117:22]
  always @(*) begin
    IBusCachedPlugin_fetchPc_correction = 1'b0; // @[Fetcher.scala 129:24]
    if(IBusCachedPlugin_fetchPc_redo_valid) begin
      IBusCachedPlugin_fetchPc_correction = 1'b1; // @[Fetcher.scala 151:20]
    end
    if(IBusCachedPlugin_jump_pcLoad_valid) begin
      IBusCachedPlugin_fetchPc_correction = 1'b1; // @[Fetcher.scala 156:20]
    end
  end

  assign IBusCachedPlugin_fetchPc_output_fire = (IBusCachedPlugin_fetchPc_output_valid && IBusCachedPlugin_fetchPc_output_ready); // @[BaseType.scala 305:24]
  assign IBusCachedPlugin_fetchPc_corrected = (IBusCachedPlugin_fetchPc_correction || IBusCachedPlugin_fetchPc_correctionReg); // @[BaseType.scala 305:24]
  always @(*) begin
    IBusCachedPlugin_fetchPc_pcRegPropagate = 1'b0; // @[Fetcher.scala 132:28]
    if(IBusCachedPlugin_iBusRsp_stages_1_input_ready) begin
      IBusCachedPlugin_fetchPc_pcRegPropagate = 1'b1; // @[Fetcher.scala 235:34]
    end
  end

  assign when_Fetcher_l134 = (IBusCachedPlugin_fetchPc_correction || IBusCachedPlugin_fetchPc_pcRegPropagate); // @[BaseType.scala 305:24]
  assign IBusCachedPlugin_fetchPc_output_fire_1 = (IBusCachedPlugin_fetchPc_output_valid && IBusCachedPlugin_fetchPc_output_ready); // @[BaseType.scala 305:24]
  assign when_Fetcher_l134_1 = ((! IBusCachedPlugin_fetchPc_output_valid) && IBusCachedPlugin_fetchPc_output_ready); // @[BaseType.scala 305:24]
  always @(*) begin
    IBusCachedPlugin_fetchPc_pc = (IBusCachedPlugin_fetchPc_pcReg + _zz_IBusCachedPlugin_fetchPc_pc); // @[BaseType.scala 299:24]
    if(IBusCachedPlugin_fetchPc_redo_valid) begin
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_fetchPc_redo_payload; // @[Fetcher.scala 152:12]
    end
    if(IBusCachedPlugin_jump_pcLoad_valid) begin
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_jump_pcLoad_payload; // @[Fetcher.scala 157:12]
    end
    IBusCachedPlugin_fetchPc_pc[0] = 1'b0; // @[Fetcher.scala 165:13]
    IBusCachedPlugin_fetchPc_pc[1] = 1'b0; // @[Fetcher.scala 166:32]
  end

  always @(*) begin
    IBusCachedPlugin_fetchPc_flushed = 1'b0; // @[Fetcher.scala 138:21]
    if(IBusCachedPlugin_fetchPc_redo_valid) begin
      IBusCachedPlugin_fetchPc_flushed = 1'b1; // @[Fetcher.scala 153:17]
    end
    if(IBusCachedPlugin_jump_pcLoad_valid) begin
      IBusCachedPlugin_fetchPc_flushed = 1'b1; // @[Fetcher.scala 158:17]
    end
  end

  assign when_Fetcher_l161 = (IBusCachedPlugin_fetchPc_booted && ((IBusCachedPlugin_fetchPc_output_ready || IBusCachedPlugin_fetchPc_correction) || IBusCachedPlugin_fetchPc_pcRegPropagate)); // @[BaseType.scala 305:24]
  assign IBusCachedPlugin_fetchPc_output_valid = ((! IBusCachedPlugin_fetcherHalt) && IBusCachedPlugin_fetchPc_booted); // @[Fetcher.scala 168:20]
  assign IBusCachedPlugin_fetchPc_output_payload = IBusCachedPlugin_fetchPc_pc; // @[Fetcher.scala 169:22]
  always @(*) begin
    IBusCachedPlugin_iBusRsp_redoFetch = 1'b0; // @[Fetcher.scala 210:23]
    if(IBusCachedPlugin_rsp_redoFetch) begin
      IBusCachedPlugin_iBusRsp_redoFetch = 1'b1; // @[IBusCachedPlugin.scala 263:29]
    end
  end

  assign IBusCachedPlugin_iBusRsp_stages_0_input_valid = IBusCachedPlugin_fetchPc_output_valid; // @[Stream.scala 294:16]
  assign IBusCachedPlugin_fetchPc_output_ready = IBusCachedPlugin_iBusRsp_stages_0_input_ready; // @[Stream.scala 295:16]
  assign IBusCachedPlugin_iBusRsp_stages_0_input_payload = IBusCachedPlugin_fetchPc_output_payload; // @[Stream.scala 296:18]
  always @(*) begin
    IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b0; // @[Fetcher.scala 219:16]
    if(IBusCachedPlugin_cache_io_cpu_prefetch_haltIt) begin
      IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b1; // @[IBusCachedPlugin.scala 167:24]
    end
  end

  assign _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready = (! IBusCachedPlugin_iBusRsp_stages_0_halt); // @[BaseType.scala 299:24]
  assign IBusCachedPlugin_iBusRsp_stages_0_input_ready = (IBusCachedPlugin_iBusRsp_stages_0_output_ready && _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready); // @[Stream.scala 427:16]
  assign IBusCachedPlugin_iBusRsp_stages_0_output_valid = (IBusCachedPlugin_iBusRsp_stages_0_input_valid && _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready); // @[Stream.scala 294:16]
  assign IBusCachedPlugin_iBusRsp_stages_0_output_payload = IBusCachedPlugin_iBusRsp_stages_0_input_payload; // @[Stream.scala 296:18]
  always @(*) begin
    IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b0; // @[Fetcher.scala 219:16]
    if(IBusCachedPlugin_mmuBus_busy) begin
      IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b1; // @[IBusCachedPlugin.scala 197:53]
    end
  end

  assign _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready = (! IBusCachedPlugin_iBusRsp_stages_1_halt); // @[BaseType.scala 299:24]
  assign IBusCachedPlugin_iBusRsp_stages_1_input_ready = (IBusCachedPlugin_iBusRsp_stages_1_output_ready && _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready); // @[Stream.scala 427:16]
  assign IBusCachedPlugin_iBusRsp_stages_1_output_valid = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready); // @[Stream.scala 294:16]
  assign IBusCachedPlugin_iBusRsp_stages_1_output_payload = IBusCachedPlugin_iBusRsp_stages_1_input_payload; // @[Stream.scala 296:18]
  always @(*) begin
    IBusCachedPlugin_iBusRsp_stages_2_halt = 1'b0; // @[Fetcher.scala 219:16]
    if(when_IBusCachedPlugin_l267) begin
      IBusCachedPlugin_iBusRsp_stages_2_halt = 1'b1; // @[IBusCachedPlugin.scala 267:34]
    end
  end

  assign _zz_IBusCachedPlugin_iBusRsp_stages_2_input_ready = (! IBusCachedPlugin_iBusRsp_stages_2_halt); // @[BaseType.scala 299:24]
  assign IBusCachedPlugin_iBusRsp_stages_2_input_ready = (IBusCachedPlugin_iBusRsp_stages_2_output_ready && _zz_IBusCachedPlugin_iBusRsp_stages_2_input_ready); // @[Stream.scala 427:16]
  assign IBusCachedPlugin_iBusRsp_stages_2_output_valid = (IBusCachedPlugin_iBusRsp_stages_2_input_valid && _zz_IBusCachedPlugin_iBusRsp_stages_2_input_ready); // @[Stream.scala 294:16]
  assign IBusCachedPlugin_iBusRsp_stages_2_output_payload = IBusCachedPlugin_iBusRsp_stages_2_input_payload; // @[Stream.scala 296:18]
  assign IBusCachedPlugin_fetchPc_redo_valid = IBusCachedPlugin_iBusRsp_redoFetch; // @[Fetcher.scala 224:28]
  assign IBusCachedPlugin_fetchPc_redo_payload = IBusCachedPlugin_iBusRsp_stages_2_input_payload; // @[Fetcher.scala 225:30]
  assign IBusCachedPlugin_iBusRsp_flush = ((decode_arbitration_removeIt || (decode_arbitration_flushNext && (! decode_arbitration_isStuck))) || IBusCachedPlugin_iBusRsp_redoFetch); // @[BaseType.scala 305:24]
  assign IBusCachedPlugin_iBusRsp_stages_0_output_ready = _zz_IBusCachedPlugin_iBusRsp_stages_0_output_ready; // @[Stream.scala 304:16]
  assign _zz_IBusCachedPlugin_iBusRsp_stages_0_output_ready = ((1'b0 && (! _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid)) || IBusCachedPlugin_iBusRsp_stages_1_input_ready); // @[Misc.scala 148:20]
  assign _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid = _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid_1; // @[Misc.scala 158:17]
  assign IBusCachedPlugin_iBusRsp_stages_1_input_valid = _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid; // @[Stream.scala 303:16]
  assign IBusCachedPlugin_iBusRsp_stages_1_input_payload = IBusCachedPlugin_fetchPc_pcReg; // @[Fetcher.scala 234:31]
  assign IBusCachedPlugin_iBusRsp_stages_1_output_ready = ((1'b0 && (! IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid)) || IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_ready); // @[Misc.scala 148:20]
  assign IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid = _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid; // @[Misc.scala 158:17]
  assign IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_payload = _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_payload; // @[Misc.scala 159:19]
  assign IBusCachedPlugin_iBusRsp_stages_2_input_valid = IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid; // @[Stream.scala 294:16]
  assign IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_ready = IBusCachedPlugin_iBusRsp_stages_2_input_ready; // @[Stream.scala 295:16]
  assign IBusCachedPlugin_iBusRsp_stages_2_input_payload = IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_payload; // @[Stream.scala 296:18]
  always @(*) begin
    IBusCachedPlugin_iBusRsp_readyForError = 1'b1; // @[Fetcher.scala 241:27]
    if(when_Fetcher_l323) begin
      IBusCachedPlugin_iBusRsp_readyForError = 1'b0; // @[Fetcher.scala 323:55]
    end
  end

  assign when_Fetcher_l243 = (IBusCachedPlugin_iBusRsp_stages_1_input_valid || IBusCachedPlugin_iBusRsp_stages_2_input_valid); // @[BaseType.scala 305:24]
  assign when_Fetcher_l323 = (! IBusCachedPlugin_pcValids_0); // @[BaseType.scala 299:24]
  assign when_Fetcher_l332 = (! (! IBusCachedPlugin_iBusRsp_stages_1_input_ready)); // @[BaseType.scala 299:24]
  assign when_Fetcher_l332_1 = (! (! IBusCachedPlugin_iBusRsp_stages_2_input_ready)); // @[BaseType.scala 299:24]
  assign when_Fetcher_l332_2 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Fetcher_l332_3 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Fetcher_l332_4 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign IBusCachedPlugin_pcValids_0 = IBusCachedPlugin_injector_nextPcCalc_valids_1; // @[Fetcher.scala 348:18]
  assign IBusCachedPlugin_pcValids_1 = IBusCachedPlugin_injector_nextPcCalc_valids_2; // @[Fetcher.scala 348:18]
  assign IBusCachedPlugin_pcValids_2 = IBusCachedPlugin_injector_nextPcCalc_valids_3; // @[Fetcher.scala 348:18]
  assign IBusCachedPlugin_pcValids_3 = IBusCachedPlugin_injector_nextPcCalc_valids_4; // @[Fetcher.scala 348:18]
  assign IBusCachedPlugin_iBusRsp_output_ready = (! decode_arbitration_isStuck); // @[Fetcher.scala 351:25]
  always @(*) begin
    decode_arbitration_isValid = IBusCachedPlugin_iBusRsp_output_valid; // @[Fetcher.scala 352:34]
    case(switch_Fetcher_l365)
      3'b010 : begin
        decode_arbitration_isValid = 1'b1; // @[Fetcher.scala 375:42]
      end
      3'b011 : begin
        decode_arbitration_isValid = 1'b1; // @[Fetcher.scala 380:42]
      end
      default : begin
      end
    endcase
    if(IBusCachedPlugin_forceNoDecodeCond) begin
      decode_arbitration_isValid = 1'b0; // @[Fetcher.scala 415:36]
    end
  end

  assign _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch = _zz__zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch[11]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[18] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[17] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[16] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[15] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[14] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[13] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[12] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[11] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[10] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[9] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[8] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[7] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[6] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[5] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[4] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[3] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[2] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[1] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[0] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch; // @[Literal.scala 87:17]
  end

  always @(*) begin
    IBusCachedPlugin_decodePrediction_cmd_hadBranch = ((decode_BRANCH_CTRL == BranchCtrlEnum_JAL) || ((decode_BRANCH_CTRL == BranchCtrlEnum_B) && _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_2[31])); // @[Fetcher.scala 502:40]
    if(_zz_6) begin
      IBusCachedPlugin_decodePrediction_cmd_hadBranch = 1'b0; // @[Fetcher.scala 509:42]
    end
  end

  assign _zz_2 = _zz__zz_2[19]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_3[10] = _zz_2; // @[Literal.scala 87:17]
    _zz_3[9] = _zz_2; // @[Literal.scala 87:17]
    _zz_3[8] = _zz_2; // @[Literal.scala 87:17]
    _zz_3[7] = _zz_2; // @[Literal.scala 87:17]
    _zz_3[6] = _zz_2; // @[Literal.scala 87:17]
    _zz_3[5] = _zz_2; // @[Literal.scala 87:17]
    _zz_3[4] = _zz_2; // @[Literal.scala 87:17]
    _zz_3[3] = _zz_2; // @[Literal.scala 87:17]
    _zz_3[2] = _zz_2; // @[Literal.scala 87:17]
    _zz_3[1] = _zz_2; // @[Literal.scala 87:17]
    _zz_3[0] = _zz_2; // @[Literal.scala 87:17]
  end

  assign _zz_4 = _zz__zz_4[11]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_5[18] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[17] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[16] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[15] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[14] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[13] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[12] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[11] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[10] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[9] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[8] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[7] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[6] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[5] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[4] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[3] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[2] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[1] = _zz_4; // @[Literal.scala 87:17]
    _zz_5[0] = _zz_4; // @[Literal.scala 87:17]
  end

  always @(*) begin
    case(decode_BRANCH_CTRL)
      BranchCtrlEnum_JAL : begin
        _zz_6 = _zz__zz_6[1]; // @[Misc.scala 239:22]
      end
      default : begin
        _zz_6 = _zz__zz_6_1[1]; // @[Misc.scala 235:22]
      end
    endcase
  end

  assign IBusCachedPlugin_predictionJumpInterface_valid = (decode_arbitration_isValid && IBusCachedPlugin_decodePrediction_cmd_hadBranch); // @[Fetcher.scala 513:39]
  assign _zz_IBusCachedPlugin_predictionJumpInterface_payload = _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload[19]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[10] = _zz_IBusCachedPlugin_predictionJumpInterface_payload; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[9] = _zz_IBusCachedPlugin_predictionJumpInterface_payload; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[8] = _zz_IBusCachedPlugin_predictionJumpInterface_payload; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[7] = _zz_IBusCachedPlugin_predictionJumpInterface_payload; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[6] = _zz_IBusCachedPlugin_predictionJumpInterface_payload; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[5] = _zz_IBusCachedPlugin_predictionJumpInterface_payload; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[4] = _zz_IBusCachedPlugin_predictionJumpInterface_payload; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[3] = _zz_IBusCachedPlugin_predictionJumpInterface_payload; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[2] = _zz_IBusCachedPlugin_predictionJumpInterface_payload; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[1] = _zz_IBusCachedPlugin_predictionJumpInterface_payload; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[0] = _zz_IBusCachedPlugin_predictionJumpInterface_payload; // @[Literal.scala 87:17]
  end

  assign _zz_IBusCachedPlugin_predictionJumpInterface_payload_2 = _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload_2[11]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[18] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[17] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[16] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[15] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[14] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[13] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[12] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[11] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[10] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[9] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[8] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[7] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[6] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[5] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[4] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[3] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[2] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[1] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[0] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2; // @[Literal.scala 87:17]
  end

  assign IBusCachedPlugin_predictionJumpInterface_payload = (decode_PC + ((decode_BRANCH_CTRL == BranchCtrlEnum_JAL) ? {{_zz_IBusCachedPlugin_predictionJumpInterface_payload_1,{{{_zz_IBusCachedPlugin_predictionJumpInterface_payload_4,decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_IBusCachedPlugin_predictionJumpInterface_payload_3,{{{_zz_IBusCachedPlugin_predictionJumpInterface_payload_5,_zz_IBusCachedPlugin_predictionJumpInterface_payload_6},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0})); // @[Fetcher.scala 514:41]
  assign iBus_cmd_valid = IBusCachedPlugin_cache_io_mem_cmd_valid; // @[IBusCachedPlugin.scala 140:12]
  always @(*) begin
    iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address; // @[IBusCachedPlugin.scala 140:12]
    iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address; // @[IBusCachedPlugin.scala 141:38]
  end

  assign iBus_cmd_payload_size = IBusCachedPlugin_cache_io_mem_cmd_payload_size; // @[IBusCachedPlugin.scala 140:12]
  assign IBusCachedPlugin_s0_tightlyCoupledHit = 1'b0; // @[BaseType.scala 305:24]
  assign IBusCachedPlugin_cache_io_cpu_prefetch_isValid = (IBusCachedPlugin_iBusRsp_stages_0_input_valid && (! IBusCachedPlugin_s0_tightlyCoupledHit)); // @[IBusCachedPlugin.scala 165:39]
  assign IBusCachedPlugin_cache_io_cpu_fetch_isValid = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && (! IBusCachedPlugin_s1_tightlyCoupledHit)); // @[IBusCachedPlugin.scala 187:36]
  assign IBusCachedPlugin_cache_io_cpu_fetch_isStuck = (! IBusCachedPlugin_iBusRsp_stages_1_input_ready); // @[IBusCachedPlugin.scala 188:36]
  assign IBusCachedPlugin_mmuBus_cmd_0_isValid = IBusCachedPlugin_cache_io_cpu_fetch_isValid; // @[IBusCachedPlugin.scala 192:35]
  assign IBusCachedPlugin_mmuBus_cmd_0_isStuck = (! IBusCachedPlugin_iBusRsp_stages_1_input_ready); // @[IBusCachedPlugin.scala 193:35]
  assign IBusCachedPlugin_mmuBus_cmd_0_virtualAddress = IBusCachedPlugin_iBusRsp_stages_1_input_payload; // @[IBusCachedPlugin.scala 194:42]
  assign IBusCachedPlugin_mmuBus_cmd_0_bypassTranslation = 1'b0; // @[IBusCachedPlugin.scala 195:45]
  assign IBusCachedPlugin_mmuBus_end = (IBusCachedPlugin_iBusRsp_stages_1_input_ready || IBusCachedPlugin_externalFlush); // @[IBusCachedPlugin.scala 196:22]
  assign IBusCachedPlugin_cache_io_cpu_decode_isValid = (IBusCachedPlugin_iBusRsp_stages_2_input_valid && (! IBusCachedPlugin_s2_tightlyCoupledHit)); // @[IBusCachedPlugin.scala 208:37]
  assign IBusCachedPlugin_cache_io_cpu_decode_isStuck = (! IBusCachedPlugin_iBusRsp_stages_2_input_ready); // @[IBusCachedPlugin.scala 209:37]
  assign IBusCachedPlugin_cache_io_cpu_decode_isUser = (CsrPlugin_privilege == 2'b00); // @[IBusCachedPlugin.scala 211:36]
  assign IBusCachedPlugin_rsp_iBusRspOutputHalt = 1'b0; // @[IBusCachedPlugin.scala 219:33]
  assign IBusCachedPlugin_rsp_issueDetected = 1'b0; // @[IBusCachedPlugin.scala 223:29]
  always @(*) begin
    IBusCachedPlugin_rsp_redoFetch = 1'b0; // @[IBusCachedPlugin.scala 224:25]
    if(when_IBusCachedPlugin_l239) begin
      IBusCachedPlugin_rsp_redoFetch = 1'b1; // @[IBusCachedPlugin.scala 241:21]
    end
    if(when_IBusCachedPlugin_l250) begin
      IBusCachedPlugin_rsp_redoFetch = 1'b1; // @[IBusCachedPlugin.scala 253:21]
    end
  end

  always @(*) begin
    IBusCachedPlugin_cache_io_cpu_fill_valid = (IBusCachedPlugin_rsp_redoFetch && (! IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling)); // @[IBusCachedPlugin.scala 229:33]
    if(when_IBusCachedPlugin_l250) begin
      IBusCachedPlugin_cache_io_cpu_fill_valid = 1'b1; // @[IBusCachedPlugin.scala 252:35]
    end
  end

  always @(*) begin
    IBusCachedPlugin_decodeExceptionPort_valid = 1'b0; // @[IBusCachedPlugin.scala 234:37]
    if(when_IBusCachedPlugin_l244) begin
      IBusCachedPlugin_decodeExceptionPort_valid = IBusCachedPlugin_iBusRsp_readyForError; // @[IBusCachedPlugin.scala 246:37]
    end
    if(when_IBusCachedPlugin_l256) begin
      IBusCachedPlugin_decodeExceptionPort_valid = IBusCachedPlugin_iBusRsp_readyForError; // @[IBusCachedPlugin.scala 258:37]
    end
  end

  always @(*) begin
    IBusCachedPlugin_decodeExceptionPort_payload_code = 4'bxxxx; // @[UInt.scala 467:20]
    if(when_IBusCachedPlugin_l244) begin
      IBusCachedPlugin_decodeExceptionPort_payload_code = 4'b1100; // @[IBusCachedPlugin.scala 247:36]
    end
    if(when_IBusCachedPlugin_l256) begin
      IBusCachedPlugin_decodeExceptionPort_payload_code = 4'b0001; // @[IBusCachedPlugin.scala 259:36]
    end
  end

  assign IBusCachedPlugin_decodeExceptionPort_payload_badAddr = {IBusCachedPlugin_iBusRsp_stages_2_input_payload[31 : 2],2'b00}; // @[IBusCachedPlugin.scala 236:39]
  assign when_IBusCachedPlugin_l239 = ((IBusCachedPlugin_cache_io_cpu_decode_isValid && IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling) && (! IBusCachedPlugin_rsp_issueDetected)); // @[BaseType.scala 305:24]
  assign when_IBusCachedPlugin_l244 = ((IBusCachedPlugin_cache_io_cpu_decode_isValid && IBusCachedPlugin_cache_io_cpu_decode_mmuException) && (! IBusCachedPlugin_rsp_issueDetected_1)); // @[BaseType.scala 305:24]
  assign when_IBusCachedPlugin_l250 = ((IBusCachedPlugin_cache_io_cpu_decode_isValid && IBusCachedPlugin_cache_io_cpu_decode_cacheMiss) && (! IBusCachedPlugin_rsp_issueDetected_2)); // @[BaseType.scala 305:24]
  assign when_IBusCachedPlugin_l256 = ((IBusCachedPlugin_cache_io_cpu_decode_isValid && IBusCachedPlugin_cache_io_cpu_decode_error) && (! IBusCachedPlugin_rsp_issueDetected_3)); // @[BaseType.scala 305:24]
  assign when_IBusCachedPlugin_l267 = (IBusCachedPlugin_rsp_issueDetected_4 || IBusCachedPlugin_rsp_iBusRspOutputHalt); // @[BaseType.scala 305:24]
  assign IBusCachedPlugin_iBusRsp_output_valid = IBusCachedPlugin_iBusRsp_stages_2_output_valid; // @[IBusCachedPlugin.scala 268:30]
  assign IBusCachedPlugin_iBusRsp_stages_2_output_ready = IBusCachedPlugin_iBusRsp_output_ready; // @[IBusCachedPlugin.scala 269:42]
  assign IBusCachedPlugin_iBusRsp_output_payload_rsp_inst = IBusCachedPlugin_cache_io_cpu_decode_data; // @[IBusCachedPlugin.scala 270:33]
  assign IBusCachedPlugin_iBusRsp_output_payload_pc = IBusCachedPlugin_iBusRsp_stages_2_output_payload; // @[IBusCachedPlugin.scala 271:27]
  assign IBusCachedPlugin_cache_io_flush = (decode_arbitration_isValid && decode_FLUSH_ALL); // @[IBusCachedPlugin.scala 287:22]
  assign dBus_cmd_valid = dataCache_1_io_mem_cmd_valid; // @[Stream.scala 294:16]
  assign dBus_cmd_payload_wr = dataCache_1_io_mem_cmd_payload_wr; // @[Stream.scala 296:18]
  assign dBus_cmd_payload_uncached = dataCache_1_io_mem_cmd_payload_uncached; // @[Stream.scala 296:18]
  assign dBus_cmd_payload_address = dataCache_1_io_mem_cmd_payload_address; // @[Stream.scala 296:18]
  assign dBus_cmd_payload_data = dataCache_1_io_mem_cmd_payload_data; // @[Stream.scala 296:18]
  assign dBus_cmd_payload_mask = dataCache_1_io_mem_cmd_payload_mask; // @[Stream.scala 296:18]
  assign dBus_cmd_payload_size = dataCache_1_io_mem_cmd_payload_size; // @[Stream.scala 296:18]
  assign dBus_cmd_payload_last = dataCache_1_io_mem_cmd_payload_last; // @[Stream.scala 296:18]
  assign when_DBusCachedPlugin_l308 = ((DBusCachedPlugin_mmuBus_busy && decode_arbitration_isValid) && decode_MEMORY_ENABLE); // @[BaseType.scala 305:24]
  assign execute_DBusCachedPlugin_size = execute_INSTRUCTION[13 : 12]; // @[BaseType.scala 318:22]
  assign dataCache_1_io_cpu_execute_isValid = (execute_arbitration_isValid && execute_MEMORY_ENABLE); // @[DBusCachedPlugin.scala 327:36]
  assign dataCache_1_io_cpu_execute_address = execute_SRC_ADD; // @[DBusCachedPlugin.scala 328:36]
  always @(*) begin
    case(execute_DBusCachedPlugin_size)
      2'b00 : begin
        _zz_execute_MEMORY_STORE_DATA_RF = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]}; // @[Misc.scala 239:22]
      end
      2'b01 : begin
        _zz_execute_MEMORY_STORE_DATA_RF = {execute_RS2[15 : 0],execute_RS2[15 : 0]}; // @[Misc.scala 239:22]
      end
      default : begin
        _zz_execute_MEMORY_STORE_DATA_RF = execute_RS2[31 : 0]; // @[Misc.scala 235:22]
      end
    endcase
  end

  assign dataCache_1_io_cpu_flush_valid = (execute_arbitration_isValid && execute_MEMORY_MANAGMENT); // @[DBusCachedPlugin.scala 346:32]
  assign dataCache_1_io_cpu_flush_payload_singleLine = (execute_INSTRUCTION[19 : 15] != 5'h0); // @[DBusCachedPlugin.scala 347:37]
  assign toplevel_dataCache_1_io_cpu_flush_isStall = (dataCache_1_io_cpu_flush_valid && (! dataCache_1_io_cpu_flush_ready)); // @[BaseType.scala 305:24]
  assign when_DBusCachedPlugin_l350 = (toplevel_dataCache_1_io_cpu_flush_isStall || dataCache_1_io_cpu_execute_haltIt); // @[BaseType.scala 305:24]
  assign when_DBusCachedPlugin_l366 = (dataCache_1_io_cpu_execute_refilling && execute_arbitration_isValid); // @[BaseType.scala 305:24]
  assign dataCache_1_io_cpu_memory_isValid = (memory_arbitration_isValid && memory_MEMORY_ENABLE); // @[DBusCachedPlugin.scala 383:35]
  assign dataCache_1_io_cpu_memory_address = memory_REGFILE_WRITE_DATA; // @[DBusCachedPlugin.scala 385:35]
  assign DBusCachedPlugin_mmuBus_cmd_0_isValid = dataCache_1_io_cpu_memory_isValid; // @[DBusCachedPlugin.scala 387:31]
  assign DBusCachedPlugin_mmuBus_cmd_0_isStuck = memory_arbitration_isStuck; // @[DBusCachedPlugin.scala 388:31]
  assign DBusCachedPlugin_mmuBus_cmd_0_virtualAddress = dataCache_1_io_cpu_memory_address; // @[DBusCachedPlugin.scala 389:38]
  assign DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation = 1'b0; // @[DBusCachedPlugin.scala 390:41]
  assign DBusCachedPlugin_mmuBus_end = ((! memory_arbitration_isStuck) || memory_arbitration_removeIt); // @[DBusCachedPlugin.scala 391:18]
  always @(*) begin
    dataCache_1_io_cpu_memory_mmuRsp_isIoAccess = DBusCachedPlugin_mmuBus_rsp_isIoAccess; // @[DBusCachedPlugin.scala 392:34]
    if(when_DBusCachedPlugin_l393) begin
      dataCache_1_io_cpu_memory_mmuRsp_isIoAccess = 1'b1; // @[DBusCachedPlugin.scala 393:45]
    end
  end

  assign when_DBusCachedPlugin_l393 = (_zz_when_DBusCachedPlugin_l393 && (! dataCache_1_io_cpu_memory_isWrite)); // @[BaseType.scala 305:24]
  always @(*) begin
    dataCache_1_io_cpu_writeBack_isValid = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE); // @[DBusCachedPlugin.scala 399:38]
    if(writeBack_arbitration_haltByOther) begin
      dataCache_1_io_cpu_writeBack_isValid = 1'b0; // @[DBusCachedPlugin.scala 544:38]
    end
  end

  assign dataCache_1_io_cpu_writeBack_isUser = (CsrPlugin_privilege == 2'b00); // @[DBusCachedPlugin.scala 402:38]
  assign dataCache_1_io_cpu_writeBack_address = writeBack_REGFILE_WRITE_DATA; // @[DBusCachedPlugin.scala 403:38]
  always @(*) begin
    dataCache_1_io_cpu_writeBack_storeData[31 : 0] = writeBack_MEMORY_STORE_DATA_RF; // @[DBusCachedPlugin.scala 404:71]
    if(DBusBypass0_cond) begin
      dataCache_1_io_cpu_writeBack_storeData[31 : 0] = DBusBypass0_value; // @[DBusCachedPlugin.scala 406:85]
    end
  end

  always @(*) begin
    DBusCachedPlugin_redoBranch_valid = 1'b0; // @[DBusCachedPlugin.scala 434:24]
    if(when_DBusCachedPlugin_l446) begin
      if(dataCache_1_io_cpu_redo) begin
        DBusCachedPlugin_redoBranch_valid = 1'b1; // @[DBusCachedPlugin.scala 461:28]
      end
    end
  end

  assign DBusCachedPlugin_redoBranch_payload = writeBack_PC; // @[DBusCachedPlugin.scala 435:26]
  always @(*) begin
    DBusCachedPlugin_exceptionBus_valid = 1'b0; // @[DBusCachedPlugin.scala 440:28]
    if(when_DBusCachedPlugin_l446) begin
      if(dataCache_1_io_cpu_writeBack_accessError) begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1; // @[DBusCachedPlugin.scala 448:30]
      end
      if(dataCache_1_io_cpu_writeBack_mmuException) begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1; // @[DBusCachedPlugin.scala 452:30]
      end
      if(dataCache_1_io_cpu_writeBack_unalignedAccess) begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1; // @[DBusCachedPlugin.scala 456:30]
      end
      if(dataCache_1_io_cpu_redo) begin
        DBusCachedPlugin_exceptionBus_valid = 1'b0; // @[DBusCachedPlugin.scala 462:49]
      end
    end
  end

  assign DBusCachedPlugin_exceptionBus_payload_badAddr = writeBack_REGFILE_WRITE_DATA; // @[DBusCachedPlugin.scala 441:30]
  always @(*) begin
    DBusCachedPlugin_exceptionBus_payload_code = 4'bxxxx; // @[UInt.scala 467:20]
    if(when_DBusCachedPlugin_l446) begin
      if(dataCache_1_io_cpu_writeBack_accessError) begin
        DBusCachedPlugin_exceptionBus_payload_code = {1'd0, _zz_DBusCachedPlugin_exceptionBus_payload_code}; // @[DBusCachedPlugin.scala 449:29]
      end
      if(dataCache_1_io_cpu_writeBack_mmuException) begin
        DBusCachedPlugin_exceptionBus_payload_code = (writeBack_MEMORY_WR ? 4'b1111 : 4'b1101); // @[DBusCachedPlugin.scala 453:29]
      end
      if(dataCache_1_io_cpu_writeBack_unalignedAccess) begin
        DBusCachedPlugin_exceptionBus_payload_code = {1'd0, _zz_DBusCachedPlugin_exceptionBus_payload_code_1}; // @[DBusCachedPlugin.scala 457:29]
      end
    end
  end

  assign when_DBusCachedPlugin_l446 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE); // @[BaseType.scala 305:24]
  assign when_DBusCachedPlugin_l466 = (dataCache_1_io_cpu_writeBack_isValid && dataCache_1_io_cpu_writeBack_haltIt); // @[BaseType.scala 305:24]
  assign writeBack_DBusCachedPlugin_rspSplits_0 = dataCache_1_io_cpu_writeBack_data[7 : 0]; // @[BaseType.scala 299:24]
  assign writeBack_DBusCachedPlugin_rspSplits_1 = dataCache_1_io_cpu_writeBack_data[15 : 8]; // @[BaseType.scala 299:24]
  assign writeBack_DBusCachedPlugin_rspSplits_2 = dataCache_1_io_cpu_writeBack_data[23 : 16]; // @[BaseType.scala 299:24]
  assign writeBack_DBusCachedPlugin_rspSplits_3 = dataCache_1_io_cpu_writeBack_data[31 : 24]; // @[BaseType.scala 299:24]
  always @(*) begin
    writeBack_DBusCachedPlugin_rspShifted[7 : 0] = _zz_writeBack_DBusCachedPlugin_rspShifted; // @[DBusCachedPlugin.scala 478:33]
    writeBack_DBusCachedPlugin_rspShifted[15 : 8] = _zz_writeBack_DBusCachedPlugin_rspShifted_2; // @[DBusCachedPlugin.scala 478:33]
    writeBack_DBusCachedPlugin_rspShifted[23 : 16] = writeBack_DBusCachedPlugin_rspSplits_2; // @[DBusCachedPlugin.scala 478:33]
    writeBack_DBusCachedPlugin_rspShifted[31 : 24] = writeBack_DBusCachedPlugin_rspSplits_3; // @[DBusCachedPlugin.scala 478:33]
  end

  assign writeBack_DBusCachedPlugin_rspRf = writeBack_DBusCachedPlugin_rspShifted[31 : 0]; // @[Misc.scala 552:9]
  assign switch_Misc_l226 = writeBack_INSTRUCTION[13 : 12]; // @[BaseType.scala 299:24]
  assign _zz_writeBack_DBusCachedPlugin_rspFormated = (writeBack_DBusCachedPlugin_rspRf[7] && (! writeBack_INSTRUCTION[14])); // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[31] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[30] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[29] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[28] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[27] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[26] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[25] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[24] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[23] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[22] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[21] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[20] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[19] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[18] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[17] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[16] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[15] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[14] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[13] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[12] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[11] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[10] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[9] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[8] = _zz_writeBack_DBusCachedPlugin_rspFormated; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[7 : 0] = writeBack_DBusCachedPlugin_rspRf[7 : 0]; // @[Literal.scala 99:91]
  end

  assign _zz_writeBack_DBusCachedPlugin_rspFormated_2 = (writeBack_DBusCachedPlugin_rspRf[15] && (! writeBack_INSTRUCTION[14])); // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[31] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[30] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[29] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[28] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[27] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[26] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[25] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[24] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[23] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[22] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[21] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[20] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[19] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[18] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[17] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[16] = _zz_writeBack_DBusCachedPlugin_rspFormated_2; // @[Literal.scala 87:17]
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[15 : 0] = writeBack_DBusCachedPlugin_rspRf[15 : 0]; // @[Literal.scala 99:91]
  end

  always @(*) begin
    case(switch_Misc_l226)
      2'b00 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_writeBack_DBusCachedPlugin_rspFormated_1; // @[Misc.scala 239:22]
      end
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_writeBack_DBusCachedPlugin_rspFormated_3; // @[Misc.scala 239:22]
      end
      default : begin
        writeBack_DBusCachedPlugin_rspFormated = writeBack_DBusCachedPlugin_rspRf; // @[Misc.scala 235:22]
      end
    endcase
  end

  assign when_DBusCachedPlugin_l492 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE); // @[BaseType.scala 305:24]
  assign IBusCachedPlugin_mmuBus_rsp_physicalAddress = IBusCachedPlugin_mmuBus_cmd_0_virtualAddress; // @[StaticMemoryTranslatorPlugin.scala 29:38]
  assign IBusCachedPlugin_mmuBus_rsp_allowRead = 1'b1; // @[StaticMemoryTranslatorPlugin.scala 30:32]
  assign IBusCachedPlugin_mmuBus_rsp_allowWrite = 1'b1; // @[StaticMemoryTranslatorPlugin.scala 31:33]
  assign IBusCachedPlugin_mmuBus_rsp_allowExecute = 1'b1; // @[StaticMemoryTranslatorPlugin.scala 32:35]
  assign IBusCachedPlugin_mmuBus_rsp_isIoAccess = (IBusCachedPlugin_mmuBus_rsp_physicalAddress[31 : 28] == 4'b1111); // @[StaticMemoryTranslatorPlugin.scala 33:33]
  assign IBusCachedPlugin_mmuBus_rsp_isPaging = 1'b0; // @[StaticMemoryTranslatorPlugin.scala 34:31]
  assign IBusCachedPlugin_mmuBus_rsp_exception = 1'b0; // @[StaticMemoryTranslatorPlugin.scala 35:32]
  assign IBusCachedPlugin_mmuBus_rsp_refilling = 1'b0; // @[StaticMemoryTranslatorPlugin.scala 36:32]
  assign IBusCachedPlugin_mmuBus_busy = 1'b0; // @[StaticMemoryTranslatorPlugin.scala 37:23]
  assign DBusCachedPlugin_mmuBus_rsp_physicalAddress = DBusCachedPlugin_mmuBus_cmd_0_virtualAddress; // @[StaticMemoryTranslatorPlugin.scala 29:38]
  assign DBusCachedPlugin_mmuBus_rsp_allowRead = 1'b1; // @[StaticMemoryTranslatorPlugin.scala 30:32]
  assign DBusCachedPlugin_mmuBus_rsp_allowWrite = 1'b1; // @[StaticMemoryTranslatorPlugin.scala 31:33]
  assign DBusCachedPlugin_mmuBus_rsp_allowExecute = 1'b1; // @[StaticMemoryTranslatorPlugin.scala 32:35]
  assign DBusCachedPlugin_mmuBus_rsp_isIoAccess = (DBusCachedPlugin_mmuBus_rsp_physicalAddress[31 : 28] == 4'b1111); // @[StaticMemoryTranslatorPlugin.scala 33:33]
  assign DBusCachedPlugin_mmuBus_rsp_isPaging = 1'b0; // @[StaticMemoryTranslatorPlugin.scala 34:31]
  assign DBusCachedPlugin_mmuBus_rsp_exception = 1'b0; // @[StaticMemoryTranslatorPlugin.scala 35:32]
  assign DBusCachedPlugin_mmuBus_rsp_refilling = 1'b0; // @[StaticMemoryTranslatorPlugin.scala 36:32]
  assign DBusCachedPlugin_mmuBus_busy = 1'b0; // @[StaticMemoryTranslatorPlugin.scala 37:23]
  assign _zz_decode_IS_CSR_1 = ((decode_INSTRUCTION & 32'h00004050) == 32'h00004050); // @[BaseType.scala 305:24]
  assign _zz_decode_IS_CSR_2 = ((decode_INSTRUCTION & 32'h00000014) == 32'h00000014); // @[BaseType.scala 305:24]
  assign _zz_decode_IS_CSR_3 = ((decode_INSTRUCTION & 32'h00000008) == 32'h00000008); // @[BaseType.scala 305:24]
  assign _zz_decode_IS_CSR_4 = ((decode_INSTRUCTION & 32'h00000058) == 32'h0); // @[BaseType.scala 305:24]
  assign _zz_decode_IS_CSR_5 = ((decode_INSTRUCTION & 32'h00002004) == 32'h00000004); // @[BaseType.scala 305:24]
  assign _zz_decode_IS_CSR_6 = ((decode_INSTRUCTION & 32'h90000010) == 32'h80000010); // @[BaseType.scala 305:24]
  assign _zz_decode_IS_CSR_7 = ((decode_INSTRUCTION & 32'h00000050) == 32'h00000010); // @[BaseType.scala 305:24]
  assign _zz_decode_IS_CSR_8 = ((decode_INSTRUCTION & 32'h00000028) == 32'h00000028); // @[BaseType.scala 305:24]
  assign _zz_decode_IS_CSR_9 = ((decode_INSTRUCTION & 32'h00000004) == 32'h00000004); // @[BaseType.scala 305:24]
  assign _zz_decode_IS_CSR_10 = ((decode_INSTRUCTION & 32'h00000020) == 32'h00000020); // @[BaseType.scala 305:24]
  assign _zz_decode_IS_CSR = {(|{_zz_decode_IS_CSR_8,(_zz__zz_decode_IS_CSR == _zz__zz_decode_IS_CSR_1)}),{(|(_zz__zz_decode_IS_CSR_2 == _zz__zz_decode_IS_CSR_3)),{(|_zz__zz_decode_IS_CSR_4),{(|_zz__zz_decode_IS_CSR_5),{_zz__zz_decode_IS_CSR_6,{_zz__zz_decode_IS_CSR_11,_zz__zz_decode_IS_CSR_13}}}}}}; // @[DecoderSimplePlugin.scala 161:19]
  assign _zz_decode_SRC1_CTRL_2 = _zz_decode_IS_CSR[2 : 1]; // @[Enum.scala 186:17]
  assign _zz_decode_SRC1_CTRL_1 = _zz_decode_SRC1_CTRL_2; // @[Enum.scala 188:10]
  assign _zz_decode_ALU_CTRL_2 = _zz_decode_IS_CSR[7 : 6]; // @[Enum.scala 186:17]
  assign _zz_decode_ALU_CTRL_1 = _zz_decode_ALU_CTRL_2; // @[Enum.scala 188:10]
  assign _zz_decode_SRC2_CTRL_2 = _zz_decode_IS_CSR[9 : 8]; // @[Enum.scala 186:17]
  assign _zz_decode_SRC2_CTRL_1 = _zz_decode_SRC2_CTRL_2; // @[Enum.scala 188:10]
  assign _zz_decode_ALU_BITWISE_CTRL_2 = _zz_decode_IS_CSR[19 : 18]; // @[Enum.scala 186:17]
  assign _zz_decode_ALU_BITWISE_CTRL_1 = _zz_decode_ALU_BITWISE_CTRL_2; // @[Enum.scala 188:10]
  assign _zz_decode_SHIFT_CTRL_2 = _zz_decode_IS_CSR[22 : 21]; // @[Enum.scala 186:17]
  assign _zz_decode_SHIFT_CTRL_1 = _zz_decode_SHIFT_CTRL_2; // @[Enum.scala 188:10]
  assign _zz_decode_FPU_OPCODE_2 = _zz_decode_IS_CSR[29 : 26]; // @[Enum.scala 186:17]
  assign _zz_decode_FPU_OPCODE_1 = _zz_decode_FPU_OPCODE_2; // @[Enum.scala 188:10]
  assign _zz_decode_ENV_CTRL_2 = _zz_decode_IS_CSR[34 : 34]; // @[Enum.scala 186:17]
  assign _zz_decode_ENV_CTRL_1 = _zz_decode_ENV_CTRL_2; // @[Enum.scala 188:10]
  assign _zz_decode_BRANCH_CTRL_2 = _zz_decode_IS_CSR[37 : 36]; // @[Enum.scala 186:17]
  assign _zz_decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL_2; // @[Enum.scala 188:10]
  assign decodeExceptionPort_valid = (decode_arbitration_isValid && (! decode_LEGAL_INSTRUCTION)); // @[DecoderSimplePlugin.scala 187:33]
  assign decodeExceptionPort_payload_code = 4'b0010; // @[DecoderSimplePlugin.scala 188:32]
  assign decodeExceptionPort_payload_badAddr = decode_INSTRUCTION; // @[DecoderSimplePlugin.scala 189:35]
  assign when_RegFilePlugin_l63 = (decode_INSTRUCTION[11 : 7] == 5'h0); // @[BaseType.scala 305:24]
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15]; // @[BaseType.scala 318:22]
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20]; // @[BaseType.scala 318:22]
  assign decode_RegFilePlugin_rs1Data = _zz_RegFilePlugin_regFile_port0; // @[Bits.scala 133:56]
  assign decode_RegFilePlugin_rs2Data = _zz_RegFilePlugin_regFile_port1; // @[Bits.scala 133:56]
  always @(*) begin
    lastStageRegFileWrite_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring); // @[RegFilePlugin.scala 102:26]
    if(_zz_7) begin
      lastStageRegFileWrite_valid = 1'b1; // @[RegFilePlugin.scala 114:28]
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7]; // @[RegFilePlugin.scala 103:28]
    if(_zz_7) begin
      lastStageRegFileWrite_payload_address = 5'h0; // @[RegFilePlugin.scala 116:32]
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_data = _zz_decode_RS2_2; // @[RegFilePlugin.scala 104:25]
    if(_zz_7) begin
      lastStageRegFileWrite_payload_data = 32'h0; // @[RegFilePlugin.scala 117:29]
    end
  end

  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2); // @[Misc.scala 239:22]
      end
      AluBitwiseCtrlEnum_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2); // @[Misc.scala 239:22]
      end
      default : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2); // @[Misc.scala 239:22]
      end
    endcase
  end

  always @(*) begin
    case(execute_ALU_CTRL)
      AluCtrlEnum_BITWISE : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_IntAluPlugin_bitwise; // @[Misc.scala 239:22]
      end
      AluCtrlEnum_SLT_SLTU : begin
        _zz_execute_REGFILE_WRITE_DATA = {31'd0, _zz__zz_execute_REGFILE_WRITE_DATA}; // @[Misc.scala 239:22]
      end
      default : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_SRC_ADD_SUB; // @[Misc.scala 239:22]
      end
    endcase
  end

  always @(*) begin
    case(execute_SRC1_CTRL)
      Src1CtrlEnum_RS : begin
        _zz_execute_SRC1 = _zz_execute_to_memory_RS1; // @[Misc.scala 239:22]
      end
      Src1CtrlEnum_PC_INCREMENT : begin
        _zz_execute_SRC1 = {29'd0, _zz__zz_execute_SRC1}; // @[Misc.scala 239:22]
      end
      Src1CtrlEnum_IMU : begin
        _zz_execute_SRC1 = {execute_INSTRUCTION[31 : 12],12'h0}; // @[Misc.scala 239:22]
      end
      default : begin
        _zz_execute_SRC1 = {27'd0, _zz__zz_execute_SRC1_1}; // @[Misc.scala 239:22]
      end
    endcase
  end

  assign _zz_execute_SRC2 = execute_INSTRUCTION[31]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_execute_SRC2_1[19] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[18] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[17] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[16] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[15] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[14] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[13] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[12] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[11] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[10] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[9] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[8] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[7] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[6] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[5] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[4] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[3] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[2] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[1] = _zz_execute_SRC2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_1[0] = _zz_execute_SRC2; // @[Literal.scala 87:17]
  end

  assign _zz_execute_SRC2_2 = _zz__zz_execute_SRC2_2[11]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_execute_SRC2_3[19] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[18] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[17] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[16] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[15] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[14] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[13] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[12] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[11] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[10] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[9] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[8] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[7] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[6] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[5] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[4] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[3] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[2] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[1] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
    _zz_execute_SRC2_3[0] = _zz_execute_SRC2_2; // @[Literal.scala 87:17]
  end

  always @(*) begin
    case(execute_SRC2_CTRL)
      Src2CtrlEnum_RS : begin
        _zz_execute_SRC2_4 = execute_RS2; // @[Misc.scala 239:22]
      end
      Src2CtrlEnum_IMI : begin
        _zz_execute_SRC2_4 = {_zz_execute_SRC2_1,execute_INSTRUCTION[31 : 20]}; // @[Misc.scala 239:22]
      end
      Src2CtrlEnum_IMS : begin
        _zz_execute_SRC2_4 = {_zz_execute_SRC2_3,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}}; // @[Misc.scala 239:22]
      end
      default : begin
        _zz_execute_SRC2_4 = _zz_execute_to_memory_PC; // @[Misc.scala 239:22]
      end
    endcase
  end

  always @(*) begin
    execute_SrcPlugin_addSub = _zz_execute_SrcPlugin_addSub; // @[BaseType.scala 318:22]
    if(execute_SRC2_FORCE_ZERO) begin
      execute_SrcPlugin_addSub = execute_SRC1; // @[SrcPlugin.scala 69:46]
    end
  end

  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31])); // @[Expression.scala 1420:25]
  assign execute_FullBarrelShifterPlugin_amplitude = execute_SRC2[4 : 0]; // @[BaseType.scala 318:22]
  always @(*) begin
    _zz_execute_FullBarrelShifterPlugin_reversed[0] = execute_SRC1[31]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[1] = execute_SRC1[30]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[2] = execute_SRC1[29]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[3] = execute_SRC1[28]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[4] = execute_SRC1[27]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[5] = execute_SRC1[26]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[6] = execute_SRC1[25]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[7] = execute_SRC1[24]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[8] = execute_SRC1[23]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[9] = execute_SRC1[22]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[10] = execute_SRC1[21]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[11] = execute_SRC1[20]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[12] = execute_SRC1[19]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[13] = execute_SRC1[18]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[14] = execute_SRC1[17]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[15] = execute_SRC1[16]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[16] = execute_SRC1[15]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[17] = execute_SRC1[14]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[18] = execute_SRC1[13]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[19] = execute_SRC1[12]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[20] = execute_SRC1[11]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[21] = execute_SRC1[10]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[22] = execute_SRC1[9]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[23] = execute_SRC1[8]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[24] = execute_SRC1[7]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[25] = execute_SRC1[6]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[26] = execute_SRC1[5]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[27] = execute_SRC1[4]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[28] = execute_SRC1[3]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[29] = execute_SRC1[2]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[30] = execute_SRC1[1]; // @[Utils.scala 432:14]
    _zz_execute_FullBarrelShifterPlugin_reversed[31] = execute_SRC1[0]; // @[Utils.scala 432:14]
  end

  assign execute_FullBarrelShifterPlugin_reversed = ((execute_SHIFT_CTRL == ShiftCtrlEnum_SLL_1) ? _zz_execute_FullBarrelShifterPlugin_reversed : execute_SRC1); // @[Expression.scala 1420:25]
  always @(*) begin
    _zz_decode_RS2_3[0] = memory_SHIFT_RIGHT[31]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[1] = memory_SHIFT_RIGHT[30]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[2] = memory_SHIFT_RIGHT[29]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[3] = memory_SHIFT_RIGHT[28]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[4] = memory_SHIFT_RIGHT[27]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[5] = memory_SHIFT_RIGHT[26]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[6] = memory_SHIFT_RIGHT[25]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[7] = memory_SHIFT_RIGHT[24]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[8] = memory_SHIFT_RIGHT[23]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[9] = memory_SHIFT_RIGHT[22]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[10] = memory_SHIFT_RIGHT[21]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[11] = memory_SHIFT_RIGHT[20]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[12] = memory_SHIFT_RIGHT[19]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[13] = memory_SHIFT_RIGHT[18]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[14] = memory_SHIFT_RIGHT[17]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[15] = memory_SHIFT_RIGHT[16]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[16] = memory_SHIFT_RIGHT[15]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[17] = memory_SHIFT_RIGHT[14]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[18] = memory_SHIFT_RIGHT[13]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[19] = memory_SHIFT_RIGHT[12]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[20] = memory_SHIFT_RIGHT[11]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[21] = memory_SHIFT_RIGHT[10]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[22] = memory_SHIFT_RIGHT[9]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[23] = memory_SHIFT_RIGHT[8]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[24] = memory_SHIFT_RIGHT[7]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[25] = memory_SHIFT_RIGHT[6]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[26] = memory_SHIFT_RIGHT[5]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[27] = memory_SHIFT_RIGHT[4]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[28] = memory_SHIFT_RIGHT[3]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[29] = memory_SHIFT_RIGHT[2]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[30] = memory_SHIFT_RIGHT[1]; // @[Utils.scala 432:14]
    _zz_decode_RS2_3[31] = memory_SHIFT_RIGHT[0]; // @[Utils.scala 432:14]
  end

  always @(*) begin
    HazardSimplePlugin_src0Hazard = 1'b0; // @[HazardSimplePlugin.scala 36:24]
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l48) begin
          HazardSimplePlugin_src0Hazard = 1'b1; // @[HazardSimplePlugin.scala 60:26]
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l48_1) begin
          HazardSimplePlugin_src0Hazard = 1'b1; // @[HazardSimplePlugin.scala 60:26]
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l48_2) begin
          HazardSimplePlugin_src0Hazard = 1'b1; // @[HazardSimplePlugin.scala 60:26]
        end
      end
    end
    if(when_HazardSimplePlugin_l105) begin
      HazardSimplePlugin_src0Hazard = 1'b0; // @[HazardSimplePlugin.scala 106:22]
    end
  end

  always @(*) begin
    HazardSimplePlugin_src1Hazard = 1'b0; // @[HazardSimplePlugin.scala 37:24]
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l51) begin
          HazardSimplePlugin_src1Hazard = 1'b1; // @[HazardSimplePlugin.scala 63:26]
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l51_1) begin
          HazardSimplePlugin_src1Hazard = 1'b1; // @[HazardSimplePlugin.scala 63:26]
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l51_2) begin
          HazardSimplePlugin_src1Hazard = 1'b1; // @[HazardSimplePlugin.scala 63:26]
        end
      end
    end
    if(when_HazardSimplePlugin_l108) begin
      HazardSimplePlugin_src1Hazard = 1'b0; // @[HazardSimplePlugin.scala 109:22]
    end
  end

  assign HazardSimplePlugin_writeBackWrites_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring); // @[HazardSimplePlugin.scala 74:29]
  assign HazardSimplePlugin_writeBackWrites_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7]; // @[HazardSimplePlugin.scala 75:31]
  assign HazardSimplePlugin_writeBackWrites_payload_data = _zz_decode_RS2_2; // @[HazardSimplePlugin.scala 76:28]
  assign HazardSimplePlugin_addr0Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[19 : 15]); // @[BaseType.scala 305:24]
  assign HazardSimplePlugin_addr1Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[24 : 20]); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l47 = 1'b1; // @[HazardSimplePlugin.scala 42:105]
  assign when_HazardSimplePlugin_l48 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l51 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l45 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l57 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l58 = (1'b0 || (! when_HazardSimplePlugin_l47)); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l48_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l51_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l45_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l57_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l58_1 = (1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE)); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l48_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l51_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l45_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l57_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l58_2 = (1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE)); // @[BaseType.scala 305:24]
  assign when_HazardSimplePlugin_l105 = (! decode_RS1_USE); // @[BaseType.scala 299:24]
  assign when_HazardSimplePlugin_l108 = (! decode_RS2_USE); // @[BaseType.scala 299:24]
  assign when_HazardSimplePlugin_l113 = (decode_arbitration_isValid && (HazardSimplePlugin_src0Hazard || HazardSimplePlugin_src1Hazard)); // @[BaseType.scala 305:24]
  assign FpuPlugin_port_cmd_ready = FpuPlugin_fpu_io_port_0_cmd_ready; // @[Stream.scala 295:16]
  assign FpuPlugin_port_commit_ready = FpuPlugin_fpu_io_port_0_commit_ready; // @[Stream.scala 295:16]
  assign FpuPlugin_port_rsp_valid = FpuPlugin_fpu_io_port_0_rsp_valid; // @[Stream.scala 294:16]
  assign FpuPlugin_port_rsp_payload_value = FpuPlugin_fpu_io_port_0_rsp_payload_value; // @[Stream.scala 296:18]
  assign FpuPlugin_port_rsp_payload_NV = FpuPlugin_fpu_io_port_0_rsp_payload_NV; // @[Stream.scala 296:18]
  assign FpuPlugin_port_rsp_payload_NX = FpuPlugin_fpu_io_port_0_rsp_payload_NX; // @[Stream.scala 296:18]
  assign FpuPlugin_port_completion_valid = FpuPlugin_fpu_io_port_0_completion_valid; // @[FpuPlugin.scala 187:35]
  assign FpuPlugin_port_completion_payload_flags_NX = FpuPlugin_fpu_io_port_0_completion_payload_flags_NX; // @[FpuPlugin.scala 187:35]
  assign FpuPlugin_port_completion_payload_flags_UF = FpuPlugin_fpu_io_port_0_completion_payload_flags_UF; // @[FpuPlugin.scala 187:35]
  assign FpuPlugin_port_completion_payload_flags_OF = FpuPlugin_fpu_io_port_0_completion_payload_flags_OF; // @[FpuPlugin.scala 187:35]
  assign FpuPlugin_port_completion_payload_flags_DZ = FpuPlugin_fpu_io_port_0_completion_payload_flags_DZ; // @[FpuPlugin.scala 187:35]
  assign FpuPlugin_port_completion_payload_flags_NV = FpuPlugin_fpu_io_port_0_completion_payload_flags_NV; // @[FpuPlugin.scala 187:35]
  assign FpuPlugin_port_completion_payload_written = FpuPlugin_fpu_io_port_0_completion_payload_written; // @[FpuPlugin.scala 187:35]
  assign FpuPlugin_port_cmd_fire = (FpuPlugin_port_cmd_valid && FpuPlugin_port_cmd_ready); // @[BaseType.scala 305:24]
  assign FpuPlugin_port_rsp_fire = (FpuPlugin_port_rsp_valid && FpuPlugin_port_rsp_ready); // @[BaseType.scala 305:24]
  assign FpuPlugin_hasPending = (FpuPlugin_pendings != 6'h0); // @[BaseType.scala 305:24]
  assign when_FpuPlugin_l199 = (FpuPlugin_port_completion_valid && FpuPlugin_port_completion_payload_flags_NV); // @[BaseType.scala 305:24]
  assign when_FpuPlugin_l200 = (FpuPlugin_port_completion_valid && FpuPlugin_port_completion_payload_flags_DZ); // @[BaseType.scala 305:24]
  assign when_FpuPlugin_l201 = (FpuPlugin_port_completion_valid && FpuPlugin_port_completion_payload_flags_OF); // @[BaseType.scala 305:24]
  assign when_FpuPlugin_l202 = (FpuPlugin_port_completion_valid && FpuPlugin_port_completion_payload_flags_UF); // @[BaseType.scala 305:24]
  assign when_FpuPlugin_l203 = (FpuPlugin_port_completion_valid && FpuPlugin_port_completion_payload_flags_NX); // @[BaseType.scala 305:24]
  assign FpuPlugin_csrActive = (execute_arbitration_isValid && execute_IS_CSR); // @[BaseType.scala 305:24]
  assign when_FpuPlugin_l214 = (FpuPlugin_csrActive && FpuPlugin_hasPending); // @[BaseType.scala 305:24]
  assign FpuPlugin_sd = (FpuPlugin_fs == 2'b11); // @[BaseType.scala 305:24]
  assign when_FpuPlugin_l219 = ((writeBack_arbitration_isFiring && writeBack_FPU_ENABLE) && (writeBack_FPU_OPCODE != FpuOpcode_STORE)); // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_when_FpuPlugin_l222 = 1'b0; // @[CsrPlugin.scala 412:15]
    if(execute_CsrPlugin_csr_2) begin
      if(execute_CsrPlugin_writeEnable) begin
        _zz_when_FpuPlugin_l222 = 1'b1; // @[CsrPlugin.scala 414:11]
      end
    end
  end

  always @(*) begin
    _zz_when_FpuPlugin_l222_1 = 1'b0; // @[CsrPlugin.scala 412:15]
    if(execute_CsrPlugin_csr_3) begin
      if(execute_CsrPlugin_writeEnable) begin
        _zz_when_FpuPlugin_l222_1 = 1'b1; // @[CsrPlugin.scala 414:11]
      end
    end
  end

  always @(*) begin
    _zz_when_FpuPlugin_l222_2 = 1'b0; // @[CsrPlugin.scala 412:15]
    if(execute_CsrPlugin_csr_1) begin
      if(execute_CsrPlugin_writeEnable) begin
        _zz_when_FpuPlugin_l222_2 = 1'b1; // @[CsrPlugin.scala 414:11]
      end
    end
  end

  assign when_FpuPlugin_l222 = ({_zz_when_FpuPlugin_l222_2,{_zz_when_FpuPlugin_l222_1,_zz_when_FpuPlugin_l222}} != 3'b000); // @[BaseType.scala 305:24]
  assign FpuPlugin_port_cmd_fire_1 = (FpuPlugin_port_cmd_valid && FpuPlugin_port_cmd_ready); // @[BaseType.scala 305:24]
  assign when_FpuPlugin_l237 = (! decode_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign decode_FpuPlugin_hazard = (FpuPlugin_pendings[5] || FpuPlugin_csrActive); // @[BaseType.scala 305:24]
  assign when_FpuPlugin_l241 = ((decode_arbitration_isValid && decode_FPU_ENABLE) && decode_FpuPlugin_hazard); // @[BaseType.scala 305:24]
  assign FpuPlugin_port_cmd_isStall = (FpuPlugin_port_cmd_valid && (! FpuPlugin_port_cmd_ready)); // @[BaseType.scala 305:24]
  assign decode_FpuPlugin_iRoundMode = decode_INSTRUCTION[14 : 12]; // @[BaseType.scala 299:24]
  assign decode_FpuPlugin_roundMode = ((decode_INSTRUCTION[14 : 12] == 3'b111) ? FpuPlugin_rm : decode_INSTRUCTION[14 : 12]); // @[Expression.scala 1420:25]
  assign FpuPlugin_port_cmd_valid = (((decode_arbitration_isValid && decode_FPU_ENABLE) && (! decode_FpuPlugin_forked)) && (! decode_FpuPlugin_hazard)); // @[FpuPlugin.scala 247:26]
  assign FpuPlugin_port_cmd_payload_opcode = decode_FPU_OPCODE; // @[FpuPlugin.scala 248:26]
  assign FpuPlugin_port_cmd_payload_arg = decode_FPU_ARG; // @[FpuPlugin.scala 249:26]
  assign FpuPlugin_port_cmd_payload_rs1 = decode_INSTRUCTION[19 : 15]; // @[FpuPlugin.scala 250:26]
  assign FpuPlugin_port_cmd_payload_rs2 = decode_INSTRUCTION[24 : 20]; // @[FpuPlugin.scala 251:26]
  assign FpuPlugin_port_cmd_payload_rs3 = decode_INSTRUCTION[31 : 27]; // @[FpuPlugin.scala 252:26]
  assign FpuPlugin_port_cmd_payload_rd = decode_INSTRUCTION[11 : 7]; // @[FpuPlugin.scala 253:26]
  assign FpuPlugin_port_cmd_payload_format = FpuFormat_FLOAT; // @[FpuPlugin.scala 254:26]
  assign _zz_FpuPlugin_port_cmd_payload_roundMode_1 = decode_FpuPlugin_roundMode; // @[Enum.scala 186:17]
  assign _zz_FpuPlugin_port_cmd_payload_roundMode = _zz_FpuPlugin_port_cmd_payload_roundMode_1; // @[Enum.scala 188:10]
  assign FpuPlugin_port_cmd_payload_roundMode = _zz_FpuPlugin_port_cmd_payload_roundMode; // @[FpuPlugin.scala 255:26]
  assign FpuPlugin_port_cmd_fire_2 = (FpuPlugin_port_cmd_valid && FpuPlugin_port_cmd_ready); // @[BaseType.scala 305:24]
  assign writeBack_FpuPlugin_isRsp = (writeBack_FPU_FORKED && writeBack_FPU_RSP); // @[BaseType.scala 305:24]
  assign writeBack_FpuPlugin_isCommit = (writeBack_FPU_FORKED && writeBack_FPU_COMMIT); // @[BaseType.scala 305:24]
  assign writeBack_FpuPlugin_storeFormated = FpuPlugin_port_rsp_payload_value; // @[Misc.scala 552:9]
  always @(*) begin
    FpuPlugin_port_rsp_ready = 1'b0; // @[FpuPlugin.scala 278:22]
    if(writeBack_FpuPlugin_isRsp) begin
      if(!when_FpuPlugin_l288) begin
        if(when_FpuPlugin_l290) begin
          FpuPlugin_port_rsp_ready = 1'b1; // @[FpuPlugin.scala 291:26]
        end
      end
    end
  end

  assign DBusBypass0_value = writeBack_FpuPlugin_storeFormated; // @[Misc.scala 552:9]
  assign when_FpuPlugin_l283 = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt)); // @[BaseType.scala 305:24]
  assign when_FpuPlugin_l288 = (! FpuPlugin_port_rsp_valid); // @[BaseType.scala 299:24]
  assign when_FpuPlugin_l290 = (! writeBack_arbitration_haltItself); // @[BaseType.scala 299:24]
  assign writeBack_FpuPlugin_commit_valid = (writeBack_FpuPlugin_isCommit && (! writeBack_arbitration_isStuck)); // @[FpuPlugin.scala 297:20]
  assign writeBack_FpuPlugin_commit_payload_value[31 : 0] = (writeBack_FPU_COMMIT_LOAD ? writeBack_MEMORY_LOAD_DATA[31 : 0] : writeBack_RS1); // @[FpuPlugin.scala 298:33]
  assign writeBack_FpuPlugin_commit_payload_write = (writeBack_arbitration_isValid && (! writeBack_arbitration_removeIt)); // @[FpuPlugin.scala 300:20]
  assign writeBack_FpuPlugin_commit_payload_opcode = writeBack_FPU_OPCODE; // @[FpuPlugin.scala 301:21]
  assign writeBack_FpuPlugin_commit_payload_rd = writeBack_INSTRUCTION[11 : 7]; // @[FpuPlugin.scala 302:17]
  assign when_FpuPlugin_l304 = (writeBack_FpuPlugin_isCommit && (! writeBack_FpuPlugin_commit_ready)); // @[BaseType.scala 305:24]
  assign writeBack_FpuPlugin_commit_ready = (! writeBack_FpuPlugin_commit_rValid); // @[Stream.scala 380:16]
  assign writeBack_FpuPlugin_commit_s2mPipe_valid = (writeBack_FpuPlugin_commit_valid || writeBack_FpuPlugin_commit_rValid); // @[Stream.scala 382:19]
  assign _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode = (writeBack_FpuPlugin_commit_rValid ? writeBack_FpuPlugin_commit_rData_opcode : writeBack_FpuPlugin_commit_payload_opcode); // @[Expression.scala 1420:25]
  assign writeBack_FpuPlugin_commit_s2mPipe_payload_opcode = _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode; // @[Stream.scala 383:21]
  assign writeBack_FpuPlugin_commit_s2mPipe_payload_rd = (writeBack_FpuPlugin_commit_rValid ? writeBack_FpuPlugin_commit_rData_rd : writeBack_FpuPlugin_commit_payload_rd); // @[Stream.scala 383:21]
  assign writeBack_FpuPlugin_commit_s2mPipe_payload_write = (writeBack_FpuPlugin_commit_rValid ? writeBack_FpuPlugin_commit_rData_write : writeBack_FpuPlugin_commit_payload_write); // @[Stream.scala 383:21]
  assign writeBack_FpuPlugin_commit_s2mPipe_payload_value = (writeBack_FpuPlugin_commit_rValid ? writeBack_FpuPlugin_commit_rData_value : writeBack_FpuPlugin_commit_payload_value); // @[Stream.scala 383:21]
  assign FpuPlugin_port_commit_valid = writeBack_FpuPlugin_commit_s2mPipe_valid; // @[Stream.scala 294:16]
  assign writeBack_FpuPlugin_commit_s2mPipe_ready = FpuPlugin_port_commit_ready; // @[Stream.scala 295:16]
  assign FpuPlugin_port_commit_payload_opcode = writeBack_FpuPlugin_commit_s2mPipe_payload_opcode; // @[Stream.scala 296:18]
  assign FpuPlugin_port_commit_payload_rd = writeBack_FpuPlugin_commit_s2mPipe_payload_rd; // @[Stream.scala 296:18]
  assign FpuPlugin_port_commit_payload_write = writeBack_FpuPlugin_commit_s2mPipe_payload_write; // @[Stream.scala 296:18]
  assign FpuPlugin_port_commit_payload_value = writeBack_FpuPlugin_commit_s2mPipe_payload_value; // @[Stream.scala 296:18]
  always @(*) begin
    CsrPlugin_privilege = 2'b11; // @[CsrPlugin.scala 680:15]
    if(CsrPlugin_forceMachineWire) begin
      CsrPlugin_privilege = 2'b11; // @[CsrPlugin.scala 682:40]
    end
  end

  assign CsrPlugin_misa_base = 2'b01;
  assign CsrPlugin_misa_extensions = 26'h0000042;
  assign CsrPlugin_mtvec_mode = 2'b00;
  assign CsrPlugin_mtvec_base = 30'h20000000;
  assign _zz_when_CsrPlugin_l1222 = (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE); // @[BaseType.scala 305:24]
  assign _zz_when_CsrPlugin_l1222_1 = (CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE); // @[BaseType.scala 305:24]
  assign _zz_when_CsrPlugin_l1222_2 = (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE); // @[BaseType.scala 305:24]
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b11; // @[Expression.scala 2342:18]
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = ((CsrPlugin_privilege < CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped) ? CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped : CsrPlugin_privilege); // @[Expression.scala 1420:25]
  assign _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code = {decodeExceptionPort_valid,IBusCachedPlugin_decodeExceptionPort_valid}; // @[BaseType.scala 318:22]
  assign _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 = _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1[0]; // @[BaseType.scala 305:24]
  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode; // @[CsrPlugin.scala 1167:25]
    if(_zz_when) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b1; // @[CsrPlugin.scala 1172:38]
    end
    if(decode_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b0; // @[CsrPlugin.scala 1188:38]
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute; // @[CsrPlugin.scala 1167:25]
    if(BranchPlugin_branchExceptionPort_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b1; // @[CsrPlugin.scala 1172:38]
    end
    if(execute_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0; // @[CsrPlugin.scala 1188:38]
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory; // @[CsrPlugin.scala 1167:25]
    if(memory_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0; // @[CsrPlugin.scala 1188:38]
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack; // @[CsrPlugin.scala 1167:25]
    if(DBusCachedPlugin_exceptionBus_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b1; // @[CsrPlugin.scala 1172:38]
    end
    if(writeBack_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b0; // @[CsrPlugin.scala 1188:38]
    end
  end

  assign when_CsrPlugin_l1179 = (! decode_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1179_1 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1179_2 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1179_3 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1192 = ({CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValids_memory,{CsrPlugin_exceptionPortCtrl_exceptionValids_execute,CsrPlugin_exceptionPortCtrl_exceptionValids_decode}}} != 4'b0000); // @[BaseType.scala 305:24]
  assign CsrPlugin_exceptionPendings_0 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode; // @[CsrPlugin.scala 1198:27]
  assign CsrPlugin_exceptionPendings_1 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute; // @[CsrPlugin.scala 1198:27]
  assign CsrPlugin_exceptionPendings_2 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory; // @[CsrPlugin.scala 1198:27]
  assign CsrPlugin_exceptionPendings_3 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack; // @[CsrPlugin.scala 1198:27]
  assign when_CsrPlugin_l1216 = (CsrPlugin_mstatus_MIE || (CsrPlugin_privilege < 2'b11)); // @[BaseType.scala 305:24]
  assign when_CsrPlugin_l1222 = ((_zz_when_CsrPlugin_l1222 && 1'b1) && (! 1'b0)); // @[BaseType.scala 305:24]
  assign when_CsrPlugin_l1222_1 = ((_zz_when_CsrPlugin_l1222_1 && 1'b1) && (! 1'b0)); // @[BaseType.scala 305:24]
  assign when_CsrPlugin_l1222_2 = ((_zz_when_CsrPlugin_l1222_2 && 1'b1) && (! 1'b0)); // @[BaseType.scala 305:24]
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && CsrPlugin_allowException); // @[BaseType.scala 305:24]
  assign CsrPlugin_lastStageWasWfi = 1'b0; // @[CsrPlugin.scala 1244:152]
  assign CsrPlugin_pipelineLiberator_active = ((CsrPlugin_interrupt_valid && CsrPlugin_allowInterrupts) && decode_arbitration_isValid); // @[BaseType.scala 305:24]
  assign when_CsrPlugin_l1255 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1255_1 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1255_2 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1260 = ((! CsrPlugin_pipelineLiberator_active) || decode_arbitration_removeIt); // @[BaseType.scala 305:24]
  always @(*) begin
    CsrPlugin_pipelineLiberator_done = CsrPlugin_pipelineLiberator_pcValids_2; // @[Misc.scala 552:9]
    if(when_CsrPlugin_l1266) begin
      CsrPlugin_pipelineLiberator_done = 1'b0; // @[CsrPlugin.scala 1266:53]
    end
    if(CsrPlugin_hadException) begin
      CsrPlugin_pipelineLiberator_done = 1'b0; // @[CsrPlugin.scala 1275:39]
    end
  end

  assign when_CsrPlugin_l1266 = ({CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute}} != 3'b000); // @[BaseType.scala 305:24]
  assign CsrPlugin_interruptJump = ((CsrPlugin_interrupt_valid && CsrPlugin_pipelineLiberator_done) && CsrPlugin_allowInterrupts); // @[CsrPlugin.scala 1271:21]
  always @(*) begin
    CsrPlugin_targetPrivilege = CsrPlugin_interrupt_targetPrivilege; // @[Misc.scala 552:9]
    if(CsrPlugin_hadException) begin
      CsrPlugin_targetPrivilege = CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege; // @[CsrPlugin.scala 1285:25]
    end
  end

  always @(*) begin
    CsrPlugin_trapCause = CsrPlugin_interrupt_code; // @[Misc.scala 552:9]
    if(CsrPlugin_hadException) begin
      CsrPlugin_trapCause = CsrPlugin_exceptionPortCtrl_exceptionContext_code; // @[CsrPlugin.scala 1291:19]
    end
  end

  assign CsrPlugin_trapCauseEbreakDebug = 1'b0; // @[CsrPlugin.scala 1289:34]
  always @(*) begin
    CsrPlugin_xtvec_mode = 2'bxx; // @[Bits.scala 231:20]
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_mode = CsrPlugin_mtvec_mode; // @[CsrPlugin.scala 1305:22]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    CsrPlugin_xtvec_base = 30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; // @[UInt.scala 467:20]
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_base = CsrPlugin_mtvec_base; // @[CsrPlugin.scala 1305:22]
      end
      default : begin
      end
    endcase
  end

  assign CsrPlugin_trapEnterDebug = 1'b0; // @[CsrPlugin.scala 1308:28]
  assign when_CsrPlugin_l1310 = (CsrPlugin_hadException || CsrPlugin_interruptJump); // @[BaseType.scala 305:24]
  assign when_CsrPlugin_l1318 = (! CsrPlugin_trapEnterDebug); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1376 = (writeBack_arbitration_isValid && (writeBack_ENV_CTRL == EnvCtrlEnum_XRET)); // @[BaseType.scala 305:24]
  assign switch_CsrPlugin_l1380 = writeBack_INSTRUCTION[29 : 28]; // @[BaseType.scala 299:24]
  assign contextSwitching = CsrPlugin_jumpInterface_valid; // @[CsrPlugin.scala 1405:24]
  assign when_CsrPlugin_l1447 = (|{(writeBack_arbitration_isValid && (writeBack_ENV_CTRL == EnvCtrlEnum_XRET)),{(memory_arbitration_isValid && (memory_ENV_CTRL == EnvCtrlEnum_XRET)),(execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_XRET))}}); // @[BaseType.scala 312:24]
  assign execute_CsrPlugin_blockedBySideEffects = ((|{writeBack_arbitration_isValid,memory_arbitration_isValid}) || 1'b0); // @[BaseType.scala 305:24]
  always @(*) begin
    execute_CsrPlugin_illegalAccess = 1'b1; // @[CsrPlugin.scala 1454:29]
    if(execute_CsrPlugin_csr_3) begin
      execute_CsrPlugin_illegalAccess = 1'b0; // @[CsrPlugin.scala 1529:29]
    end
    if(execute_CsrPlugin_csr_2) begin
      execute_CsrPlugin_illegalAccess = 1'b0; // @[CsrPlugin.scala 1529:29]
    end
    if(execute_CsrPlugin_csr_1) begin
      execute_CsrPlugin_illegalAccess = 1'b0; // @[CsrPlugin.scala 1529:29]
    end
    if(execute_CsrPlugin_csr_256) begin
      execute_CsrPlugin_illegalAccess = 1'b0; // @[CsrPlugin.scala 1529:29]
    end
    if(execute_CsrPlugin_csr_768) begin
      execute_CsrPlugin_illegalAccess = 1'b0; // @[CsrPlugin.scala 1529:29]
    end
    if(execute_CsrPlugin_csr_836) begin
      execute_CsrPlugin_illegalAccess = 1'b0; // @[CsrPlugin.scala 1529:29]
    end
    if(execute_CsrPlugin_csr_772) begin
      execute_CsrPlugin_illegalAccess = 1'b0; // @[CsrPlugin.scala 1529:29]
    end
    if(execute_CsrPlugin_csr_833) begin
      execute_CsrPlugin_illegalAccess = 1'b0; // @[CsrPlugin.scala 1529:29]
    end
    if(execute_CsrPlugin_csr_834) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0; // @[CsrPlugin.scala 1532:52]
      end
    end
    if(execute_CsrPlugin_csr_835) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0; // @[CsrPlugin.scala 1532:52]
      end
    end
    if(CsrPlugin_csrMapping_allowCsrSignal) begin
      execute_CsrPlugin_illegalAccess = 1'b0; // @[CsrPlugin.scala 1620:25]
    end
    if(when_CsrPlugin_l1625) begin
      execute_CsrPlugin_illegalAccess = 1'b1; // @[CsrPlugin.scala 1626:27]
    end
    if(when_CsrPlugin_l1631) begin
      execute_CsrPlugin_illegalAccess = 1'b0; // @[CsrPlugin.scala 1631:25]
    end
  end

  always @(*) begin
    execute_CsrPlugin_illegalInstruction = 1'b0; // @[CsrPlugin.scala 1455:34]
    if(when_CsrPlugin_l1467) begin
      if(when_CsrPlugin_l1468) begin
        execute_CsrPlugin_illegalInstruction = 1'b1; // @[CsrPlugin.scala 1469:32]
      end
    end
  end

  assign when_CsrPlugin_l1467 = (execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_XRET)); // @[BaseType.scala 305:24]
  assign when_CsrPlugin_l1468 = (CsrPlugin_privilege < execute_INSTRUCTION[29 : 28]); // @[BaseType.scala 305:24]
  always @(*) begin
    execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE); // @[BaseType.scala 305:24]
    if(when_CsrPlugin_l1625) begin
      execute_CsrPlugin_writeInstruction = 1'b0; // @[CsrPlugin.scala 1628:30]
    end
  end

  always @(*) begin
    execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE); // @[BaseType.scala 305:24]
    if(when_CsrPlugin_l1625) begin
      execute_CsrPlugin_readInstruction = 1'b0; // @[CsrPlugin.scala 1627:29]
    end
  end

  assign execute_CsrPlugin_writeEnable = (execute_CsrPlugin_writeInstruction && (! execute_arbitration_isStuck)); // @[BaseType.scala 305:24]
  assign execute_CsrPlugin_readEnable = (execute_CsrPlugin_readInstruction && (! execute_arbitration_isStuck)); // @[BaseType.scala 305:24]
  assign CsrPlugin_csrMapping_hazardFree = (! execute_CsrPlugin_blockedBySideEffects); // @[CsrPlugin.scala 1499:31]
  assign execute_CsrPlugin_readToWriteData = CsrPlugin_csrMapping_readDataSignal; // @[Misc.scala 552:9]
  assign switch_Misc_l226_1 = execute_INSTRUCTION[13]; // @[BaseType.scala 305:24]
  always @(*) begin
    case(switch_Misc_l226_1)
      1'b0 : begin
        _zz_CsrPlugin_csrMapping_writeDataSignal = execute_SRC1; // @[Misc.scala 239:22]
      end
      default : begin
        _zz_CsrPlugin_csrMapping_writeDataSignal = (execute_INSTRUCTION[12] ? (execute_CsrPlugin_readToWriteData & (~ execute_SRC1)) : (execute_CsrPlugin_readToWriteData | execute_SRC1)); // @[Misc.scala 239:22]
      end
    endcase
  end

  assign CsrPlugin_csrMapping_writeDataSignal = _zz_CsrPlugin_csrMapping_writeDataSignal; // @[CsrPlugin.scala 1502:19]
  assign when_CsrPlugin_l1507 = (execute_arbitration_isValid && execute_IS_CSR); // @[BaseType.scala 305:24]
  assign when_CsrPlugin_l1511 = (execute_arbitration_isValid && (execute_IS_CSR || 1'b0)); // @[BaseType.scala 305:24]
  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20]; // @[BaseType.scala 299:24]
  assign when_DebugPlugin_l238 = (DebugPlugin_haltIt && (! DebugPlugin_isPipBusy)); // @[BaseType.scala 305:24]
  assign DebugPlugin_allowEBreak = (DebugPlugin_debugUsed && (! DebugPlugin_disableEbreak)); // @[BaseType.scala 305:24]
  always @(*) begin
    debug_bus_cmd_ready = 1'b1; // @[DebugPlugin.scala 255:24]
    if(debug_bus_cmd_valid) begin
      case(switch_DebugPlugin_l280)
        6'h01 : begin
          if(debug_bus_cmd_payload_wr) begin
            debug_bus_cmd_ready = IBusCachedPlugin_injectionPort_ready; // @[DebugPlugin.scala 294:32]
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    debug_bus_rsp_data = DebugPlugin_busReadDataReg; // @[DebugPlugin.scala 256:23]
    if(when_DebugPlugin_l257) begin
      debug_bus_rsp_data[0] = DebugPlugin_resetIt; // @[DebugPlugin.scala 258:28]
      debug_bus_rsp_data[1] = DebugPlugin_haltIt; // @[DebugPlugin.scala 259:28]
      debug_bus_rsp_data[2] = DebugPlugin_isPipBusy; // @[DebugPlugin.scala 260:28]
      debug_bus_rsp_data[3] = DebugPlugin_haltedByBreak; // @[DebugPlugin.scala 261:28]
      debug_bus_rsp_data[4] = DebugPlugin_stepIt; // @[DebugPlugin.scala 262:28]
    end
  end

  assign when_DebugPlugin_l257 = (! _zz_when_DebugPlugin_l257); // @[BaseType.scala 299:24]
  always @(*) begin
    IBusCachedPlugin_injectionPort_valid = 1'b0; // @[DebugPlugin.scala 276:27]
    if(debug_bus_cmd_valid) begin
      case(switch_DebugPlugin_l280)
        6'h01 : begin
          if(debug_bus_cmd_payload_wr) begin
            IBusCachedPlugin_injectionPort_valid = 1'b1; // @[DebugPlugin.scala 293:35]
          end
        end
        default : begin
        end
      endcase
    end
  end

  assign IBusCachedPlugin_injectionPort_payload = debug_bus_cmd_payload_data; // @[DebugPlugin.scala 277:29]
  assign switch_DebugPlugin_l280 = debug_bus_cmd_payload_address[7 : 2]; // @[BaseType.scala 299:24]
  assign when_DebugPlugin_l284 = debug_bus_cmd_payload_data[16]; // @[BaseType.scala 305:24]
  assign when_DebugPlugin_l284_1 = debug_bus_cmd_payload_data[24]; // @[BaseType.scala 305:24]
  assign when_DebugPlugin_l285 = debug_bus_cmd_payload_data[17]; // @[BaseType.scala 305:24]
  assign when_DebugPlugin_l285_1 = debug_bus_cmd_payload_data[25]; // @[BaseType.scala 305:24]
  assign when_DebugPlugin_l286 = debug_bus_cmd_payload_data[25]; // @[BaseType.scala 305:24]
  assign when_DebugPlugin_l287 = debug_bus_cmd_payload_data[25]; // @[BaseType.scala 305:24]
  assign when_DebugPlugin_l288 = debug_bus_cmd_payload_data[18]; // @[BaseType.scala 305:24]
  assign when_DebugPlugin_l288_1 = debug_bus_cmd_payload_data[26]; // @[BaseType.scala 305:24]
  assign when_DebugPlugin_l308 = (execute_arbitration_isValid && execute_DO_EBREAK); // @[BaseType.scala 305:24]
  assign when_DebugPlugin_l311 = (({writeBack_arbitration_isValid,memory_arbitration_isValid} != 2'b00) == 1'b0); // @[BaseType.scala 305:24]
  assign when_DebugPlugin_l324 = (DebugPlugin_stepIt && IBusCachedPlugin_incomingInstruction); // @[BaseType.scala 305:24]
  assign debug_resetOut = DebugPlugin_resetIt_regNext; // @[DebugPlugin.scala 341:19]
  assign when_DebugPlugin_l344 = (DebugPlugin_haltIt || DebugPlugin_stepIt); // @[BaseType.scala 305:24]
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2); // @[BaseType.scala 305:24]
  assign switch_Misc_l226_2 = execute_INSTRUCTION[14 : 12]; // @[BaseType.scala 299:24]
  always @(*) begin
    casez(switch_Misc_l226_2)
      3'b000 : begin
        _zz_execute_BRANCH_COND_RESULT = execute_BranchPlugin_eq; // @[Misc.scala 239:22]
      end
      3'b001 : begin
        _zz_execute_BRANCH_COND_RESULT = (! execute_BranchPlugin_eq); // @[Misc.scala 239:22]
      end
      3'b1?1 : begin
        _zz_execute_BRANCH_COND_RESULT = (! execute_SRC_LESS); // @[Misc.scala 239:22]
      end
      default : begin
        _zz_execute_BRANCH_COND_RESULT = execute_SRC_LESS; // @[Misc.scala 235:22]
      end
    endcase
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : begin
        _zz_execute_BRANCH_COND_RESULT_1 = 1'b0; // @[Misc.scala 239:22]
      end
      BranchCtrlEnum_JAL : begin
        _zz_execute_BRANCH_COND_RESULT_1 = 1'b1; // @[Misc.scala 239:22]
      end
      BranchCtrlEnum_JALR : begin
        _zz_execute_BRANCH_COND_RESULT_1 = 1'b1; // @[Misc.scala 239:22]
      end
      default : begin
        _zz_execute_BRANCH_COND_RESULT_1 = _zz_execute_BRANCH_COND_RESULT; // @[Misc.scala 239:22]
      end
    endcase
  end

  assign _zz_execute_BranchPlugin_missAlignedTarget = execute_INSTRUCTION[31]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_execute_BranchPlugin_missAlignedTarget_1[19] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[18] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[17] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[16] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[15] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[14] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[13] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[12] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[11] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[10] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[9] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[8] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[7] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[6] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[5] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[4] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[3] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[2] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[1] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_1[0] = _zz_execute_BranchPlugin_missAlignedTarget; // @[Literal.scala 87:17]
  end

  assign _zz_execute_BranchPlugin_missAlignedTarget_2 = _zz__zz_execute_BranchPlugin_missAlignedTarget_2[19]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_execute_BranchPlugin_missAlignedTarget_3[10] = _zz_execute_BranchPlugin_missAlignedTarget_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_3[9] = _zz_execute_BranchPlugin_missAlignedTarget_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_3[8] = _zz_execute_BranchPlugin_missAlignedTarget_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_3[7] = _zz_execute_BranchPlugin_missAlignedTarget_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_3[6] = _zz_execute_BranchPlugin_missAlignedTarget_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_3[5] = _zz_execute_BranchPlugin_missAlignedTarget_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_3[4] = _zz_execute_BranchPlugin_missAlignedTarget_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_3[3] = _zz_execute_BranchPlugin_missAlignedTarget_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_3[2] = _zz_execute_BranchPlugin_missAlignedTarget_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_3[1] = _zz_execute_BranchPlugin_missAlignedTarget_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_3[0] = _zz_execute_BranchPlugin_missAlignedTarget_2; // @[Literal.scala 87:17]
  end

  assign _zz_execute_BranchPlugin_missAlignedTarget_4 = _zz__zz_execute_BranchPlugin_missAlignedTarget_4[11]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_execute_BranchPlugin_missAlignedTarget_5[18] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[17] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[16] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[15] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[14] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[13] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[12] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[11] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[10] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[9] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[8] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[7] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[6] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[5] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[4] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[3] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[2] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[1] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_missAlignedTarget_5[0] = _zz_execute_BranchPlugin_missAlignedTarget_4; // @[Literal.scala 87:17]
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_JALR : begin
        _zz_execute_BranchPlugin_missAlignedTarget_6 = (_zz__zz_execute_BranchPlugin_missAlignedTarget_6[1] ^ execute_RS1[1]); // @[Misc.scala 239:22]
      end
      BranchCtrlEnum_JAL : begin
        _zz_execute_BranchPlugin_missAlignedTarget_6 = _zz__zz_execute_BranchPlugin_missAlignedTarget_6_1[1]; // @[Misc.scala 239:22]
      end
      default : begin
        _zz_execute_BranchPlugin_missAlignedTarget_6 = _zz__zz_execute_BranchPlugin_missAlignedTarget_6_2[1]; // @[Misc.scala 235:22]
      end
    endcase
  end

  assign execute_BranchPlugin_missAlignedTarget = (execute_BRANCH_COND_RESULT && _zz_execute_BranchPlugin_missAlignedTarget_6); // @[BaseType.scala 305:24]
  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_JALR : begin
        execute_BranchPlugin_branch_src1 = execute_RS1; // @[BranchPlugin.scala 272:23]
      end
      default : begin
        execute_BranchPlugin_branch_src1 = execute_PC; // @[BranchPlugin.scala 276:23]
      end
    endcase
  end

  assign _zz_execute_BranchPlugin_branch_src2 = execute_INSTRUCTION[31]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_1[19] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[18] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[17] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[16] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[15] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[14] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[13] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[12] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[11] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[10] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[9] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[8] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[7] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[6] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[5] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[4] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[3] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[2] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[1] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_1[0] = _zz_execute_BranchPlugin_branch_src2; // @[Literal.scala 87:17]
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_JALR : begin
        execute_BranchPlugin_branch_src2 = {_zz_execute_BranchPlugin_branch_src2_1,execute_INSTRUCTION[31 : 20]}; // @[BranchPlugin.scala 273:23]
      end
      default : begin
        execute_BranchPlugin_branch_src2 = ((execute_BRANCH_CTRL == BranchCtrlEnum_JAL) ? {{_zz_execute_BranchPlugin_branch_src2_3,{{{_zz_execute_BranchPlugin_branch_src2_6,execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_execute_BranchPlugin_branch_src2_5,{{{_zz_execute_BranchPlugin_branch_src2_7,_zz_execute_BranchPlugin_branch_src2_8},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0}); // @[BranchPlugin.scala 277:23]
        if(execute_PREDICTION_HAD_BRANCHED2) begin
          execute_BranchPlugin_branch_src2 = {29'd0, _zz_execute_BranchPlugin_branch_src2_9}; // @[BranchPlugin.scala 279:25]
        end
      end
    endcase
  end

  assign _zz_execute_BranchPlugin_branch_src2_2 = _zz__zz_execute_BranchPlugin_branch_src2_2[19]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_3[10] = _zz_execute_BranchPlugin_branch_src2_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_3[9] = _zz_execute_BranchPlugin_branch_src2_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_3[8] = _zz_execute_BranchPlugin_branch_src2_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_3[7] = _zz_execute_BranchPlugin_branch_src2_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_3[6] = _zz_execute_BranchPlugin_branch_src2_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_3[5] = _zz_execute_BranchPlugin_branch_src2_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_3[4] = _zz_execute_BranchPlugin_branch_src2_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_3[3] = _zz_execute_BranchPlugin_branch_src2_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_3[2] = _zz_execute_BranchPlugin_branch_src2_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_3[1] = _zz_execute_BranchPlugin_branch_src2_2; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_3[0] = _zz_execute_BranchPlugin_branch_src2_2; // @[Literal.scala 87:17]
  end

  assign _zz_execute_BranchPlugin_branch_src2_4 = _zz__zz_execute_BranchPlugin_branch_src2_4[11]; // @[BaseType.scala 305:24]
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_5[18] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[17] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[16] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[15] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[14] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[13] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[12] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[11] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[10] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[9] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[8] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[7] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[6] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[5] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[4] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[3] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[2] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[1] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
    _zz_execute_BranchPlugin_branch_src2_5[0] = _zz_execute_BranchPlugin_branch_src2_4; // @[Literal.scala 87:17]
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2); // @[BaseType.scala 299:24]
  assign BranchPlugin_jumpInterface_valid = ((execute_arbitration_isValid && execute_BRANCH_DO) && (! 1'b0)); // @[BranchPlugin.scala 292:27]
  assign BranchPlugin_jumpInterface_payload = execute_BRANCH_CALC; // @[BranchPlugin.scala 293:29]
  always @(*) begin
    BranchPlugin_branchExceptionPort_valid = (execute_arbitration_isValid && (execute_BRANCH_DO && execute_BRANCH_CALC[1])); // @[BranchPlugin.scala 298:35]
    if(when_BranchPlugin_l302) begin
      BranchPlugin_branchExceptionPort_valid = 1'b0; // @[BranchPlugin.scala 302:62]
    end
  end

  assign BranchPlugin_branchExceptionPort_payload_code = 4'b0000; // @[BranchPlugin.scala 299:34]
  assign BranchPlugin_branchExceptionPort_payload_badAddr = execute_BRANCH_CALC; // @[BranchPlugin.scala 300:37]
  assign when_BranchPlugin_l302 = 1'b0; // @[HazardSimplePlugin.scala 22:133]
  assign IBusCachedPlugin_decodePrediction_rsp_wasWrong = BranchPlugin_jumpInterface_valid; // @[BranchPlugin.scala 306:35]
  assign when_Pipeline_l124 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_1 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_2 = ((! writeBack_arbitration_isStuck) && (! CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack)); // @[BaseType.scala 305:24]
  assign when_Pipeline_l124_3 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_4 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_5 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_6 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_7 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_8 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_9 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_decode_to_execute_SRC1_CTRL_1 = decode_SRC1_CTRL; // @[Pipeline.scala 110:25]
  assign _zz_decode_SRC1_CTRL = _zz_decode_SRC1_CTRL_1; // @[Pipeline.scala 121:26]
  assign when_Pipeline_l124_10 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_execute_SRC1_CTRL = decode_to_execute_SRC1_CTRL; // @[Pipeline.scala 124:26]
  assign when_Pipeline_l124_11 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_12 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_13 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_14 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_decode_to_execute_ALU_CTRL_1 = decode_ALU_CTRL; // @[Pipeline.scala 110:25]
  assign _zz_decode_ALU_CTRL = _zz_decode_ALU_CTRL_1; // @[Pipeline.scala 121:26]
  assign when_Pipeline_l124_15 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_execute_ALU_CTRL = decode_to_execute_ALU_CTRL; // @[Pipeline.scala 124:26]
  assign _zz_decode_to_execute_SRC2_CTRL_1 = decode_SRC2_CTRL; // @[Pipeline.scala 110:25]
  assign _zz_decode_SRC2_CTRL = _zz_decode_SRC2_CTRL_1; // @[Pipeline.scala 121:26]
  assign when_Pipeline_l124_16 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_execute_SRC2_CTRL = decode_to_execute_SRC2_CTRL; // @[Pipeline.scala 124:26]
  assign when_Pipeline_l124_17 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_18 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_19 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_20 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_21 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_22 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_23 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_24 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_25 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_26 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_27 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL_1 = decode_ALU_BITWISE_CTRL; // @[Pipeline.scala 110:25]
  assign _zz_decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL_1; // @[Pipeline.scala 121:26]
  assign when_Pipeline_l124_28 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_execute_ALU_BITWISE_CTRL = decode_to_execute_ALU_BITWISE_CTRL; // @[Pipeline.scala 124:26]
  assign _zz_decode_to_execute_SHIFT_CTRL_1 = decode_SHIFT_CTRL; // @[Pipeline.scala 110:25]
  assign _zz_execute_to_memory_SHIFT_CTRL_1 = execute_SHIFT_CTRL; // @[Pipeline.scala 110:25]
  assign _zz_decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL_1; // @[Pipeline.scala 121:26]
  assign when_Pipeline_l124_29 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_execute_SHIFT_CTRL = decode_to_execute_SHIFT_CTRL; // @[Pipeline.scala 124:26]
  assign when_Pipeline_l124_30 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_memory_SHIFT_CTRL = execute_to_memory_SHIFT_CTRL; // @[Pipeline.scala 124:26]
  assign when_Pipeline_l124_31 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_32 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_33 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_34 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_35 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_36 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_37 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_38 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_39 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_decode_to_execute_FPU_OPCODE_1 = decode_FPU_OPCODE; // @[Pipeline.scala 110:25]
  assign _zz_execute_to_memory_FPU_OPCODE_1 = execute_FPU_OPCODE; // @[Pipeline.scala 110:25]
  assign _zz_memory_to_writeBack_FPU_OPCODE_1 = memory_FPU_OPCODE; // @[Pipeline.scala 110:25]
  assign _zz_decode_FPU_OPCODE = _zz_decode_FPU_OPCODE_1; // @[Pipeline.scala 121:26]
  assign when_Pipeline_l124_40 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_execute_FPU_OPCODE = decode_to_execute_FPU_OPCODE; // @[Pipeline.scala 124:26]
  assign when_Pipeline_l124_41 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_memory_FPU_OPCODE = execute_to_memory_FPU_OPCODE; // @[Pipeline.scala 124:26]
  assign when_Pipeline_l124_42 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_writeBack_FPU_OPCODE = memory_to_writeBack_FPU_OPCODE; // @[Pipeline.scala 124:26]
  assign when_Pipeline_l124_43 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_decode_to_execute_ENV_CTRL_1 = decode_ENV_CTRL; // @[Pipeline.scala 110:25]
  assign _zz_execute_to_memory_ENV_CTRL_1 = execute_ENV_CTRL; // @[Pipeline.scala 110:25]
  assign _zz_memory_to_writeBack_ENV_CTRL_1 = memory_ENV_CTRL; // @[Pipeline.scala 110:25]
  assign _zz_decode_ENV_CTRL = _zz_decode_ENV_CTRL_1; // @[Pipeline.scala 121:26]
  assign when_Pipeline_l124_44 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_execute_ENV_CTRL = decode_to_execute_ENV_CTRL; // @[Pipeline.scala 124:26]
  assign when_Pipeline_l124_45 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_memory_ENV_CTRL = execute_to_memory_ENV_CTRL; // @[Pipeline.scala 124:26]
  assign when_Pipeline_l124_46 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_writeBack_ENV_CTRL = memory_to_writeBack_ENV_CTRL; // @[Pipeline.scala 124:26]
  assign _zz_decode_to_execute_BRANCH_CTRL_1 = decode_BRANCH_CTRL; // @[Pipeline.scala 110:25]
  assign _zz_decode_BRANCH_CTRL_1 = _zz_decode_BRANCH_CTRL; // @[Pipeline.scala 121:26]
  assign when_Pipeline_l124_47 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_execute_BRANCH_CTRL = decode_to_execute_BRANCH_CTRL; // @[Pipeline.scala 124:26]
  assign when_Pipeline_l124_48 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_49 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_50 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_51 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_52 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_53 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_54 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_55 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_56 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_57 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_58 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_59 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_60 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_61 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_62 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_63 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_64 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_65 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_66 = (! writeBack_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_Pipeline_l124_67 = (! memory_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign decode_arbitration_isFlushed = (({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,execute_arbitration_flushNext}} != 3'b000) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,{execute_arbitration_flushIt,decode_arbitration_flushIt}}} != 4'b0000)); // @[Pipeline.scala 132:35]
  assign execute_arbitration_isFlushed = (({writeBack_arbitration_flushNext,memory_arbitration_flushNext} != 2'b00) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,execute_arbitration_flushIt}} != 3'b000)); // @[Pipeline.scala 132:35]
  assign memory_arbitration_isFlushed = ((writeBack_arbitration_flushNext != 1'b0) || ({writeBack_arbitration_flushIt,memory_arbitration_flushIt} != 2'b00)); // @[Pipeline.scala 132:35]
  assign writeBack_arbitration_isFlushed = (1'b0 || (writeBack_arbitration_flushIt != 1'b0)); // @[Pipeline.scala 132:35]
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck)); // @[Pipeline.scala 141:41]
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers); // @[Pipeline.scala 142:33]
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt)); // @[Pipeline.scala 143:34]
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt)); // @[Pipeline.scala 144:34]
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck)); // @[Pipeline.scala 141:41]
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers); // @[Pipeline.scala 142:33]
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt)); // @[Pipeline.scala 143:34]
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt)); // @[Pipeline.scala 144:34]
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck)); // @[Pipeline.scala 141:41]
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers); // @[Pipeline.scala 142:33]
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt)); // @[Pipeline.scala 143:34]
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt)); // @[Pipeline.scala 144:34]
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0); // @[Pipeline.scala 141:41]
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers); // @[Pipeline.scala 142:33]
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt)); // @[Pipeline.scala 143:34]
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt)); // @[Pipeline.scala 144:34]
  assign when_Pipeline_l151 = ((! execute_arbitration_isStuck) || execute_arbitration_removeIt); // @[BaseType.scala 305:24]
  assign when_Pipeline_l154 = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt)); // @[BaseType.scala 305:24]
  assign when_Pipeline_l151_1 = ((! memory_arbitration_isStuck) || memory_arbitration_removeIt); // @[BaseType.scala 305:24]
  assign when_Pipeline_l154_1 = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt)); // @[BaseType.scala 305:24]
  assign when_Pipeline_l151_2 = ((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt); // @[BaseType.scala 305:24]
  assign when_Pipeline_l154_2 = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt)); // @[BaseType.scala 305:24]
  always @(*) begin
    IBusCachedPlugin_injectionPort_ready = 1'b0; // @[Fetcher.scala 361:31]
    case(switch_Fetcher_l365)
      3'b100 : begin
        IBusCachedPlugin_injectionPort_ready = 1'b1; // @[Fetcher.scala 386:35]
      end
      default : begin
      end
    endcase
  end

  assign when_Fetcher_l381 = (! decode_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1589 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1589_1 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1589_2 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1589_3 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1589_4 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1589_5 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1589_6 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1589_7 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1589_8 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign when_CsrPlugin_l1589_9 = (! execute_arbitration_isStuck); // @[BaseType.scala 299:24]
  assign _zz_FpuPlugin_flags_NX = CsrPlugin_csrMapping_writeDataSignal[4 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit = 32'h0; // @[Expression.scala 2301:18]
    if(execute_CsrPlugin_csr_3) begin
      _zz_CsrPlugin_csrMapping_readDataInit[7 : 5] = FpuPlugin_rm; // @[CsrPlugin.scala 1598:138]
      _zz_CsrPlugin_csrMapping_readDataInit[4 : 0] = {FpuPlugin_flags_NV,{FpuPlugin_flags_DZ,{FpuPlugin_flags_OF,{FpuPlugin_flags_UF,FpuPlugin_flags_NX}}}}; // @[CsrPlugin.scala 1598:138]
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_1 = 32'h0; // @[Expression.scala 2301:18]
    if(execute_CsrPlugin_csr_2) begin
      _zz_CsrPlugin_csrMapping_readDataInit_1[2 : 0] = FpuPlugin_rm; // @[CsrPlugin.scala 1598:138]
    end
  end

  assign _zz_FpuPlugin_flags_NX_1 = CsrPlugin_csrMapping_writeDataSignal[4 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_2 = 32'h0; // @[Expression.scala 2301:18]
    if(execute_CsrPlugin_csr_1) begin
      _zz_CsrPlugin_csrMapping_readDataInit_2[4 : 0] = {FpuPlugin_flags_NV,{FpuPlugin_flags_DZ,{FpuPlugin_flags_OF,{FpuPlugin_flags_UF,FpuPlugin_flags_NX}}}}; // @[CsrPlugin.scala 1598:138]
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_3 = 32'h0; // @[Expression.scala 2301:18]
    if(execute_CsrPlugin_csr_256) begin
      _zz_CsrPlugin_csrMapping_readDataInit_3[14 : 13] = FpuPlugin_fs; // @[CsrPlugin.scala 1598:138]
      _zz_CsrPlugin_csrMapping_readDataInit_3[31 : 31] = FpuPlugin_sd; // @[CsrPlugin.scala 1598:138]
    end
  end

  assign switch_CsrPlugin_l980 = CsrPlugin_csrMapping_writeDataSignal[12 : 11]; // @[BaseType.scala 299:24]
  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_4 = 32'h0; // @[Expression.scala 2301:18]
    if(execute_CsrPlugin_csr_768) begin
      _zz_CsrPlugin_csrMapping_readDataInit_4[14 : 13] = FpuPlugin_fs; // @[CsrPlugin.scala 1598:138]
      _zz_CsrPlugin_csrMapping_readDataInit_4[31 : 31] = FpuPlugin_sd; // @[CsrPlugin.scala 1598:138]
      _zz_CsrPlugin_csrMapping_readDataInit_4[7 : 7] = CsrPlugin_mstatus_MPIE; // @[CsrPlugin.scala 1598:138]
      _zz_CsrPlugin_csrMapping_readDataInit_4[3 : 3] = CsrPlugin_mstatus_MIE; // @[CsrPlugin.scala 1598:138]
      _zz_CsrPlugin_csrMapping_readDataInit_4[12 : 11] = CsrPlugin_mstatus_MPP; // @[CsrPlugin.scala 1598:138]
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_5 = 32'h0; // @[Expression.scala 2301:18]
    if(execute_CsrPlugin_csr_836) begin
      _zz_CsrPlugin_csrMapping_readDataInit_5[11 : 11] = CsrPlugin_mip_MEIP; // @[CsrPlugin.scala 1598:138]
      _zz_CsrPlugin_csrMapping_readDataInit_5[7 : 7] = CsrPlugin_mip_MTIP; // @[CsrPlugin.scala 1598:138]
      _zz_CsrPlugin_csrMapping_readDataInit_5[3 : 3] = CsrPlugin_mip_MSIP; // @[CsrPlugin.scala 1598:138]
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_6 = 32'h0; // @[Expression.scala 2301:18]
    if(execute_CsrPlugin_csr_772) begin
      _zz_CsrPlugin_csrMapping_readDataInit_6[11 : 11] = CsrPlugin_mie_MEIE; // @[CsrPlugin.scala 1598:138]
      _zz_CsrPlugin_csrMapping_readDataInit_6[7 : 7] = CsrPlugin_mie_MTIE; // @[CsrPlugin.scala 1598:138]
      _zz_CsrPlugin_csrMapping_readDataInit_6[3 : 3] = CsrPlugin_mie_MSIE; // @[CsrPlugin.scala 1598:138]
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_7 = 32'h0; // @[Expression.scala 2301:18]
    if(execute_CsrPlugin_csr_833) begin
      _zz_CsrPlugin_csrMapping_readDataInit_7[31 : 0] = CsrPlugin_mepc; // @[CsrPlugin.scala 1598:138]
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_8 = 32'h0; // @[Expression.scala 2301:18]
    if(execute_CsrPlugin_csr_834) begin
      _zz_CsrPlugin_csrMapping_readDataInit_8[31 : 31] = CsrPlugin_mcause_interrupt; // @[CsrPlugin.scala 1598:138]
      _zz_CsrPlugin_csrMapping_readDataInit_8[3 : 0] = CsrPlugin_mcause_exceptionCode; // @[CsrPlugin.scala 1598:138]
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_9 = 32'h0; // @[Expression.scala 2301:18]
    if(execute_CsrPlugin_csr_835) begin
      _zz_CsrPlugin_csrMapping_readDataInit_9[31 : 0] = CsrPlugin_mtval; // @[CsrPlugin.scala 1598:138]
    end
  end

  assign CsrPlugin_csrMapping_readDataInit = ((((_zz_CsrPlugin_csrMapping_readDataInit | _zz_CsrPlugin_csrMapping_readDataInit_1) | (_zz_CsrPlugin_csrMapping_readDataInit_2 | _zz_CsrPlugin_csrMapping_readDataInit_3)) | ((_zz_CsrPlugin_csrMapping_readDataInit_4 | _zz_CsrPlugin_csrMapping_readDataInit_5) | (_zz_CsrPlugin_csrMapping_readDataInit_6 | _zz_CsrPlugin_csrMapping_readDataInit_7))) | (_zz_CsrPlugin_csrMapping_readDataInit_8 | _zz_CsrPlugin_csrMapping_readDataInit_9)); // @[CsrPlugin.scala 1604:39]
  always @(*) begin
    when_CsrPlugin_l1625 = 1'b0; // @[CsrPlugin.scala 1622:27]
    if(when_CsrPlugin_l1623) begin
      when_CsrPlugin_l1625 = 1'b1; // @[CsrPlugin.scala 1623:21]
    end
  end

  assign when_CsrPlugin_l1623 = (CsrPlugin_privilege < execute_CsrPlugin_csrAddress[9 : 8]); // @[BaseType.scala 305:24]
  assign when_CsrPlugin_l1631 = ((! execute_arbitration_isValid) || (! execute_IS_CSR)); // @[BaseType.scala 305:24]
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      IBusCachedPlugin_fetchPc_pcReg <= 32'h80000000; // @[Data.scala 400:33]
      IBusCachedPlugin_fetchPc_correctionReg <= 1'b0; // @[Data.scala 400:33]
      IBusCachedPlugin_fetchPc_booted <= 1'b0; // @[Data.scala 400:33]
      IBusCachedPlugin_fetchPc_inc <= 1'b0; // @[Data.scala 400:33]
      _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid_1 <= 1'b0; // @[Data.scala 400:33]
      _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid <= 1'b0; // @[Data.scala 400:33]
      IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0; // @[Data.scala 400:33]
      IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0; // @[Data.scala 400:33]
      IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0; // @[Data.scala 400:33]
      IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0; // @[Data.scala 400:33]
      IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0; // @[Data.scala 400:33]
      IBusCachedPlugin_rspCounter <= 32'h0; // @[Data.scala 400:33]
      DBusCachedPlugin_rspCounter <= 32'h0; // @[Data.scala 400:33]
      _zz_7 <= 1'b1; // @[Data.scala 400:33]
      HazardSimplePlugin_writeBackBuffer_valid <= 1'b0; // @[Data.scala 400:33]
      FpuPlugin_pendings <= 6'h0; // @[Data.scala 400:33]
      FpuPlugin_flags_NV <= 1'b0; // @[Data.scala 400:33]
      FpuPlugin_flags_DZ <= 1'b0; // @[Data.scala 400:33]
      FpuPlugin_flags_OF <= 1'b0; // @[Data.scala 400:33]
      FpuPlugin_flags_UF <= 1'b0; // @[Data.scala 400:33]
      FpuPlugin_flags_NX <= 1'b0; // @[Data.scala 400:33]
      FpuPlugin_rm <= 3'b000; // @[Data.scala 400:33]
      FpuPlugin_fs <= 2'b01; // @[Data.scala 400:33]
      decode_FpuPlugin_forked <= 1'b0; // @[Data.scala 400:33]
      writeBack_FpuPlugin_commit_rValid <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_mstatus_MIE <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_mstatus_MPIE <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_mstatus_MPP <= 2'b11; // @[Data.scala 400:33]
      CsrPlugin_mie_MEIE <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_mie_MTIE <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_mie_MSIE <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_mcycle <= 64'h0; // @[Data.scala 400:33]
      CsrPlugin_minstret <= 64'h0; // @[Data.scala 400:33]
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_interrupt_valid <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0; // @[Data.scala 400:33]
      CsrPlugin_hadException <= 1'b0; // @[Data.scala 400:33]
      execute_CsrPlugin_wfiWake <= 1'b0; // @[Data.scala 400:33]
      execute_arbitration_isValid <= 1'b0; // @[Data.scala 400:33]
      memory_arbitration_isValid <= 1'b0; // @[Data.scala 400:33]
      writeBack_arbitration_isValid <= 1'b0; // @[Data.scala 400:33]
      switch_Fetcher_l365 <= 3'b000; // @[Data.scala 400:33]
      decode_to_execute_FPU_FORKED <= 1'b0; // @[Data.scala 400:33]
      execute_to_memory_FPU_FORKED <= 1'b0; // @[Data.scala 400:33]
      memory_to_writeBack_FPU_FORKED <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(IBusCachedPlugin_fetchPc_correction) begin
        IBusCachedPlugin_fetchPc_correctionReg <= 1'b1; // @[Fetcher.scala 130:42]
      end
      if(IBusCachedPlugin_fetchPc_output_fire) begin
        IBusCachedPlugin_fetchPc_correctionReg <= 1'b0; // @[Fetcher.scala 130:62]
      end
      IBusCachedPlugin_fetchPc_booted <= 1'b1; // @[Reg.scala 39:30]
      if(when_Fetcher_l134) begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0; // @[Fetcher.scala 134:32]
      end
      if(IBusCachedPlugin_fetchPc_output_fire_1) begin
        IBusCachedPlugin_fetchPc_inc <= 1'b1; // @[Fetcher.scala 134:72]
      end
      if(when_Fetcher_l134_1) begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0; // @[Fetcher.scala 134:93]
      end
      if(when_Fetcher_l161) begin
        IBusCachedPlugin_fetchPc_pcReg <= IBusCachedPlugin_fetchPc_pc; // @[Fetcher.scala 162:15]
      end
      if(IBusCachedPlugin_iBusRsp_flush) begin
        _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid_1 <= 1'b0; // @[Misc.scala 146:41]
      end
      if(_zz_IBusCachedPlugin_iBusRsp_stages_0_output_ready) begin
        _zz_IBusCachedPlugin_iBusRsp_stages_1_input_valid_1 <= (IBusCachedPlugin_iBusRsp_stages_0_output_valid && (! 1'b0)); // @[Misc.scala 154:18]
      end
      if(IBusCachedPlugin_iBusRsp_flush) begin
        _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid <= 1'b0; // @[Misc.scala 146:41]
      end
      if(IBusCachedPlugin_iBusRsp_stages_1_output_ready) begin
        _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid <= (IBusCachedPlugin_iBusRsp_stages_1_output_valid && (! IBusCachedPlugin_iBusRsp_flush)); // @[Misc.scala 154:18]
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0; // @[Fetcher.scala 330:17]
      end
      if(when_Fetcher_l332) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b1; // @[Fetcher.scala 333:17]
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0; // @[Fetcher.scala 330:17]
      end
      if(when_Fetcher_l332_1) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= IBusCachedPlugin_injector_nextPcCalc_valids_0; // @[Fetcher.scala 333:17]
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0; // @[Fetcher.scala 336:17]
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0; // @[Fetcher.scala 330:17]
      end
      if(when_Fetcher_l332_2) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= IBusCachedPlugin_injector_nextPcCalc_valids_1; // @[Fetcher.scala 333:17]
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0; // @[Fetcher.scala 336:17]
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0; // @[Fetcher.scala 330:17]
      end
      if(when_Fetcher_l332_3) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= IBusCachedPlugin_injector_nextPcCalc_valids_2; // @[Fetcher.scala 333:17]
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0; // @[Fetcher.scala 336:17]
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0; // @[Fetcher.scala 330:17]
      end
      if(when_Fetcher_l332_4) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= IBusCachedPlugin_injector_nextPcCalc_valids_3; // @[Fetcher.scala 333:17]
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0; // @[Fetcher.scala 336:17]
      end
      if(iBus_rsp_valid) begin
        IBusCachedPlugin_rspCounter <= (IBusCachedPlugin_rspCounter + 32'h00000001); // @[IBusCachedPlugin.scala 146:20]
      end
      if(dBus_rsp_valid) begin
        DBusCachedPlugin_rspCounter <= (DBusCachedPlugin_rspCounter + 32'h00000001); // @[DBusCachedPlugin.scala 301:20]
      end
      _zz_7 <= 1'b0; // @[Reg.scala 39:30]
      HazardSimplePlugin_writeBackBuffer_valid <= HazardSimplePlugin_writeBackWrites_valid; // @[Reg.scala 39:30]
      FpuPlugin_pendings <= (_zz_FpuPlugin_pendings - _zz_FpuPlugin_pendings_6); // @[FpuPlugin.scala 194:16]
      if(when_FpuPlugin_l199) begin
        FpuPlugin_flags_NV <= 1'b1; // @[FpuPlugin.scala 199:28]
      end
      if(when_FpuPlugin_l200) begin
        FpuPlugin_flags_DZ <= 1'b1; // @[FpuPlugin.scala 200:28]
      end
      if(when_FpuPlugin_l201) begin
        FpuPlugin_flags_OF <= 1'b1; // @[FpuPlugin.scala 201:28]
      end
      if(when_FpuPlugin_l202) begin
        FpuPlugin_flags_UF <= 1'b1; // @[FpuPlugin.scala 202:28]
      end
      if(when_FpuPlugin_l203) begin
        FpuPlugin_flags_NX <= 1'b1; // @[FpuPlugin.scala 203:28]
      end
      if(when_FpuPlugin_l219) begin
        FpuPlugin_fs <= 2'b11; // @[FpuPlugin.scala 220:12]
      end
      if(when_FpuPlugin_l222) begin
        FpuPlugin_fs <= 2'b11; // @[FpuPlugin.scala 223:12]
      end
      if(FpuPlugin_port_cmd_fire_1) begin
        decode_FpuPlugin_forked <= 1'b1; // @[FpuPlugin.scala 237:30]
      end
      if(when_FpuPlugin_l237) begin
        decode_FpuPlugin_forked <= 1'b0; // @[FpuPlugin.scala 237:53]
      end
      if(writeBack_FpuPlugin_isRsp) begin
        if(writeBack_arbitration_isValid) begin
          if(when_FpuPlugin_l283) begin
            if(FpuPlugin_port_rsp_payload_NV) begin
              FpuPlugin_flags_NV <= 1'b1; // @[FpuPlugin.scala 284:26]
            end
            if(FpuPlugin_port_rsp_payload_NX) begin
              FpuPlugin_flags_NX <= 1'b1; // @[FpuPlugin.scala 285:26]
            end
          end
        end
      end
      if(writeBack_FpuPlugin_commit_valid) begin
        writeBack_FpuPlugin_commit_rValid <= 1'b1; // @[Stream.scala 377:33]
      end
      if(writeBack_FpuPlugin_commit_s2mPipe_ready) begin
        writeBack_FpuPlugin_commit_rValid <= 1'b0; // @[Stream.scala 377:53]
      end
      CsrPlugin_mcycle <= (CsrPlugin_mcycle + 64'h0000000000000001); // @[CsrPlugin.scala 1096:14]
      if(writeBack_arbitration_isFiring) begin
        CsrPlugin_minstret <= (CsrPlugin_minstret + 64'h0000000000000001); // @[CsrPlugin.scala 1098:18]
      end
      if(when_CsrPlugin_l1179) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0; // @[CsrPlugin.scala 1180:42]
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= CsrPlugin_exceptionPortCtrl_exceptionValids_decode; // @[CsrPlugin.scala 1183:44]
      end
      if(when_CsrPlugin_l1179_1) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= (CsrPlugin_exceptionPortCtrl_exceptionValids_decode && (! decode_arbitration_isStuck)); // @[CsrPlugin.scala 1180:42]
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute; // @[CsrPlugin.scala 1183:44]
      end
      if(when_CsrPlugin_l1179_2) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= (CsrPlugin_exceptionPortCtrl_exceptionValids_execute && (! execute_arbitration_isStuck)); // @[CsrPlugin.scala 1180:42]
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory; // @[CsrPlugin.scala 1183:44]
      end
      if(when_CsrPlugin_l1179_3) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= (CsrPlugin_exceptionPortCtrl_exceptionValids_memory && (! memory_arbitration_isStuck)); // @[CsrPlugin.scala 1180:42]
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0; // @[CsrPlugin.scala 1185:44]
      end
      CsrPlugin_interrupt_valid <= 1'b0; // @[Reg.scala 39:30]
      if(when_CsrPlugin_l1216) begin
        if(when_CsrPlugin_l1222) begin
          CsrPlugin_interrupt_valid <= 1'b1; // @[CsrPlugin.scala 1223:23]
        end
        if(when_CsrPlugin_l1222_1) begin
          CsrPlugin_interrupt_valid <= 1'b1; // @[CsrPlugin.scala 1223:23]
        end
        if(when_CsrPlugin_l1222_2) begin
          CsrPlugin_interrupt_valid <= 1'b1; // @[CsrPlugin.scala 1223:23]
        end
      end
      if(CsrPlugin_pipelineLiberator_active) begin
        if(when_CsrPlugin_l1255) begin
          CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b1; // @[CsrPlugin.scala 1256:19]
        end
        if(when_CsrPlugin_l1255_1) begin
          CsrPlugin_pipelineLiberator_pcValids_1 <= CsrPlugin_pipelineLiberator_pcValids_0; // @[CsrPlugin.scala 1256:19]
        end
        if(when_CsrPlugin_l1255_2) begin
          CsrPlugin_pipelineLiberator_pcValids_2 <= CsrPlugin_pipelineLiberator_pcValids_1; // @[CsrPlugin.scala 1256:19]
        end
      end
      if(when_CsrPlugin_l1260) begin
        CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0; // @[CsrPlugin.scala 1261:30]
        CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0; // @[CsrPlugin.scala 1261:30]
        CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0; // @[CsrPlugin.scala 1261:30]
      end
      if(CsrPlugin_interruptJump) begin
        CsrPlugin_interrupt_valid <= 1'b0; // @[CsrPlugin.scala 1272:46]
      end
      CsrPlugin_hadException <= CsrPlugin_exception; // @[Reg.scala 39:30]
      if(when_CsrPlugin_l1310) begin
        if(when_CsrPlugin_l1318) begin
          case(CsrPlugin_targetPrivilege)
            2'b11 : begin
              CsrPlugin_mstatus_MIE <= 1'b0; // @[CsrPlugin.scala 1334:28]
              CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE; // @[CsrPlugin.scala 1335:28]
              CsrPlugin_mstatus_MPP <= CsrPlugin_privilege; // @[CsrPlugin.scala 1336:28]
            end
            default : begin
            end
          endcase
        end
      end
      if(when_CsrPlugin_l1376) begin
        case(switch_CsrPlugin_l1380)
          2'b11 : begin
            CsrPlugin_mstatus_MPP <= 2'b00; // @[CsrPlugin.scala 1382:27]
            CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE; // @[CsrPlugin.scala 1383:27]
            CsrPlugin_mstatus_MPIE <= 1'b1; // @[CsrPlugin.scala 1384:28]
          end
          default : begin
          end
        endcase
      end
      execute_CsrPlugin_wfiWake <= (({_zz_when_CsrPlugin_l1222_2,{_zz_when_CsrPlugin_l1222_1,_zz_when_CsrPlugin_l1222}} != 3'b000) || CsrPlugin_thirdPartyWake); // @[Reg.scala 39:30]
      if(when_Pipeline_l124_53) begin
        decode_to_execute_FPU_FORKED <= _zz_decode_to_execute_FPU_FORKED; // @[Pipeline.scala 124:40]
      end
      if(when_Pipeline_l124_54) begin
        execute_to_memory_FPU_FORKED <= _zz_execute_to_memory_FPU_FORKED; // @[Pipeline.scala 124:40]
      end
      if(when_Pipeline_l124_55) begin
        memory_to_writeBack_FPU_FORKED <= _zz_memory_to_writeBack_FPU_FORKED; // @[Pipeline.scala 124:40]
      end
      if(when_Pipeline_l151) begin
        execute_arbitration_isValid <= 1'b0; // @[Pipeline.scala 152:35]
      end
      if(when_Pipeline_l154) begin
        execute_arbitration_isValid <= decode_arbitration_isValid; // @[Pipeline.scala 155:35]
      end
      if(when_Pipeline_l151_1) begin
        memory_arbitration_isValid <= 1'b0; // @[Pipeline.scala 152:35]
      end
      if(when_Pipeline_l154_1) begin
        memory_arbitration_isValid <= execute_arbitration_isValid; // @[Pipeline.scala 155:35]
      end
      if(when_Pipeline_l151_2) begin
        writeBack_arbitration_isValid <= 1'b0; // @[Pipeline.scala 152:35]
      end
      if(when_Pipeline_l154_2) begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid; // @[Pipeline.scala 155:35]
      end
      case(switch_Fetcher_l365)
        3'b000 : begin
          if(IBusCachedPlugin_injectionPort_valid) begin
            switch_Fetcher_l365 <= 3'b001; // @[Fetcher.scala 368:23]
          end
        end
        3'b001 : begin
          switch_Fetcher_l365 <= 3'b010; // @[Fetcher.scala 372:21]
        end
        3'b010 : begin
          switch_Fetcher_l365 <= 3'b011; // @[Fetcher.scala 377:21]
        end
        3'b011 : begin
          if(when_Fetcher_l381) begin
            switch_Fetcher_l365 <= 3'b100; // @[Fetcher.scala 382:23]
          end
        end
        3'b100 : begin
          switch_Fetcher_l365 <= 3'b000; // @[Fetcher.scala 387:21]
        end
        default : begin
        end
      endcase
      if(execute_CsrPlugin_csr_3) begin
        if(execute_CsrPlugin_writeEnable) begin
          FpuPlugin_rm <= CsrPlugin_csrMapping_writeDataSignal[7 : 5]; // @[Bits.scala 133:56]
          FpuPlugin_flags_NX <= _zz_FpuPlugin_flags_NX[0]; // @[Bool.scala 189:10]
          FpuPlugin_flags_UF <= _zz_FpuPlugin_flags_NX[1]; // @[Bool.scala 189:10]
          FpuPlugin_flags_OF <= _zz_FpuPlugin_flags_NX[2]; // @[Bool.scala 189:10]
          FpuPlugin_flags_DZ <= _zz_FpuPlugin_flags_NX[3]; // @[Bool.scala 189:10]
          FpuPlugin_flags_NV <= _zz_FpuPlugin_flags_NX[4]; // @[Bool.scala 189:10]
        end
      end
      if(execute_CsrPlugin_csr_2) begin
        if(execute_CsrPlugin_writeEnable) begin
          FpuPlugin_rm <= CsrPlugin_csrMapping_writeDataSignal[2 : 0]; // @[Bits.scala 133:56]
        end
      end
      if(execute_CsrPlugin_csr_1) begin
        if(execute_CsrPlugin_writeEnable) begin
          FpuPlugin_flags_NX <= _zz_FpuPlugin_flags_NX_1[0]; // @[Bool.scala 189:10]
          FpuPlugin_flags_UF <= _zz_FpuPlugin_flags_NX_1[1]; // @[Bool.scala 189:10]
          FpuPlugin_flags_OF <= _zz_FpuPlugin_flags_NX_1[2]; // @[Bool.scala 189:10]
          FpuPlugin_flags_DZ <= _zz_FpuPlugin_flags_NX_1[3]; // @[Bool.scala 189:10]
          FpuPlugin_flags_NV <= _zz_FpuPlugin_flags_NX_1[4]; // @[Bool.scala 189:10]
        end
      end
      if(execute_CsrPlugin_csr_256) begin
        if(execute_CsrPlugin_writeEnable) begin
          FpuPlugin_fs <= CsrPlugin_csrMapping_writeDataSignal[14 : 13]; // @[Bits.scala 133:56]
        end
      end
      if(execute_CsrPlugin_csr_768) begin
        if(execute_CsrPlugin_writeEnable) begin
          FpuPlugin_fs <= CsrPlugin_csrMapping_writeDataSignal[14 : 13]; // @[Bits.scala 133:56]
          CsrPlugin_mstatus_MPIE <= CsrPlugin_csrMapping_writeDataSignal[7]; // @[Bool.scala 189:10]
          CsrPlugin_mstatus_MIE <= CsrPlugin_csrMapping_writeDataSignal[3]; // @[Bool.scala 189:10]
          case(switch_CsrPlugin_l980)
            2'b11 : begin
              CsrPlugin_mstatus_MPP <= 2'b11; // @[CsrPlugin.scala 981:30]
            end
            default : begin
            end
          endcase
        end
      end
      if(execute_CsrPlugin_csr_772) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_mie_MEIE <= CsrPlugin_csrMapping_writeDataSignal[11]; // @[Bool.scala 189:10]
          CsrPlugin_mie_MTIE <= CsrPlugin_csrMapping_writeDataSignal[7]; // @[Bool.scala 189:10]
          CsrPlugin_mie_MSIE <= CsrPlugin_csrMapping_writeDataSignal[3]; // @[Bool.scala 189:10]
        end
      end
    end
  end

  always @(posedge clk) begin
    if(IBusCachedPlugin_iBusRsp_stages_1_output_ready) begin
      _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_payload <= IBusCachedPlugin_iBusRsp_stages_1_output_payload; // @[Misc.scala 155:15]
    end
    if(IBusCachedPlugin_iBusRsp_stages_1_input_ready) begin
      IBusCachedPlugin_s1_tightlyCoupledHit <= IBusCachedPlugin_s0_tightlyCoupledHit; // @[IBusCachedPlugin.scala 181:44]
    end
    if(IBusCachedPlugin_iBusRsp_stages_2_input_ready) begin
      IBusCachedPlugin_s2_tightlyCoupledHit <= IBusCachedPlugin_s1_tightlyCoupledHit; // @[IBusCachedPlugin.scala 207:44]
    end
    HazardSimplePlugin_writeBackBuffer_payload_address <= HazardSimplePlugin_writeBackWrites_payload_address; // @[Reg.scala 39:30]
    HazardSimplePlugin_writeBackBuffer_payload_data <= HazardSimplePlugin_writeBackWrites_payload_data; // @[Reg.scala 39:30]
    if(writeBack_FpuPlugin_commit_ready) begin
      writeBack_FpuPlugin_commit_rData_opcode <= writeBack_FpuPlugin_commit_payload_opcode; // @[Stream.scala 378:28]
      writeBack_FpuPlugin_commit_rData_rd <= writeBack_FpuPlugin_commit_payload_rd; // @[Stream.scala 378:28]
      writeBack_FpuPlugin_commit_rData_write <= writeBack_FpuPlugin_commit_payload_write; // @[Stream.scala 378:28]
      writeBack_FpuPlugin_commit_rData_value <= writeBack_FpuPlugin_commit_payload_value; // @[Stream.scala 378:28]
    end
    CsrPlugin_mip_MEIP <= externalInterrupt; // @[Reg.scala 39:30]
    CsrPlugin_mip_MTIP <= timerInterrupt; // @[Reg.scala 39:30]
    CsrPlugin_mip_MSIP <= softwareInterrupt; // @[Reg.scala 39:30]
    if(_zz_when) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 ? IBusCachedPlugin_decodeExceptionPort_payload_code : decodeExceptionPort_payload_code); // @[CsrPlugin.scala 1173:30]
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 ? IBusCachedPlugin_decodeExceptionPort_payload_badAddr : decodeExceptionPort_payload_badAddr); // @[CsrPlugin.scala 1173:30]
    end
    if(BranchPlugin_branchExceptionPort_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= BranchPlugin_branchExceptionPort_payload_code; // @[CsrPlugin.scala 1173:30]
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= BranchPlugin_branchExceptionPort_payload_badAddr; // @[CsrPlugin.scala 1173:30]
    end
    if(DBusCachedPlugin_exceptionBus_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= DBusCachedPlugin_exceptionBus_payload_code; // @[CsrPlugin.scala 1173:30]
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= DBusCachedPlugin_exceptionBus_payload_badAddr; // @[CsrPlugin.scala 1173:30]
    end
    if(when_CsrPlugin_l1216) begin
      if(when_CsrPlugin_l1222) begin
        CsrPlugin_interrupt_code <= 4'b0111; // @[CsrPlugin.scala 1224:22]
        CsrPlugin_interrupt_targetPrivilege <= 2'b11; // @[CsrPlugin.scala 1225:33]
      end
      if(when_CsrPlugin_l1222_1) begin
        CsrPlugin_interrupt_code <= 4'b0011; // @[CsrPlugin.scala 1224:22]
        CsrPlugin_interrupt_targetPrivilege <= 2'b11; // @[CsrPlugin.scala 1225:33]
      end
      if(when_CsrPlugin_l1222_2) begin
        CsrPlugin_interrupt_code <= 4'b1011; // @[CsrPlugin.scala 1224:22]
        CsrPlugin_interrupt_targetPrivilege <= 2'b11; // @[CsrPlugin.scala 1225:33]
      end
    end
    if(when_CsrPlugin_l1310) begin
      if(when_CsrPlugin_l1318) begin
        case(CsrPlugin_targetPrivilege)
          2'b11 : begin
            CsrPlugin_mcause_interrupt <= (! CsrPlugin_hadException); // @[CsrPlugin.scala 1337:32]
            CsrPlugin_mcause_exceptionCode <= CsrPlugin_trapCause; // @[CsrPlugin.scala 1338:36]
            CsrPlugin_mepc <= writeBack_PC; // @[CsrPlugin.scala 1339:20]
            if(CsrPlugin_hadException) begin
              CsrPlugin_mtval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr; // @[CsrPlugin.scala 1341:23]
            end
          end
          default : begin
          end
        endcase
      end
    end
    if(when_Pipeline_l124) begin
      decode_to_execute_PC <= decode_PC; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_1) begin
      execute_to_memory_PC <= _zz_execute_to_memory_PC; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_2) begin
      memory_to_writeBack_PC <= memory_PC; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_3) begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_4) begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_5) begin
      memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_6) begin
      decode_to_execute_FORMAL_PC_NEXT <= _zz_decode_to_execute_FORMAL_PC_NEXT; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_7) begin
      execute_to_memory_FORMAL_PC_NEXT <= _zz_execute_to_memory_FORMAL_PC_NEXT; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_8) begin
      memory_to_writeBack_FORMAL_PC_NEXT <= memory_FORMAL_PC_NEXT; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_9) begin
      decode_to_execute_MEMORY_FORCE_CONSTISTENCY <= decode_MEMORY_FORCE_CONSTISTENCY; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_10) begin
      decode_to_execute_SRC1_CTRL <= _zz_decode_to_execute_SRC1_CTRL; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_11) begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_12) begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_13) begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_14) begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_15) begin
      decode_to_execute_ALU_CTRL <= _zz_decode_to_execute_ALU_CTRL; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_16) begin
      decode_to_execute_SRC2_CTRL <= _zz_decode_to_execute_SRC2_CTRL; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_17) begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_18) begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_19) begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_20) begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_21) begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_22) begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_23) begin
      decode_to_execute_MEMORY_WR <= decode_MEMORY_WR; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_24) begin
      execute_to_memory_MEMORY_WR <= execute_MEMORY_WR; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_25) begin
      memory_to_writeBack_MEMORY_WR <= memory_MEMORY_WR; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_26) begin
      decode_to_execute_MEMORY_MANAGMENT <= decode_MEMORY_MANAGMENT; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_27) begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_28) begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_decode_to_execute_ALU_BITWISE_CTRL; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_29) begin
      decode_to_execute_SHIFT_CTRL <= _zz_decode_to_execute_SHIFT_CTRL; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_30) begin
      execute_to_memory_SHIFT_CTRL <= _zz_execute_to_memory_SHIFT_CTRL; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_31) begin
      decode_to_execute_FPU_ENABLE <= decode_FPU_ENABLE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_32) begin
      execute_to_memory_FPU_ENABLE <= execute_FPU_ENABLE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_33) begin
      memory_to_writeBack_FPU_ENABLE <= memory_FPU_ENABLE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_34) begin
      decode_to_execute_FPU_COMMIT <= decode_FPU_COMMIT; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_35) begin
      execute_to_memory_FPU_COMMIT <= execute_FPU_COMMIT; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_36) begin
      memory_to_writeBack_FPU_COMMIT <= memory_FPU_COMMIT; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_37) begin
      decode_to_execute_FPU_RSP <= decode_FPU_RSP; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_38) begin
      execute_to_memory_FPU_RSP <= execute_FPU_RSP; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_39) begin
      memory_to_writeBack_FPU_RSP <= memory_FPU_RSP; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_40) begin
      decode_to_execute_FPU_OPCODE <= _zz_decode_to_execute_FPU_OPCODE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_41) begin
      execute_to_memory_FPU_OPCODE <= _zz_execute_to_memory_FPU_OPCODE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_42) begin
      memory_to_writeBack_FPU_OPCODE <= _zz_memory_to_writeBack_FPU_OPCODE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_43) begin
      decode_to_execute_IS_CSR <= decode_IS_CSR; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_44) begin
      decode_to_execute_ENV_CTRL <= _zz_decode_to_execute_ENV_CTRL; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_45) begin
      execute_to_memory_ENV_CTRL <= _zz_execute_to_memory_ENV_CTRL; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_46) begin
      memory_to_writeBack_ENV_CTRL <= _zz_memory_to_writeBack_ENV_CTRL; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_47) begin
      decode_to_execute_BRANCH_CTRL <= _zz_decode_to_execute_BRANCH_CTRL; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_48) begin
      decode_to_execute_RS1 <= decode_RS1; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_49) begin
      execute_to_memory_RS1 <= _zz_execute_to_memory_RS1; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_50) begin
      memory_to_writeBack_RS1 <= memory_RS1; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_51) begin
      decode_to_execute_RS2 <= decode_RS2; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_52) begin
      decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_56) begin
      decode_to_execute_FPU_COMMIT_LOAD <= decode_FPU_COMMIT_LOAD; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_57) begin
      execute_to_memory_FPU_COMMIT_LOAD <= execute_FPU_COMMIT_LOAD; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_58) begin
      memory_to_writeBack_FPU_COMMIT_LOAD <= memory_FPU_COMMIT_LOAD; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_59) begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_60) begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_61) begin
      decode_to_execute_DO_EBREAK <= decode_DO_EBREAK; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_62) begin
      decode_to_execute_PREDICTION_HAD_BRANCHED2 <= decode_PREDICTION_HAD_BRANCHED2; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_63) begin
      execute_to_memory_MEMORY_STORE_DATA_RF <= execute_MEMORY_STORE_DATA_RF; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_64) begin
      memory_to_writeBack_MEMORY_STORE_DATA_RF <= memory_MEMORY_STORE_DATA_RF; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_65) begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_decode_RS2; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_66) begin
      memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_decode_RS2_1; // @[Pipeline.scala 124:40]
    end
    if(when_Pipeline_l124_67) begin
      execute_to_memory_SHIFT_RIGHT <= execute_SHIFT_RIGHT; // @[Pipeline.scala 124:40]
    end
    if(when_CsrPlugin_l1589) begin
      execute_CsrPlugin_csr_3 <= (decode_INSTRUCTION[31 : 20] == 12'h003); // @[CsrPlugin.scala 1589:101]
    end
    if(when_CsrPlugin_l1589_1) begin
      execute_CsrPlugin_csr_2 <= (decode_INSTRUCTION[31 : 20] == 12'h002); // @[CsrPlugin.scala 1589:101]
    end
    if(when_CsrPlugin_l1589_2) begin
      execute_CsrPlugin_csr_1 <= (decode_INSTRUCTION[31 : 20] == 12'h001); // @[CsrPlugin.scala 1589:101]
    end
    if(when_CsrPlugin_l1589_3) begin
      execute_CsrPlugin_csr_256 <= (decode_INSTRUCTION[31 : 20] == 12'h100); // @[CsrPlugin.scala 1589:101]
    end
    if(when_CsrPlugin_l1589_4) begin
      execute_CsrPlugin_csr_768 <= (decode_INSTRUCTION[31 : 20] == 12'h300); // @[CsrPlugin.scala 1589:101]
    end
    if(when_CsrPlugin_l1589_5) begin
      execute_CsrPlugin_csr_836 <= (decode_INSTRUCTION[31 : 20] == 12'h344); // @[CsrPlugin.scala 1589:101]
    end
    if(when_CsrPlugin_l1589_6) begin
      execute_CsrPlugin_csr_772 <= (decode_INSTRUCTION[31 : 20] == 12'h304); // @[CsrPlugin.scala 1589:101]
    end
    if(when_CsrPlugin_l1589_7) begin
      execute_CsrPlugin_csr_833 <= (decode_INSTRUCTION[31 : 20] == 12'h341); // @[CsrPlugin.scala 1589:101]
    end
    if(when_CsrPlugin_l1589_8) begin
      execute_CsrPlugin_csr_834 <= (decode_INSTRUCTION[31 : 20] == 12'h342); // @[CsrPlugin.scala 1589:101]
    end
    if(when_CsrPlugin_l1589_9) begin
      execute_CsrPlugin_csr_835 <= (decode_INSTRUCTION[31 : 20] == 12'h343); // @[CsrPlugin.scala 1589:101]
    end
    if(execute_CsrPlugin_csr_836) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mip_MSIP <= CsrPlugin_csrMapping_writeDataSignal[3]; // @[Bool.scala 189:10]
      end
    end
    if(execute_CsrPlugin_csr_833) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mepc <= CsrPlugin_csrMapping_writeDataSignal[31 : 0]; // @[UInt.scala 381:56]
      end
    end
  end

  always @(posedge clk) begin
    DebugPlugin_firstCycle <= 1'b0; // @[Reg.scala 39:30]
    if(debug_bus_cmd_ready) begin
      DebugPlugin_firstCycle <= 1'b1; // @[DebugPlugin.scala 231:39]
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle; // @[Reg.scala 39:30]
    DebugPlugin_isPipBusy <= (({writeBack_arbitration_isValid,{memory_arbitration_isValid,{execute_arbitration_isValid,decode_arbitration_isValid}}} != 4'b0000) || IBusCachedPlugin_incomingInstruction); // @[Reg.scala 39:30]
    if(writeBack_arbitration_isValid) begin
      DebugPlugin_busReadDataReg <= _zz_decode_RS2_2; // @[DebugPlugin.scala 253:24]
    end
    _zz_when_DebugPlugin_l257 <= debug_bus_cmd_payload_address[2]; // @[Reg.scala 39:30]
    if(when_DebugPlugin_l308) begin
      DebugPlugin_busReadDataReg <= execute_PC; // @[DebugPlugin.scala 310:24]
    end
    DebugPlugin_resetIt_regNext <= DebugPlugin_resetIt; // @[Reg.scala 39:30]
  end

  always @(posedge clk or posedge debugReset) begin
    if(debugReset) begin
      DebugPlugin_resetIt <= 1'b0; // @[Data.scala 400:33]
      DebugPlugin_haltIt <= 1'b0; // @[Data.scala 400:33]
      DebugPlugin_stepIt <= 1'b0; // @[Data.scala 400:33]
      DebugPlugin_godmode <= 1'b0; // @[Data.scala 400:33]
      DebugPlugin_haltedByBreak <= 1'b0; // @[Data.scala 400:33]
      DebugPlugin_debugUsed <= 1'b0; // @[Data.scala 400:33]
      DebugPlugin_disableEbreak <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(when_DebugPlugin_l238) begin
        DebugPlugin_godmode <= 1'b1; // @[DebugPlugin.scala 238:36]
      end
      if(debug_bus_cmd_valid) begin
        DebugPlugin_debugUsed <= 1'b1; // @[DebugPlugin.scala 240:38]
      end
      if(debug_bus_cmd_valid) begin
        case(switch_DebugPlugin_l280)
          6'h0 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_stepIt <= debug_bus_cmd_payload_data[4]; // @[DebugPlugin.scala 283:22]
              if(when_DebugPlugin_l284) begin
                DebugPlugin_resetIt <= 1'b1; // @[DebugPlugin.scala 284:23]
              end
              if(when_DebugPlugin_l284_1) begin
                DebugPlugin_resetIt <= 1'b0; // @[DebugPlugin.scala 284:53]
              end
              if(when_DebugPlugin_l285) begin
                DebugPlugin_haltIt <= 1'b1; // @[DebugPlugin.scala 285:22]
              end
              if(when_DebugPlugin_l285_1) begin
                DebugPlugin_haltIt <= 1'b0; // @[DebugPlugin.scala 285:52]
              end
              if(when_DebugPlugin_l286) begin
                DebugPlugin_haltedByBreak <= 1'b0; // @[DebugPlugin.scala 286:29]
              end
              if(when_DebugPlugin_l287) begin
                DebugPlugin_godmode <= 1'b0; // @[DebugPlugin.scala 287:23]
              end
              if(when_DebugPlugin_l288) begin
                DebugPlugin_disableEbreak <= 1'b1; // @[DebugPlugin.scala 288:29]
              end
              if(when_DebugPlugin_l288_1) begin
                DebugPlugin_disableEbreak <= 1'b0; // @[DebugPlugin.scala 288:59]
              end
            end
          end
          default : begin
          end
        endcase
      end
      if(when_DebugPlugin_l308) begin
        if(when_DebugPlugin_l311) begin
          DebugPlugin_haltIt <= 1'b1; // @[DebugPlugin.scala 315:18]
          DebugPlugin_haltedByBreak <= 1'b1; // @[DebugPlugin.scala 316:25]
        end
      end
      if(when_DebugPlugin_l324) begin
        if(decode_arbitration_isValid) begin
          DebugPlugin_haltIt <= 1'b1; // @[DebugPlugin.scala 327:18]
        end
      end
    end
  end


endmodule

module FpuCore (
  input               io_port_0_cmd_valid,
  output              io_port_0_cmd_ready,
  input      [3:0]    io_port_0_cmd_payload_opcode,
  input      [1:0]    io_port_0_cmd_payload_arg,
  input      [4:0]    io_port_0_cmd_payload_rs1,
  input      [4:0]    io_port_0_cmd_payload_rs2,
  input      [4:0]    io_port_0_cmd_payload_rs3,
  input      [4:0]    io_port_0_cmd_payload_rd,
  input      [0:0]    io_port_0_cmd_payload_format,
  input      [2:0]    io_port_0_cmd_payload_roundMode,
  input               io_port_0_commit_valid,
  output              io_port_0_commit_ready,
  input      [3:0]    io_port_0_commit_payload_opcode,
  input      [4:0]    io_port_0_commit_payload_rd,
  input               io_port_0_commit_payload_write,
  input      [31:0]   io_port_0_commit_payload_value,
  output              io_port_0_rsp_valid,
  input               io_port_0_rsp_ready,
  output     [31:0]   io_port_0_rsp_payload_value,
  output              io_port_0_rsp_payload_NV,
  output              io_port_0_rsp_payload_NX,
  output              io_port_0_completion_valid,
  output              io_port_0_completion_payload_flags_NX,
  output              io_port_0_completion_payload_flags_UF,
  output              io_port_0_completion_payload_flags_OF,
  output              io_port_0_completion_payload_flags_DZ,
  output              io_port_0_completion_payload_flags_NV,
  output              io_port_0_completion_payload_written,
  input               clk,
  input               reset
);
  localparam FpuOpcode_LOAD = 4'd0;
  localparam FpuOpcode_STORE = 4'd1;
  localparam FpuOpcode_MUL = 4'd2;
  localparam FpuOpcode_ADD = 4'd3;
  localparam FpuOpcode_FMA = 4'd4;
  localparam FpuOpcode_I2F = 4'd5;
  localparam FpuOpcode_F2I = 4'd6;
  localparam FpuOpcode_CMP = 4'd7;
  localparam FpuOpcode_DIV = 4'd8;
  localparam FpuOpcode_SQRT = 4'd9;
  localparam FpuOpcode_MIN_MAX = 4'd10;
  localparam FpuOpcode_SGNJ = 4'd11;
  localparam FpuOpcode_FMV_X_W = 4'd12;
  localparam FpuOpcode_FMV_W_X = 4'd13;
  localparam FpuOpcode_FCLASS = 4'd14;
  localparam FpuOpcode_FCVT_X_X = 4'd15;
  localparam FpuFormat_FLOAT = 1'd0;
  localparam FpuFormat_DOUBLE = 1'd1;
  localparam FpuRoundMode_RNE = 3'd0;
  localparam FpuRoundMode_RTZ = 3'd1;
  localparam FpuRoundMode_RDN = 3'd2;
  localparam FpuRoundMode_RUP = 3'd3;
  localparam FpuRoundMode_RMM = 3'd4;

  wire                streamFork_1_io_outputs_1_ready;
  wire                div_divider_io_input_valid;
  wire       [23:0]   div_divider_io_input_payload_a;
  wire       [23:0]   div_divider_io_input_payload_b;
  wire                sqrt_sqrt_io_input_valid;
  wire       [24:0]   sqrt_sqrt_io_input_payload_a;
  reg        [33:0]   _zz_rf_ram_port0;
  reg        [33:0]   _zz_rf_ram_port1;
  reg        [33:0]   _zz_rf_ram_port2;
  wire       [0:0]    _zz_rf_scoreboards_0_target_port1;
  wire       [0:0]    _zz_rf_scoreboards_0_target_port2;
  wire       [0:0]    _zz_rf_scoreboards_0_target_port3;
  wire       [0:0]    _zz_rf_scoreboards_0_target_port4;
  wire       [0:0]    _zz_rf_scoreboards_0_hit_port1;
  wire       [0:0]    _zz_rf_scoreboards_0_hit_port2;
  wire       [0:0]    _zz_rf_scoreboards_0_hit_port3;
  wire       [0:0]    _zz_rf_scoreboards_0_hit_port4;
  wire       [0:0]    _zz_rf_scoreboards_0_hit_port5;
  wire       [0:0]    _zz_rf_scoreboards_0_writes_port1;
  wire                streamFork_1_io_input_ready;
  wire                streamFork_1_io_outputs_0_valid;
  wire       [3:0]    streamFork_1_io_outputs_0_payload_opcode;
  wire       [4:0]    streamFork_1_io_outputs_0_payload_rd;
  wire                streamFork_1_io_outputs_0_payload_write;
  wire       [31:0]   streamFork_1_io_outputs_0_payload_value;
  wire                streamFork_1_io_outputs_1_valid;
  wire       [3:0]    streamFork_1_io_outputs_1_payload_opcode;
  wire       [4:0]    streamFork_1_io_outputs_1_payload_rd;
  wire                streamFork_1_io_outputs_1_payload_write;
  wire       [31:0]   streamFork_1_io_outputs_1_payload_value;
  wire                cmdArbiter_arbiter_io_inputs_0_ready;
  wire                cmdArbiter_arbiter_io_output_valid;
  wire       [3:0]    cmdArbiter_arbiter_io_output_payload_opcode;
  wire       [1:0]    cmdArbiter_arbiter_io_output_payload_arg;
  wire       [4:0]    cmdArbiter_arbiter_io_output_payload_rs1;
  wire       [4:0]    cmdArbiter_arbiter_io_output_payload_rs2;
  wire       [4:0]    cmdArbiter_arbiter_io_output_payload_rs3;
  wire       [4:0]    cmdArbiter_arbiter_io_output_payload_rd;
  wire       [0:0]    cmdArbiter_arbiter_io_output_payload_format;
  wire       [2:0]    cmdArbiter_arbiter_io_output_payload_roundMode;
  wire       [0:0]    cmdArbiter_arbiter_io_chosenOH;
  wire                div_divider_io_input_ready;
  wire                div_divider_io_output_valid;
  wire       [26:0]   div_divider_io_output_payload_result;
  wire       [24:0]   div_divider_io_output_payload_remain;
  wire                sqrt_sqrt_io_input_ready;
  wire                sqrt_sqrt_io_output_valid;
  wire       [23:0]   sqrt_sqrt_io_output_payload_result;
  wire       [27:0]   sqrt_sqrt_io_output_payload_remain;
  wire                streamArbiter_2_io_inputs_0_ready;
  wire                streamArbiter_2_io_inputs_1_ready;
  wire                streamArbiter_2_io_inputs_2_ready;
  wire                streamArbiter_2_io_inputs_3_ready;
  wire                streamArbiter_2_io_inputs_4_ready;
  wire                streamArbiter_2_io_inputs_5_ready;
  wire                streamArbiter_2_io_output_valid;
  wire       [4:0]    streamArbiter_2_io_output_payload_rd;
  wire       [23:0]   streamArbiter_2_io_output_payload_value_mantissa;
  wire       [8:0]    streamArbiter_2_io_output_payload_value_exponent;
  wire                streamArbiter_2_io_output_payload_value_sign;
  wire                streamArbiter_2_io_output_payload_value_special;
  wire                streamArbiter_2_io_output_payload_scrap;
  wire       [2:0]    streamArbiter_2_io_output_payload_roundMode;
  wire                streamArbiter_2_io_output_payload_NV;
  wire                streamArbiter_2_io_output_payload_DZ;
  wire       [2:0]    streamArbiter_2_io_chosen;
  wire       [5:0]    streamArbiter_2_io_chosenOH;
  wire       [0:0]    _zz_rf_scoreboards_0_target_port;
  wire       [0:0]    _zz_rf_scoreboards_0_hit_port;
  wire       [3:0]    _zz_commitLogic_0_pending_counter;
  wire       [3:0]    _zz_commitLogic_0_pending_counter_1;
  wire       [0:0]    _zz_commitLogic_0_pending_counter_2;
  wire       [3:0]    _zz_commitLogic_0_pending_counter_3;
  wire       [0:0]    _zz_commitLogic_0_pending_counter_4;
  wire       [3:0]    _zz_commitLogic_0_add_counter;
  wire       [3:0]    _zz_commitLogic_0_add_counter_1;
  wire       [0:0]    _zz_commitLogic_0_add_counter_2;
  wire       [3:0]    _zz_commitLogic_0_add_counter_3;
  wire       [0:0]    _zz_commitLogic_0_add_counter_4;
  wire       [3:0]    _zz_commitLogic_0_mul_counter;
  wire       [3:0]    _zz_commitLogic_0_mul_counter_1;
  wire       [0:0]    _zz_commitLogic_0_mul_counter_2;
  wire       [3:0]    _zz_commitLogic_0_mul_counter_3;
  wire       [0:0]    _zz_commitLogic_0_mul_counter_4;
  wire       [3:0]    _zz_commitLogic_0_div_counter;
  wire       [3:0]    _zz_commitLogic_0_div_counter_1;
  wire       [0:0]    _zz_commitLogic_0_div_counter_2;
  wire       [3:0]    _zz_commitLogic_0_div_counter_3;
  wire       [0:0]    _zz_commitLogic_0_div_counter_4;
  wire       [3:0]    _zz_commitLogic_0_sqrt_counter;
  wire       [3:0]    _zz_commitLogic_0_sqrt_counter_1;
  wire       [0:0]    _zz_commitLogic_0_sqrt_counter_2;
  wire       [3:0]    _zz_commitLogic_0_sqrt_counter_3;
  wire       [0:0]    _zz_commitLogic_0_sqrt_counter_4;
  wire       [3:0]    _zz_commitLogic_0_short_counter;
  wire       [3:0]    _zz_commitLogic_0_short_counter_1;
  wire       [0:0]    _zz_commitLogic_0_short_counter_2;
  wire       [3:0]    _zz_commitLogic_0_short_counter_3;
  wire       [0:0]    _zz_commitLogic_0_short_counter_4;
  wire       [0:0]    _zz_rf_scoreboards_0_writes_port;
  wire       [3:0]    _zz_decode_shortPipHit;
  wire                _zz_decode_shortPipHit_1;
  wire       [0:0]    _zz_decode_shortPipHit_2;
  wire       [0:0]    _zz_decode_shortPipHit_3;
  wire       [0:0]    _zz_when;
  wire       [31:0]   _zz_load_s1_fsm_shift_input_1;
  wire       [31:0]   _zz_load_s1_fsm_shift_input_2;
  wire       [31:0]   _zz_load_s1_fsm_shift_input_3;
  wire       [31:0]   _zz_load_s1_fsm_shift_input_4;
  wire       [31:0]   _zz_load_s1_fsm_shift_input_5;
  wire       [31:0]   _zz_load_s0_output_rData_value_2;
  wire       [32:0]   _zz_load_s0_output_rData_value_3;
  wire       [32:0]   _zz_load_s0_output_rData_value_4;
  wire       [32:0]   _zz_load_s0_output_rData_value_5;
  wire       [0:0]    _zz_load_s0_output_rData_value_6;
  wire                _zz__zz_load_s1_fsm_shift_by;
  wire       [0:0]    _zz__zz_load_s1_fsm_shift_by_1;
  wire       [20:0]   _zz__zz_load_s1_fsm_shift_by_2;
  wire                _zz__zz_load_s1_fsm_shift_by_3;
  wire       [0:0]    _zz__zz_load_s1_fsm_shift_by_4;
  wire       [9:0]    _zz__zz_load_s1_fsm_shift_by_5;
  wire       [31:0]   _zz__zz_load_s1_fsm_shift_by_1_1;
  wire       [9:0]    _zz_load_s1_recoded_exponent;
  wire       [9:0]    _zz_load_s1_recoded_exponent_1;
  wire       [9:0]    _zz_load_s1_recoded_exponent_2;
  wire       [8:0]    _zz_load_s1_output_payload_value_exponent;
  wire       [8:0]    _zz_shortPip_f32_exp;
  wire       [8:0]    _zz_shortPip_expInSubnormalRange;
  wire       [32:0]   _zz_shortPip_fsm_shift_input_1;
  wire       [32:0]   _zz_shortPip_fsm_shift_input_2;
  wire       [32:0]   _zz_shortPip_fsm_shift_input_3;
  wire       [32:0]   _zz_shortPip_fsm_shift_input_4;
  wire       [32:0]   _zz_shortPip_fsm_shift_input_5;
  wire       [32:0]   _zz_shortPip_fsm_shift_input_6;
  wire       [8:0]    _zz_shortPip_fsm_shift_by_2;
  wire       [8:0]    _zz_shortPip_fsm_shift_by_3;
  wire       [8:0]    _zz_shortPip_fsm_shift_by_4;
  wire       [8:0]    _zz_shortPip_fsm_shift_by_5;
  wire       [8:0]    _zz_shortPip_fsm_shift_by_6;
  wire       [31:0]   _zz_shortPip_f2i_result;
  wire       [0:0]    _zz_shortPip_f2i_result_1;
  wire       [47:0]   _zz_mul_sum1_sum;
  wire       [47:0]   _zz_mul_sum1_sum_1;
  wire       [41:0]   _zz_mul_sum1_sum_2;
  wire       [47:0]   _zz_mul_sum2_sum;
  wire       [47:0]   _zz_mul_sum2_sum_1;
  wire       [41:0]   _zz_mul_sum2_sum_2;
  wire       [47:0]   _zz_mul_sum2_sum_3;
  wire       [47:0]   _zz_mul_sum2_sum_4;
  wire       [9:0]    _zz_mul_norm_exp;
  wire       [0:0]    _zz_mul_norm_exp_1;
  wire       [9:0]    _zz_mul_norm_forceUnderflow;
  wire       [9:0]    _zz_mul_norm_output_exponent;
  wire       [10:0]   _zz_div_exponent;
  wire       [10:0]   _zz_div_exponent_1;
  wire       [10:0]   _zz_div_exponent_2;
  wire       [10:0]   _zz_div_exponent_3;
  wire       [10:0]   _zz_div_exponent_4;
  wire       [0:0]    _zz_div_exponent_5;
  wire       [8:0]    _zz_sqrt_exponent;
  wire       [8:0]    _zz_sqrt_exponent_1;
  wire       [7:0]    _zz_sqrt_exponent_2;
  wire       [7:0]    _zz_sqrt_exponent_3;
  wire       [8:0]    _zz_sqrt_exponent_4;
  wire       [0:0]    _zz_sqrt_exponent_5;
  wire       [9:0]    _zz_add_shifter_shiftBy_1;
  wire       [9:0]    _zz_add_shifter_shiftBy_2;
  wire       [9:0]    _zz_add_shifter_shiftBy_3;
  wire       [0:0]    _zz_add_shifter_shiftBy_4;
  wire       [25:0]   _zz_add_shifter_yMantissa_1;
  wire       [25:0]   _zz_add_shifter_yMantissa_2;
  wire       [25:0]   _zz_add_shifter_yMantissa_3;
  wire       [25:0]   _zz_add_shifter_yMantissa_4;
  wire       [25:0]   _zz_add_shifter_yMantissa_5;
  wire       [26:0]   _zz_add_math_xSigned;
  wire       [26:0]   _zz_add_math_xSigned_1;
  wire       [0:0]    _zz_add_math_xSigned_2;
  wire       [26:0]   _zz_add_math_ySigned;
  wire       [26:0]   _zz_add_math_ySigned_1;
  wire       [0:0]    _zz_add_math_ySigned_2;
  wire       [27:0]   _zz_add_math_output_payload_xyMantissa;
  wire       [27:0]   _zz_add_math_output_payload_xyMantissa_1;
  wire       [27:0]   _zz_add_math_output_payload_xyMantissa_2;
  wire       [27:0]   _zz_add_math_output_payload_xyMantissa_3;
  wire                _zz__zz_add_oh_shift;
  wire       [0:0]    _zz__zz_add_oh_shift_1;
  wire       [15:0]   _zz__zz_add_oh_shift_2;
  wire                _zz__zz_add_oh_shift_3;
  wire       [0:0]    _zz__zz_add_oh_shift_4;
  wire       [4:0]    _zz__zz_add_oh_shift_5;
  wire       [26:0]   _zz__zz_add_oh_shift_1_1;
  wire       [9:0]    _zz_add_norm_output_payload_exponent;
  wire       [9:0]    _zz_add_norm_output_payload_exponent_1;
  wire       [5:0]    _zz_add_norm_output_payload_exponent_2;
  wire       [24:0]   _zz_add_result_output_payload_value_mantissa;
  wire       [9:0]    _zz_roundFront_expDif;
  wire       [8:0]    _zz_roundFront_expDif_1;
  wire       [4:0]    _zz_roundFront_discardCount;
  wire       [4:0]    _zz_roundFront_exactMask;
  wire                _zz_roundFront_exactMask_1;
  wire       [0:0]    _zz_roundFront_exactMask_2;
  wire       [17:0]   _zz_roundFront_exactMask_3;
  wire       [4:0]    _zz_roundFront_exactMask_4;
  wire                _zz_roundFront_exactMask_5;
  wire       [0:0]    _zz_roundFront_exactMask_6;
  wire       [9:0]    _zz_roundFront_exactMask_7;
  wire       [4:0]    _zz_roundFront_exactMask_8;
  wire                _zz_roundFront_exactMask_9;
  wire       [0:0]    _zz_roundFront_exactMask_10;
  wire       [1:0]    _zz_roundFront_exactMask_11;
  wire       [24:0]   _zz_roundFront_roundAdjusted;
  wire       [23:0]   _zz_roundFront_roundAdjusted_1;
  wire       [24:0]   _zz__zz_roundFront_mantissaIncrement;
  wire       [22:0]   _zz__zz_roundFront_mantissaIncrement_1;
  wire       [22:0]   _zz_roundBack_adderMantissa;
  wire       [23:0]   _zz_roundBack_adderRightOp;
  wire       [23:0]   _zz_roundBack_adderRightOp_1;
  wire       [31:0]   _zz_roundBack_adder_2;
  wire       [31:0]   _zz_roundBack_adder_3;
  wire       [31:0]   _zz_roundBack_adder_4;
  wire       [8:0]    _zz_roundBack_borringCase;
  wire       [8:0]    _zz_when_FpuCore_l1608;
  wire       [8:0]    _zz_when_FpuCore_l1630;
  wire       [33:0]   _zz_rf_ram_port;
  reg                 _zz_1;
  reg        [25:0]   add_shifter_yMantissa_5;
  reg        [25:0]   add_shifter_yMantissa_4;
  reg        [25:0]   add_shifter_yMantissa_3;
  reg        [25:0]   add_shifter_yMantissa_2;
  reg        [25:0]   add_shifter_yMantissa_1;
  reg        [32:0]   shortPip_fsm_shift_input_6;
  reg        [32:0]   shortPip_fsm_shift_input_5;
  reg        [32:0]   shortPip_fsm_shift_input_4;
  reg        [32:0]   shortPip_fsm_shift_input_3;
  reg        [32:0]   shortPip_fsm_shift_input_2;
  reg        [32:0]   shortPip_fsm_shift_input_1;
  reg        [31:0]   load_s1_fsm_shift_input_5;
  reg        [31:0]   load_s1_fsm_shift_input_4;
  reg        [31:0]   load_s1_fsm_shift_input_3;
  reg        [31:0]   load_s1_fsm_shift_input_2;
  reg        [31:0]   load_s1_fsm_shift_input_1;
  reg                 _zz_2;
  reg                 _zz_3;
  reg                 _zz_4;
  reg        [5:0]    rf_init_counter;
  wire                rf_init_done;
  wire                when_FpuCore_l163;
  reg                 rf_scoreboards_0_targetWrite_valid;
  reg        [4:0]    rf_scoreboards_0_targetWrite_payload_address;
  reg                 rf_scoreboards_0_targetWrite_payload_data;
  reg                 rf_scoreboards_0_hitWrite_valid;
  reg        [4:0]    rf_scoreboards_0_hitWrite_payload_address;
  reg                 rf_scoreboards_0_hitWrite_payload_data;
  wire                commitFork_load_0_valid;
  reg                 commitFork_load_0_ready;
  wire       [3:0]    commitFork_load_0_payload_opcode;
  wire       [4:0]    commitFork_load_0_payload_rd;
  wire                commitFork_load_0_payload_write;
  wire       [31:0]   commitFork_load_0_payload_value;
  wire                commitFork_commit_0_valid;
  wire                commitFork_commit_0_ready;
  wire       [3:0]    commitFork_commit_0_payload_opcode;
  wire       [4:0]    commitFork_commit_0_payload_rd;
  wire                commitFork_commit_0_payload_write;
  wire       [31:0]   commitFork_commit_0_payload_value;
  wire                FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_valid;
  wire                FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_ready;
  wire       [3:0]    FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode;
  wire       [4:0]    FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_rd;
  wire                FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_write;
  wire       [31:0]   FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_value;
  reg                 FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid;
  reg        [3:0]    FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode;
  reg        [4:0]    FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_rd;
  reg                 FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_write;
  reg        [31:0]   FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_value;
  wire       [3:0]    _zz_payload_opcode;
  reg        [3:0]    commitLogic_0_pending_counter;
  wire                commitLogic_0_pending_full;
  wire                commitLogic_0_pending_notEmpty;
  reg                 commitLogic_0_pending_inc;
  reg                 commitLogic_0_pending_dec;
  reg        [3:0]    commitLogic_0_add_counter;
  wire                commitLogic_0_add_full;
  wire                commitLogic_0_add_notEmpty;
  reg                 commitLogic_0_add_inc;
  reg                 commitLogic_0_add_dec;
  reg        [3:0]    commitLogic_0_mul_counter;
  wire                commitLogic_0_mul_full;
  wire                commitLogic_0_mul_notEmpty;
  reg                 commitLogic_0_mul_inc;
  reg                 commitLogic_0_mul_dec;
  reg        [3:0]    commitLogic_0_div_counter;
  wire                commitLogic_0_div_full;
  wire                commitLogic_0_div_notEmpty;
  reg                 commitLogic_0_div_inc;
  reg                 commitLogic_0_div_dec;
  reg        [3:0]    commitLogic_0_sqrt_counter;
  wire                commitLogic_0_sqrt_full;
  wire                commitLogic_0_sqrt_notEmpty;
  reg                 commitLogic_0_sqrt_inc;
  reg                 commitLogic_0_sqrt_dec;
  reg        [3:0]    commitLogic_0_short_counter;
  wire                commitLogic_0_short_full;
  wire                commitLogic_0_short_notEmpty;
  reg                 commitLogic_0_short_inc;
  reg                 commitLogic_0_short_dec;
  wire                _zz_commitFork_commit_0_ready;
  wire       [3:0]    _zz_commitLogic_0_input_payload_opcode;
  wire                commitLogic_0_input_valid;
  wire       [3:0]    commitLogic_0_input_payload_opcode;
  wire       [4:0]    commitLogic_0_input_payload_rd;
  wire                commitLogic_0_input_payload_write;
  wire       [31:0]   commitLogic_0_input_payload_value;
  wire                when_FpuCore_l208;
  wire                when_FpuCore_l209;
  wire                when_FpuCore_l210;
  wire                when_FpuCore_l211;
  wire                when_FpuCore_l212;
  wire                scheduler_0_input_valid;
  wire                scheduler_0_input_ready;
  wire       [3:0]    scheduler_0_input_payload_opcode;
  wire       [1:0]    scheduler_0_input_payload_arg;
  wire       [4:0]    scheduler_0_input_payload_rs1;
  wire       [4:0]    scheduler_0_input_payload_rs2;
  wire       [4:0]    scheduler_0_input_payload_rs3;
  wire       [4:0]    scheduler_0_input_payload_rd;
  wire       [0:0]    scheduler_0_input_payload_format;
  wire       [2:0]    scheduler_0_input_payload_roundMode;
  reg                 io_port_0_cmd_rValid;
  reg        [3:0]    io_port_0_cmd_rData_opcode;
  reg        [1:0]    io_port_0_cmd_rData_arg;
  reg        [4:0]    io_port_0_cmd_rData_rs1;
  reg        [4:0]    io_port_0_cmd_rData_rs2;
  reg        [4:0]    io_port_0_cmd_rData_rs3;
  reg        [4:0]    io_port_0_cmd_rData_rd;
  reg        [0:0]    io_port_0_cmd_rData_format;
  reg        [2:0]    io_port_0_cmd_rData_roundMode;
  wire       [3:0]    _zz_scheduler_0_input_payload_opcode;
  wire       [0:0]    _zz_scheduler_0_input_payload_format;
  wire       [2:0]    _zz_scheduler_0_input_payload_roundMode;
  reg                 scheduler_0_useRs1;
  reg                 scheduler_0_useRs2;
  reg                 scheduler_0_useRs3;
  reg                 scheduler_0_useRd;
  wire                scheduler_0_rfHits_0;
  wire                scheduler_0_rfHits_1;
  wire                scheduler_0_rfHits_2;
  wire                scheduler_0_rfHits_3;
  wire                scheduler_0_rfTargets_0;
  wire                scheduler_0_rfTargets_1;
  wire                scheduler_0_rfTargets_2;
  wire                scheduler_0_rfTargets_3;
  wire                scheduler_0_rfBusy_0;
  wire                scheduler_0_rfBusy_1;
  wire                scheduler_0_rfBusy_2;
  wire                scheduler_0_rfBusy_3;
  wire                scheduler_0_hits_0;
  wire                scheduler_0_hits_1;
  wire                scheduler_0_hits_2;
  wire                scheduler_0_hits_3;
  wire                scheduler_0_hazard;
  wire                _zz_scheduler_0_input_ready;
  wire                scheduler_0_output_valid;
  wire                scheduler_0_output_ready;
  wire       [3:0]    scheduler_0_output_payload_opcode;
  wire       [1:0]    scheduler_0_output_payload_arg;
  reg        [4:0]    scheduler_0_output_payload_rs1;
  wire       [4:0]    scheduler_0_output_payload_rs2;
  wire       [4:0]    scheduler_0_output_payload_rs3;
  wire       [4:0]    scheduler_0_output_payload_rd;
  wire       [0:0]    scheduler_0_output_payload_format;
  wire       [2:0]    scheduler_0_output_payload_roundMode;
  wire                when_FpuCore_l258;
  wire                when_FpuCore_l261;
  wire                scheduler_0_output_fire;
  wire                when_FpuCore_l265;
  wire       [3:0]    _zz_io_inputs_0_payload_opcode;
  wire       [0:0]    _zz_io_inputs_0_payload_format;
  wire       [2:0]    _zz_io_inputs_0_payload_roundMode;
  wire                cmdArbiter_output_valid;
  wire                cmdArbiter_output_ready;
  wire       [3:0]    cmdArbiter_output_payload_opcode;
  wire       [4:0]    cmdArbiter_output_payload_rs1;
  wire       [4:0]    cmdArbiter_output_payload_rs2;
  wire       [4:0]    cmdArbiter_output_payload_rs3;
  wire       [4:0]    cmdArbiter_output_payload_rd;
  wire       [1:0]    cmdArbiter_output_payload_arg;
  wire       [2:0]    cmdArbiter_output_payload_roundMode;
  wire                read_s0_valid;
  reg                 read_s0_ready;
  wire       [3:0]    read_s0_payload_opcode;
  wire       [4:0]    read_s0_payload_rs1;
  wire       [4:0]    read_s0_payload_rs2;
  wire       [4:0]    read_s0_payload_rs3;
  wire       [4:0]    read_s0_payload_rd;
  wire       [1:0]    read_s0_payload_arg;
  wire       [2:0]    read_s0_payload_roundMode;
  wire                read_s1_valid;
  wire                read_s1_ready;
  wire       [3:0]    read_s1_payload_opcode;
  wire       [4:0]    read_s1_payload_rs1;
  wire       [4:0]    read_s1_payload_rs2;
  wire       [4:0]    read_s1_payload_rs3;
  wire       [4:0]    read_s1_payload_rd;
  wire       [1:0]    read_s1_payload_arg;
  wire       [2:0]    read_s1_payload_roundMode;
  reg                 read_s0_rValid;
  reg        [3:0]    read_s0_rData_opcode;
  reg        [4:0]    read_s0_rData_rs1;
  reg        [4:0]    read_s0_rData_rs2;
  reg        [4:0]    read_s0_rData_rs3;
  reg        [4:0]    read_s0_rData_rd;
  reg        [1:0]    read_s0_rData_arg;
  reg        [2:0]    read_s0_rData_roundMode;
  wire                when_Stream_l368;
  wire                read_output_valid;
  wire                read_output_ready;
  wire       [3:0]    read_output_payload_opcode;
  wire       [22:0]   read_output_payload_rs1_mantissa;
  wire       [8:0]    read_output_payload_rs1_exponent;
  wire                read_output_payload_rs1_sign;
  wire                read_output_payload_rs1_special;
  wire       [22:0]   read_output_payload_rs2_mantissa;
  wire       [8:0]    read_output_payload_rs2_exponent;
  wire                read_output_payload_rs2_sign;
  wire                read_output_payload_rs2_special;
  wire       [22:0]   read_output_payload_rs3_mantissa;
  wire       [8:0]    read_output_payload_rs3_exponent;
  wire                read_output_payload_rs3_sign;
  wire                read_output_payload_rs3_special;
  wire       [4:0]    read_output_payload_rd;
  wire       [1:0]    read_output_payload_arg;
  wire       [2:0]    read_output_payload_roundMode;
  wire       [4:0]    _zz_read_rs_0_value_mantissa;
  wire                read_output_isStall;
  wire                _zz_read_rs_0_value_mantissa_1;
  wire       [22:0]   read_rs_0_value_mantissa;
  wire       [8:0]    read_rs_0_value_exponent;
  wire                read_rs_0_value_sign;
  wire                read_rs_0_value_special;
  wire       [33:0]   _zz_read_rs_0_value_mantissa_2;
  wire       [4:0]    _zz_read_rs_1_value_mantissa;
  wire                read_output_isStall_1;
  wire                _zz_read_rs_1_value_mantissa_1;
  wire       [22:0]   read_rs_1_value_mantissa;
  wire       [8:0]    read_rs_1_value_exponent;
  wire                read_rs_1_value_sign;
  wire                read_rs_1_value_special;
  wire       [33:0]   _zz_read_rs_1_value_mantissa_2;
  wire       [4:0]    _zz_read_rs_2_value_mantissa;
  wire                read_output_isStall_2;
  wire                _zz_read_rs_2_value_mantissa_1;
  wire       [22:0]   read_rs_2_value_mantissa;
  wire       [8:0]    read_rs_2_value_exponent;
  wire                read_rs_2_value_sign;
  wire                read_rs_2_value_special;
  wire       [33:0]   _zz_read_rs_2_value_mantissa_2;
  wire                decode_input_valid;
  reg                 decode_input_ready;
  wire       [3:0]    decode_input_payload_opcode;
  wire       [22:0]   decode_input_payload_rs1_mantissa;
  wire       [8:0]    decode_input_payload_rs1_exponent;
  wire                decode_input_payload_rs1_sign;
  wire                decode_input_payload_rs1_special;
  wire       [22:0]   decode_input_payload_rs2_mantissa;
  wire       [8:0]    decode_input_payload_rs2_exponent;
  wire                decode_input_payload_rs2_sign;
  wire                decode_input_payload_rs2_special;
  wire       [22:0]   decode_input_payload_rs3_mantissa;
  wire       [8:0]    decode_input_payload_rs3_exponent;
  wire                decode_input_payload_rs3_sign;
  wire                decode_input_payload_rs3_special;
  wire       [4:0]    decode_input_payload_rd;
  wire       [1:0]    decode_input_payload_arg;
  wire       [2:0]    decode_input_payload_roundMode;
  wire                decode_loadHit;
  wire                decode_load_valid;
  wire                decode_load_ready;
  wire       [4:0]    decode_load_payload_rd;
  wire                decode_load_payload_i2f;
  wire       [1:0]    decode_load_payload_arg;
  wire       [2:0]    decode_load_payload_roundMode;
  wire                when_FpuCore_l329;
  wire                decode_shortPipHit;
  wire                decode_shortPip_valid;
  reg                 decode_shortPip_ready;
  wire       [3:0]    decode_shortPip_payload_opcode;
  wire       [22:0]   decode_shortPip_payload_rs1_mantissa;
  wire       [8:0]    decode_shortPip_payload_rs1_exponent;
  wire                decode_shortPip_payload_rs1_sign;
  wire                decode_shortPip_payload_rs1_special;
  wire       [22:0]   decode_shortPip_payload_rs2_mantissa;
  wire       [8:0]    decode_shortPip_payload_rs2_exponent;
  wire                decode_shortPip_payload_rs2_sign;
  wire                decode_shortPip_payload_rs2_special;
  wire       [4:0]    decode_shortPip_payload_rd;
  wire       [31:0]   decode_shortPip_payload_value;
  wire       [1:0]    decode_shortPip_payload_arg;
  wire       [2:0]    decode_shortPip_payload_roundMode;
  wire                when_FpuCore_l335;
  wire                decode_divSqrtHit;
  wire                decode_divSqrt_valid;
  wire                decode_divSqrt_ready;
  wire       [22:0]   decode_divSqrt_payload_rs1_mantissa;
  wire       [8:0]    decode_divSqrt_payload_rs1_exponent;
  wire                decode_divSqrt_payload_rs1_sign;
  wire                decode_divSqrt_payload_rs1_special;
  wire       [22:0]   decode_divSqrt_payload_rs2_mantissa;
  wire       [8:0]    decode_divSqrt_payload_rs2_exponent;
  wire                decode_divSqrt_payload_rs2_sign;
  wire                decode_divSqrt_payload_rs2_special;
  wire       [4:0]    decode_divSqrt_payload_rd;
  wire                decode_divSqrt_payload_div;
  wire       [2:0]    decode_divSqrt_payload_roundMode;
  wire                decode_divHit;
  wire                decode_div_valid;
  wire                decode_div_ready;
  wire       [22:0]   decode_div_payload_rs1_mantissa;
  wire       [8:0]    decode_div_payload_rs1_exponent;
  wire                decode_div_payload_rs1_sign;
  wire                decode_div_payload_rs1_special;
  wire       [22:0]   decode_div_payload_rs2_mantissa;
  wire       [8:0]    decode_div_payload_rs2_exponent;
  wire                decode_div_payload_rs2_sign;
  wire                decode_div_payload_rs2_special;
  wire       [4:0]    decode_div_payload_rd;
  wire       [2:0]    decode_div_payload_roundMode;
  wire                when_FpuCore_l351;
  wire                decode_sqrtHit;
  wire                decode_sqrt_valid;
  wire                decode_sqrt_ready;
  wire       [22:0]   decode_sqrt_payload_rs1_mantissa;
  wire       [8:0]    decode_sqrt_payload_rs1_exponent;
  wire                decode_sqrt_payload_rs1_sign;
  wire                decode_sqrt_payload_rs1_special;
  wire       [4:0]    decode_sqrt_payload_rd;
  wire       [2:0]    decode_sqrt_payload_roundMode;
  wire                when_FpuCore_l359;
  wire                decode_fmaHit;
  wire                decode_mulHit;
  wire                decode_mul_valid;
  reg                 decode_mul_ready;
  reg        [22:0]   decode_mul_payload_rs1_mantissa;
  reg        [8:0]    decode_mul_payload_rs1_exponent;
  reg                 decode_mul_payload_rs1_sign;
  reg                 decode_mul_payload_rs1_special;
  reg        [22:0]   decode_mul_payload_rs2_mantissa;
  reg        [8:0]    decode_mul_payload_rs2_exponent;
  reg                 decode_mul_payload_rs2_sign;
  reg                 decode_mul_payload_rs2_special;
  reg        [22:0]   decode_mul_payload_rs3_mantissa;
  reg        [8:0]    decode_mul_payload_rs3_exponent;
  reg                 decode_mul_payload_rs3_sign;
  reg                 decode_mul_payload_rs3_special;
  reg        [4:0]    decode_mul_payload_rd;
  reg                 decode_mul_payload_add;
  reg                 decode_mul_payload_divSqrt;
  reg                 decode_mul_payload_msb1;
  reg                 decode_mul_payload_msb2;
  reg        [2:0]    decode_mul_payload_roundMode;
  wire                decode_divSqrtToMul_valid;
  wire                decode_divSqrtToMul_ready;
  wire       [22:0]   decode_divSqrtToMul_payload_rs1_mantissa;
  wire       [8:0]    decode_divSqrtToMul_payload_rs1_exponent;
  wire                decode_divSqrtToMul_payload_rs1_sign;
  wire                decode_divSqrtToMul_payload_rs1_special;
  wire       [22:0]   decode_divSqrtToMul_payload_rs2_mantissa;
  wire       [8:0]    decode_divSqrtToMul_payload_rs2_exponent;
  wire                decode_divSqrtToMul_payload_rs2_sign;
  wire                decode_divSqrtToMul_payload_rs2_special;
  wire       [22:0]   decode_divSqrtToMul_payload_rs3_mantissa;
  wire       [8:0]    decode_divSqrtToMul_payload_rs3_exponent;
  wire                decode_divSqrtToMul_payload_rs3_sign;
  wire                decode_divSqrtToMul_payload_rs3_special;
  wire       [4:0]    decode_divSqrtToMul_payload_rd;
  wire                decode_divSqrtToMul_payload_add;
  wire                decode_divSqrtToMul_payload_divSqrt;
  wire                decode_divSqrtToMul_payload_msb1;
  wire                decode_divSqrtToMul_payload_msb2;
  wire       [2:0]    decode_divSqrtToMul_payload_roundMode;
  wire                when_FpuCore_l375;
  wire                when_FpuCore_l380;
  wire                decode_addHit;
  wire                decode_add_valid;
  wire                decode_add_ready;
  reg        [24:0]   decode_add_payload_rs1_mantissa;
  reg        [8:0]    decode_add_payload_rs1_exponent;
  reg                 decode_add_payload_rs1_sign;
  reg                 decode_add_payload_rs1_special;
  reg        [24:0]   decode_add_payload_rs2_mantissa;
  reg        [8:0]    decode_add_payload_rs2_exponent;
  reg                 decode_add_payload_rs2_sign;
  reg                 decode_add_payload_rs2_special;
  reg        [4:0]    decode_add_payload_rd;
  reg        [2:0]    decode_add_payload_roundMode;
  reg                 decode_add_payload_needCommit;
  wire                decode_mulToAdd_valid;
  wire                decode_mulToAdd_ready;
  wire       [24:0]   decode_mulToAdd_payload_rs1_mantissa;
  wire       [8:0]    decode_mulToAdd_payload_rs1_exponent;
  wire                decode_mulToAdd_payload_rs1_sign;
  wire                decode_mulToAdd_payload_rs1_special;
  wire       [24:0]   decode_mulToAdd_payload_rs2_mantissa;
  wire       [8:0]    decode_mulToAdd_payload_rs2_exponent;
  wire                decode_mulToAdd_payload_rs2_sign;
  wire                decode_mulToAdd_payload_rs2_special;
  wire       [4:0]    decode_mulToAdd_payload_rd;
  wire       [2:0]    decode_mulToAdd_payload_roundMode;
  wire                decode_mulToAdd_payload_needCommit;
  wire                when_FpuCore_l399;
  wire                when_FpuCore_l404;
  wire                decode_load_s2mPipe_valid;
  reg                 decode_load_s2mPipe_ready;
  wire       [4:0]    decode_load_s2mPipe_payload_rd;
  wire                decode_load_s2mPipe_payload_i2f;
  wire       [1:0]    decode_load_s2mPipe_payload_arg;
  wire       [2:0]    decode_load_s2mPipe_payload_roundMode;
  reg                 decode_load_rValid;
  reg        [4:0]    decode_load_rData_rd;
  reg                 decode_load_rData_i2f;
  reg        [1:0]    decode_load_rData_arg;
  reg        [2:0]    decode_load_rData_roundMode;
  wire       [2:0]    _zz_decode_load_s2mPipe_payload_roundMode;
  wire                decode_load_s2mPipe_m2sPipe_valid;
  reg                 decode_load_s2mPipe_m2sPipe_ready;
  wire       [4:0]    decode_load_s2mPipe_m2sPipe_payload_rd;
  wire                decode_load_s2mPipe_m2sPipe_payload_i2f;
  wire       [1:0]    decode_load_s2mPipe_m2sPipe_payload_arg;
  wire       [2:0]    decode_load_s2mPipe_m2sPipe_payload_roundMode;
  reg                 decode_load_s2mPipe_rValid;
  reg        [4:0]    decode_load_s2mPipe_rData_rd;
  reg                 decode_load_s2mPipe_rData_i2f;
  reg        [1:0]    decode_load_s2mPipe_rData_arg;
  reg        [2:0]    decode_load_s2mPipe_rData_roundMode;
  wire                when_Stream_l368_1;
  wire                load_s0_input_valid;
  wire                load_s0_input_ready;
  wire       [4:0]    load_s0_input_payload_rd;
  wire                load_s0_input_payload_i2f;
  wire       [1:0]    load_s0_input_payload_arg;
  wire       [2:0]    load_s0_input_payload_roundMode;
  reg                 decode_load_s2mPipe_m2sPipe_rValid;
  reg        [4:0]    decode_load_s2mPipe_m2sPipe_rData_rd;
  reg                 decode_load_s2mPipe_m2sPipe_rData_i2f;
  reg        [1:0]    decode_load_s2mPipe_m2sPipe_rData_arg;
  reg        [2:0]    decode_load_s2mPipe_m2sPipe_rData_roundMode;
  wire                when_Stream_l368_2;
  wire                when_Stream_l438;
  reg                 load_s0_filtred_0_valid;
  reg                 load_s0_filtred_0_ready;
  wire       [3:0]    load_s0_filtred_0_payload_opcode;
  wire       [4:0]    load_s0_filtred_0_payload_rd;
  wire                load_s0_filtred_0_payload_write;
  wire       [31:0]   load_s0_filtred_0_payload_value;
  wire                load_s0_hazard;
  wire                _zz_load_s0_input_ready;
  wire                load_s0_output_valid;
  reg                 load_s0_output_ready;
  wire       [4:0]    load_s0_output_payload_rd;
  wire       [31:0]   load_s0_output_payload_value;
  wire                load_s0_output_payload_i2f;
  wire       [1:0]    load_s0_output_payload_arg;
  wire       [2:0]    load_s0_output_payload_roundMode;
  wire                load_s1_input_valid;
  wire                load_s1_input_ready;
  wire       [4:0]    load_s1_input_payload_rd;
  wire       [31:0]   load_s1_input_payload_value;
  wire                load_s1_input_payload_i2f;
  wire       [1:0]    load_s1_input_payload_arg;
  wire       [2:0]    load_s1_input_payload_roundMode;
  reg                 load_s0_output_rValid;
  reg        [4:0]    load_s0_output_rData_rd;
  reg        [31:0]   load_s0_output_rData_value;
  reg                 load_s0_output_rData_i2f;
  reg        [1:0]    load_s0_output_rData_arg;
  reg        [2:0]    load_s0_output_rData_roundMode;
  wire                when_Stream_l368_3;
  reg                 load_s1_busy;
  wire       [22:0]   load_s1_f32_mantissa;
  wire       [7:0]    load_s1_f32_exponent;
  wire                load_s1_f32_sign;
  wire       [8:0]    load_s1_recodedExpOffset;
  wire       [22:0]   load_s1_passThroughFloat_mantissa;
  wire       [8:0]    load_s1_passThroughFloat_exponent;
  wire                load_s1_passThroughFloat_sign;
  wire                load_s1_passThroughFloat_special;
  wire                load_s1_manZero;
  wire                load_s1_expZero;
  wire                load_s1_expOne;
  wire                load_s1_isZero;
  wire                load_s1_isSubnormal;
  wire                load_s1_isInfinity;
  wire                load_s1_isNan;
  reg                 load_s1_fsm_done;
  reg                 load_s1_fsm_boot;
  reg                 load_s1_fsm_patched;
  reg        [31:0]   load_s1_fsm_ohInput;
  wire                when_FpuCore_l508;
  reg                 load_s1_fsm_i2fZero;
  reg        [4:0]    load_s1_fsm_shift_by;
  reg        [31:0]   load_s1_fsm_shift_input;
  wire                when_FpuCore_l525;
  reg        [31:0]   load_s1_fsm_shift_output;
  wire                when_FpuCore_l529;
  wire                when_FpuCore_l532;
  wire       [31:0]   _zz_load_s0_output_rData_value;
  wire                _zz_load_s0_output_rData_value_1;
  wire       [31:0]   _zz_load_s1_fsm_shift_by;
  wire       [31:0]   _zz_load_s1_fsm_shift_by_1;
  wire                _zz_load_s1_fsm_shift_by_2;
  wire                _zz_load_s1_fsm_shift_by_3;
  wire                _zz_load_s1_fsm_shift_by_4;
  wire                _zz_load_s1_fsm_shift_by_5;
  wire                _zz_load_s1_fsm_shift_by_6;
  wire                _zz_load_s1_fsm_shift_by_7;
  wire                _zz_load_s1_fsm_shift_by_8;
  wire                _zz_load_s1_fsm_shift_by_9;
  wire                _zz_load_s1_fsm_shift_by_10;
  wire                _zz_load_s1_fsm_shift_by_11;
  wire                _zz_load_s1_fsm_shift_by_12;
  wire                _zz_load_s1_fsm_shift_by_13;
  wire                _zz_load_s1_fsm_shift_by_14;
  wire                _zz_load_s1_fsm_shift_by_15;
  wire                _zz_load_s1_fsm_shift_by_16;
  wire                _zz_load_s1_fsm_shift_by_17;
  wire                _zz_load_s1_fsm_shift_by_18;
  wire                _zz_load_s1_fsm_shift_by_19;
  wire                _zz_load_s1_fsm_shift_by_20;
  wire                _zz_load_s1_fsm_shift_by_21;
  wire                _zz_load_s1_fsm_shift_by_22;
  wire                _zz_load_s1_fsm_shift_by_23;
  wire                _zz_load_s1_fsm_shift_by_24;
  wire                _zz_load_s1_fsm_shift_by_25;
  wire                _zz_load_s1_fsm_shift_by_26;
  wire                _zz_load_s1_fsm_shift_by_27;
  wire                _zz_load_s1_fsm_shift_by_28;
  wire                _zz_load_s1_fsm_shift_by_29;
  wire                _zz_load_s1_fsm_shift_by_30;
  wire                _zz_load_s1_fsm_shift_by_31;
  wire                _zz_load_s1_fsm_shift_by_32;
  reg        [8:0]    load_s1_fsm_expOffset;
  wire                load_s1_input_isStall;
  wire                when_FpuCore_l551;
  wire       [23:0]   load_s1_i2fHigh;
  wire       [7:0]    load_s1_i2fLow;
  wire                load_s1_scrap;
  wire       [22:0]   load_s1_recoded_mantissa;
  reg        [8:0]    load_s1_recoded_exponent;
  wire                load_s1_recoded_sign;
  reg                 load_s1_recoded_special;
  wire                _zz_load_s1_input_ready;
  wire                load_s1_output_valid;
  reg                 load_s1_output_ready;
  wire       [4:0]    load_s1_output_payload_rd;
  reg        [23:0]   load_s1_output_payload_value_mantissa;
  reg        [8:0]    load_s1_output_payload_value_exponent;
  reg                 load_s1_output_payload_value_sign;
  reg                 load_s1_output_payload_value_special;
  reg                 load_s1_output_payload_scrap;
  wire       [2:0]    load_s1_output_payload_roundMode;
  wire                load_s1_output_payload_NV;
  wire                load_s1_output_payload_DZ;
  wire                when_FpuCore_l594;
  wire                shortPip_input_valid;
  wire                shortPip_input_ready;
  wire       [3:0]    shortPip_input_payload_opcode;
  wire       [22:0]   shortPip_input_payload_rs1_mantissa;
  wire       [8:0]    shortPip_input_payload_rs1_exponent;
  wire                shortPip_input_payload_rs1_sign;
  wire                shortPip_input_payload_rs1_special;
  wire       [22:0]   shortPip_input_payload_rs2_mantissa;
  wire       [8:0]    shortPip_input_payload_rs2_exponent;
  wire                shortPip_input_payload_rs2_sign;
  wire                shortPip_input_payload_rs2_special;
  wire       [4:0]    shortPip_input_payload_rd;
  wire       [31:0]   shortPip_input_payload_value;
  wire       [1:0]    shortPip_input_payload_arg;
  wire       [2:0]    shortPip_input_payload_roundMode;
  reg                 decode_shortPip_rValid;
  reg        [3:0]    decode_shortPip_rData_opcode;
  reg        [22:0]   decode_shortPip_rData_rs1_mantissa;
  reg        [8:0]    decode_shortPip_rData_rs1_exponent;
  reg                 decode_shortPip_rData_rs1_sign;
  reg                 decode_shortPip_rData_rs1_special;
  reg        [22:0]   decode_shortPip_rData_rs2_mantissa;
  reg        [8:0]    decode_shortPip_rData_rs2_exponent;
  reg                 decode_shortPip_rData_rs2_sign;
  reg                 decode_shortPip_rData_rs2_special;
  reg        [4:0]    decode_shortPip_rData_rd;
  reg        [31:0]   decode_shortPip_rData_value;
  reg        [1:0]    decode_shortPip_rData_arg;
  reg        [2:0]    decode_shortPip_rData_roundMode;
  wire                when_Stream_l368_4;
  wire                shortPip_toFpuRf;
  wire                shortPip_rfOutput_valid;
  wire                shortPip_rfOutput_ready;
  wire       [4:0]    shortPip_rfOutput_payload_rd;
  reg        [23:0]   shortPip_rfOutput_payload_value_mantissa;
  reg        [8:0]    shortPip_rfOutput_payload_value_exponent;
  reg                 shortPip_rfOutput_payload_value_sign;
  reg                 shortPip_rfOutput_payload_value_special;
  wire                shortPip_rfOutput_payload_scrap;
  wire       [2:0]    shortPip_rfOutput_payload_roundMode;
  wire                shortPip_rfOutput_payload_NV;
  wire                shortPip_rfOutput_payload_DZ;
  wire                shortPip_input_fire;
  wire                when_FpuCore_l221;
  wire                shortPip_isCommited;
  wire                _zz_shortPip_rfOutput_ready;
  wire                shortPip_output_valid;
  reg                 shortPip_output_ready;
  wire       [4:0]    shortPip_output_payload_rd;
  wire       [23:0]   shortPip_output_payload_value_mantissa;
  wire       [8:0]    shortPip_output_payload_value_exponent;
  wire                shortPip_output_payload_value_sign;
  wire                shortPip_output_payload_value_special;
  wire                shortPip_output_payload_scrap;
  wire       [2:0]    shortPip_output_payload_roundMode;
  wire                shortPip_output_payload_NV;
  wire                shortPip_output_payload_DZ;
  reg        [31:0]   shortPip_result;
  reg                 shortPip_halt;
  reg        [31:0]   shortPip_recodedResult;
  wire       [7:0]    shortPip_f32_exp;
  wire       [22:0]   shortPip_f32_man;
  wire       [7:0]    shortPip_expSubnormalThreshold;
  wire                shortPip_expInSubnormalRange;
  wire                shortPip_isSubnormal;
  wire                shortPip_isNormal;
  wire       [8:0]    shortPip_fsm_f2iShift;
  wire                shortPip_fsm_isF2i;
  wire                shortPip_fsm_needRecoding;
  reg                 shortPip_fsm_done;
  reg                 shortPip_fsm_boot;
  wire                shortPip_fsm_isZero;
  reg        [5:0]    shortPip_fsm_shift_by;
  reg        [32:0]   shortPip_fsm_shift_input;
  reg                 shortPip_fsm_shift_scrap;
  wire                when_FpuCore_l646;
  wire                when_FpuCore_l646_1;
  wire                when_FpuCore_l646_2;
  wire                when_FpuCore_l646_3;
  wire                when_FpuCore_l646_4;
  wire                when_FpuCore_l646_5;
  wire                when_FpuCore_l652;
  reg        [32:0]   shortPip_fsm_shift_output;
  wire       [7:0]    shortPip_fsm_formatShiftOffset;
  wire                when_FpuCore_l658;
  wire       [8:0]    _zz_shortPip_fsm_shift_by;
  wire       [5:0]    _zz_shortPip_fsm_shift_by_1;
  wire                shortPip_input_isStall;
  wire                when_FpuCore_l672;
  reg                 shortPip_mantissaForced;
  reg                 shortPip_exponentForced;
  reg                 shortPip_mantissaForcedValue;
  reg                 shortPip_exponentForcedValue;
  reg                 shortPip_cononicalForced;
  wire       [1:0]    switch_FpuCore_l686;
  wire                when_FpuCore_l702;
  reg                 shortPip_rspNv;
  reg                 shortPip_rspNx;
  wire       [31:0]   shortPip_f2i_unsigned;
  wire                shortPip_f2i_resign;
  wire       [1:0]    shortPip_f2i_round;
  reg                 shortPip_f2i_increment;
  reg        [31:0]   shortPip_f2i_result;
  wire                shortPip_f2i_overflow;
  wire                shortPip_f2i_underflow;
  wire                shortPip_f2i_isZero;
  wire                when_FpuCore_l767;
  wire                shortPip_bothZero;
  reg                 shortPip_rs1Equal;
  reg                 shortPip_rs1AbsSmaller;
  wire                when_FpuCore_l780;
  wire                when_FpuCore_l781;
  wire                when_FpuCore_l782;
  wire                when_FpuCore_l783;
  wire                when_FpuCore_l784;
  wire       [1:0]    switch_Misc_l226;
  reg                 shortPip_rs1Smaller;
  wire                shortPip_minMaxSelectRs2;
  wire                shortPip_minMaxSelectNanQuiet;
  reg        [0:0]    shortPip_cmpResult;
  wire                when_FpuCore_l796;
  wire                shortPip_sgnjRs1Sign;
  wire                shortPip_sgnjRs2Sign;
  wire                shortPip_sgnjResult;
  reg        [31:0]   shortPip_fclassResult;
  wire                shortPip_decoded_isNan;
  wire                shortPip_decoded_isNormal;
  wire                shortPip_decoded_isSubnormal;
  wire                shortPip_decoded_isZero;
  wire                shortPip_decoded_isInfinity;
  wire                shortPip_decoded_isQuiet;
  wire                when_FpuCore_l850;
  wire                shortPip_signalQuiet;
  wire                shortPip_rs1Nan;
  wire                shortPip_rs2Nan;
  wire                shortPip_rs1NanNv;
  wire                shortPip_rs2NanNv;
  wire                shortPip_NV;
  wire                shortPip_rspStreams_0_valid;
  reg                 shortPip_rspStreams_0_ready;
  wire       [31:0]   shortPip_rspStreams_0_payload_value;
  wire                shortPip_rspStreams_0_payload_NV;
  wire                shortPip_rspStreams_0_payload_NX;
  wire                shortPip_rspStreams_0_m2sPipe_valid;
  wire                shortPip_rspStreams_0_m2sPipe_ready;
  wire       [31:0]   shortPip_rspStreams_0_m2sPipe_payload_value;
  wire                shortPip_rspStreams_0_m2sPipe_payload_NV;
  wire                shortPip_rspStreams_0_m2sPipe_payload_NX;
  reg                 shortPip_rspStreams_0_rValid;
  reg        [31:0]   shortPip_rspStreams_0_rData_value;
  reg                 shortPip_rspStreams_0_rData_NV;
  reg                 shortPip_rspStreams_0_rData_NX;
  wire                when_Stream_l368_5;
  wire                mul_preMul_input_valid;
  wire                mul_preMul_input_ready;
  wire       [22:0]   mul_preMul_input_payload_rs1_mantissa;
  wire       [8:0]    mul_preMul_input_payload_rs1_exponent;
  wire                mul_preMul_input_payload_rs1_sign;
  wire                mul_preMul_input_payload_rs1_special;
  wire       [22:0]   mul_preMul_input_payload_rs2_mantissa;
  wire       [8:0]    mul_preMul_input_payload_rs2_exponent;
  wire                mul_preMul_input_payload_rs2_sign;
  wire                mul_preMul_input_payload_rs2_special;
  wire       [22:0]   mul_preMul_input_payload_rs3_mantissa;
  wire       [8:0]    mul_preMul_input_payload_rs3_exponent;
  wire                mul_preMul_input_payload_rs3_sign;
  wire                mul_preMul_input_payload_rs3_special;
  wire       [4:0]    mul_preMul_input_payload_rd;
  wire                mul_preMul_input_payload_add;
  wire                mul_preMul_input_payload_divSqrt;
  wire                mul_preMul_input_payload_msb1;
  wire                mul_preMul_input_payload_msb2;
  wire       [2:0]    mul_preMul_input_payload_roundMode;
  reg                 decode_mul_rValid;
  reg        [22:0]   decode_mul_rData_rs1_mantissa;
  reg        [8:0]    decode_mul_rData_rs1_exponent;
  reg                 decode_mul_rData_rs1_sign;
  reg                 decode_mul_rData_rs1_special;
  reg        [22:0]   decode_mul_rData_rs2_mantissa;
  reg        [8:0]    decode_mul_rData_rs2_exponent;
  reg                 decode_mul_rData_rs2_sign;
  reg                 decode_mul_rData_rs2_special;
  reg        [22:0]   decode_mul_rData_rs3_mantissa;
  reg        [8:0]    decode_mul_rData_rs3_exponent;
  reg                 decode_mul_rData_rs3_sign;
  reg                 decode_mul_rData_rs3_special;
  reg        [4:0]    decode_mul_rData_rd;
  reg                 decode_mul_rData_add;
  reg                 decode_mul_rData_divSqrt;
  reg                 decode_mul_rData_msb1;
  reg                 decode_mul_rData_msb2;
  reg        [2:0]    decode_mul_rData_roundMode;
  wire                when_Stream_l368_6;
  wire                mul_preMul_output_valid;
  reg                 mul_preMul_output_ready;
  wire       [22:0]   mul_preMul_output_payload_rs1_mantissa;
  wire       [8:0]    mul_preMul_output_payload_rs1_exponent;
  wire                mul_preMul_output_payload_rs1_sign;
  wire                mul_preMul_output_payload_rs1_special;
  wire       [22:0]   mul_preMul_output_payload_rs2_mantissa;
  wire       [8:0]    mul_preMul_output_payload_rs2_exponent;
  wire                mul_preMul_output_payload_rs2_sign;
  wire                mul_preMul_output_payload_rs2_special;
  wire       [22:0]   mul_preMul_output_payload_rs3_mantissa;
  wire       [8:0]    mul_preMul_output_payload_rs3_exponent;
  wire                mul_preMul_output_payload_rs3_sign;
  wire                mul_preMul_output_payload_rs3_special;
  wire       [4:0]    mul_preMul_output_payload_rd;
  wire                mul_preMul_output_payload_add;
  wire                mul_preMul_output_payload_divSqrt;
  wire                mul_preMul_output_payload_msb1;
  wire                mul_preMul_output_payload_msb2;
  wire       [2:0]    mul_preMul_output_payload_roundMode;
  wire       [9:0]    mul_preMul_output_payload_exp;
  wire                mul_mul_input_valid;
  wire                mul_mul_input_ready;
  wire       [22:0]   mul_mul_input_payload_rs1_mantissa;
  wire       [8:0]    mul_mul_input_payload_rs1_exponent;
  wire                mul_mul_input_payload_rs1_sign;
  wire                mul_mul_input_payload_rs1_special;
  wire       [22:0]   mul_mul_input_payload_rs2_mantissa;
  wire       [8:0]    mul_mul_input_payload_rs2_exponent;
  wire                mul_mul_input_payload_rs2_sign;
  wire                mul_mul_input_payload_rs2_special;
  wire       [22:0]   mul_mul_input_payload_rs3_mantissa;
  wire       [8:0]    mul_mul_input_payload_rs3_exponent;
  wire                mul_mul_input_payload_rs3_sign;
  wire                mul_mul_input_payload_rs3_special;
  wire       [4:0]    mul_mul_input_payload_rd;
  wire                mul_mul_input_payload_add;
  wire                mul_mul_input_payload_divSqrt;
  wire                mul_mul_input_payload_msb1;
  wire                mul_mul_input_payload_msb2;
  wire       [2:0]    mul_mul_input_payload_roundMode;
  wire       [9:0]    mul_mul_input_payload_exp;
  reg                 mul_preMul_output_rValid;
  reg        [22:0]   mul_preMul_output_rData_rs1_mantissa;
  reg        [8:0]    mul_preMul_output_rData_rs1_exponent;
  reg                 mul_preMul_output_rData_rs1_sign;
  reg                 mul_preMul_output_rData_rs1_special;
  reg        [22:0]   mul_preMul_output_rData_rs2_mantissa;
  reg        [8:0]    mul_preMul_output_rData_rs2_exponent;
  reg                 mul_preMul_output_rData_rs2_sign;
  reg                 mul_preMul_output_rData_rs2_special;
  reg        [22:0]   mul_preMul_output_rData_rs3_mantissa;
  reg        [8:0]    mul_preMul_output_rData_rs3_exponent;
  reg                 mul_preMul_output_rData_rs3_sign;
  reg                 mul_preMul_output_rData_rs3_special;
  reg        [4:0]    mul_preMul_output_rData_rd;
  reg                 mul_preMul_output_rData_add;
  reg                 mul_preMul_output_rData_divSqrt;
  reg                 mul_preMul_output_rData_msb1;
  reg                 mul_preMul_output_rData_msb2;
  reg        [2:0]    mul_preMul_output_rData_roundMode;
  reg        [9:0]    mul_preMul_output_rData_exp;
  wire                when_Stream_l368_7;
  wire                mul_mul_output_valid;
  reg                 mul_mul_output_ready;
  wire       [22:0]   mul_mul_output_payload_rs1_mantissa;
  wire       [8:0]    mul_mul_output_payload_rs1_exponent;
  wire                mul_mul_output_payload_rs1_sign;
  wire                mul_mul_output_payload_rs1_special;
  wire       [22:0]   mul_mul_output_payload_rs2_mantissa;
  wire       [8:0]    mul_mul_output_payload_rs2_exponent;
  wire                mul_mul_output_payload_rs2_sign;
  wire                mul_mul_output_payload_rs2_special;
  wire       [22:0]   mul_mul_output_payload_rs3_mantissa;
  wire       [8:0]    mul_mul_output_payload_rs3_exponent;
  wire                mul_mul_output_payload_rs3_sign;
  wire                mul_mul_output_payload_rs3_special;
  wire       [4:0]    mul_mul_output_payload_rd;
  wire                mul_mul_output_payload_add;
  wire                mul_mul_output_payload_divSqrt;
  wire                mul_mul_output_payload_msb1;
  wire                mul_mul_output_payload_msb2;
  wire       [2:0]    mul_mul_output_payload_roundMode;
  wire       [9:0]    mul_mul_output_payload_exp;
  wire       [35:0]   mul_mul_output_payload_muls_0;
  wire       [23:0]   mul_mul_output_payload_muls_1;
  wire       [23:0]   mul_mul_output_payload_muls_2;
  wire       [11:0]   mul_mul_output_payload_muls_3;
  wire       [23:0]   mul_mul_mulA;
  wire       [23:0]   mul_mul_mulB;
  wire                mul_sum1_input_valid;
  wire                mul_sum1_input_ready;
  wire       [22:0]   mul_sum1_input_payload_rs1_mantissa;
  wire       [8:0]    mul_sum1_input_payload_rs1_exponent;
  wire                mul_sum1_input_payload_rs1_sign;
  wire                mul_sum1_input_payload_rs1_special;
  wire       [22:0]   mul_sum1_input_payload_rs2_mantissa;
  wire       [8:0]    mul_sum1_input_payload_rs2_exponent;
  wire                mul_sum1_input_payload_rs2_sign;
  wire                mul_sum1_input_payload_rs2_special;
  wire       [22:0]   mul_sum1_input_payload_rs3_mantissa;
  wire       [8:0]    mul_sum1_input_payload_rs3_exponent;
  wire                mul_sum1_input_payload_rs3_sign;
  wire                mul_sum1_input_payload_rs3_special;
  wire       [4:0]    mul_sum1_input_payload_rd;
  wire                mul_sum1_input_payload_add;
  wire                mul_sum1_input_payload_divSqrt;
  wire                mul_sum1_input_payload_msb1;
  wire                mul_sum1_input_payload_msb2;
  wire       [2:0]    mul_sum1_input_payload_roundMode;
  wire       [9:0]    mul_sum1_input_payload_exp;
  wire       [35:0]   mul_sum1_input_payload_muls_0;
  wire       [23:0]   mul_sum1_input_payload_muls_1;
  wire       [23:0]   mul_sum1_input_payload_muls_2;
  wire       [11:0]   mul_sum1_input_payload_muls_3;
  reg                 mul_mul_output_rValid;
  reg        [22:0]   mul_mul_output_rData_rs1_mantissa;
  reg        [8:0]    mul_mul_output_rData_rs1_exponent;
  reg                 mul_mul_output_rData_rs1_sign;
  reg                 mul_mul_output_rData_rs1_special;
  reg        [22:0]   mul_mul_output_rData_rs2_mantissa;
  reg        [8:0]    mul_mul_output_rData_rs2_exponent;
  reg                 mul_mul_output_rData_rs2_sign;
  reg                 mul_mul_output_rData_rs2_special;
  reg        [22:0]   mul_mul_output_rData_rs3_mantissa;
  reg        [8:0]    mul_mul_output_rData_rs3_exponent;
  reg                 mul_mul_output_rData_rs3_sign;
  reg                 mul_mul_output_rData_rs3_special;
  reg        [4:0]    mul_mul_output_rData_rd;
  reg                 mul_mul_output_rData_add;
  reg                 mul_mul_output_rData_divSqrt;
  reg                 mul_mul_output_rData_msb1;
  reg                 mul_mul_output_rData_msb2;
  reg        [2:0]    mul_mul_output_rData_roundMode;
  reg        [9:0]    mul_mul_output_rData_exp;
  reg        [35:0]   mul_mul_output_rData_muls_0;
  reg        [23:0]   mul_mul_output_rData_muls_1;
  reg        [23:0]   mul_mul_output_rData_muls_2;
  reg        [11:0]   mul_mul_output_rData_muls_3;
  wire                when_Stream_l368_8;
  wire       [47:0]   mul_sum1_sum;
  wire                mul_sum1_output_valid;
  reg                 mul_sum1_output_ready;
  wire       [22:0]   mul_sum1_output_payload_rs1_mantissa;
  wire       [8:0]    mul_sum1_output_payload_rs1_exponent;
  wire                mul_sum1_output_payload_rs1_sign;
  wire                mul_sum1_output_payload_rs1_special;
  wire       [22:0]   mul_sum1_output_payload_rs2_mantissa;
  wire       [8:0]    mul_sum1_output_payload_rs2_exponent;
  wire                mul_sum1_output_payload_rs2_sign;
  wire                mul_sum1_output_payload_rs2_special;
  wire       [22:0]   mul_sum1_output_payload_rs3_mantissa;
  wire       [8:0]    mul_sum1_output_payload_rs3_exponent;
  wire                mul_sum1_output_payload_rs3_sign;
  wire                mul_sum1_output_payload_rs3_special;
  wire       [4:0]    mul_sum1_output_payload_rd;
  wire                mul_sum1_output_payload_add;
  wire                mul_sum1_output_payload_divSqrt;
  wire                mul_sum1_output_payload_msb1;
  wire                mul_sum1_output_payload_msb2;
  wire       [2:0]    mul_sum1_output_payload_roundMode;
  wire       [9:0]    mul_sum1_output_payload_exp;
  wire       [23:0]   mul_sum1_output_payload_muls2_0;
  wire       [11:0]   mul_sum1_output_payload_muls2_1;
  wire       [47:0]   mul_sum1_output_payload_mulC2;
  wire                mul_sum2_input_valid;
  wire                mul_sum2_input_ready;
  wire       [22:0]   mul_sum2_input_payload_rs1_mantissa;
  wire       [8:0]    mul_sum2_input_payload_rs1_exponent;
  wire                mul_sum2_input_payload_rs1_sign;
  wire                mul_sum2_input_payload_rs1_special;
  wire       [22:0]   mul_sum2_input_payload_rs2_mantissa;
  wire       [8:0]    mul_sum2_input_payload_rs2_exponent;
  wire                mul_sum2_input_payload_rs2_sign;
  wire                mul_sum2_input_payload_rs2_special;
  wire       [22:0]   mul_sum2_input_payload_rs3_mantissa;
  wire       [8:0]    mul_sum2_input_payload_rs3_exponent;
  wire                mul_sum2_input_payload_rs3_sign;
  wire                mul_sum2_input_payload_rs3_special;
  wire       [4:0]    mul_sum2_input_payload_rd;
  wire                mul_sum2_input_payload_add;
  wire                mul_sum2_input_payload_divSqrt;
  wire                mul_sum2_input_payload_msb1;
  wire                mul_sum2_input_payload_msb2;
  wire       [2:0]    mul_sum2_input_payload_roundMode;
  wire       [9:0]    mul_sum2_input_payload_exp;
  wire       [23:0]   mul_sum2_input_payload_muls2_0;
  wire       [11:0]   mul_sum2_input_payload_muls2_1;
  wire       [47:0]   mul_sum2_input_payload_mulC2;
  reg                 mul_sum1_output_rValid;
  reg        [22:0]   mul_sum1_output_rData_rs1_mantissa;
  reg        [8:0]    mul_sum1_output_rData_rs1_exponent;
  reg                 mul_sum1_output_rData_rs1_sign;
  reg                 mul_sum1_output_rData_rs1_special;
  reg        [22:0]   mul_sum1_output_rData_rs2_mantissa;
  reg        [8:0]    mul_sum1_output_rData_rs2_exponent;
  reg                 mul_sum1_output_rData_rs2_sign;
  reg                 mul_sum1_output_rData_rs2_special;
  reg        [22:0]   mul_sum1_output_rData_rs3_mantissa;
  reg        [8:0]    mul_sum1_output_rData_rs3_exponent;
  reg                 mul_sum1_output_rData_rs3_sign;
  reg                 mul_sum1_output_rData_rs3_special;
  reg        [4:0]    mul_sum1_output_rData_rd;
  reg                 mul_sum1_output_rData_add;
  reg                 mul_sum1_output_rData_divSqrt;
  reg                 mul_sum1_output_rData_msb1;
  reg                 mul_sum1_output_rData_msb2;
  reg        [2:0]    mul_sum1_output_rData_roundMode;
  reg        [9:0]    mul_sum1_output_rData_exp;
  reg        [23:0]   mul_sum1_output_rData_muls2_0;
  reg        [11:0]   mul_sum1_output_rData_muls2_1;
  reg        [47:0]   mul_sum1_output_rData_mulC2;
  wire                when_Stream_l368_9;
  wire       [47:0]   mul_sum2_sum;
  wire                mul_sum2_input_fire;
  wire                when_FpuCore_l221_1;
  wire                mul_sum2_isCommited;
  wire                _zz_mul_sum2_input_ready;
  wire                mul_sum2_output_valid;
  reg                 mul_sum2_output_ready;
  wire       [22:0]   mul_sum2_output_payload_rs1_mantissa;
  wire       [8:0]    mul_sum2_output_payload_rs1_exponent;
  wire                mul_sum2_output_payload_rs1_sign;
  wire                mul_sum2_output_payload_rs1_special;
  wire       [22:0]   mul_sum2_output_payload_rs2_mantissa;
  wire       [8:0]    mul_sum2_output_payload_rs2_exponent;
  wire                mul_sum2_output_payload_rs2_sign;
  wire                mul_sum2_output_payload_rs2_special;
  wire       [22:0]   mul_sum2_output_payload_rs3_mantissa;
  wire       [8:0]    mul_sum2_output_payload_rs3_exponent;
  wire                mul_sum2_output_payload_rs3_sign;
  wire                mul_sum2_output_payload_rs3_special;
  wire       [4:0]    mul_sum2_output_payload_rd;
  wire                mul_sum2_output_payload_add;
  wire                mul_sum2_output_payload_divSqrt;
  wire                mul_sum2_output_payload_msb1;
  wire                mul_sum2_output_payload_msb2;
  wire       [2:0]    mul_sum2_output_payload_roundMode;
  wire       [9:0]    mul_sum2_output_payload_exp;
  wire       [47:0]   mul_sum2_output_payload_mulC;
  wire                mul_norm_input_valid;
  wire                mul_norm_input_ready;
  wire       [22:0]   mul_norm_input_payload_rs1_mantissa;
  wire       [8:0]    mul_norm_input_payload_rs1_exponent;
  wire                mul_norm_input_payload_rs1_sign;
  wire                mul_norm_input_payload_rs1_special;
  wire       [22:0]   mul_norm_input_payload_rs2_mantissa;
  wire       [8:0]    mul_norm_input_payload_rs2_exponent;
  wire                mul_norm_input_payload_rs2_sign;
  wire                mul_norm_input_payload_rs2_special;
  wire       [22:0]   mul_norm_input_payload_rs3_mantissa;
  wire       [8:0]    mul_norm_input_payload_rs3_exponent;
  wire                mul_norm_input_payload_rs3_sign;
  wire                mul_norm_input_payload_rs3_special;
  wire       [4:0]    mul_norm_input_payload_rd;
  wire                mul_norm_input_payload_add;
  wire                mul_norm_input_payload_divSqrt;
  wire                mul_norm_input_payload_msb1;
  wire                mul_norm_input_payload_msb2;
  wire       [2:0]    mul_norm_input_payload_roundMode;
  wire       [9:0]    mul_norm_input_payload_exp;
  wire       [47:0]   mul_norm_input_payload_mulC;
  reg                 mul_sum2_output_rValid;
  reg        [22:0]   mul_sum2_output_rData_rs1_mantissa;
  reg        [8:0]    mul_sum2_output_rData_rs1_exponent;
  reg                 mul_sum2_output_rData_rs1_sign;
  reg                 mul_sum2_output_rData_rs1_special;
  reg        [22:0]   mul_sum2_output_rData_rs2_mantissa;
  reg        [8:0]    mul_sum2_output_rData_rs2_exponent;
  reg                 mul_sum2_output_rData_rs2_sign;
  reg                 mul_sum2_output_rData_rs2_special;
  reg        [22:0]   mul_sum2_output_rData_rs3_mantissa;
  reg        [8:0]    mul_sum2_output_rData_rs3_exponent;
  reg                 mul_sum2_output_rData_rs3_sign;
  reg                 mul_sum2_output_rData_rs3_special;
  reg        [4:0]    mul_sum2_output_rData_rd;
  reg                 mul_sum2_output_rData_add;
  reg                 mul_sum2_output_rData_divSqrt;
  reg                 mul_sum2_output_rData_msb1;
  reg                 mul_sum2_output_rData_msb2;
  reg        [2:0]    mul_sum2_output_rData_roundMode;
  reg        [9:0]    mul_sum2_output_rData_exp;
  reg        [47:0]   mul_sum2_output_rData_mulC;
  wire                when_Stream_l368_10;
  wire       [25:0]   mul_norm_mulHigh;
  wire       [21:0]   mul_norm_mulLow;
  reg                 mul_norm_scrap;
  wire                mul_norm_needShift;
  wire       [9:0]    mul_norm_exp;
  wire       [23:0]   mul_norm_man;
  wire                when_FpuCore_l967;
  wire                mul_norm_forceZero;
  wire       [8:0]    mul_norm_underflowThreshold;
  wire       [6:0]    mul_norm_underflowExp;
  wire                mul_norm_forceUnderflow;
  wire                mul_norm_forceOverflow;
  wire                mul_norm_infinitynan;
  wire                mul_norm_forceNan;
  reg        [23:0]   mul_norm_output_mantissa;
  reg        [8:0]    mul_norm_output_exponent;
  wire                mul_norm_output_sign;
  reg                 mul_norm_output_special;
  reg                 mul_norm_NV;
  wire                when_FpuCore_l983;
  wire                when_FpuCore_l987;
  wire                mul_result_notMul_output_valid;
  wire       [23:0]   mul_result_notMul_output_payload;
  wire                mul_result_output_valid;
  wire                mul_result_output_ready;
  wire       [4:0]    mul_result_output_payload_rd;
  wire       [23:0]   mul_result_output_payload_value_mantissa;
  wire       [8:0]    mul_result_output_payload_value_exponent;
  wire                mul_result_output_payload_value_sign;
  wire                mul_result_output_payload_value_special;
  wire                mul_result_output_payload_scrap;
  wire       [2:0]    mul_result_output_payload_roundMode;
  wire                mul_result_output_payload_NV;
  wire                mul_result_output_payload_DZ;
  wire                mul_result_mulToAdd_valid;
  reg                 mul_result_mulToAdd_ready;
  reg        [24:0]   mul_result_mulToAdd_payload_rs1_mantissa;
  wire       [8:0]    mul_result_mulToAdd_payload_rs1_exponent;
  wire                mul_result_mulToAdd_payload_rs1_sign;
  wire                mul_result_mulToAdd_payload_rs1_special;
  wire       [24:0]   mul_result_mulToAdd_payload_rs2_mantissa;
  wire       [8:0]    mul_result_mulToAdd_payload_rs2_exponent;
  wire                mul_result_mulToAdd_payload_rs2_sign;
  wire                mul_result_mulToAdd_payload_rs2_special;
  wire       [4:0]    mul_result_mulToAdd_payload_rd;
  wire       [2:0]    mul_result_mulToAdd_payload_roundMode;
  wire                mul_result_mulToAdd_payload_needCommit;
  wire                mul_result_mulToAdd_m2sPipe_valid;
  wire                mul_result_mulToAdd_m2sPipe_ready;
  wire       [24:0]   mul_result_mulToAdd_m2sPipe_payload_rs1_mantissa;
  wire       [8:0]    mul_result_mulToAdd_m2sPipe_payload_rs1_exponent;
  wire                mul_result_mulToAdd_m2sPipe_payload_rs1_sign;
  wire                mul_result_mulToAdd_m2sPipe_payload_rs1_special;
  wire       [24:0]   mul_result_mulToAdd_m2sPipe_payload_rs2_mantissa;
  wire       [8:0]    mul_result_mulToAdd_m2sPipe_payload_rs2_exponent;
  wire                mul_result_mulToAdd_m2sPipe_payload_rs2_sign;
  wire                mul_result_mulToAdd_m2sPipe_payload_rs2_special;
  wire       [4:0]    mul_result_mulToAdd_m2sPipe_payload_rd;
  wire       [2:0]    mul_result_mulToAdd_m2sPipe_payload_roundMode;
  wire                mul_result_mulToAdd_m2sPipe_payload_needCommit;
  reg                 mul_result_mulToAdd_rValid;
  reg        [24:0]   mul_result_mulToAdd_rData_rs1_mantissa;
  reg        [8:0]    mul_result_mulToAdd_rData_rs1_exponent;
  reg                 mul_result_mulToAdd_rData_rs1_sign;
  reg                 mul_result_mulToAdd_rData_rs1_special;
  reg        [24:0]   mul_result_mulToAdd_rData_rs2_mantissa;
  reg        [8:0]    mul_result_mulToAdd_rData_rs2_exponent;
  reg                 mul_result_mulToAdd_rData_rs2_sign;
  reg                 mul_result_mulToAdd_rData_rs2_special;
  reg        [4:0]    mul_result_mulToAdd_rData_rd;
  reg        [2:0]    mul_result_mulToAdd_rData_roundMode;
  reg                 mul_result_mulToAdd_rData_needCommit;
  wire                when_Stream_l368_11;
  wire                div_input_valid;
  wire                div_input_ready;
  wire       [22:0]   div_input_payload_rs1_mantissa;
  wire       [8:0]    div_input_payload_rs1_exponent;
  wire                div_input_payload_rs1_sign;
  wire                div_input_payload_rs1_special;
  wire       [22:0]   div_input_payload_rs2_mantissa;
  wire       [8:0]    div_input_payload_rs2_exponent;
  wire                div_input_payload_rs2_sign;
  wire                div_input_payload_rs2_special;
  wire       [4:0]    div_input_payload_rd;
  wire       [2:0]    div_input_payload_roundMode;
  reg                 decode_div_rValid;
  wire                div_input_fire;
  reg        [22:0]   decode_div_rData_rs1_mantissa;
  reg        [8:0]    decode_div_rData_rs1_exponent;
  reg                 decode_div_rData_rs1_sign;
  reg                 decode_div_rData_rs1_special;
  reg        [22:0]   decode_div_rData_rs2_mantissa;
  reg        [8:0]    decode_div_rData_rs2_exponent;
  reg                 decode_div_rData_rs2_sign;
  reg                 decode_div_rData_rs2_special;
  reg        [4:0]    decode_div_rData_rd;
  reg        [2:0]    decode_div_rData_roundMode;
  reg                 div_haltIt;
  wire                div_input_fire_1;
  wire                when_FpuCore_l221_2;
  reg                 div_isCommited;
  wire                _zz_div_input_ready;
  wire                div_output_valid;
  wire                div_output_ready;
  wire       [4:0]    div_output_payload_rd;
  reg        [23:0]   div_output_payload_value_mantissa;
  reg        [8:0]    div_output_payload_value_exponent;
  wire                div_output_payload_value_sign;
  reg                 div_output_payload_value_special;
  wire                div_output_payload_scrap;
  wire       [2:0]    div_output_payload_roundMode;
  reg                 div_output_payload_NV;
  wire                div_output_payload_DZ;
  wire       [25:0]   div_dividerResult;
  wire                div_dividerScrap;
  reg                 div_cmdSent;
  wire                FpuPlugin_fpu_div_divider_io_input_fire;
  wire                when_FpuCore_l1056;
  wire                div_needShift;
  wire       [23:0]   div_mantissa;
  wire                div_scrap;
  wire       [10:0]   div_exponent;
  wire                when_FpuCore_l1072;
  wire       [10:0]   div_underflowThreshold;
  wire       [10:0]   div_underflowExp;
  wire                div_forceUnderflow;
  wire                div_forceOverflow;
  wire                div_infinitynan;
  wire                div_forceNan;
  wire                div_forceZero;
  wire                when_FpuCore_l1089;
  wire                when_FpuCore_l1093;
  wire                sqrt_input_valid;
  wire                sqrt_input_ready;
  wire       [22:0]   sqrt_input_payload_rs1_mantissa;
  wire       [8:0]    sqrt_input_payload_rs1_exponent;
  wire                sqrt_input_payload_rs1_sign;
  wire                sqrt_input_payload_rs1_special;
  wire       [4:0]    sqrt_input_payload_rd;
  wire       [2:0]    sqrt_input_payload_roundMode;
  reg                 decode_sqrt_rValid;
  wire                sqrt_input_fire;
  reg        [22:0]   decode_sqrt_rData_rs1_mantissa;
  reg        [8:0]    decode_sqrt_rData_rs1_exponent;
  reg                 decode_sqrt_rData_rs1_sign;
  reg                 decode_sqrt_rData_rs1_special;
  reg        [4:0]    decode_sqrt_rData_rd;
  reg        [2:0]    decode_sqrt_rData_roundMode;
  reg                 sqrt_haltIt;
  wire                sqrt_input_fire_1;
  wire                when_FpuCore_l221_3;
  reg                 sqrt_isCommited;
  wire                _zz_sqrt_input_ready;
  wire                sqrt_output_valid;
  wire                sqrt_output_ready;
  wire       [4:0]    sqrt_output_payload_rd;
  reg        [23:0]   sqrt_output_payload_value_mantissa;
  reg        [8:0]    sqrt_output_payload_value_exponent;
  wire                sqrt_output_payload_value_sign;
  reg                 sqrt_output_payload_value_special;
  wire                sqrt_output_payload_scrap;
  wire       [2:0]    sqrt_output_payload_roundMode;
  reg                 sqrt_output_payload_NV;
  wire                sqrt_output_payload_DZ;
  wire                sqrt_needShift;
  reg                 sqrt_cmdSent;
  wire                FpuPlugin_fpu_sqrt_sqrt_io_input_fire;
  wire                when_FpuCore_l1118;
  wire                sqrt_scrap;
  reg        [8:0]    sqrt_exponent;
  wire                sqrt_negative;
  wire                when_FpuCore_l1137;
  wire                when_FpuCore_l1144;
  wire                when_FpuCore_l1148;
  wire                add_preShifter_input_valid;
  wire                add_preShifter_input_ready;
  wire       [24:0]   add_preShifter_input_payload_rs1_mantissa;
  wire       [8:0]    add_preShifter_input_payload_rs1_exponent;
  wire                add_preShifter_input_payload_rs1_sign;
  wire                add_preShifter_input_payload_rs1_special;
  wire       [24:0]   add_preShifter_input_payload_rs2_mantissa;
  wire       [8:0]    add_preShifter_input_payload_rs2_exponent;
  wire                add_preShifter_input_payload_rs2_sign;
  wire                add_preShifter_input_payload_rs2_special;
  wire       [4:0]    add_preShifter_input_payload_rd;
  wire       [2:0]    add_preShifter_input_payload_roundMode;
  wire                add_preShifter_input_payload_needCommit;
  wire                add_preShifter_output_valid;
  reg                 add_preShifter_output_ready;
  wire       [24:0]   add_preShifter_output_payload_rs1_mantissa;
  wire       [8:0]    add_preShifter_output_payload_rs1_exponent;
  wire                add_preShifter_output_payload_rs1_sign;
  wire                add_preShifter_output_payload_rs1_special;
  wire       [24:0]   add_preShifter_output_payload_rs2_mantissa;
  wire       [8:0]    add_preShifter_output_payload_rs2_exponent;
  wire                add_preShifter_output_payload_rs2_sign;
  wire                add_preShifter_output_payload_rs2_special;
  wire       [4:0]    add_preShifter_output_payload_rd;
  wire       [2:0]    add_preShifter_output_payload_roundMode;
  wire                add_preShifter_output_payload_needCommit;
  wire                add_preShifter_output_payload_absRs1Bigger;
  wire                add_preShifter_output_payload_rs1ExponentBigger;
  wire       [9:0]    add_preShifter_exp21;
  wire                add_preShifter_rs1ExponentBigger;
  wire                add_preShifter_rs1ExponentEqual;
  wire                add_preShifter_rs1MantissaBigger;
  wire                add_preShifter_absRs1Bigger;
  wire                add_shifter_input_valid;
  wire                add_shifter_input_ready;
  wire       [24:0]   add_shifter_input_payload_rs1_mantissa;
  wire       [8:0]    add_shifter_input_payload_rs1_exponent;
  wire                add_shifter_input_payload_rs1_sign;
  wire                add_shifter_input_payload_rs1_special;
  wire       [24:0]   add_shifter_input_payload_rs2_mantissa;
  wire       [8:0]    add_shifter_input_payload_rs2_exponent;
  wire                add_shifter_input_payload_rs2_sign;
  wire                add_shifter_input_payload_rs2_special;
  wire       [4:0]    add_shifter_input_payload_rd;
  wire       [2:0]    add_shifter_input_payload_roundMode;
  wire                add_shifter_input_payload_needCommit;
  wire                add_shifter_input_payload_absRs1Bigger;
  wire                add_shifter_input_payload_rs1ExponentBigger;
  reg                 add_preShifter_output_rValid;
  reg        [24:0]   add_preShifter_output_rData_rs1_mantissa;
  reg        [8:0]    add_preShifter_output_rData_rs1_exponent;
  reg                 add_preShifter_output_rData_rs1_sign;
  reg                 add_preShifter_output_rData_rs1_special;
  reg        [24:0]   add_preShifter_output_rData_rs2_mantissa;
  reg        [8:0]    add_preShifter_output_rData_rs2_exponent;
  reg                 add_preShifter_output_rData_rs2_sign;
  reg                 add_preShifter_output_rData_rs2_special;
  reg        [4:0]    add_preShifter_output_rData_rd;
  reg        [2:0]    add_preShifter_output_rData_roundMode;
  reg                 add_preShifter_output_rData_needCommit;
  reg                 add_preShifter_output_rData_absRs1Bigger;
  reg                 add_preShifter_output_rData_rs1ExponentBigger;
  wire                when_Stream_l368_12;
  wire                add_shifter_output_valid;
  reg                 add_shifter_output_ready;
  wire       [24:0]   add_shifter_output_payload_rs1_mantissa;
  wire       [8:0]    add_shifter_output_payload_rs1_exponent;
  wire                add_shifter_output_payload_rs1_sign;
  wire                add_shifter_output_payload_rs1_special;
  wire       [24:0]   add_shifter_output_payload_rs2_mantissa;
  wire       [8:0]    add_shifter_output_payload_rs2_exponent;
  wire                add_shifter_output_payload_rs2_sign;
  wire                add_shifter_output_payload_rs2_special;
  wire       [4:0]    add_shifter_output_payload_rd;
  wire       [2:0]    add_shifter_output_payload_roundMode;
  wire                add_shifter_output_payload_needCommit;
  wire                add_shifter_output_payload_xSign;
  wire                add_shifter_output_payload_ySign;
  wire       [25:0]   add_shifter_output_payload_xMantissa;
  wire       [25:0]   add_shifter_output_payload_yMantissa;
  wire       [8:0]    add_shifter_output_payload_xyExponent;
  wire                add_shifter_output_payload_xySign;
  wire                add_shifter_output_payload_roundingScrap;
  wire       [9:0]    add_shifter_exp21;
  wire       [9:0]    _zz_add_shifter_shiftBy;
  wire       [9:0]    add_shifter_shiftBy;
  wire                add_shifter_shiftOverflow;
  wire                add_shifter_passThrough;
  wire                add_shifter_xySign;
  wire       [25:0]   add_shifter_xMantissa;
  wire       [25:0]   add_shifter_yMantissaUnshifted;
  wire       [25:0]   add_shifter_yMantissa;
  reg                 add_shifter_roundingScrap;
  wire                when_FpuCore_l1419;
  wire                when_FpuCore_l1419_1;
  wire                when_FpuCore_l1419_2;
  wire                when_FpuCore_l1419_3;
  wire                when_FpuCore_l1419_4;
  wire                when_FpuCore_l1424;
  wire                add_math_input_valid;
  wire                add_math_input_ready;
  wire       [24:0]   add_math_input_payload_rs1_mantissa;
  wire       [8:0]    add_math_input_payload_rs1_exponent;
  wire                add_math_input_payload_rs1_sign;
  wire                add_math_input_payload_rs1_special;
  wire       [24:0]   add_math_input_payload_rs2_mantissa;
  wire       [8:0]    add_math_input_payload_rs2_exponent;
  wire                add_math_input_payload_rs2_sign;
  wire                add_math_input_payload_rs2_special;
  wire       [4:0]    add_math_input_payload_rd;
  wire       [2:0]    add_math_input_payload_roundMode;
  wire                add_math_input_payload_needCommit;
  wire                add_math_input_payload_xSign;
  wire                add_math_input_payload_ySign;
  wire       [25:0]   add_math_input_payload_xMantissa;
  wire       [25:0]   add_math_input_payload_yMantissa;
  wire       [8:0]    add_math_input_payload_xyExponent;
  wire                add_math_input_payload_xySign;
  wire                add_math_input_payload_roundingScrap;
  reg                 add_shifter_output_rValid;
  reg        [24:0]   add_shifter_output_rData_rs1_mantissa;
  reg        [8:0]    add_shifter_output_rData_rs1_exponent;
  reg                 add_shifter_output_rData_rs1_sign;
  reg                 add_shifter_output_rData_rs1_special;
  reg        [24:0]   add_shifter_output_rData_rs2_mantissa;
  reg        [8:0]    add_shifter_output_rData_rs2_exponent;
  reg                 add_shifter_output_rData_rs2_sign;
  reg                 add_shifter_output_rData_rs2_special;
  reg        [4:0]    add_shifter_output_rData_rd;
  reg        [2:0]    add_shifter_output_rData_roundMode;
  reg                 add_shifter_output_rData_needCommit;
  reg                 add_shifter_output_rData_xSign;
  reg                 add_shifter_output_rData_ySign;
  reg        [25:0]   add_shifter_output_rData_xMantissa;
  reg        [25:0]   add_shifter_output_rData_yMantissa;
  reg        [8:0]    add_shifter_output_rData_xyExponent;
  reg                 add_shifter_output_rData_xySign;
  reg                 add_shifter_output_rData_roundingScrap;
  wire                when_Stream_l368_13;
  wire                add_math_output_valid;
  reg                 add_math_output_ready;
  wire       [24:0]   add_math_output_payload_rs1_mantissa;
  wire       [8:0]    add_math_output_payload_rs1_exponent;
  wire                add_math_output_payload_rs1_sign;
  wire                add_math_output_payload_rs1_special;
  wire       [24:0]   add_math_output_payload_rs2_mantissa;
  wire       [8:0]    add_math_output_payload_rs2_exponent;
  wire                add_math_output_payload_rs2_sign;
  wire                add_math_output_payload_rs2_special;
  wire       [4:0]    add_math_output_payload_rd;
  wire       [2:0]    add_math_output_payload_roundMode;
  wire                add_math_output_payload_needCommit;
  wire                add_math_output_payload_xSign;
  wire                add_math_output_payload_ySign;
  wire       [25:0]   add_math_output_payload_xMantissa;
  wire       [25:0]   add_math_output_payload_yMantissa;
  wire       [8:0]    add_math_output_payload_xyExponent;
  wire                add_math_output_payload_xySign;
  wire                add_math_output_payload_roundingScrap;
  wire       [26:0]   add_math_output_payload_xyMantissa;
  wire       [26:0]   add_math_xSigned;
  wire       [26:0]   add_math_ySigned;
  wire                add_oh_input_valid;
  wire                add_oh_input_ready;
  wire       [24:0]   add_oh_input_payload_rs1_mantissa;
  wire       [8:0]    add_oh_input_payload_rs1_exponent;
  wire                add_oh_input_payload_rs1_sign;
  wire                add_oh_input_payload_rs1_special;
  wire       [24:0]   add_oh_input_payload_rs2_mantissa;
  wire       [8:0]    add_oh_input_payload_rs2_exponent;
  wire                add_oh_input_payload_rs2_sign;
  wire                add_oh_input_payload_rs2_special;
  wire       [4:0]    add_oh_input_payload_rd;
  wire       [2:0]    add_oh_input_payload_roundMode;
  wire                add_oh_input_payload_needCommit;
  wire                add_oh_input_payload_xSign;
  wire                add_oh_input_payload_ySign;
  wire       [25:0]   add_oh_input_payload_xMantissa;
  wire       [25:0]   add_oh_input_payload_yMantissa;
  wire       [8:0]    add_oh_input_payload_xyExponent;
  wire                add_oh_input_payload_xySign;
  wire                add_oh_input_payload_roundingScrap;
  wire       [26:0]   add_oh_input_payload_xyMantissa;
  reg                 add_math_output_rValid;
  reg        [24:0]   add_math_output_rData_rs1_mantissa;
  reg        [8:0]    add_math_output_rData_rs1_exponent;
  reg                 add_math_output_rData_rs1_sign;
  reg                 add_math_output_rData_rs1_special;
  reg        [24:0]   add_math_output_rData_rs2_mantissa;
  reg        [8:0]    add_math_output_rData_rs2_exponent;
  reg                 add_math_output_rData_rs2_sign;
  reg                 add_math_output_rData_rs2_special;
  reg        [4:0]    add_math_output_rData_rd;
  reg        [2:0]    add_math_output_rData_roundMode;
  reg                 add_math_output_rData_needCommit;
  reg                 add_math_output_rData_xSign;
  reg                 add_math_output_rData_ySign;
  reg        [25:0]   add_math_output_rData_xMantissa;
  reg        [25:0]   add_math_output_rData_yMantissa;
  reg        [8:0]    add_math_output_rData_xyExponent;
  reg                 add_math_output_rData_xySign;
  reg                 add_math_output_rData_roundingScrap;
  reg        [26:0]   add_math_output_rData_xyMantissa;
  wire                when_Stream_l368_14;
  wire                add_oh_input_fire;
  wire                when_FpuCore_l221_4;
  wire                add_oh_isCommited;
  wire                _zz_add_oh_input_ready;
  wire                add_oh_output_valid;
  reg                 add_oh_output_ready;
  wire       [24:0]   add_oh_output_payload_rs1_mantissa;
  wire       [8:0]    add_oh_output_payload_rs1_exponent;
  wire                add_oh_output_payload_rs1_sign;
  wire                add_oh_output_payload_rs1_special;
  wire       [24:0]   add_oh_output_payload_rs2_mantissa;
  wire       [8:0]    add_oh_output_payload_rs2_exponent;
  wire                add_oh_output_payload_rs2_sign;
  wire                add_oh_output_payload_rs2_special;
  wire       [4:0]    add_oh_output_payload_rd;
  wire       [2:0]    add_oh_output_payload_roundMode;
  wire                add_oh_output_payload_needCommit;
  wire                add_oh_output_payload_xSign;
  wire                add_oh_output_payload_ySign;
  wire       [25:0]   add_oh_output_payload_xMantissa;
  wire       [25:0]   add_oh_output_payload_yMantissa;
  wire       [8:0]    add_oh_output_payload_xyExponent;
  wire                add_oh_output_payload_xySign;
  wire                add_oh_output_payload_roundingScrap;
  wire       [26:0]   add_oh_output_payload_xyMantissa;
  wire       [4:0]    add_oh_output_payload_shift;
  wire       [26:0]   _zz_add_oh_shift;
  wire       [26:0]   _zz_add_oh_shift_1;
  wire                _zz_add_oh_shift_2;
  wire                _zz_add_oh_shift_3;
  wire                _zz_add_oh_shift_4;
  wire                _zz_add_oh_shift_5;
  wire                _zz_add_oh_shift_6;
  wire                _zz_add_oh_shift_7;
  wire                _zz_add_oh_shift_8;
  wire                _zz_add_oh_shift_9;
  wire                _zz_add_oh_shift_10;
  wire                _zz_add_oh_shift_11;
  wire                _zz_add_oh_shift_12;
  wire                _zz_add_oh_shift_13;
  wire                _zz_add_oh_shift_14;
  wire                _zz_add_oh_shift_15;
  wire                _zz_add_oh_shift_16;
  wire                _zz_add_oh_shift_17;
  wire                _zz_add_oh_shift_18;
  wire                _zz_add_oh_shift_19;
  wire                _zz_add_oh_shift_20;
  wire                _zz_add_oh_shift_21;
  wire                _zz_add_oh_shift_22;
  wire                _zz_add_oh_shift_23;
  wire                _zz_add_oh_shift_24;
  wire                _zz_add_oh_shift_25;
  wire                _zz_add_oh_shift_26;
  wire                _zz_add_oh_shift_27;
  wire       [4:0]    add_oh_shift;
  wire                add_norm_input_valid;
  wire                add_norm_input_ready;
  wire       [24:0]   add_norm_input_payload_rs1_mantissa;
  wire       [8:0]    add_norm_input_payload_rs1_exponent;
  wire                add_norm_input_payload_rs1_sign;
  wire                add_norm_input_payload_rs1_special;
  wire       [24:0]   add_norm_input_payload_rs2_mantissa;
  wire       [8:0]    add_norm_input_payload_rs2_exponent;
  wire                add_norm_input_payload_rs2_sign;
  wire                add_norm_input_payload_rs2_special;
  wire       [4:0]    add_norm_input_payload_rd;
  wire       [2:0]    add_norm_input_payload_roundMode;
  wire                add_norm_input_payload_needCommit;
  wire                add_norm_input_payload_xSign;
  wire                add_norm_input_payload_ySign;
  wire       [25:0]   add_norm_input_payload_xMantissa;
  wire       [25:0]   add_norm_input_payload_yMantissa;
  wire       [8:0]    add_norm_input_payload_xyExponent;
  wire                add_norm_input_payload_xySign;
  wire                add_norm_input_payload_roundingScrap;
  wire       [26:0]   add_norm_input_payload_xyMantissa;
  wire       [4:0]    add_norm_input_payload_shift;
  reg                 add_oh_output_rValid;
  reg        [24:0]   add_oh_output_rData_rs1_mantissa;
  reg        [8:0]    add_oh_output_rData_rs1_exponent;
  reg                 add_oh_output_rData_rs1_sign;
  reg                 add_oh_output_rData_rs1_special;
  reg        [24:0]   add_oh_output_rData_rs2_mantissa;
  reg        [8:0]    add_oh_output_rData_rs2_exponent;
  reg                 add_oh_output_rData_rs2_sign;
  reg                 add_oh_output_rData_rs2_special;
  reg        [4:0]    add_oh_output_rData_rd;
  reg        [2:0]    add_oh_output_rData_roundMode;
  reg                 add_oh_output_rData_needCommit;
  reg                 add_oh_output_rData_xSign;
  reg                 add_oh_output_rData_ySign;
  reg        [25:0]   add_oh_output_rData_xMantissa;
  reg        [25:0]   add_oh_output_rData_yMantissa;
  reg        [8:0]    add_oh_output_rData_xyExponent;
  reg                 add_oh_output_rData_xySign;
  reg                 add_oh_output_rData_roundingScrap;
  reg        [26:0]   add_oh_output_rData_xyMantissa;
  reg        [4:0]    add_oh_output_rData_shift;
  wire                when_Stream_l368_15;
  wire                add_norm_output_valid;
  wire                add_norm_output_ready;
  wire       [24:0]   add_norm_output_payload_rs1_mantissa;
  wire       [8:0]    add_norm_output_payload_rs1_exponent;
  wire                add_norm_output_payload_rs1_sign;
  wire                add_norm_output_payload_rs1_special;
  wire       [24:0]   add_norm_output_payload_rs2_mantissa;
  wire       [8:0]    add_norm_output_payload_rs2_exponent;
  wire                add_norm_output_payload_rs2_sign;
  wire                add_norm_output_payload_rs2_special;
  wire       [4:0]    add_norm_output_payload_rd;
  wire       [2:0]    add_norm_output_payload_roundMode;
  wire                add_norm_output_payload_needCommit;
  wire       [26:0]   add_norm_output_payload_mantissa;
  wire       [9:0]    add_norm_output_payload_exponent;
  wire                add_norm_output_payload_infinityNan;
  wire                add_norm_output_payload_forceNan;
  wire                add_norm_output_payload_forceZero;
  wire                add_norm_output_payload_forceInfinity;
  wire                add_norm_output_payload_xySign;
  wire                add_norm_output_payload_roundingScrap;
  wire                add_norm_output_payload_xyMantissaZero;
  wire                add_result_input_valid;
  wire                add_result_input_ready;
  wire       [24:0]   add_result_input_payload_rs1_mantissa;
  wire       [8:0]    add_result_input_payload_rs1_exponent;
  wire                add_result_input_payload_rs1_sign;
  wire                add_result_input_payload_rs1_special;
  wire       [24:0]   add_result_input_payload_rs2_mantissa;
  wire       [8:0]    add_result_input_payload_rs2_exponent;
  wire                add_result_input_payload_rs2_sign;
  wire                add_result_input_payload_rs2_special;
  wire       [4:0]    add_result_input_payload_rd;
  wire       [2:0]    add_result_input_payload_roundMode;
  wire                add_result_input_payload_needCommit;
  wire       [26:0]   add_result_input_payload_mantissa;
  wire       [9:0]    add_result_input_payload_exponent;
  wire                add_result_input_payload_infinityNan;
  wire                add_result_input_payload_forceNan;
  wire                add_result_input_payload_forceZero;
  wire                add_result_input_payload_forceInfinity;
  wire                add_result_input_payload_xySign;
  wire                add_result_input_payload_roundingScrap;
  wire                add_result_input_payload_xyMantissaZero;
  wire                add_result_output_valid;
  wire                add_result_output_ready;
  wire       [4:0]    add_result_output_payload_rd;
  reg        [23:0]   add_result_output_payload_value_mantissa;
  reg        [8:0]    add_result_output_payload_value_exponent;
  reg                 add_result_output_payload_value_sign;
  reg                 add_result_output_payload_value_special;
  wire                add_result_output_payload_scrap;
  wire       [2:0]    add_result_output_payload_roundMode;
  wire                add_result_output_payload_NV;
  wire                add_result_output_payload_DZ;
  wire                when_FpuCore_l1513;
  wire                when_FpuCore_l1516;
  wire                load_s1_output_m2sPipe_valid;
  wire                load_s1_output_m2sPipe_ready;
  wire       [4:0]    load_s1_output_m2sPipe_payload_rd;
  wire       [23:0]   load_s1_output_m2sPipe_payload_value_mantissa;
  wire       [8:0]    load_s1_output_m2sPipe_payload_value_exponent;
  wire                load_s1_output_m2sPipe_payload_value_sign;
  wire                load_s1_output_m2sPipe_payload_value_special;
  wire                load_s1_output_m2sPipe_payload_scrap;
  wire       [2:0]    load_s1_output_m2sPipe_payload_roundMode;
  wire                load_s1_output_m2sPipe_payload_NV;
  wire                load_s1_output_m2sPipe_payload_DZ;
  reg                 load_s1_output_rValid;
  reg        [4:0]    load_s1_output_rData_rd;
  reg        [23:0]   load_s1_output_rData_value_mantissa;
  reg        [8:0]    load_s1_output_rData_value_exponent;
  reg                 load_s1_output_rData_value_sign;
  reg                 load_s1_output_rData_value_special;
  reg                 load_s1_output_rData_scrap;
  reg        [2:0]    load_s1_output_rData_roundMode;
  reg                 load_s1_output_rData_NV;
  reg                 load_s1_output_rData_DZ;
  wire                when_Stream_l368_16;
  wire                shortPip_output_m2sPipe_valid;
  wire                shortPip_output_m2sPipe_ready;
  wire       [4:0]    shortPip_output_m2sPipe_payload_rd;
  wire       [23:0]   shortPip_output_m2sPipe_payload_value_mantissa;
  wire       [8:0]    shortPip_output_m2sPipe_payload_value_exponent;
  wire                shortPip_output_m2sPipe_payload_value_sign;
  wire                shortPip_output_m2sPipe_payload_value_special;
  wire                shortPip_output_m2sPipe_payload_scrap;
  wire       [2:0]    shortPip_output_m2sPipe_payload_roundMode;
  wire                shortPip_output_m2sPipe_payload_NV;
  wire                shortPip_output_m2sPipe_payload_DZ;
  reg                 shortPip_output_rValid;
  reg        [4:0]    shortPip_output_rData_rd;
  reg        [23:0]   shortPip_output_rData_value_mantissa;
  reg        [8:0]    shortPip_output_rData_value_exponent;
  reg                 shortPip_output_rData_value_sign;
  reg                 shortPip_output_rData_value_special;
  reg                 shortPip_output_rData_scrap;
  reg        [2:0]    shortPip_output_rData_roundMode;
  reg                 shortPip_output_rData_NV;
  reg                 shortPip_output_rData_DZ;
  wire                when_Stream_l368_17;
  wire                merge_arbitrated_valid;
  wire       [4:0]    merge_arbitrated_payload_rd;
  wire       [23:0]   merge_arbitrated_payload_value_mantissa;
  wire       [8:0]    merge_arbitrated_payload_value_exponent;
  wire                merge_arbitrated_payload_value_sign;
  wire                merge_arbitrated_payload_value_special;
  wire                merge_arbitrated_payload_scrap;
  wire       [2:0]    merge_arbitrated_payload_roundMode;
  wire                merge_arbitrated_payload_NV;
  wire                merge_arbitrated_payload_DZ;
  reg                 roundFront_input_valid;
  reg        [4:0]    roundFront_input_payload_rd;
  reg        [23:0]   roundFront_input_payload_value_mantissa;
  reg        [8:0]    roundFront_input_payload_value_exponent;
  reg                 roundFront_input_payload_value_sign;
  reg                 roundFront_input_payload_value_special;
  reg                 roundFront_input_payload_scrap;
  reg        [2:0]    roundFront_input_payload_roundMode;
  reg                 roundFront_input_payload_NV;
  reg                 roundFront_input_payload_DZ;
  wire                roundFront_output_valid;
  wire       [4:0]    roundFront_output_payload_rd;
  wire       [23:0]   roundFront_output_payload_value_mantissa;
  wire       [8:0]    roundFront_output_payload_value_exponent;
  wire                roundFront_output_payload_value_sign;
  wire                roundFront_output_payload_value_special;
  wire                roundFront_output_payload_scrap;
  wire       [2:0]    roundFront_output_payload_roundMode;
  wire                roundFront_output_payload_NV;
  wire                roundFront_output_payload_DZ;
  wire                roundFront_output_payload_mantissaIncrement;
  wire       [1:0]    roundFront_output_payload_roundAdjusted;
  wire       [24:0]   roundFront_output_payload_exactMask;
  wire       [24:0]   roundFront_manAggregate;
  wire       [7:0]    roundFront_expBase;
  wire       [9:0]    roundFront_expDif;
  wire                roundFront_expSubnormal;
  wire       [4:0]    roundFront_discardCount;
  wire       [24:0]   roundFront_exactMask;
  wire       [1:0]    roundFront_roundAdjusted;
  reg                 _zz_roundFront_mantissaIncrement;
  wire                roundFront_mantissaIncrement;
  reg                 roundBack_input_valid;
  reg        [4:0]    roundBack_input_payload_rd;
  reg        [23:0]   roundBack_input_payload_value_mantissa;
  reg        [8:0]    roundBack_input_payload_value_exponent;
  reg                 roundBack_input_payload_value_sign;
  reg                 roundBack_input_payload_value_special;
  reg                 roundBack_input_payload_scrap;
  reg        [2:0]    roundBack_input_payload_roundMode;
  reg                 roundBack_input_payload_NV;
  reg                 roundBack_input_payload_DZ;
  reg                 roundBack_input_payload_mantissaIncrement;
  reg        [1:0]    roundBack_input_payload_roundAdjusted;
  reg        [24:0]   roundBack_input_payload_exactMask;
  wire                roundBack_output_valid;
  wire       [4:0]    roundBack_output_payload_rd;
  wire       [22:0]   roundBack_output_payload_value_mantissa;
  wire       [8:0]    roundBack_output_payload_value_exponent;
  wire                roundBack_output_payload_value_sign;
  wire                roundBack_output_payload_value_special;
  wire                roundBack_output_payload_NV;
  wire                roundBack_output_payload_NX;
  wire                roundBack_output_payload_OF;
  wire                roundBack_output_payload_UF;
  wire                roundBack_output_payload_DZ;
  wire                roundBack_output_payload_write;
  wire       [22:0]   roundBack_math_mantissa;
  wire       [8:0]    roundBack_math_exponent;
  wire                roundBack_math_sign;
  wire                roundBack_math_special;
  wire       [22:0]   roundBack_adderMantissa;
  (* keep , syn_keep *) wire       [22:0]   roundBack_adderRightOp /* synthesis syn_keep = 1 */ ;
  (* keep , syn_keep *) wire       [31:0]   _zz_roundBack_adder /* synthesis syn_keep = 1 */ ;
  (* keep , syn_keep *) wire       [0:0]    _zz_roundBack_adder_1 /* synthesis syn_keep = 1 */ ;
  (* keep , syn_keep *) wire       [31:0]   roundBack_adder /* synthesis syn_keep = 1 */ ;
  reg        [22:0]   roundBack_patched_mantissa;
  reg        [8:0]    roundBack_patched_exponent;
  wire                roundBack_patched_sign;
  reg                 roundBack_patched_special;
  reg                 roundBack_nx;
  reg                 roundBack_of;
  reg                 roundBack_uf;
  wire       [7:0]    roundBack_ufSubnormalThreshold;
  wire       [6:0]    roundBack_ufThreshold;
  wire       [8:0]    roundBack_ofThreshold;
  reg        [2:0]    roundBack_threshold;
  wire       [2:0]    roundBack_borringRound;
  wire                roundBack_borringCase;
  wire                when_FpuCore_l1608;
  wire                when_FpuCore_l1611;
  reg                 when_FpuCore_l1621;
  wire                when_FpuCore_l1630;
  reg                 when_FpuCore_l1640;
  wire                when_FpuCore_l1649;
  wire                roundBack_writes_0;
  wire                roundBack_write;
  reg                 writeback_input_valid;
  reg        [4:0]    writeback_input_payload_rd;
  reg        [22:0]   writeback_input_payload_value_mantissa;
  reg        [8:0]    writeback_input_payload_value_exponent;
  reg                 writeback_input_payload_value_sign;
  reg                 writeback_input_payload_value_special;
  reg                 writeback_input_payload_NV;
  reg                 writeback_input_payload_NX;
  reg                 writeback_input_payload_OF;
  reg                 writeback_input_payload_UF;
  reg                 writeback_input_payload_DZ;
  reg                 writeback_input_payload_write;
  wire                when_FpuCore_l1681;
  wire                writeback_port_valid;
  wire       [4:0]    writeback_port_payload_address;
  wire       [22:0]   writeback_port_payload_data_value_mantissa;
  wire       [8:0]    writeback_port_payload_data_value_exponent;
  wire                writeback_port_payload_data_value_sign;
  wire                writeback_port_payload_data_value_special;
  `ifndef SYNTHESIS
  reg [63:0] io_port_0_cmd_payload_opcode_string;
  reg [47:0] io_port_0_cmd_payload_format_string;
  reg [23:0] io_port_0_cmd_payload_roundMode_string;
  reg [63:0] io_port_0_commit_payload_opcode_string;
  reg [63:0] commitFork_load_0_payload_opcode_string;
  reg [63:0] commitFork_commit_0_payload_opcode_string;
  reg [63:0] FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string;
  reg [63:0] FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string;
  reg [63:0] _zz_payload_opcode_string;
  reg [63:0] _zz_commitLogic_0_input_payload_opcode_string;
  reg [63:0] commitLogic_0_input_payload_opcode_string;
  reg [63:0] scheduler_0_input_payload_opcode_string;
  reg [47:0] scheduler_0_input_payload_format_string;
  reg [23:0] scheduler_0_input_payload_roundMode_string;
  reg [63:0] io_port_0_cmd_rData_opcode_string;
  reg [47:0] io_port_0_cmd_rData_format_string;
  reg [23:0] io_port_0_cmd_rData_roundMode_string;
  reg [63:0] _zz_scheduler_0_input_payload_opcode_string;
  reg [47:0] _zz_scheduler_0_input_payload_format_string;
  reg [23:0] _zz_scheduler_0_input_payload_roundMode_string;
  reg [63:0] scheduler_0_output_payload_opcode_string;
  reg [47:0] scheduler_0_output_payload_format_string;
  reg [23:0] scheduler_0_output_payload_roundMode_string;
  reg [63:0] _zz_io_inputs_0_payload_opcode_string;
  reg [47:0] _zz_io_inputs_0_payload_format_string;
  reg [23:0] _zz_io_inputs_0_payload_roundMode_string;
  reg [63:0] cmdArbiter_output_payload_opcode_string;
  reg [23:0] cmdArbiter_output_payload_roundMode_string;
  reg [63:0] read_s0_payload_opcode_string;
  reg [23:0] read_s0_payload_roundMode_string;
  reg [63:0] read_s1_payload_opcode_string;
  reg [23:0] read_s1_payload_roundMode_string;
  reg [63:0] read_s0_rData_opcode_string;
  reg [23:0] read_s0_rData_roundMode_string;
  reg [63:0] read_output_payload_opcode_string;
  reg [23:0] read_output_payload_roundMode_string;
  reg [63:0] decode_input_payload_opcode_string;
  reg [23:0] decode_input_payload_roundMode_string;
  reg [23:0] decode_load_payload_roundMode_string;
  reg [63:0] decode_shortPip_payload_opcode_string;
  reg [23:0] decode_shortPip_payload_roundMode_string;
  reg [23:0] decode_divSqrt_payload_roundMode_string;
  reg [23:0] decode_div_payload_roundMode_string;
  reg [23:0] decode_sqrt_payload_roundMode_string;
  reg [23:0] decode_mul_payload_roundMode_string;
  reg [23:0] decode_divSqrtToMul_payload_roundMode_string;
  reg [23:0] decode_add_payload_roundMode_string;
  reg [23:0] decode_mulToAdd_payload_roundMode_string;
  reg [23:0] decode_load_s2mPipe_payload_roundMode_string;
  reg [23:0] decode_load_rData_roundMode_string;
  reg [23:0] _zz_decode_load_s2mPipe_payload_roundMode_string;
  reg [23:0] decode_load_s2mPipe_m2sPipe_payload_roundMode_string;
  reg [23:0] decode_load_s2mPipe_rData_roundMode_string;
  reg [23:0] load_s0_input_payload_roundMode_string;
  reg [23:0] decode_load_s2mPipe_m2sPipe_rData_roundMode_string;
  reg [63:0] load_s0_filtred_0_payload_opcode_string;
  reg [23:0] load_s0_output_payload_roundMode_string;
  reg [23:0] load_s1_input_payload_roundMode_string;
  reg [23:0] load_s0_output_rData_roundMode_string;
  reg [23:0] load_s1_output_payload_roundMode_string;
  reg [63:0] shortPip_input_payload_opcode_string;
  reg [23:0] shortPip_input_payload_roundMode_string;
  reg [63:0] decode_shortPip_rData_opcode_string;
  reg [23:0] decode_shortPip_rData_roundMode_string;
  reg [23:0] shortPip_rfOutput_payload_roundMode_string;
  reg [23:0] shortPip_output_payload_roundMode_string;
  reg [23:0] mul_preMul_input_payload_roundMode_string;
  reg [23:0] decode_mul_rData_roundMode_string;
  reg [23:0] mul_preMul_output_payload_roundMode_string;
  reg [23:0] mul_mul_input_payload_roundMode_string;
  reg [23:0] mul_preMul_output_rData_roundMode_string;
  reg [23:0] mul_mul_output_payload_roundMode_string;
  reg [23:0] mul_sum1_input_payload_roundMode_string;
  reg [23:0] mul_mul_output_rData_roundMode_string;
  reg [23:0] mul_sum1_output_payload_roundMode_string;
  reg [23:0] mul_sum2_input_payload_roundMode_string;
  reg [23:0] mul_sum1_output_rData_roundMode_string;
  reg [23:0] mul_sum2_output_payload_roundMode_string;
  reg [23:0] mul_norm_input_payload_roundMode_string;
  reg [23:0] mul_sum2_output_rData_roundMode_string;
  reg [23:0] mul_result_output_payload_roundMode_string;
  reg [23:0] mul_result_mulToAdd_payload_roundMode_string;
  reg [23:0] mul_result_mulToAdd_m2sPipe_payload_roundMode_string;
  reg [23:0] mul_result_mulToAdd_rData_roundMode_string;
  reg [23:0] div_input_payload_roundMode_string;
  reg [23:0] decode_div_rData_roundMode_string;
  reg [23:0] div_output_payload_roundMode_string;
  reg [23:0] sqrt_input_payload_roundMode_string;
  reg [23:0] decode_sqrt_rData_roundMode_string;
  reg [23:0] sqrt_output_payload_roundMode_string;
  reg [23:0] add_preShifter_input_payload_roundMode_string;
  reg [23:0] add_preShifter_output_payload_roundMode_string;
  reg [23:0] add_shifter_input_payload_roundMode_string;
  reg [23:0] add_preShifter_output_rData_roundMode_string;
  reg [23:0] add_shifter_output_payload_roundMode_string;
  reg [23:0] add_math_input_payload_roundMode_string;
  reg [23:0] add_shifter_output_rData_roundMode_string;
  reg [23:0] add_math_output_payload_roundMode_string;
  reg [23:0] add_oh_input_payload_roundMode_string;
  reg [23:0] add_math_output_rData_roundMode_string;
  reg [23:0] add_oh_output_payload_roundMode_string;
  reg [23:0] add_norm_input_payload_roundMode_string;
  reg [23:0] add_oh_output_rData_roundMode_string;
  reg [23:0] add_norm_output_payload_roundMode_string;
  reg [23:0] add_result_input_payload_roundMode_string;
  reg [23:0] add_result_output_payload_roundMode_string;
  reg [23:0] load_s1_output_m2sPipe_payload_roundMode_string;
  reg [23:0] load_s1_output_rData_roundMode_string;
  reg [23:0] shortPip_output_m2sPipe_payload_roundMode_string;
  reg [23:0] shortPip_output_rData_roundMode_string;
  reg [23:0] merge_arbitrated_payload_roundMode_string;
  reg [23:0] roundFront_input_payload_roundMode_string;
  reg [23:0] roundFront_output_payload_roundMode_string;
  reg [23:0] roundBack_input_payload_roundMode_string;
  `endif

  reg [33:0] rf_ram [0:31];
  (* ram_style = "distributed" *) reg [0:0] rf_scoreboards_0_target [0:31];
  (* ram_style = "distributed" *) reg [0:0] rf_scoreboards_0_hit [0:31];
  (* ram_style = "distributed" *) reg [0:0] rf_scoreboards_0_writes [0:31];

  assign _zz_commitLogic_0_pending_counter = (commitLogic_0_pending_counter + _zz_commitLogic_0_pending_counter_1);
  assign _zz_commitLogic_0_pending_counter_2 = commitLogic_0_pending_inc;
  assign _zz_commitLogic_0_pending_counter_1 = {3'd0, _zz_commitLogic_0_pending_counter_2};
  assign _zz_commitLogic_0_pending_counter_4 = commitLogic_0_pending_dec;
  assign _zz_commitLogic_0_pending_counter_3 = {3'd0, _zz_commitLogic_0_pending_counter_4};
  assign _zz_commitLogic_0_add_counter = (commitLogic_0_add_counter + _zz_commitLogic_0_add_counter_1);
  assign _zz_commitLogic_0_add_counter_2 = commitLogic_0_add_inc;
  assign _zz_commitLogic_0_add_counter_1 = {3'd0, _zz_commitLogic_0_add_counter_2};
  assign _zz_commitLogic_0_add_counter_4 = commitLogic_0_add_dec;
  assign _zz_commitLogic_0_add_counter_3 = {3'd0, _zz_commitLogic_0_add_counter_4};
  assign _zz_commitLogic_0_mul_counter = (commitLogic_0_mul_counter + _zz_commitLogic_0_mul_counter_1);
  assign _zz_commitLogic_0_mul_counter_2 = commitLogic_0_mul_inc;
  assign _zz_commitLogic_0_mul_counter_1 = {3'd0, _zz_commitLogic_0_mul_counter_2};
  assign _zz_commitLogic_0_mul_counter_4 = commitLogic_0_mul_dec;
  assign _zz_commitLogic_0_mul_counter_3 = {3'd0, _zz_commitLogic_0_mul_counter_4};
  assign _zz_commitLogic_0_div_counter = (commitLogic_0_div_counter + _zz_commitLogic_0_div_counter_1);
  assign _zz_commitLogic_0_div_counter_2 = commitLogic_0_div_inc;
  assign _zz_commitLogic_0_div_counter_1 = {3'd0, _zz_commitLogic_0_div_counter_2};
  assign _zz_commitLogic_0_div_counter_4 = commitLogic_0_div_dec;
  assign _zz_commitLogic_0_div_counter_3 = {3'd0, _zz_commitLogic_0_div_counter_4};
  assign _zz_commitLogic_0_sqrt_counter = (commitLogic_0_sqrt_counter + _zz_commitLogic_0_sqrt_counter_1);
  assign _zz_commitLogic_0_sqrt_counter_2 = commitLogic_0_sqrt_inc;
  assign _zz_commitLogic_0_sqrt_counter_1 = {3'd0, _zz_commitLogic_0_sqrt_counter_2};
  assign _zz_commitLogic_0_sqrt_counter_4 = commitLogic_0_sqrt_dec;
  assign _zz_commitLogic_0_sqrt_counter_3 = {3'd0, _zz_commitLogic_0_sqrt_counter_4};
  assign _zz_commitLogic_0_short_counter = (commitLogic_0_short_counter + _zz_commitLogic_0_short_counter_1);
  assign _zz_commitLogic_0_short_counter_2 = commitLogic_0_short_inc;
  assign _zz_commitLogic_0_short_counter_1 = {3'd0, _zz_commitLogic_0_short_counter_2};
  assign _zz_commitLogic_0_short_counter_4 = commitLogic_0_short_dec;
  assign _zz_commitLogic_0_short_counter_3 = {3'd0, _zz_commitLogic_0_short_counter_4};
  assign _zz_when = 1'b1;
  assign _zz_load_s1_fsm_shift_input_1 = (load_s1_fsm_shift_input <<< 1'b1);
  assign _zz_load_s1_fsm_shift_input_2 = (load_s1_fsm_shift_input_1 <<< 2'b10);
  assign _zz_load_s1_fsm_shift_input_3 = (load_s1_fsm_shift_input_2 <<< 3'b100);
  assign _zz_load_s1_fsm_shift_input_4 = (load_s1_fsm_shift_input_3 <<< 4'b1000);
  assign _zz_load_s1_fsm_shift_input_5 = (load_s1_fsm_shift_input_4 <<< 5'h10);
  assign _zz_load_s0_output_rData_value_3 = _zz_load_s0_output_rData_value_4;
  assign _zz_load_s0_output_rData_value_2 = _zz_load_s0_output_rData_value_3[31:0];
  assign _zz_load_s0_output_rData_value_4 = ({_zz_load_s0_output_rData_value_1,(_zz_load_s0_output_rData_value_1 ? (~ _zz_load_s0_output_rData_value) : _zz_load_s0_output_rData_value)} + _zz_load_s0_output_rData_value_5);
  assign _zz_load_s0_output_rData_value_6 = _zz_load_s0_output_rData_value_1;
  assign _zz_load_s0_output_rData_value_5 = {32'd0, _zz_load_s0_output_rData_value_6};
  assign _zz__zz_load_s1_fsm_shift_by_1_1 = (_zz_load_s1_fsm_shift_by - 32'h00000001);
  assign _zz_load_s1_recoded_exponent = (_zz_load_s1_recoded_exponent_1 + _zz_load_s1_recoded_exponent_2);
  assign _zz_load_s1_recoded_exponent_1 = ({1'b0,load_s1_passThroughFloat_exponent} - {1'b0,load_s1_fsm_expOffset});
  assign _zz_load_s1_recoded_exponent_2 = {1'd0, load_s1_recodedExpOffset};
  assign _zz_load_s1_output_payload_value_exponent = {4'd0, load_s1_fsm_shift_by};
  assign _zz_shortPip_f32_exp = (shortPip_input_payload_rs1_exponent - 9'h080);
  assign _zz_shortPip_expInSubnormalRange = {1'd0, shortPip_expSubnormalThreshold};
  assign _zz_shortPip_fsm_shift_input_1 = (shortPip_fsm_shift_input >>> 6'h20);
  assign _zz_shortPip_fsm_shift_input_2 = (shortPip_fsm_shift_input_1 >>> 5'h10);
  assign _zz_shortPip_fsm_shift_input_3 = (shortPip_fsm_shift_input_2 >>> 4'b1000);
  assign _zz_shortPip_fsm_shift_input_4 = (shortPip_fsm_shift_input_3 >>> 3'b100);
  assign _zz_shortPip_fsm_shift_input_5 = (shortPip_fsm_shift_input_4 >>> 2'b10);
  assign _zz_shortPip_fsm_shift_input_6 = (shortPip_fsm_shift_input_5 >>> 1'b1);
  assign _zz_shortPip_fsm_shift_by_2 = (((_zz_shortPip_fsm_shift_by < _zz_shortPip_fsm_shift_by_3) ? _zz_shortPip_fsm_shift_by : _zz_shortPip_fsm_shift_by_4) + 9'h0);
  assign _zz_shortPip_fsm_shift_by_3 = {3'd0, _zz_shortPip_fsm_shift_by_1};
  assign _zz_shortPip_fsm_shift_by_4 = {3'd0, _zz_shortPip_fsm_shift_by_1};
  assign _zz_shortPip_fsm_shift_by_5 = (_zz_shortPip_fsm_shift_by_6 - shortPip_input_payload_rs1_exponent);
  assign _zz_shortPip_fsm_shift_by_6 = {1'd0, shortPip_fsm_formatShiftOffset};
  assign _zz_shortPip_f2i_result_1 = (shortPip_f2i_resign ^ shortPip_f2i_increment);
  assign _zz_shortPip_f2i_result = {31'd0, _zz_shortPip_f2i_result_1};
  assign _zz_mul_sum1_sum = {12'd0, mul_sum1_input_payload_muls_0};
  assign _zz_mul_sum1_sum_2 = ({18'd0,mul_sum1_input_payload_muls_1} <<< 18);
  assign _zz_mul_sum1_sum_1 = {6'd0, _zz_mul_sum1_sum_2};
  assign _zz_mul_sum2_sum = (_zz_mul_sum2_sum_1 + _zz_mul_sum2_sum_3);
  assign _zz_mul_sum2_sum_2 = ({18'd0,mul_sum2_input_payload_muls2_0} <<< 18);
  assign _zz_mul_sum2_sum_1 = {6'd0, _zz_mul_sum2_sum_2};
  assign _zz_mul_sum2_sum_4 = ({36'd0,mul_sum2_input_payload_muls2_1} <<< 36);
  assign _zz_mul_sum2_sum_3 = _zz_mul_sum2_sum_4;
  assign _zz_mul_norm_exp_1 = mul_norm_needShift;
  assign _zz_mul_norm_exp = {9'd0, _zz_mul_norm_exp_1};
  assign _zz_mul_norm_forceUnderflow = {1'd0, mul_norm_underflowThreshold};
  assign _zz_mul_norm_output_exponent = (mul_norm_exp - 10'h0ff);
  assign _zz_div_exponent = (_zz_div_exponent_1 - _zz_div_exponent_3);
  assign _zz_div_exponent_1 = (_zz_div_exponent_2 + 11'h4ff);
  assign _zz_div_exponent_2 = {2'd0, div_input_payload_rs1_exponent};
  assign _zz_div_exponent_3 = {2'd0, div_input_payload_rs2_exponent};
  assign _zz_div_exponent_5 = div_needShift;
  assign _zz_div_exponent_4 = {10'd0, _zz_div_exponent_5};
  assign _zz_sqrt_exponent = (_zz_sqrt_exponent_1 + {1'b0,_zz_sqrt_exponent_3});
  assign _zz_sqrt_exponent_2 = {1'b0,7'h7f};
  assign _zz_sqrt_exponent_1 = {1'd0, _zz_sqrt_exponent_2};
  assign _zz_sqrt_exponent_3 = (sqrt_input_payload_rs1_exponent >>> 1);
  assign _zz_sqrt_exponent_5 = sqrt_input_payload_rs1_exponent[0];
  assign _zz_sqrt_exponent_4 = {8'd0, _zz_sqrt_exponent_5};
  assign _zz_add_shifter_shiftBy_1 = (_zz_add_shifter_shiftBy[9] ? _zz_add_shifter_shiftBy_2 : _zz_add_shifter_shiftBy);
  assign _zz_add_shifter_shiftBy_2 = (~ _zz_add_shifter_shiftBy);
  assign _zz_add_shifter_shiftBy_4 = _zz_add_shifter_shiftBy[9];
  assign _zz_add_shifter_shiftBy_3 = {9'd0, _zz_add_shifter_shiftBy_4};
  assign _zz_add_shifter_yMantissa_1 = (add_shifter_yMantissa >>> 5'h10);
  assign _zz_add_shifter_yMantissa_2 = (add_shifter_yMantissa_1 >>> 4'b1000);
  assign _zz_add_shifter_yMantissa_3 = (add_shifter_yMantissa_2 >>> 3'b100);
  assign _zz_add_shifter_yMantissa_4 = (add_shifter_yMantissa_3 >>> 2'b10);
  assign _zz_add_shifter_yMantissa_5 = (add_shifter_yMantissa_4 >>> 1'b1);
  assign _zz_add_math_xSigned = ({add_math_input_payload_xSign,(add_math_input_payload_xSign ? (~ add_math_input_payload_xMantissa) : add_math_input_payload_xMantissa)} + _zz_add_math_xSigned_1);
  assign _zz_add_math_xSigned_2 = add_math_input_payload_xSign;
  assign _zz_add_math_xSigned_1 = {26'd0, _zz_add_math_xSigned_2};
  assign _zz_add_math_ySigned = ({add_math_input_payload_ySign,(add_math_input_payload_ySign ? (~ add_math_input_payload_yMantissa) : add_math_input_payload_yMantissa)} + _zz_add_math_ySigned_1);
  assign _zz_add_math_ySigned_2 = (add_math_input_payload_ySign && (! add_math_input_payload_roundingScrap));
  assign _zz_add_math_ySigned_1 = {26'd0, _zz_add_math_ySigned_2};
  assign _zz_add_math_output_payload_xyMantissa = _zz_add_math_output_payload_xyMantissa_1;
  assign _zz_add_math_output_payload_xyMantissa_1 = ($signed(_zz_add_math_output_payload_xyMantissa_2) + $signed(_zz_add_math_output_payload_xyMantissa_3));
  assign _zz_add_math_output_payload_xyMantissa_2 = {add_math_xSigned[26],add_math_xSigned};
  assign _zz_add_math_output_payload_xyMantissa_3 = {add_math_ySigned[26],add_math_ySigned};
  assign _zz__zz_add_oh_shift_1_1 = (_zz_add_oh_shift - 27'h0000001);
  assign _zz_add_norm_output_payload_exponent = ({1'b0,add_norm_input_payload_xyExponent} - _zz_add_norm_output_payload_exponent_1);
  assign _zz_add_norm_output_payload_exponent_2 = {1'b0,add_norm_input_payload_shift};
  assign _zz_add_norm_output_payload_exponent_1 = {4'd0, _zz_add_norm_output_payload_exponent_2};
  assign _zz_add_result_output_payload_value_mantissa = (add_result_input_payload_mantissa >>> 2);
  assign _zz_roundFront_expDif_1 = {1'b0,roundFront_expBase};
  assign _zz_roundFront_expDif = {1'd0, _zz_roundFront_expDif_1};
  assign _zz_roundFront_discardCount = roundFront_expDif[4:0];
  assign _zz_roundFront_roundAdjusted = {1'b1,_zz_roundFront_roundAdjusted_1};
  assign _zz_roundFront_roundAdjusted_1 = (roundFront_manAggregate >>> 1);
  assign _zz__zz_roundFront_mantissaIncrement = {2'b01,_zz__zz_roundFront_mantissaIncrement_1};
  assign _zz__zz_roundFront_mantissaIncrement_1 = (roundFront_manAggregate >>> 2);
  assign _zz_roundBack_adderMantissa = (roundBack_input_payload_exactMask[23 : 0] >>> 1);
  assign _zz_roundBack_adderRightOp = (roundBack_input_payload_mantissaIncrement ? _zz_roundBack_adderRightOp_1 : 24'h0);
  assign _zz_roundBack_adderRightOp_1 = (roundBack_input_payload_exactMask >>> 1);
  assign _zz_roundBack_adder_2 = (_zz_roundBack_adder + _zz_roundBack_adder_3);
  assign _zz_roundBack_adder_3 = {9'd0, roundBack_adderRightOp};
  assign _zz_roundBack_adder_4 = {31'd0, _zz_roundBack_adder_1};
  assign _zz_roundBack_borringCase = {1'd0, roundBack_ufSubnormalThreshold};
  assign _zz_when_FpuCore_l1608 = {1'd0, roundBack_ufSubnormalThreshold};
  assign _zz_when_FpuCore_l1630 = {2'd0, roundBack_ufThreshold};
  assign _zz_rf_ram_port = {writeback_port_payload_data_value_special,{writeback_port_payload_data_value_sign,{writeback_port_payload_data_value_exponent,writeback_port_payload_data_value_mantissa}}};
  assign _zz_rf_scoreboards_0_target_port = rf_scoreboards_0_targetWrite_payload_data;
  assign _zz_rf_scoreboards_0_hit_port = rf_scoreboards_0_hitWrite_payload_data;
  assign _zz_rf_scoreboards_0_writes_port = commitLogic_0_input_payload_write;
  assign _zz_decode_shortPipHit = FpuOpcode_MIN_MAX;
  assign _zz_decode_shortPipHit_1 = (decode_input_payload_opcode == FpuOpcode_CMP);
  assign _zz_decode_shortPipHit_2 = (decode_input_payload_opcode == FpuOpcode_F2I);
  assign _zz_decode_shortPipHit_3 = (decode_input_payload_opcode == FpuOpcode_STORE);
  assign _zz__zz_load_s1_fsm_shift_by = load_s1_fsm_ohInput[9];
  assign _zz__zz_load_s1_fsm_shift_by_1 = load_s1_fsm_ohInput[10];
  assign _zz__zz_load_s1_fsm_shift_by_2 = {load_s1_fsm_ohInput[11],{load_s1_fsm_ohInput[12],{load_s1_fsm_ohInput[13],{load_s1_fsm_ohInput[14],{load_s1_fsm_ohInput[15],{load_s1_fsm_ohInput[16],{load_s1_fsm_ohInput[17],{load_s1_fsm_ohInput[18],{load_s1_fsm_ohInput[19],{_zz__zz_load_s1_fsm_shift_by_3,{_zz__zz_load_s1_fsm_shift_by_4,_zz__zz_load_s1_fsm_shift_by_5}}}}}}}}}}};
  assign _zz__zz_load_s1_fsm_shift_by_3 = load_s1_fsm_ohInput[20];
  assign _zz__zz_load_s1_fsm_shift_by_4 = load_s1_fsm_ohInput[21];
  assign _zz__zz_load_s1_fsm_shift_by_5 = {load_s1_fsm_ohInput[22],{load_s1_fsm_ohInput[23],{load_s1_fsm_ohInput[24],{load_s1_fsm_ohInput[25],{load_s1_fsm_ohInput[26],{load_s1_fsm_ohInput[27],{load_s1_fsm_ohInput[28],{load_s1_fsm_ohInput[29],{load_s1_fsm_ohInput[30],load_s1_fsm_ohInput[31]}}}}}}}}};
  assign _zz__zz_add_oh_shift = add_oh_output_payload_xyMantissa[9];
  assign _zz__zz_add_oh_shift_1 = add_oh_output_payload_xyMantissa[10];
  assign _zz__zz_add_oh_shift_2 = {add_oh_output_payload_xyMantissa[11],{add_oh_output_payload_xyMantissa[12],{add_oh_output_payload_xyMantissa[13],{add_oh_output_payload_xyMantissa[14],{add_oh_output_payload_xyMantissa[15],{add_oh_output_payload_xyMantissa[16],{add_oh_output_payload_xyMantissa[17],{add_oh_output_payload_xyMantissa[18],{add_oh_output_payload_xyMantissa[19],{_zz__zz_add_oh_shift_3,{_zz__zz_add_oh_shift_4,_zz__zz_add_oh_shift_5}}}}}}}}}}};
  assign _zz__zz_add_oh_shift_3 = add_oh_output_payload_xyMantissa[20];
  assign _zz__zz_add_oh_shift_4 = add_oh_output_payload_xyMantissa[21];
  assign _zz__zz_add_oh_shift_5 = {add_oh_output_payload_xyMantissa[22],{add_oh_output_payload_xyMantissa[23],{add_oh_output_payload_xyMantissa[24],{add_oh_output_payload_xyMantissa[25],add_oh_output_payload_xyMantissa[26]}}}};
  assign _zz_roundFront_exactMask = 5'h13;
  assign _zz_roundFront_exactMask_1 = (5'h12 < roundFront_discardCount);
  assign _zz_roundFront_exactMask_2 = (5'h11 < roundFront_discardCount);
  assign _zz_roundFront_exactMask_3 = {(5'h10 < roundFront_discardCount),{(5'h0f < roundFront_discardCount),{(5'h0e < roundFront_discardCount),{(5'h0d < roundFront_discardCount),{(5'h0c < roundFront_discardCount),{(_zz_roundFront_exactMask_4 < roundFront_discardCount),{_zz_roundFront_exactMask_5,{_zz_roundFront_exactMask_6,_zz_roundFront_exactMask_7}}}}}}}};
  assign _zz_roundFront_exactMask_4 = 5'h0b;
  assign _zz_roundFront_exactMask_5 = (5'h0a < roundFront_discardCount);
  assign _zz_roundFront_exactMask_6 = (5'h09 < roundFront_discardCount);
  assign _zz_roundFront_exactMask_7 = {(5'h08 < roundFront_discardCount),{(5'h07 < roundFront_discardCount),{(5'h06 < roundFront_discardCount),{(5'h05 < roundFront_discardCount),{(5'h04 < roundFront_discardCount),{(_zz_roundFront_exactMask_8 < roundFront_discardCount),{_zz_roundFront_exactMask_9,{_zz_roundFront_exactMask_10,_zz_roundFront_exactMask_11}}}}}}}};
  assign _zz_roundFront_exactMask_8 = 5'h03;
  assign _zz_roundFront_exactMask_9 = (5'h02 < roundFront_discardCount);
  assign _zz_roundFront_exactMask_10 = (5'h01 < roundFront_discardCount);
  assign _zz_roundFront_exactMask_11 = {(5'h0 < roundFront_discardCount),1'b1};
  always @(posedge clk) begin
    if(_zz_read_rs_0_value_mantissa_1) begin
      _zz_rf_ram_port0 <= rf_ram[_zz_read_rs_0_value_mantissa];
    end
  end

  always @(posedge clk) begin
    if(_zz_read_rs_1_value_mantissa_1) begin
      _zz_rf_ram_port1 <= rf_ram[_zz_read_rs_1_value_mantissa];
    end
  end

  always @(posedge clk) begin
    if(_zz_read_rs_2_value_mantissa_1) begin
      _zz_rf_ram_port2 <= rf_ram[_zz_read_rs_2_value_mantissa];
    end
  end

  always @(posedge clk) begin
    if(_zz_1) begin
      rf_ram[writeback_port_payload_address] <= _zz_rf_ram_port;
    end
  end

  always @(posedge clk) begin
    if(_zz_4) begin
      rf_scoreboards_0_target[rf_scoreboards_0_targetWrite_payload_address] <= _zz_rf_scoreboards_0_target_port;
    end
  end

  assign _zz_rf_scoreboards_0_target_port1 = rf_scoreboards_0_target[scheduler_0_input_payload_rs1];
  assign _zz_rf_scoreboards_0_target_port2 = rf_scoreboards_0_target[scheduler_0_input_payload_rs2];
  assign _zz_rf_scoreboards_0_target_port3 = rf_scoreboards_0_target[scheduler_0_input_payload_rs3];
  assign _zz_rf_scoreboards_0_target_port4 = rf_scoreboards_0_target[scheduler_0_input_payload_rd];
  always @(posedge clk) begin
    if(_zz_3) begin
      rf_scoreboards_0_hit[rf_scoreboards_0_hitWrite_payload_address] <= _zz_rf_scoreboards_0_hit_port;
    end
  end

  assign _zz_rf_scoreboards_0_hit_port1 = rf_scoreboards_0_hit[scheduler_0_input_payload_rs1];
  assign _zz_rf_scoreboards_0_hit_port2 = rf_scoreboards_0_hit[scheduler_0_input_payload_rs2];
  assign _zz_rf_scoreboards_0_hit_port3 = rf_scoreboards_0_hit[scheduler_0_input_payload_rs3];
  assign _zz_rf_scoreboards_0_hit_port4 = rf_scoreboards_0_hit[scheduler_0_input_payload_rd];
  assign _zz_rf_scoreboards_0_hit_port5 = rf_scoreboards_0_hit[writeback_input_payload_rd];
  always @(posedge clk) begin
    if(_zz_2) begin
      rf_scoreboards_0_writes[commitLogic_0_input_payload_rd] <= _zz_rf_scoreboards_0_writes_port;
    end
  end

  assign _zz_rf_scoreboards_0_writes_port1 = rf_scoreboards_0_writes[roundBack_input_payload_rd];
  StreamFork streamFork_1 (
    .io_input_valid              (io_port_0_commit_valid                       ), //i
    .io_input_ready              (streamFork_1_io_input_ready                  ), //o
    .io_input_payload_opcode     (io_port_0_commit_payload_opcode[3:0]         ), //i
    .io_input_payload_rd         (io_port_0_commit_payload_rd[4:0]             ), //i
    .io_input_payload_write      (io_port_0_commit_payload_write               ), //i
    .io_input_payload_value      (io_port_0_commit_payload_value[31:0]         ), //i
    .io_outputs_0_valid          (streamFork_1_io_outputs_0_valid              ), //o
    .io_outputs_0_ready          (commitFork_load_0_ready                      ), //i
    .io_outputs_0_payload_opcode (streamFork_1_io_outputs_0_payload_opcode[3:0]), //o
    .io_outputs_0_payload_rd     (streamFork_1_io_outputs_0_payload_rd[4:0]    ), //o
    .io_outputs_0_payload_write  (streamFork_1_io_outputs_0_payload_write      ), //o
    .io_outputs_0_payload_value  (streamFork_1_io_outputs_0_payload_value[31:0]), //o
    .io_outputs_1_valid          (streamFork_1_io_outputs_1_valid              ), //o
    .io_outputs_1_ready          (streamFork_1_io_outputs_1_ready              ), //i
    .io_outputs_1_payload_opcode (streamFork_1_io_outputs_1_payload_opcode[3:0]), //o
    .io_outputs_1_payload_rd     (streamFork_1_io_outputs_1_payload_rd[4:0]    ), //o
    .io_outputs_1_payload_write  (streamFork_1_io_outputs_1_payload_write      ), //o
    .io_outputs_1_payload_value  (streamFork_1_io_outputs_1_payload_value[31:0])  //o
  );
  StreamArbiter_1 cmdArbiter_arbiter (
    .io_inputs_0_valid             (scheduler_0_output_valid                           ), //i
    .io_inputs_0_ready             (cmdArbiter_arbiter_io_inputs_0_ready               ), //o
    .io_inputs_0_payload_opcode    (_zz_io_inputs_0_payload_opcode[3:0]                ), //i
    .io_inputs_0_payload_arg       (scheduler_0_output_payload_arg[1:0]                ), //i
    .io_inputs_0_payload_rs1       (scheduler_0_output_payload_rs1[4:0]                ), //i
    .io_inputs_0_payload_rs2       (scheduler_0_output_payload_rs2[4:0]                ), //i
    .io_inputs_0_payload_rs3       (scheduler_0_output_payload_rs3[4:0]                ), //i
    .io_inputs_0_payload_rd        (scheduler_0_output_payload_rd[4:0]                 ), //i
    .io_inputs_0_payload_format    (_zz_io_inputs_0_payload_format                     ), //i
    .io_inputs_0_payload_roundMode (_zz_io_inputs_0_payload_roundMode[2:0]             ), //i
    .io_output_valid               (cmdArbiter_arbiter_io_output_valid                 ), //o
    .io_output_ready               (cmdArbiter_output_ready                            ), //i
    .io_output_payload_opcode      (cmdArbiter_arbiter_io_output_payload_opcode[3:0]   ), //o
    .io_output_payload_arg         (cmdArbiter_arbiter_io_output_payload_arg[1:0]      ), //o
    .io_output_payload_rs1         (cmdArbiter_arbiter_io_output_payload_rs1[4:0]      ), //o
    .io_output_payload_rs2         (cmdArbiter_arbiter_io_output_payload_rs2[4:0]      ), //o
    .io_output_payload_rs3         (cmdArbiter_arbiter_io_output_payload_rs3[4:0]      ), //o
    .io_output_payload_rd          (cmdArbiter_arbiter_io_output_payload_rd[4:0]       ), //o
    .io_output_payload_format      (cmdArbiter_arbiter_io_output_payload_format        ), //o
    .io_output_payload_roundMode   (cmdArbiter_arbiter_io_output_payload_roundMode[2:0]), //o
    .io_chosenOH                   (cmdArbiter_arbiter_io_chosenOH                     ), //o
    .clk                           (clk                                                ), //i
    .reset                         (reset                                              )  //i
  );
  FpuDiv div_divider (
    .io_input_valid           (div_divider_io_input_valid                ), //i
    .io_input_ready           (div_divider_io_input_ready                ), //o
    .io_input_payload_a       (div_divider_io_input_payload_a[23:0]      ), //i
    .io_input_payload_b       (div_divider_io_input_payload_b[23:0]      ), //i
    .io_output_valid          (div_divider_io_output_valid               ), //o
    .io_output_ready          (div_input_ready                           ), //i
    .io_output_payload_result (div_divider_io_output_payload_result[26:0]), //o
    .io_output_payload_remain (div_divider_io_output_payload_remain[24:0]), //o
    .clk                      (clk                                       ), //i
    .reset                    (reset                                     )  //i
  );
  FpuSqrt sqrt_sqrt (
    .io_input_valid           (sqrt_sqrt_io_input_valid                ), //i
    .io_input_ready           (sqrt_sqrt_io_input_ready                ), //o
    .io_input_payload_a       (sqrt_sqrt_io_input_payload_a[24:0]      ), //i
    .io_output_valid          (sqrt_sqrt_io_output_valid               ), //o
    .io_output_ready          (sqrt_input_ready                        ), //i
    .io_output_payload_result (sqrt_sqrt_io_output_payload_result[23:0]), //o
    .io_output_payload_remain (sqrt_sqrt_io_output_payload_remain[27:0]), //o
    .clk                      (clk                                     ), //i
    .reset                    (reset                                   )  //i
  );
  StreamArbiter streamArbiter_2 (
    .io_inputs_0_valid                  (load_s1_output_m2sPipe_valid                          ), //i
    .io_inputs_0_ready                  (streamArbiter_2_io_inputs_0_ready                     ), //o
    .io_inputs_0_payload_rd             (load_s1_output_m2sPipe_payload_rd[4:0]                ), //i
    .io_inputs_0_payload_value_mantissa (load_s1_output_m2sPipe_payload_value_mantissa[23:0]   ), //i
    .io_inputs_0_payload_value_exponent (load_s1_output_m2sPipe_payload_value_exponent[8:0]    ), //i
    .io_inputs_0_payload_value_sign     (load_s1_output_m2sPipe_payload_value_sign             ), //i
    .io_inputs_0_payload_value_special  (load_s1_output_m2sPipe_payload_value_special          ), //i
    .io_inputs_0_payload_scrap          (load_s1_output_m2sPipe_payload_scrap                  ), //i
    .io_inputs_0_payload_roundMode      (load_s1_output_m2sPipe_payload_roundMode[2:0]         ), //i
    .io_inputs_0_payload_NV             (load_s1_output_m2sPipe_payload_NV                     ), //i
    .io_inputs_0_payload_DZ             (load_s1_output_m2sPipe_payload_DZ                     ), //i
    .io_inputs_1_valid                  (sqrt_output_valid                                     ), //i
    .io_inputs_1_ready                  (streamArbiter_2_io_inputs_1_ready                     ), //o
    .io_inputs_1_payload_rd             (sqrt_output_payload_rd[4:0]                           ), //i
    .io_inputs_1_payload_value_mantissa (sqrt_output_payload_value_mantissa[23:0]              ), //i
    .io_inputs_1_payload_value_exponent (sqrt_output_payload_value_exponent[8:0]               ), //i
    .io_inputs_1_payload_value_sign     (sqrt_output_payload_value_sign                        ), //i
    .io_inputs_1_payload_value_special  (sqrt_output_payload_value_special                     ), //i
    .io_inputs_1_payload_scrap          (sqrt_output_payload_scrap                             ), //i
    .io_inputs_1_payload_roundMode      (sqrt_output_payload_roundMode[2:0]                    ), //i
    .io_inputs_1_payload_NV             (sqrt_output_payload_NV                                ), //i
    .io_inputs_1_payload_DZ             (sqrt_output_payload_DZ                                ), //i
    .io_inputs_2_valid                  (div_output_valid                                      ), //i
    .io_inputs_2_ready                  (streamArbiter_2_io_inputs_2_ready                     ), //o
    .io_inputs_2_payload_rd             (div_output_payload_rd[4:0]                            ), //i
    .io_inputs_2_payload_value_mantissa (div_output_payload_value_mantissa[23:0]               ), //i
    .io_inputs_2_payload_value_exponent (div_output_payload_value_exponent[8:0]                ), //i
    .io_inputs_2_payload_value_sign     (div_output_payload_value_sign                         ), //i
    .io_inputs_2_payload_value_special  (div_output_payload_value_special                      ), //i
    .io_inputs_2_payload_scrap          (div_output_payload_scrap                              ), //i
    .io_inputs_2_payload_roundMode      (div_output_payload_roundMode[2:0]                     ), //i
    .io_inputs_2_payload_NV             (div_output_payload_NV                                 ), //i
    .io_inputs_2_payload_DZ             (div_output_payload_DZ                                 ), //i
    .io_inputs_3_valid                  (add_result_output_valid                               ), //i
    .io_inputs_3_ready                  (streamArbiter_2_io_inputs_3_ready                     ), //o
    .io_inputs_3_payload_rd             (add_result_output_payload_rd[4:0]                     ), //i
    .io_inputs_3_payload_value_mantissa (add_result_output_payload_value_mantissa[23:0]        ), //i
    .io_inputs_3_payload_value_exponent (add_result_output_payload_value_exponent[8:0]         ), //i
    .io_inputs_3_payload_value_sign     (add_result_output_payload_value_sign                  ), //i
    .io_inputs_3_payload_value_special  (add_result_output_payload_value_special               ), //i
    .io_inputs_3_payload_scrap          (add_result_output_payload_scrap                       ), //i
    .io_inputs_3_payload_roundMode      (add_result_output_payload_roundMode[2:0]              ), //i
    .io_inputs_3_payload_NV             (add_result_output_payload_NV                          ), //i
    .io_inputs_3_payload_DZ             (add_result_output_payload_DZ                          ), //i
    .io_inputs_4_valid                  (mul_result_output_valid                               ), //i
    .io_inputs_4_ready                  (streamArbiter_2_io_inputs_4_ready                     ), //o
    .io_inputs_4_payload_rd             (mul_result_output_payload_rd[4:0]                     ), //i
    .io_inputs_4_payload_value_mantissa (mul_result_output_payload_value_mantissa[23:0]        ), //i
    .io_inputs_4_payload_value_exponent (mul_result_output_payload_value_exponent[8:0]         ), //i
    .io_inputs_4_payload_value_sign     (mul_result_output_payload_value_sign                  ), //i
    .io_inputs_4_payload_value_special  (mul_result_output_payload_value_special               ), //i
    .io_inputs_4_payload_scrap          (mul_result_output_payload_scrap                       ), //i
    .io_inputs_4_payload_roundMode      (mul_result_output_payload_roundMode[2:0]              ), //i
    .io_inputs_4_payload_NV             (mul_result_output_payload_NV                          ), //i
    .io_inputs_4_payload_DZ             (mul_result_output_payload_DZ                          ), //i
    .io_inputs_5_valid                  (shortPip_output_m2sPipe_valid                         ), //i
    .io_inputs_5_ready                  (streamArbiter_2_io_inputs_5_ready                     ), //o
    .io_inputs_5_payload_rd             (shortPip_output_m2sPipe_payload_rd[4:0]               ), //i
    .io_inputs_5_payload_value_mantissa (shortPip_output_m2sPipe_payload_value_mantissa[23:0]  ), //i
    .io_inputs_5_payload_value_exponent (shortPip_output_m2sPipe_payload_value_exponent[8:0]   ), //i
    .io_inputs_5_payload_value_sign     (shortPip_output_m2sPipe_payload_value_sign            ), //i
    .io_inputs_5_payload_value_special  (shortPip_output_m2sPipe_payload_value_special         ), //i
    .io_inputs_5_payload_scrap          (shortPip_output_m2sPipe_payload_scrap                 ), //i
    .io_inputs_5_payload_roundMode      (shortPip_output_m2sPipe_payload_roundMode[2:0]        ), //i
    .io_inputs_5_payload_NV             (shortPip_output_m2sPipe_payload_NV                    ), //i
    .io_inputs_5_payload_DZ             (shortPip_output_m2sPipe_payload_DZ                    ), //i
    .io_output_valid                    (streamArbiter_2_io_output_valid                       ), //o
    .io_output_ready                    (1'b1                                                  ), //i
    .io_output_payload_rd               (streamArbiter_2_io_output_payload_rd[4:0]             ), //o
    .io_output_payload_value_mantissa   (streamArbiter_2_io_output_payload_value_mantissa[23:0]), //o
    .io_output_payload_value_exponent   (streamArbiter_2_io_output_payload_value_exponent[8:0] ), //o
    .io_output_payload_value_sign       (streamArbiter_2_io_output_payload_value_sign          ), //o
    .io_output_payload_value_special    (streamArbiter_2_io_output_payload_value_special       ), //o
    .io_output_payload_scrap            (streamArbiter_2_io_output_payload_scrap               ), //o
    .io_output_payload_roundMode        (streamArbiter_2_io_output_payload_roundMode[2:0]      ), //o
    .io_output_payload_NV               (streamArbiter_2_io_output_payload_NV                  ), //o
    .io_output_payload_DZ               (streamArbiter_2_io_output_payload_DZ                  ), //o
    .io_chosen                          (streamArbiter_2_io_chosen[2:0]                        ), //o
    .io_chosenOH                        (streamArbiter_2_io_chosenOH[5:0]                      ), //o
    .clk                                (clk                                                   ), //i
    .reset                              (reset                                                 )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_port_0_cmd_payload_opcode)
      FpuOpcode_LOAD : io_port_0_cmd_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : io_port_0_cmd_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : io_port_0_cmd_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : io_port_0_cmd_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : io_port_0_cmd_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : io_port_0_cmd_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : io_port_0_cmd_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : io_port_0_cmd_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : io_port_0_cmd_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : io_port_0_cmd_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : io_port_0_cmd_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : io_port_0_cmd_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : io_port_0_cmd_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : io_port_0_cmd_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : io_port_0_cmd_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : io_port_0_cmd_payload_opcode_string = "FCVT_X_X";
      default : io_port_0_cmd_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_payload_format)
      FpuFormat_FLOAT : io_port_0_cmd_payload_format_string = "FLOAT ";
      FpuFormat_DOUBLE : io_port_0_cmd_payload_format_string = "DOUBLE";
      default : io_port_0_cmd_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_payload_roundMode)
      FpuRoundMode_RNE : io_port_0_cmd_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : io_port_0_cmd_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : io_port_0_cmd_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : io_port_0_cmd_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : io_port_0_cmd_payload_roundMode_string = "RMM";
      default : io_port_0_cmd_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_port_0_commit_payload_opcode)
      FpuOpcode_LOAD : io_port_0_commit_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : io_port_0_commit_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : io_port_0_commit_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : io_port_0_commit_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : io_port_0_commit_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : io_port_0_commit_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : io_port_0_commit_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : io_port_0_commit_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : io_port_0_commit_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : io_port_0_commit_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : io_port_0_commit_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : io_port_0_commit_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : io_port_0_commit_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : io_port_0_commit_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : io_port_0_commit_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : io_port_0_commit_payload_opcode_string = "FCVT_X_X";
      default : io_port_0_commit_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(commitFork_load_0_payload_opcode)
      FpuOpcode_LOAD : commitFork_load_0_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : commitFork_load_0_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : commitFork_load_0_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : commitFork_load_0_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : commitFork_load_0_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : commitFork_load_0_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : commitFork_load_0_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : commitFork_load_0_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : commitFork_load_0_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : commitFork_load_0_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : commitFork_load_0_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : commitFork_load_0_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : commitFork_load_0_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : commitFork_load_0_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : commitFork_load_0_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : commitFork_load_0_payload_opcode_string = "FCVT_X_X";
      default : commitFork_load_0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(commitFork_commit_0_payload_opcode)
      FpuOpcode_LOAD : commitFork_commit_0_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : commitFork_commit_0_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : commitFork_commit_0_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : commitFork_commit_0_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : commitFork_commit_0_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : commitFork_commit_0_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : commitFork_commit_0_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : commitFork_commit_0_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : commitFork_commit_0_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : commitFork_commit_0_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : commitFork_commit_0_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : commitFork_commit_0_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : commitFork_commit_0_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : commitFork_commit_0_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : commitFork_commit_0_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : commitFork_commit_0_payload_opcode_string = "FCVT_X_X";
      default : commitFork_commit_0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode)
      FpuOpcode_LOAD : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "FCVT_X_X";
      default : FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode)
      FpuOpcode_LOAD : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "LOAD    ";
      FpuOpcode_STORE : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "STORE   ";
      FpuOpcode_MUL : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "MUL     ";
      FpuOpcode_ADD : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "ADD     ";
      FpuOpcode_FMA : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "FMA     ";
      FpuOpcode_I2F : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "I2F     ";
      FpuOpcode_F2I : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "F2I     ";
      FpuOpcode_CMP : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "CMP     ";
      FpuOpcode_DIV : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "DIV     ";
      FpuOpcode_SQRT : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "FCVT_X_X";
      default : FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_payload_opcode)
      FpuOpcode_LOAD : _zz_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : _zz_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : _zz_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : _zz_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : _zz_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : _zz_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : _zz_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : _zz_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : _zz_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : _zz_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_payload_opcode_string = "FCVT_X_X";
      default : _zz_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_commitLogic_0_input_payload_opcode)
      FpuOpcode_LOAD : _zz_commitLogic_0_input_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : _zz_commitLogic_0_input_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : _zz_commitLogic_0_input_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : _zz_commitLogic_0_input_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : _zz_commitLogic_0_input_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : _zz_commitLogic_0_input_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : _zz_commitLogic_0_input_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : _zz_commitLogic_0_input_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : _zz_commitLogic_0_input_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : _zz_commitLogic_0_input_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_commitLogic_0_input_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_commitLogic_0_input_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_commitLogic_0_input_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_commitLogic_0_input_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_commitLogic_0_input_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_commitLogic_0_input_payload_opcode_string = "FCVT_X_X";
      default : _zz_commitLogic_0_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(commitLogic_0_input_payload_opcode)
      FpuOpcode_LOAD : commitLogic_0_input_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : commitLogic_0_input_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : commitLogic_0_input_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : commitLogic_0_input_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : commitLogic_0_input_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : commitLogic_0_input_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : commitLogic_0_input_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : commitLogic_0_input_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : commitLogic_0_input_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : commitLogic_0_input_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : commitLogic_0_input_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : commitLogic_0_input_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : commitLogic_0_input_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : commitLogic_0_input_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : commitLogic_0_input_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : commitLogic_0_input_payload_opcode_string = "FCVT_X_X";
      default : commitLogic_0_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(scheduler_0_input_payload_opcode)
      FpuOpcode_LOAD : scheduler_0_input_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : scheduler_0_input_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : scheduler_0_input_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : scheduler_0_input_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : scheduler_0_input_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : scheduler_0_input_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : scheduler_0_input_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : scheduler_0_input_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : scheduler_0_input_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : scheduler_0_input_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : scheduler_0_input_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : scheduler_0_input_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : scheduler_0_input_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : scheduler_0_input_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : scheduler_0_input_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : scheduler_0_input_payload_opcode_string = "FCVT_X_X";
      default : scheduler_0_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(scheduler_0_input_payload_format)
      FpuFormat_FLOAT : scheduler_0_input_payload_format_string = "FLOAT ";
      FpuFormat_DOUBLE : scheduler_0_input_payload_format_string = "DOUBLE";
      default : scheduler_0_input_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(scheduler_0_input_payload_roundMode)
      FpuRoundMode_RNE : scheduler_0_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : scheduler_0_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : scheduler_0_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : scheduler_0_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : scheduler_0_input_payload_roundMode_string = "RMM";
      default : scheduler_0_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_rData_opcode)
      FpuOpcode_LOAD : io_port_0_cmd_rData_opcode_string = "LOAD    ";
      FpuOpcode_STORE : io_port_0_cmd_rData_opcode_string = "STORE   ";
      FpuOpcode_MUL : io_port_0_cmd_rData_opcode_string = "MUL     ";
      FpuOpcode_ADD : io_port_0_cmd_rData_opcode_string = "ADD     ";
      FpuOpcode_FMA : io_port_0_cmd_rData_opcode_string = "FMA     ";
      FpuOpcode_I2F : io_port_0_cmd_rData_opcode_string = "I2F     ";
      FpuOpcode_F2I : io_port_0_cmd_rData_opcode_string = "F2I     ";
      FpuOpcode_CMP : io_port_0_cmd_rData_opcode_string = "CMP     ";
      FpuOpcode_DIV : io_port_0_cmd_rData_opcode_string = "DIV     ";
      FpuOpcode_SQRT : io_port_0_cmd_rData_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : io_port_0_cmd_rData_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : io_port_0_cmd_rData_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : io_port_0_cmd_rData_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : io_port_0_cmd_rData_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : io_port_0_cmd_rData_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : io_port_0_cmd_rData_opcode_string = "FCVT_X_X";
      default : io_port_0_cmd_rData_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_rData_format)
      FpuFormat_FLOAT : io_port_0_cmd_rData_format_string = "FLOAT ";
      FpuFormat_DOUBLE : io_port_0_cmd_rData_format_string = "DOUBLE";
      default : io_port_0_cmd_rData_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_rData_roundMode)
      FpuRoundMode_RNE : io_port_0_cmd_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : io_port_0_cmd_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : io_port_0_cmd_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : io_port_0_cmd_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : io_port_0_cmd_rData_roundMode_string = "RMM";
      default : io_port_0_cmd_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_scheduler_0_input_payload_opcode)
      FpuOpcode_LOAD : _zz_scheduler_0_input_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : _zz_scheduler_0_input_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : _zz_scheduler_0_input_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : _zz_scheduler_0_input_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : _zz_scheduler_0_input_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : _zz_scheduler_0_input_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : _zz_scheduler_0_input_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : _zz_scheduler_0_input_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : _zz_scheduler_0_input_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : _zz_scheduler_0_input_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_scheduler_0_input_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_scheduler_0_input_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_scheduler_0_input_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_scheduler_0_input_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_scheduler_0_input_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_scheduler_0_input_payload_opcode_string = "FCVT_X_X";
      default : _zz_scheduler_0_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_scheduler_0_input_payload_format)
      FpuFormat_FLOAT : _zz_scheduler_0_input_payload_format_string = "FLOAT ";
      FpuFormat_DOUBLE : _zz_scheduler_0_input_payload_format_string = "DOUBLE";
      default : _zz_scheduler_0_input_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_scheduler_0_input_payload_roundMode)
      FpuRoundMode_RNE : _zz_scheduler_0_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : _zz_scheduler_0_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : _zz_scheduler_0_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : _zz_scheduler_0_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : _zz_scheduler_0_input_payload_roundMode_string = "RMM";
      default : _zz_scheduler_0_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(scheduler_0_output_payload_opcode)
      FpuOpcode_LOAD : scheduler_0_output_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : scheduler_0_output_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : scheduler_0_output_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : scheduler_0_output_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : scheduler_0_output_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : scheduler_0_output_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : scheduler_0_output_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : scheduler_0_output_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : scheduler_0_output_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : scheduler_0_output_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : scheduler_0_output_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : scheduler_0_output_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : scheduler_0_output_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : scheduler_0_output_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : scheduler_0_output_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : scheduler_0_output_payload_opcode_string = "FCVT_X_X";
      default : scheduler_0_output_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(scheduler_0_output_payload_format)
      FpuFormat_FLOAT : scheduler_0_output_payload_format_string = "FLOAT ";
      FpuFormat_DOUBLE : scheduler_0_output_payload_format_string = "DOUBLE";
      default : scheduler_0_output_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(scheduler_0_output_payload_roundMode)
      FpuRoundMode_RNE : scheduler_0_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : scheduler_0_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : scheduler_0_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : scheduler_0_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : scheduler_0_output_payload_roundMode_string = "RMM";
      default : scheduler_0_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_io_inputs_0_payload_opcode)
      FpuOpcode_LOAD : _zz_io_inputs_0_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : _zz_io_inputs_0_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : _zz_io_inputs_0_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : _zz_io_inputs_0_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : _zz_io_inputs_0_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : _zz_io_inputs_0_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : _zz_io_inputs_0_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : _zz_io_inputs_0_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : _zz_io_inputs_0_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : _zz_io_inputs_0_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_io_inputs_0_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_io_inputs_0_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_io_inputs_0_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_io_inputs_0_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_io_inputs_0_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_io_inputs_0_payload_opcode_string = "FCVT_X_X";
      default : _zz_io_inputs_0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_inputs_0_payload_format)
      FpuFormat_FLOAT : _zz_io_inputs_0_payload_format_string = "FLOAT ";
      FpuFormat_DOUBLE : _zz_io_inputs_0_payload_format_string = "DOUBLE";
      default : _zz_io_inputs_0_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_io_inputs_0_payload_roundMode)
      FpuRoundMode_RNE : _zz_io_inputs_0_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : _zz_io_inputs_0_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : _zz_io_inputs_0_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : _zz_io_inputs_0_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : _zz_io_inputs_0_payload_roundMode_string = "RMM";
      default : _zz_io_inputs_0_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(cmdArbiter_output_payload_opcode)
      FpuOpcode_LOAD : cmdArbiter_output_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : cmdArbiter_output_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : cmdArbiter_output_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : cmdArbiter_output_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : cmdArbiter_output_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : cmdArbiter_output_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : cmdArbiter_output_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : cmdArbiter_output_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : cmdArbiter_output_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : cmdArbiter_output_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : cmdArbiter_output_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : cmdArbiter_output_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : cmdArbiter_output_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : cmdArbiter_output_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : cmdArbiter_output_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : cmdArbiter_output_payload_opcode_string = "FCVT_X_X";
      default : cmdArbiter_output_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(cmdArbiter_output_payload_roundMode)
      FpuRoundMode_RNE : cmdArbiter_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : cmdArbiter_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : cmdArbiter_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : cmdArbiter_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : cmdArbiter_output_payload_roundMode_string = "RMM";
      default : cmdArbiter_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(read_s0_payload_opcode)
      FpuOpcode_LOAD : read_s0_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : read_s0_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : read_s0_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : read_s0_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : read_s0_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : read_s0_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : read_s0_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : read_s0_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : read_s0_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : read_s0_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : read_s0_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : read_s0_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : read_s0_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : read_s0_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : read_s0_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : read_s0_payload_opcode_string = "FCVT_X_X";
      default : read_s0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(read_s0_payload_roundMode)
      FpuRoundMode_RNE : read_s0_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : read_s0_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : read_s0_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : read_s0_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : read_s0_payload_roundMode_string = "RMM";
      default : read_s0_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(read_s1_payload_opcode)
      FpuOpcode_LOAD : read_s1_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : read_s1_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : read_s1_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : read_s1_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : read_s1_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : read_s1_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : read_s1_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : read_s1_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : read_s1_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : read_s1_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : read_s1_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : read_s1_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : read_s1_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : read_s1_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : read_s1_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : read_s1_payload_opcode_string = "FCVT_X_X";
      default : read_s1_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(read_s1_payload_roundMode)
      FpuRoundMode_RNE : read_s1_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : read_s1_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : read_s1_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : read_s1_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : read_s1_payload_roundMode_string = "RMM";
      default : read_s1_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(read_s0_rData_opcode)
      FpuOpcode_LOAD : read_s0_rData_opcode_string = "LOAD    ";
      FpuOpcode_STORE : read_s0_rData_opcode_string = "STORE   ";
      FpuOpcode_MUL : read_s0_rData_opcode_string = "MUL     ";
      FpuOpcode_ADD : read_s0_rData_opcode_string = "ADD     ";
      FpuOpcode_FMA : read_s0_rData_opcode_string = "FMA     ";
      FpuOpcode_I2F : read_s0_rData_opcode_string = "I2F     ";
      FpuOpcode_F2I : read_s0_rData_opcode_string = "F2I     ";
      FpuOpcode_CMP : read_s0_rData_opcode_string = "CMP     ";
      FpuOpcode_DIV : read_s0_rData_opcode_string = "DIV     ";
      FpuOpcode_SQRT : read_s0_rData_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : read_s0_rData_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : read_s0_rData_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : read_s0_rData_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : read_s0_rData_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : read_s0_rData_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : read_s0_rData_opcode_string = "FCVT_X_X";
      default : read_s0_rData_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(read_s0_rData_roundMode)
      FpuRoundMode_RNE : read_s0_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : read_s0_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : read_s0_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : read_s0_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : read_s0_rData_roundMode_string = "RMM";
      default : read_s0_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(read_output_payload_opcode)
      FpuOpcode_LOAD : read_output_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : read_output_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : read_output_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : read_output_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : read_output_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : read_output_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : read_output_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : read_output_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : read_output_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : read_output_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : read_output_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : read_output_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : read_output_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : read_output_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : read_output_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : read_output_payload_opcode_string = "FCVT_X_X";
      default : read_output_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(read_output_payload_roundMode)
      FpuRoundMode_RNE : read_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : read_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : read_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : read_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : read_output_payload_roundMode_string = "RMM";
      default : read_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_input_payload_opcode)
      FpuOpcode_LOAD : decode_input_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : decode_input_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : decode_input_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : decode_input_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : decode_input_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : decode_input_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : decode_input_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : decode_input_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : decode_input_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : decode_input_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : decode_input_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : decode_input_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : decode_input_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : decode_input_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : decode_input_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : decode_input_payload_opcode_string = "FCVT_X_X";
      default : decode_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_input_payload_roundMode)
      FpuRoundMode_RNE : decode_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_input_payload_roundMode_string = "RMM";
      default : decode_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_payload_roundMode)
      FpuRoundMode_RNE : decode_load_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_load_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_load_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_load_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_load_payload_roundMode_string = "RMM";
      default : decode_load_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_shortPip_payload_opcode)
      FpuOpcode_LOAD : decode_shortPip_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : decode_shortPip_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : decode_shortPip_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : decode_shortPip_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : decode_shortPip_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : decode_shortPip_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : decode_shortPip_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : decode_shortPip_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : decode_shortPip_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : decode_shortPip_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : decode_shortPip_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : decode_shortPip_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : decode_shortPip_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : decode_shortPip_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : decode_shortPip_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : decode_shortPip_payload_opcode_string = "FCVT_X_X";
      default : decode_shortPip_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_shortPip_payload_roundMode)
      FpuRoundMode_RNE : decode_shortPip_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_shortPip_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_shortPip_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_shortPip_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_shortPip_payload_roundMode_string = "RMM";
      default : decode_shortPip_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_divSqrt_payload_roundMode)
      FpuRoundMode_RNE : decode_divSqrt_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_divSqrt_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_divSqrt_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_divSqrt_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_divSqrt_payload_roundMode_string = "RMM";
      default : decode_divSqrt_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_div_payload_roundMode)
      FpuRoundMode_RNE : decode_div_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_div_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_div_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_div_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_div_payload_roundMode_string = "RMM";
      default : decode_div_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_sqrt_payload_roundMode)
      FpuRoundMode_RNE : decode_sqrt_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_sqrt_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_sqrt_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_sqrt_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_sqrt_payload_roundMode_string = "RMM";
      default : decode_sqrt_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_mul_payload_roundMode)
      FpuRoundMode_RNE : decode_mul_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_mul_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_mul_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_mul_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_mul_payload_roundMode_string = "RMM";
      default : decode_mul_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_divSqrtToMul_payload_roundMode)
      FpuRoundMode_RNE : decode_divSqrtToMul_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_divSqrtToMul_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_divSqrtToMul_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_divSqrtToMul_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_divSqrtToMul_payload_roundMode_string = "RMM";
      default : decode_divSqrtToMul_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_add_payload_roundMode)
      FpuRoundMode_RNE : decode_add_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_add_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_add_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_add_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_add_payload_roundMode_string = "RMM";
      default : decode_add_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_mulToAdd_payload_roundMode)
      FpuRoundMode_RNE : decode_mulToAdd_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_mulToAdd_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_mulToAdd_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_mulToAdd_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_mulToAdd_payload_roundMode_string = "RMM";
      default : decode_mulToAdd_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_s2mPipe_payload_roundMode)
      FpuRoundMode_RNE : decode_load_s2mPipe_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_load_s2mPipe_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_load_s2mPipe_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_load_s2mPipe_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_load_s2mPipe_payload_roundMode_string = "RMM";
      default : decode_load_s2mPipe_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_rData_roundMode)
      FpuRoundMode_RNE : decode_load_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_load_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_load_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_load_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_load_rData_roundMode_string = "RMM";
      default : decode_load_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_load_s2mPipe_payload_roundMode)
      FpuRoundMode_RNE : _zz_decode_load_s2mPipe_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : _zz_decode_load_s2mPipe_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : _zz_decode_load_s2mPipe_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : _zz_decode_load_s2mPipe_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : _zz_decode_load_s2mPipe_payload_roundMode_string = "RMM";
      default : _zz_decode_load_s2mPipe_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_s2mPipe_m2sPipe_payload_roundMode)
      FpuRoundMode_RNE : decode_load_s2mPipe_m2sPipe_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_load_s2mPipe_m2sPipe_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_load_s2mPipe_m2sPipe_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_load_s2mPipe_m2sPipe_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_load_s2mPipe_m2sPipe_payload_roundMode_string = "RMM";
      default : decode_load_s2mPipe_m2sPipe_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_s2mPipe_rData_roundMode)
      FpuRoundMode_RNE : decode_load_s2mPipe_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_load_s2mPipe_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_load_s2mPipe_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_load_s2mPipe_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_load_s2mPipe_rData_roundMode_string = "RMM";
      default : decode_load_s2mPipe_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s0_input_payload_roundMode)
      FpuRoundMode_RNE : load_s0_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : load_s0_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : load_s0_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : load_s0_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : load_s0_input_payload_roundMode_string = "RMM";
      default : load_s0_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_s2mPipe_m2sPipe_rData_roundMode)
      FpuRoundMode_RNE : decode_load_s2mPipe_m2sPipe_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_load_s2mPipe_m2sPipe_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_load_s2mPipe_m2sPipe_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_load_s2mPipe_m2sPipe_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_load_s2mPipe_m2sPipe_rData_roundMode_string = "RMM";
      default : decode_load_s2mPipe_m2sPipe_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s0_filtred_0_payload_opcode)
      FpuOpcode_LOAD : load_s0_filtred_0_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : load_s0_filtred_0_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : load_s0_filtred_0_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : load_s0_filtred_0_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : load_s0_filtred_0_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : load_s0_filtred_0_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : load_s0_filtred_0_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : load_s0_filtred_0_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : load_s0_filtred_0_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : load_s0_filtred_0_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : load_s0_filtred_0_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : load_s0_filtred_0_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : load_s0_filtred_0_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : load_s0_filtred_0_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : load_s0_filtred_0_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : load_s0_filtred_0_payload_opcode_string = "FCVT_X_X";
      default : load_s0_filtred_0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(load_s0_output_payload_roundMode)
      FpuRoundMode_RNE : load_s0_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : load_s0_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : load_s0_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : load_s0_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : load_s0_output_payload_roundMode_string = "RMM";
      default : load_s0_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s1_input_payload_roundMode)
      FpuRoundMode_RNE : load_s1_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : load_s1_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : load_s1_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : load_s1_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : load_s1_input_payload_roundMode_string = "RMM";
      default : load_s1_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s0_output_rData_roundMode)
      FpuRoundMode_RNE : load_s0_output_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : load_s0_output_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : load_s0_output_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : load_s0_output_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : load_s0_output_rData_roundMode_string = "RMM";
      default : load_s0_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s1_output_payload_roundMode)
      FpuRoundMode_RNE : load_s1_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : load_s1_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : load_s1_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : load_s1_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : load_s1_output_payload_roundMode_string = "RMM";
      default : load_s1_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(shortPip_input_payload_opcode)
      FpuOpcode_LOAD : shortPip_input_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : shortPip_input_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : shortPip_input_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : shortPip_input_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : shortPip_input_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : shortPip_input_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : shortPip_input_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : shortPip_input_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : shortPip_input_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : shortPip_input_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : shortPip_input_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : shortPip_input_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : shortPip_input_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : shortPip_input_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : shortPip_input_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : shortPip_input_payload_opcode_string = "FCVT_X_X";
      default : shortPip_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(shortPip_input_payload_roundMode)
      FpuRoundMode_RNE : shortPip_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : shortPip_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : shortPip_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : shortPip_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : shortPip_input_payload_roundMode_string = "RMM";
      default : shortPip_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_shortPip_rData_opcode)
      FpuOpcode_LOAD : decode_shortPip_rData_opcode_string = "LOAD    ";
      FpuOpcode_STORE : decode_shortPip_rData_opcode_string = "STORE   ";
      FpuOpcode_MUL : decode_shortPip_rData_opcode_string = "MUL     ";
      FpuOpcode_ADD : decode_shortPip_rData_opcode_string = "ADD     ";
      FpuOpcode_FMA : decode_shortPip_rData_opcode_string = "FMA     ";
      FpuOpcode_I2F : decode_shortPip_rData_opcode_string = "I2F     ";
      FpuOpcode_F2I : decode_shortPip_rData_opcode_string = "F2I     ";
      FpuOpcode_CMP : decode_shortPip_rData_opcode_string = "CMP     ";
      FpuOpcode_DIV : decode_shortPip_rData_opcode_string = "DIV     ";
      FpuOpcode_SQRT : decode_shortPip_rData_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : decode_shortPip_rData_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : decode_shortPip_rData_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : decode_shortPip_rData_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : decode_shortPip_rData_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : decode_shortPip_rData_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : decode_shortPip_rData_opcode_string = "FCVT_X_X";
      default : decode_shortPip_rData_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_shortPip_rData_roundMode)
      FpuRoundMode_RNE : decode_shortPip_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_shortPip_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_shortPip_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_shortPip_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_shortPip_rData_roundMode_string = "RMM";
      default : decode_shortPip_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(shortPip_rfOutput_payload_roundMode)
      FpuRoundMode_RNE : shortPip_rfOutput_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : shortPip_rfOutput_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : shortPip_rfOutput_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : shortPip_rfOutput_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : shortPip_rfOutput_payload_roundMode_string = "RMM";
      default : shortPip_rfOutput_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(shortPip_output_payload_roundMode)
      FpuRoundMode_RNE : shortPip_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : shortPip_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : shortPip_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : shortPip_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : shortPip_output_payload_roundMode_string = "RMM";
      default : shortPip_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_preMul_input_payload_roundMode)
      FpuRoundMode_RNE : mul_preMul_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_preMul_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_preMul_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_preMul_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_preMul_input_payload_roundMode_string = "RMM";
      default : mul_preMul_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_mul_rData_roundMode)
      FpuRoundMode_RNE : decode_mul_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_mul_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_mul_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_mul_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_mul_rData_roundMode_string = "RMM";
      default : decode_mul_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_preMul_output_payload_roundMode)
      FpuRoundMode_RNE : mul_preMul_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_preMul_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_preMul_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_preMul_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_preMul_output_payload_roundMode_string = "RMM";
      default : mul_preMul_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_mul_input_payload_roundMode)
      FpuRoundMode_RNE : mul_mul_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_mul_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_mul_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_mul_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_mul_input_payload_roundMode_string = "RMM";
      default : mul_mul_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_preMul_output_rData_roundMode)
      FpuRoundMode_RNE : mul_preMul_output_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_preMul_output_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_preMul_output_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_preMul_output_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_preMul_output_rData_roundMode_string = "RMM";
      default : mul_preMul_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_mul_output_payload_roundMode)
      FpuRoundMode_RNE : mul_mul_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_mul_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_mul_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_mul_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_mul_output_payload_roundMode_string = "RMM";
      default : mul_mul_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_sum1_input_payload_roundMode)
      FpuRoundMode_RNE : mul_sum1_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_sum1_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_sum1_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_sum1_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_sum1_input_payload_roundMode_string = "RMM";
      default : mul_sum1_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_mul_output_rData_roundMode)
      FpuRoundMode_RNE : mul_mul_output_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_mul_output_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_mul_output_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_mul_output_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_mul_output_rData_roundMode_string = "RMM";
      default : mul_mul_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_sum1_output_payload_roundMode)
      FpuRoundMode_RNE : mul_sum1_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_sum1_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_sum1_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_sum1_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_sum1_output_payload_roundMode_string = "RMM";
      default : mul_sum1_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_sum2_input_payload_roundMode)
      FpuRoundMode_RNE : mul_sum2_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_sum2_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_sum2_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_sum2_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_sum2_input_payload_roundMode_string = "RMM";
      default : mul_sum2_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_sum1_output_rData_roundMode)
      FpuRoundMode_RNE : mul_sum1_output_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_sum1_output_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_sum1_output_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_sum1_output_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_sum1_output_rData_roundMode_string = "RMM";
      default : mul_sum1_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_sum2_output_payload_roundMode)
      FpuRoundMode_RNE : mul_sum2_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_sum2_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_sum2_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_sum2_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_sum2_output_payload_roundMode_string = "RMM";
      default : mul_sum2_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_norm_input_payload_roundMode)
      FpuRoundMode_RNE : mul_norm_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_norm_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_norm_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_norm_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_norm_input_payload_roundMode_string = "RMM";
      default : mul_norm_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_sum2_output_rData_roundMode)
      FpuRoundMode_RNE : mul_sum2_output_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_sum2_output_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_sum2_output_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_sum2_output_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_sum2_output_rData_roundMode_string = "RMM";
      default : mul_sum2_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_result_output_payload_roundMode)
      FpuRoundMode_RNE : mul_result_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_result_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_result_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_result_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_result_output_payload_roundMode_string = "RMM";
      default : mul_result_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_result_mulToAdd_payload_roundMode)
      FpuRoundMode_RNE : mul_result_mulToAdd_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_result_mulToAdd_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_result_mulToAdd_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_result_mulToAdd_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_result_mulToAdd_payload_roundMode_string = "RMM";
      default : mul_result_mulToAdd_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_result_mulToAdd_m2sPipe_payload_roundMode)
      FpuRoundMode_RNE : mul_result_mulToAdd_m2sPipe_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_result_mulToAdd_m2sPipe_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_result_mulToAdd_m2sPipe_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_result_mulToAdd_m2sPipe_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_result_mulToAdd_m2sPipe_payload_roundMode_string = "RMM";
      default : mul_result_mulToAdd_m2sPipe_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_result_mulToAdd_rData_roundMode)
      FpuRoundMode_RNE : mul_result_mulToAdd_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : mul_result_mulToAdd_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : mul_result_mulToAdd_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : mul_result_mulToAdd_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : mul_result_mulToAdd_rData_roundMode_string = "RMM";
      default : mul_result_mulToAdd_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(div_input_payload_roundMode)
      FpuRoundMode_RNE : div_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : div_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : div_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : div_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : div_input_payload_roundMode_string = "RMM";
      default : div_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_div_rData_roundMode)
      FpuRoundMode_RNE : decode_div_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_div_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_div_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_div_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_div_rData_roundMode_string = "RMM";
      default : decode_div_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(div_output_payload_roundMode)
      FpuRoundMode_RNE : div_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : div_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : div_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : div_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : div_output_payload_roundMode_string = "RMM";
      default : div_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(sqrt_input_payload_roundMode)
      FpuRoundMode_RNE : sqrt_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : sqrt_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : sqrt_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : sqrt_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : sqrt_input_payload_roundMode_string = "RMM";
      default : sqrt_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_sqrt_rData_roundMode)
      FpuRoundMode_RNE : decode_sqrt_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : decode_sqrt_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : decode_sqrt_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : decode_sqrt_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : decode_sqrt_rData_roundMode_string = "RMM";
      default : decode_sqrt_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(sqrt_output_payload_roundMode)
      FpuRoundMode_RNE : sqrt_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : sqrt_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : sqrt_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : sqrt_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : sqrt_output_payload_roundMode_string = "RMM";
      default : sqrt_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_preShifter_input_payload_roundMode)
      FpuRoundMode_RNE : add_preShifter_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_preShifter_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_preShifter_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_preShifter_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_preShifter_input_payload_roundMode_string = "RMM";
      default : add_preShifter_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_preShifter_output_payload_roundMode)
      FpuRoundMode_RNE : add_preShifter_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_preShifter_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_preShifter_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_preShifter_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_preShifter_output_payload_roundMode_string = "RMM";
      default : add_preShifter_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_shifter_input_payload_roundMode)
      FpuRoundMode_RNE : add_shifter_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_shifter_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_shifter_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_shifter_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_shifter_input_payload_roundMode_string = "RMM";
      default : add_shifter_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_preShifter_output_rData_roundMode)
      FpuRoundMode_RNE : add_preShifter_output_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_preShifter_output_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_preShifter_output_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_preShifter_output_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_preShifter_output_rData_roundMode_string = "RMM";
      default : add_preShifter_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_shifter_output_payload_roundMode)
      FpuRoundMode_RNE : add_shifter_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_shifter_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_shifter_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_shifter_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_shifter_output_payload_roundMode_string = "RMM";
      default : add_shifter_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_math_input_payload_roundMode)
      FpuRoundMode_RNE : add_math_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_math_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_math_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_math_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_math_input_payload_roundMode_string = "RMM";
      default : add_math_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_shifter_output_rData_roundMode)
      FpuRoundMode_RNE : add_shifter_output_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_shifter_output_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_shifter_output_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_shifter_output_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_shifter_output_rData_roundMode_string = "RMM";
      default : add_shifter_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_math_output_payload_roundMode)
      FpuRoundMode_RNE : add_math_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_math_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_math_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_math_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_math_output_payload_roundMode_string = "RMM";
      default : add_math_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_oh_input_payload_roundMode)
      FpuRoundMode_RNE : add_oh_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_oh_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_oh_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_oh_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_oh_input_payload_roundMode_string = "RMM";
      default : add_oh_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_math_output_rData_roundMode)
      FpuRoundMode_RNE : add_math_output_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_math_output_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_math_output_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_math_output_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_math_output_rData_roundMode_string = "RMM";
      default : add_math_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_oh_output_payload_roundMode)
      FpuRoundMode_RNE : add_oh_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_oh_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_oh_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_oh_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_oh_output_payload_roundMode_string = "RMM";
      default : add_oh_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_norm_input_payload_roundMode)
      FpuRoundMode_RNE : add_norm_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_norm_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_norm_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_norm_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_norm_input_payload_roundMode_string = "RMM";
      default : add_norm_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_oh_output_rData_roundMode)
      FpuRoundMode_RNE : add_oh_output_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_oh_output_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_oh_output_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_oh_output_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_oh_output_rData_roundMode_string = "RMM";
      default : add_oh_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_norm_output_payload_roundMode)
      FpuRoundMode_RNE : add_norm_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_norm_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_norm_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_norm_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_norm_output_payload_roundMode_string = "RMM";
      default : add_norm_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_result_input_payload_roundMode)
      FpuRoundMode_RNE : add_result_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_result_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_result_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_result_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_result_input_payload_roundMode_string = "RMM";
      default : add_result_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_result_output_payload_roundMode)
      FpuRoundMode_RNE : add_result_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : add_result_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : add_result_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : add_result_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : add_result_output_payload_roundMode_string = "RMM";
      default : add_result_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s1_output_m2sPipe_payload_roundMode)
      FpuRoundMode_RNE : load_s1_output_m2sPipe_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : load_s1_output_m2sPipe_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : load_s1_output_m2sPipe_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : load_s1_output_m2sPipe_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : load_s1_output_m2sPipe_payload_roundMode_string = "RMM";
      default : load_s1_output_m2sPipe_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s1_output_rData_roundMode)
      FpuRoundMode_RNE : load_s1_output_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : load_s1_output_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : load_s1_output_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : load_s1_output_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : load_s1_output_rData_roundMode_string = "RMM";
      default : load_s1_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(shortPip_output_m2sPipe_payload_roundMode)
      FpuRoundMode_RNE : shortPip_output_m2sPipe_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : shortPip_output_m2sPipe_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : shortPip_output_m2sPipe_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : shortPip_output_m2sPipe_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : shortPip_output_m2sPipe_payload_roundMode_string = "RMM";
      default : shortPip_output_m2sPipe_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(shortPip_output_rData_roundMode)
      FpuRoundMode_RNE : shortPip_output_rData_roundMode_string = "RNE";
      FpuRoundMode_RTZ : shortPip_output_rData_roundMode_string = "RTZ";
      FpuRoundMode_RDN : shortPip_output_rData_roundMode_string = "RDN";
      FpuRoundMode_RUP : shortPip_output_rData_roundMode_string = "RUP";
      FpuRoundMode_RMM : shortPip_output_rData_roundMode_string = "RMM";
      default : shortPip_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(merge_arbitrated_payload_roundMode)
      FpuRoundMode_RNE : merge_arbitrated_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : merge_arbitrated_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : merge_arbitrated_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : merge_arbitrated_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : merge_arbitrated_payload_roundMode_string = "RMM";
      default : merge_arbitrated_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(roundFront_input_payload_roundMode)
      FpuRoundMode_RNE : roundFront_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : roundFront_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : roundFront_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : roundFront_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : roundFront_input_payload_roundMode_string = "RMM";
      default : roundFront_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(roundFront_output_payload_roundMode)
      FpuRoundMode_RNE : roundFront_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : roundFront_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : roundFront_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : roundFront_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : roundFront_output_payload_roundMode_string = "RMM";
      default : roundFront_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(roundBack_input_payload_roundMode)
      FpuRoundMode_RNE : roundBack_input_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : roundBack_input_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : roundBack_input_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : roundBack_input_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : roundBack_input_payload_roundMode_string = "RMM";
      default : roundBack_input_payload_roundMode_string = "???";
    endcase
  end
  `endif

  always @(*) begin
    _zz_1 = 1'b0; // @[when.scala 47:16]
    if(writeback_port_valid) begin
      _zz_1 = 1'b1; // @[when.scala 52:10]
    end
  end

  always @(*) begin
    add_shifter_yMantissa_5 = add_shifter_yMantissa_4; // @[Data.scala 57:9]
    add_shifter_yMantissa_5 = (add_shifter_shiftBy[0] ? _zz_add_shifter_yMantissa_5 : add_shifter_yMantissa_4); // @[Data.scala 63:9]
    if(add_shifter_passThrough) begin
      add_shifter_yMantissa_5 = 26'h0; // @[FpuCore.scala 1422:37]
    end
  end

  always @(*) begin
    add_shifter_yMantissa_4 = add_shifter_yMantissa_3; // @[Data.scala 57:9]
    add_shifter_yMantissa_4 = (add_shifter_shiftBy[1] ? _zz_add_shifter_yMantissa_4 : add_shifter_yMantissa_3); // @[Data.scala 63:9]
  end

  always @(*) begin
    add_shifter_yMantissa_3 = add_shifter_yMantissa_2; // @[Data.scala 57:9]
    add_shifter_yMantissa_3 = (add_shifter_shiftBy[2] ? _zz_add_shifter_yMantissa_3 : add_shifter_yMantissa_2); // @[Data.scala 63:9]
  end

  always @(*) begin
    add_shifter_yMantissa_2 = add_shifter_yMantissa_1; // @[Data.scala 57:9]
    add_shifter_yMantissa_2 = (add_shifter_shiftBy[3] ? _zz_add_shifter_yMantissa_2 : add_shifter_yMantissa_1); // @[Data.scala 63:9]
  end

  always @(*) begin
    add_shifter_yMantissa_1 = add_shifter_yMantissa; // @[Data.scala 57:9]
    add_shifter_yMantissa_1 = (add_shifter_shiftBy[4] ? _zz_add_shifter_yMantissa_1 : add_shifter_yMantissa); // @[Data.scala 63:9]
  end

  always @(*) begin
    shortPip_fsm_shift_input_6 = shortPip_fsm_shift_input_5; // @[Data.scala 57:9]
    shortPip_fsm_shift_input_6 = (shortPip_fsm_shift_by[0] ? _zz_shortPip_fsm_shift_input_6 : shortPip_fsm_shift_input_5); // @[Data.scala 63:9]
  end

  always @(*) begin
    shortPip_fsm_shift_input_5 = shortPip_fsm_shift_input_4; // @[Data.scala 57:9]
    shortPip_fsm_shift_input_5 = (shortPip_fsm_shift_by[1] ? _zz_shortPip_fsm_shift_input_5 : shortPip_fsm_shift_input_4); // @[Data.scala 63:9]
  end

  always @(*) begin
    shortPip_fsm_shift_input_4 = shortPip_fsm_shift_input_3; // @[Data.scala 57:9]
    shortPip_fsm_shift_input_4 = (shortPip_fsm_shift_by[2] ? _zz_shortPip_fsm_shift_input_4 : shortPip_fsm_shift_input_3); // @[Data.scala 63:9]
  end

  always @(*) begin
    shortPip_fsm_shift_input_3 = shortPip_fsm_shift_input_2; // @[Data.scala 57:9]
    shortPip_fsm_shift_input_3 = (shortPip_fsm_shift_by[3] ? _zz_shortPip_fsm_shift_input_3 : shortPip_fsm_shift_input_2); // @[Data.scala 63:9]
  end

  always @(*) begin
    shortPip_fsm_shift_input_2 = shortPip_fsm_shift_input_1; // @[Data.scala 57:9]
    shortPip_fsm_shift_input_2 = (shortPip_fsm_shift_by[4] ? _zz_shortPip_fsm_shift_input_2 : shortPip_fsm_shift_input_1); // @[Data.scala 63:9]
  end

  always @(*) begin
    shortPip_fsm_shift_input_1 = shortPip_fsm_shift_input; // @[Data.scala 57:9]
    shortPip_fsm_shift_input_1 = (shortPip_fsm_shift_by[5] ? _zz_shortPip_fsm_shift_input_1 : shortPip_fsm_shift_input); // @[Data.scala 63:9]
  end

  always @(*) begin
    load_s1_fsm_shift_input_5 = load_s1_fsm_shift_input_4; // @[Data.scala 57:9]
    load_s1_fsm_shift_input_5 = (load_s1_fsm_shift_by[4] ? _zz_load_s1_fsm_shift_input_5 : load_s1_fsm_shift_input_4); // @[Data.scala 63:9]
  end

  always @(*) begin
    load_s1_fsm_shift_input_4 = load_s1_fsm_shift_input_3; // @[Data.scala 57:9]
    load_s1_fsm_shift_input_4 = (load_s1_fsm_shift_by[3] ? _zz_load_s1_fsm_shift_input_4 : load_s1_fsm_shift_input_3); // @[Data.scala 63:9]
  end

  always @(*) begin
    load_s1_fsm_shift_input_3 = load_s1_fsm_shift_input_2; // @[Data.scala 57:9]
    load_s1_fsm_shift_input_3 = (load_s1_fsm_shift_by[2] ? _zz_load_s1_fsm_shift_input_3 : load_s1_fsm_shift_input_2); // @[Data.scala 63:9]
  end

  always @(*) begin
    load_s1_fsm_shift_input_2 = load_s1_fsm_shift_input_1; // @[Data.scala 57:9]
    load_s1_fsm_shift_input_2 = (load_s1_fsm_shift_by[1] ? _zz_load_s1_fsm_shift_input_2 : load_s1_fsm_shift_input_1); // @[Data.scala 63:9]
  end

  always @(*) begin
    load_s1_fsm_shift_input_1 = load_s1_fsm_shift_input; // @[Data.scala 57:9]
    load_s1_fsm_shift_input_1 = (load_s1_fsm_shift_by[0] ? _zz_load_s1_fsm_shift_input_1 : load_s1_fsm_shift_input); // @[Data.scala 63:9]
  end

  always @(*) begin
    _zz_2 = 1'b0; // @[when.scala 47:16]
    if(commitLogic_0_input_valid) begin
      _zz_2 = 1'b1; // @[when.scala 52:10]
    end
  end

  always @(*) begin
    _zz_3 = 1'b0; // @[when.scala 47:16]
    if(rf_scoreboards_0_hitWrite_valid) begin
      _zz_3 = 1'b1; // @[when.scala 52:10]
    end
  end

  always @(*) begin
    _zz_4 = 1'b0; // @[when.scala 47:16]
    if(rf_scoreboards_0_targetWrite_valid) begin
      _zz_4 = 1'b1; // @[when.scala 52:10]
    end
  end

  assign rf_init_done = rf_init_counter[5]; // @[Misc.scala 552:9]
  assign when_FpuCore_l163 = (! rf_init_done); // @[BaseType.scala 299:24]
  always @(*) begin
    rf_scoreboards_0_targetWrite_valid = (! rf_init_done); // @[FpuCore.scala 167:20]
    if(when_FpuCore_l265) begin
      rf_scoreboards_0_targetWrite_valid = 1'b1; // @[FpuCore.scala 266:36]
    end
  end

  always @(*) begin
    rf_scoreboards_0_targetWrite_payload_address = rf_init_counter[4:0]; // @[FpuCore.scala 168:22]
    if(when_FpuCore_l261) begin
      rf_scoreboards_0_targetWrite_payload_address = scheduler_0_input_payload_rd; // @[FpuCore.scala 262:38]
    end
  end

  always @(*) begin
    rf_scoreboards_0_targetWrite_payload_data = 1'b0; // @[FpuCore.scala 169:19]
    if(when_FpuCore_l261) begin
      rf_scoreboards_0_targetWrite_payload_data = (! scheduler_0_rfTargets_3); // @[FpuCore.scala 263:35]
    end
  end

  always @(*) begin
    rf_scoreboards_0_hitWrite_valid = (! rf_init_done); // @[FpuCore.scala 167:20]
    if(writeback_input_valid) begin
      if(when_FpuCore_l1681) begin
        rf_scoreboards_0_hitWrite_valid = 1'b1; // @[FpuCore.scala 1681:20]
      end
    end
  end

  always @(*) begin
    rf_scoreboards_0_hitWrite_payload_address = rf_init_counter[4:0]; // @[FpuCore.scala 168:22]
    if(writeback_input_valid) begin
      rf_scoreboards_0_hitWrite_payload_address = writeback_input_payload_rd; // @[FpuCore.scala 1682:22]
    end
  end

  always @(*) begin
    rf_scoreboards_0_hitWrite_payload_data = 1'b0; // @[FpuCore.scala 169:19]
    if(writeback_input_valid) begin
      rf_scoreboards_0_hitWrite_payload_data = (! _zz_rf_scoreboards_0_hit_port5[0]); // @[FpuCore.scala 1683:19]
    end
  end

  assign io_port_0_commit_ready = streamFork_1_io_input_ready; // @[Stream.scala 295:16]
  assign commitFork_load_0_valid = streamFork_1_io_outputs_0_valid; // @[Stream.scala 294:16]
  assign commitFork_load_0_payload_opcode = streamFork_1_io_outputs_0_payload_opcode; // @[Stream.scala 296:18]
  assign commitFork_load_0_payload_rd = streamFork_1_io_outputs_0_payload_rd; // @[Stream.scala 296:18]
  assign commitFork_load_0_payload_write = streamFork_1_io_outputs_0_payload_write; // @[Stream.scala 296:18]
  assign commitFork_load_0_payload_value = streamFork_1_io_outputs_0_payload_value; // @[Stream.scala 296:18]
  assign streamFork_1_io_outputs_1_ready = (! FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid); // @[Stream.scala 380:16]
  assign FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_valid = (streamFork_1_io_outputs_1_valid || FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid); // @[Stream.scala 382:19]
  assign _zz_payload_opcode = (FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid ? FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode : streamFork_1_io_outputs_1_payload_opcode); // @[Expression.scala 1420:25]
  assign FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode = _zz_payload_opcode; // @[Stream.scala 383:21]
  assign FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_rd = (FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid ? FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_rd : streamFork_1_io_outputs_1_payload_rd); // @[Stream.scala 383:21]
  assign FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_write = (FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid ? FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_write : streamFork_1_io_outputs_1_payload_write); // @[Stream.scala 383:21]
  assign FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_value = (FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid ? FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_value : streamFork_1_io_outputs_1_payload_value); // @[Stream.scala 383:21]
  assign commitFork_commit_0_valid = FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_valid; // @[Stream.scala 294:16]
  assign FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_ready = commitFork_commit_0_ready; // @[Stream.scala 295:16]
  assign commitFork_commit_0_payload_opcode = FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_opcode; // @[Stream.scala 296:18]
  assign commitFork_commit_0_payload_rd = FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_rd; // @[Stream.scala 296:18]
  assign commitFork_commit_0_payload_write = FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_write; // @[Stream.scala 296:18]
  assign commitFork_commit_0_payload_value = FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_payload_value; // @[Stream.scala 296:18]
  assign commitLogic_0_pending_full = (&commitLogic_0_pending_counter); // @[BaseType.scala 312:24]
  assign commitLogic_0_pending_notEmpty = (|commitLogic_0_pending_counter); // @[BaseType.scala 312:24]
  always @(*) begin
    commitLogic_0_pending_inc = 1'b0; // @[FpuCore.scala 197:15]
    if(when_FpuCore_l265) begin
      commitLogic_0_pending_inc = 1'b1; // @[FpuCore.scala 267:39]
    end
  end

  always @(*) begin
    commitLogic_0_pending_dec = 1'b0; // @[FpuCore.scala 198:15]
    if(commitLogic_0_input_valid) begin
      commitLogic_0_pending_dec = 1'b1; // @[FpuCore.scala 214:19]
    end
  end

  assign commitLogic_0_add_full = (&commitLogic_0_add_counter); // @[BaseType.scala 312:24]
  assign commitLogic_0_add_notEmpty = (|commitLogic_0_add_counter); // @[BaseType.scala 312:24]
  always @(*) begin
    commitLogic_0_add_inc = 1'b0; // @[FpuCore.scala 197:15]
    if(commitLogic_0_input_valid) begin
      if(when_FpuCore_l208) begin
        commitLogic_0_add_inc = 1'b1; // @[FpuCore.scala 208:17]
      end
    end
  end

  always @(*) begin
    commitLogic_0_add_dec = 1'b0; // @[FpuCore.scala 198:15]
    if(when_FpuCore_l221_4) begin
      commitLogic_0_add_dec = 1'b1; // @[FpuCore.scala 221:58]
    end
  end

  assign commitLogic_0_mul_full = (&commitLogic_0_mul_counter); // @[BaseType.scala 312:24]
  assign commitLogic_0_mul_notEmpty = (|commitLogic_0_mul_counter); // @[BaseType.scala 312:24]
  always @(*) begin
    commitLogic_0_mul_inc = 1'b0; // @[FpuCore.scala 197:15]
    if(commitLogic_0_input_valid) begin
      if(when_FpuCore_l209) begin
        commitLogic_0_mul_inc = 1'b1; // @[FpuCore.scala 209:17]
      end
    end
  end

  always @(*) begin
    commitLogic_0_mul_dec = 1'b0; // @[FpuCore.scala 198:15]
    if(when_FpuCore_l221_1) begin
      commitLogic_0_mul_dec = 1'b1; // @[FpuCore.scala 221:58]
    end
  end

  assign commitLogic_0_div_full = (&commitLogic_0_div_counter); // @[BaseType.scala 312:24]
  assign commitLogic_0_div_notEmpty = (|commitLogic_0_div_counter); // @[BaseType.scala 312:24]
  always @(*) begin
    commitLogic_0_div_inc = 1'b0; // @[FpuCore.scala 197:15]
    if(commitLogic_0_input_valid) begin
      if(when_FpuCore_l210) begin
        commitLogic_0_div_inc = 1'b1; // @[FpuCore.scala 210:17]
      end
    end
  end

  always @(*) begin
    commitLogic_0_div_dec = 1'b0; // @[FpuCore.scala 198:15]
    if(when_FpuCore_l221_2) begin
      commitLogic_0_div_dec = 1'b1; // @[FpuCore.scala 221:58]
    end
  end

  assign commitLogic_0_sqrt_full = (&commitLogic_0_sqrt_counter); // @[BaseType.scala 312:24]
  assign commitLogic_0_sqrt_notEmpty = (|commitLogic_0_sqrt_counter); // @[BaseType.scala 312:24]
  always @(*) begin
    commitLogic_0_sqrt_inc = 1'b0; // @[FpuCore.scala 197:15]
    if(commitLogic_0_input_valid) begin
      if(when_FpuCore_l211) begin
        commitLogic_0_sqrt_inc = 1'b1; // @[FpuCore.scala 211:17]
      end
    end
  end

  always @(*) begin
    commitLogic_0_sqrt_dec = 1'b0; // @[FpuCore.scala 198:15]
    if(when_FpuCore_l221_3) begin
      commitLogic_0_sqrt_dec = 1'b1; // @[FpuCore.scala 221:58]
    end
  end

  assign commitLogic_0_short_full = (&commitLogic_0_short_counter); // @[BaseType.scala 312:24]
  assign commitLogic_0_short_notEmpty = (|commitLogic_0_short_counter); // @[BaseType.scala 312:24]
  always @(*) begin
    commitLogic_0_short_inc = 1'b0; // @[FpuCore.scala 197:15]
    if(commitLogic_0_input_valid) begin
      if(when_FpuCore_l212) begin
        commitLogic_0_short_inc = 1'b1; // @[FpuCore.scala 212:17]
      end
    end
  end

  always @(*) begin
    commitLogic_0_short_dec = 1'b0; // @[FpuCore.scala 198:15]
    if(when_FpuCore_l221) begin
      commitLogic_0_short_dec = 1'b1; // @[FpuCore.scala 221:58]
    end
  end

  assign _zz_commitFork_commit_0_ready = (! (({commitLogic_0_short_full,{commitLogic_0_sqrt_full,{commitLogic_0_div_full,{commitLogic_0_mul_full,commitLogic_0_add_full}}}} != 5'h0) || (! commitLogic_0_pending_notEmpty))); // @[BaseType.scala 299:24]
  assign commitFork_commit_0_ready = (1'b1 && _zz_commitFork_commit_0_ready); // @[Stream.scala 427:16]
  assign _zz_commitLogic_0_input_payload_opcode = commitFork_commit_0_payload_opcode; // @[Stream.scala 428:18]
  assign commitLogic_0_input_valid = (commitFork_commit_0_valid && _zz_commitFork_commit_0_ready); // @[Stream.scala 78:15]
  assign commitLogic_0_input_payload_opcode = _zz_commitLogic_0_input_payload_opcode; // @[Stream.scala 79:17]
  assign commitLogic_0_input_payload_rd = commitFork_commit_0_payload_rd; // @[Stream.scala 79:17]
  assign commitLogic_0_input_payload_write = commitFork_commit_0_payload_write; // @[Stream.scala 79:17]
  assign commitLogic_0_input_payload_value = commitFork_commit_0_payload_value; // @[Stream.scala 79:17]
  assign when_FpuCore_l208 = ((commitLogic_0_input_payload_opcode == FpuOpcode_ADD) != 1'b0); // @[BaseType.scala 305:24]
  assign when_FpuCore_l209 = ({(commitLogic_0_input_payload_opcode == FpuOpcode_FMA),(commitLogic_0_input_payload_opcode == FpuOpcode_MUL)} != 2'b00); // @[BaseType.scala 305:24]
  assign when_FpuCore_l210 = ((commitLogic_0_input_payload_opcode == FpuOpcode_DIV) != 1'b0); // @[BaseType.scala 305:24]
  assign when_FpuCore_l211 = ((commitLogic_0_input_payload_opcode == FpuOpcode_SQRT) != 1'b0); // @[BaseType.scala 305:24]
  assign when_FpuCore_l212 = ({(commitLogic_0_input_payload_opcode == FpuOpcode_FCVT_X_X),{(commitLogic_0_input_payload_opcode == FpuOpcode_MIN_MAX),(commitLogic_0_input_payload_opcode == FpuOpcode_SGNJ)}} != 3'b000); // @[BaseType.scala 305:24]
  assign io_port_0_cmd_ready = (! io_port_0_cmd_rValid); // @[Stream.scala 380:16]
  assign scheduler_0_input_valid = (io_port_0_cmd_valid || io_port_0_cmd_rValid); // @[Stream.scala 382:19]
  assign _zz_scheduler_0_input_payload_opcode = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_opcode : io_port_0_cmd_payload_opcode); // @[Expression.scala 1420:25]
  assign _zz_scheduler_0_input_payload_format = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_format : io_port_0_cmd_payload_format); // @[Expression.scala 1420:25]
  assign _zz_scheduler_0_input_payload_roundMode = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_roundMode : io_port_0_cmd_payload_roundMode); // @[Expression.scala 1420:25]
  assign scheduler_0_input_payload_opcode = _zz_scheduler_0_input_payload_opcode; // @[Stream.scala 383:21]
  assign scheduler_0_input_payload_arg = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_arg : io_port_0_cmd_payload_arg); // @[Stream.scala 383:21]
  assign scheduler_0_input_payload_rs1 = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_rs1 : io_port_0_cmd_payload_rs1); // @[Stream.scala 383:21]
  assign scheduler_0_input_payload_rs2 = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_rs2 : io_port_0_cmd_payload_rs2); // @[Stream.scala 383:21]
  assign scheduler_0_input_payload_rs3 = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_rs3 : io_port_0_cmd_payload_rs3); // @[Stream.scala 383:21]
  assign scheduler_0_input_payload_rd = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_rd : io_port_0_cmd_payload_rd); // @[Stream.scala 383:21]
  assign scheduler_0_input_payload_format = _zz_scheduler_0_input_payload_format; // @[Stream.scala 383:21]
  assign scheduler_0_input_payload_roundMode = _zz_scheduler_0_input_payload_roundMode; // @[Stream.scala 383:21]
  always @(*) begin
    scheduler_0_useRs1 = 1'b0; // @[FpuCore.scala 229:41]
    case(scheduler_0_input_payload_opcode)
      FpuOpcode_LOAD : begin
      end
      FpuOpcode_STORE : begin
      end
      FpuOpcode_ADD : begin
        scheduler_0_useRs1 = 1'b1; // @[FpuCore.scala 233:55]
      end
      FpuOpcode_MUL : begin
        scheduler_0_useRs1 = 1'b1; // @[FpuCore.scala 234:55]
      end
      FpuOpcode_DIV : begin
        scheduler_0_useRs1 = 1'b1; // @[FpuCore.scala 235:55]
      end
      FpuOpcode_SQRT : begin
        scheduler_0_useRs1 = 1'b1; // @[FpuCore.scala 236:55]
      end
      FpuOpcode_FMA : begin
        scheduler_0_useRs1 = 1'b1; // @[FpuCore.scala 237:55]
      end
      FpuOpcode_I2F : begin
      end
      FpuOpcode_F2I : begin
        scheduler_0_useRs1 = 1'b1; // @[FpuCore.scala 239:39]
      end
      FpuOpcode_MIN_MAX : begin
        scheduler_0_useRs1 = 1'b1; // @[FpuCore.scala 240:55]
      end
      FpuOpcode_CMP : begin
        scheduler_0_useRs1 = 1'b1; // @[FpuCore.scala 241:39]
      end
      FpuOpcode_SGNJ : begin
        scheduler_0_useRs1 = 1'b1; // @[FpuCore.scala 242:55]
      end
      FpuOpcode_FMV_X_W : begin
        scheduler_0_useRs1 = 1'b1; // @[FpuCore.scala 243:39]
      end
      FpuOpcode_FMV_W_X : begin
      end
      FpuOpcode_FCLASS : begin
        scheduler_0_useRs1 = 1'b1; // @[FpuCore.scala 245:40]
      end
      default : begin
        scheduler_0_useRs1 = 1'b1; // @[FpuCore.scala 246:56]
      end
    endcase
  end

  always @(*) begin
    scheduler_0_useRs2 = 1'b0; // @[FpuCore.scala 229:41]
    case(scheduler_0_input_payload_opcode)
      FpuOpcode_LOAD : begin
      end
      FpuOpcode_STORE : begin
        scheduler_0_useRs2 = 1'b1; // @[FpuCore.scala 232:39]
      end
      FpuOpcode_ADD : begin
        scheduler_0_useRs2 = 1'b1; // @[FpuCore.scala 233:71]
      end
      FpuOpcode_MUL : begin
        scheduler_0_useRs2 = 1'b1; // @[FpuCore.scala 234:71]
      end
      FpuOpcode_DIV : begin
        scheduler_0_useRs2 = 1'b1; // @[FpuCore.scala 235:71]
      end
      FpuOpcode_SQRT : begin
      end
      FpuOpcode_FMA : begin
        scheduler_0_useRs2 = 1'b1; // @[FpuCore.scala 237:71]
      end
      FpuOpcode_I2F : begin
      end
      FpuOpcode_F2I : begin
      end
      FpuOpcode_MIN_MAX : begin
        scheduler_0_useRs2 = 1'b1; // @[FpuCore.scala 240:71]
      end
      FpuOpcode_CMP : begin
        scheduler_0_useRs2 = 1'b1; // @[FpuCore.scala 241:55]
      end
      FpuOpcode_SGNJ : begin
        scheduler_0_useRs2 = 1'b1; // @[FpuCore.scala 242:71]
      end
      FpuOpcode_FMV_X_W : begin
      end
      FpuOpcode_FMV_W_X : begin
      end
      FpuOpcode_FCLASS : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    scheduler_0_useRs3 = 1'b0; // @[FpuCore.scala 229:41]
    case(scheduler_0_input_payload_opcode)
      FpuOpcode_LOAD : begin
      end
      FpuOpcode_STORE : begin
      end
      FpuOpcode_ADD : begin
      end
      FpuOpcode_MUL : begin
      end
      FpuOpcode_DIV : begin
      end
      FpuOpcode_SQRT : begin
      end
      FpuOpcode_FMA : begin
        scheduler_0_useRs3 = 1'b1; // @[FpuCore.scala 237:87]
      end
      FpuOpcode_I2F : begin
      end
      FpuOpcode_F2I : begin
      end
      FpuOpcode_MIN_MAX : begin
      end
      FpuOpcode_CMP : begin
      end
      FpuOpcode_SGNJ : begin
      end
      FpuOpcode_FMV_X_W : begin
      end
      FpuOpcode_FMV_W_X : begin
      end
      FpuOpcode_FCLASS : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    scheduler_0_useRd = 1'b0; // @[FpuCore.scala 229:41]
    case(scheduler_0_input_payload_opcode)
      FpuOpcode_LOAD : begin
        scheduler_0_useRd = 1'b1; // @[FpuCore.scala 231:38]
      end
      FpuOpcode_STORE : begin
      end
      FpuOpcode_ADD : begin
        scheduler_0_useRd = 1'b1; // @[FpuCore.scala 233:39]
      end
      FpuOpcode_MUL : begin
        scheduler_0_useRd = 1'b1; // @[FpuCore.scala 234:39]
      end
      FpuOpcode_DIV : begin
        scheduler_0_useRd = 1'b1; // @[FpuCore.scala 235:39]
      end
      FpuOpcode_SQRT : begin
        scheduler_0_useRd = 1'b1; // @[FpuCore.scala 236:39]
      end
      FpuOpcode_FMA : begin
        scheduler_0_useRd = 1'b1; // @[FpuCore.scala 237:39]
      end
      FpuOpcode_I2F : begin
        scheduler_0_useRd = 1'b1; // @[FpuCore.scala 238:39]
      end
      FpuOpcode_F2I : begin
      end
      FpuOpcode_MIN_MAX : begin
        scheduler_0_useRd = 1'b1; // @[FpuCore.scala 240:39]
      end
      FpuOpcode_CMP : begin
      end
      FpuOpcode_SGNJ : begin
        scheduler_0_useRd = 1'b1; // @[FpuCore.scala 242:39]
      end
      FpuOpcode_FMV_X_W : begin
      end
      FpuOpcode_FMV_W_X : begin
        scheduler_0_useRd = 1'b1; // @[FpuCore.scala 244:39]
      end
      FpuOpcode_FCLASS : begin
      end
      default : begin
        scheduler_0_useRd = 1'b1; // @[FpuCore.scala 246:39]
      end
    endcase
  end

  assign scheduler_0_rfHits_0 = _zz_rf_scoreboards_0_hit_port1[0]; // @[Bool.scala 189:10]
  assign scheduler_0_rfHits_1 = _zz_rf_scoreboards_0_hit_port2[0]; // @[Bool.scala 189:10]
  assign scheduler_0_rfHits_2 = _zz_rf_scoreboards_0_hit_port3[0]; // @[Bool.scala 189:10]
  assign scheduler_0_rfHits_3 = _zz_rf_scoreboards_0_hit_port4[0]; // @[Bool.scala 189:10]
  assign scheduler_0_rfTargets_0 = _zz_rf_scoreboards_0_target_port1[0]; // @[Bool.scala 189:10]
  assign scheduler_0_rfTargets_1 = _zz_rf_scoreboards_0_target_port2[0]; // @[Bool.scala 189:10]
  assign scheduler_0_rfTargets_2 = _zz_rf_scoreboards_0_target_port3[0]; // @[Bool.scala 189:10]
  assign scheduler_0_rfTargets_3 = _zz_rf_scoreboards_0_target_port4[0]; // @[Bool.scala 189:10]
  assign scheduler_0_rfBusy_0 = (scheduler_0_rfHits_0 ^ scheduler_0_rfTargets_0); // @[BaseType.scala 305:24]
  assign scheduler_0_rfBusy_1 = (scheduler_0_rfHits_1 ^ scheduler_0_rfTargets_1); // @[BaseType.scala 305:24]
  assign scheduler_0_rfBusy_2 = (scheduler_0_rfHits_2 ^ scheduler_0_rfTargets_2); // @[BaseType.scala 305:24]
  assign scheduler_0_rfBusy_3 = (scheduler_0_rfHits_3 ^ scheduler_0_rfTargets_3); // @[BaseType.scala 305:24]
  assign scheduler_0_hits_0 = (scheduler_0_useRs1 && scheduler_0_rfBusy_0); // @[BaseType.scala 305:24]
  assign scheduler_0_hits_1 = (scheduler_0_useRs2 && scheduler_0_rfBusy_1); // @[BaseType.scala 305:24]
  assign scheduler_0_hits_2 = (scheduler_0_useRs3 && scheduler_0_rfBusy_2); // @[BaseType.scala 305:24]
  assign scheduler_0_hits_3 = (scheduler_0_useRd && scheduler_0_rfBusy_3); // @[BaseType.scala 305:24]
  assign scheduler_0_hazard = ((({scheduler_0_hits_3,{scheduler_0_hits_2,{scheduler_0_hits_1,scheduler_0_hits_0}}} != 4'b0000) || (! rf_init_done)) || commitLogic_0_pending_full); // @[BaseType.scala 305:24]
  assign _zz_scheduler_0_input_ready = (! scheduler_0_hazard); // @[BaseType.scala 299:24]
  assign scheduler_0_output_valid = (scheduler_0_input_valid && _zz_scheduler_0_input_ready); // @[Stream.scala 426:16]
  assign scheduler_0_input_ready = (scheduler_0_output_ready && _zz_scheduler_0_input_ready); // @[Stream.scala 427:16]
  assign scheduler_0_output_payload_opcode = scheduler_0_input_payload_opcode; // @[Stream.scala 428:18]
  assign scheduler_0_output_payload_arg = scheduler_0_input_payload_arg; // @[Stream.scala 428:18]
  always @(*) begin
    scheduler_0_output_payload_rs1 = scheduler_0_input_payload_rs1; // @[Stream.scala 428:18]
    if(when_FpuCore_l258) begin
      scheduler_0_output_payload_rs1 = scheduler_0_input_payload_rs2; // @[FpuCore.scala 259:18]
    end
  end

  assign scheduler_0_output_payload_rs2 = scheduler_0_input_payload_rs2; // @[Stream.scala 428:18]
  assign scheduler_0_output_payload_rs3 = scheduler_0_input_payload_rs3; // @[Stream.scala 428:18]
  assign scheduler_0_output_payload_rd = scheduler_0_input_payload_rd; // @[Stream.scala 428:18]
  assign scheduler_0_output_payload_format = scheduler_0_input_payload_format; // @[Stream.scala 428:18]
  assign scheduler_0_output_payload_roundMode = scheduler_0_input_payload_roundMode; // @[Stream.scala 428:18]
  assign when_FpuCore_l258 = (scheduler_0_input_payload_opcode == FpuOpcode_STORE); // @[BaseType.scala 305:24]
  assign when_FpuCore_l261 = (scheduler_0_input_valid && rf_init_done); // @[BaseType.scala 305:24]
  assign scheduler_0_output_fire = (scheduler_0_output_valid && scheduler_0_output_ready); // @[BaseType.scala 305:24]
  assign when_FpuCore_l265 = (scheduler_0_output_fire && scheduler_0_useRd); // @[BaseType.scala 305:24]
  assign scheduler_0_output_ready = cmdArbiter_arbiter_io_inputs_0_ready; // @[Stream.scala 295:16]
  assign _zz_io_inputs_0_payload_opcode = scheduler_0_output_payload_opcode; // @[Stream.scala 296:18]
  assign _zz_io_inputs_0_payload_format = scheduler_0_output_payload_format; // @[Stream.scala 296:18]
  assign _zz_io_inputs_0_payload_roundMode = scheduler_0_output_payload_roundMode; // @[Stream.scala 296:18]
  assign cmdArbiter_output_valid = cmdArbiter_arbiter_io_output_valid; // @[Stream.scala 303:16]
  assign cmdArbiter_output_payload_opcode = cmdArbiter_arbiter_io_output_payload_opcode; // @[Bundle.scala 141:37]
  assign cmdArbiter_output_payload_rs1 = cmdArbiter_arbiter_io_output_payload_rs1; // @[Bundle.scala 141:37]
  assign cmdArbiter_output_payload_rs2 = cmdArbiter_arbiter_io_output_payload_rs2; // @[Bundle.scala 141:37]
  assign cmdArbiter_output_payload_rs3 = cmdArbiter_arbiter_io_output_payload_rs3; // @[Bundle.scala 141:37]
  assign cmdArbiter_output_payload_rd = cmdArbiter_arbiter_io_output_payload_rd; // @[Bundle.scala 141:37]
  assign cmdArbiter_output_payload_arg = cmdArbiter_arbiter_io_output_payload_arg; // @[Bundle.scala 141:37]
  assign cmdArbiter_output_payload_roundMode = cmdArbiter_arbiter_io_output_payload_roundMode; // @[Bundle.scala 141:37]
  assign read_s0_valid = cmdArbiter_output_valid; // @[Stream.scala 294:16]
  assign cmdArbiter_output_ready = read_s0_ready; // @[Stream.scala 295:16]
  assign read_s0_payload_opcode = cmdArbiter_output_payload_opcode; // @[Stream.scala 296:18]
  assign read_s0_payload_rs1 = cmdArbiter_output_payload_rs1; // @[Stream.scala 296:18]
  assign read_s0_payload_rs2 = cmdArbiter_output_payload_rs2; // @[Stream.scala 296:18]
  assign read_s0_payload_rs3 = cmdArbiter_output_payload_rs3; // @[Stream.scala 296:18]
  assign read_s0_payload_rd = cmdArbiter_output_payload_rd; // @[Stream.scala 296:18]
  assign read_s0_payload_arg = cmdArbiter_output_payload_arg; // @[Stream.scala 296:18]
  assign read_s0_payload_roundMode = cmdArbiter_output_payload_roundMode; // @[Stream.scala 296:18]
  always @(*) begin
    read_s0_ready = read_s1_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368) begin
      read_s0_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368 = (! read_s1_valid); // @[BaseType.scala 299:24]
  assign read_s1_valid = read_s0_rValid; // @[Stream.scala 370:19]
  assign read_s1_payload_opcode = read_s0_rData_opcode; // @[Stream.scala 371:21]
  assign read_s1_payload_rs1 = read_s0_rData_rs1; // @[Stream.scala 371:21]
  assign read_s1_payload_rs2 = read_s0_rData_rs2; // @[Stream.scala 371:21]
  assign read_s1_payload_rs3 = read_s0_rData_rs3; // @[Stream.scala 371:21]
  assign read_s1_payload_rd = read_s0_rData_rd; // @[Stream.scala 371:21]
  assign read_s1_payload_arg = read_s0_rData_arg; // @[Stream.scala 371:21]
  assign read_s1_payload_roundMode = read_s0_rData_roundMode; // @[Stream.scala 371:21]
  assign read_output_valid = read_s1_valid; // @[Stream.scala 303:16]
  assign read_s1_ready = read_output_ready; // @[Stream.scala 304:16]
  assign _zz_read_rs_0_value_mantissa = read_s0_payload_rs1; // @[BaseType.scala 318:22]
  assign read_output_isStall = (read_output_valid && (! read_output_ready)); // @[BaseType.scala 305:24]
  assign _zz_read_rs_0_value_mantissa_1 = (! read_output_isStall); // @[BaseType.scala 299:24]
  assign _zz_read_rs_0_value_mantissa_2 = _zz_rf_ram_port0[33 : 0]; // @[BaseType.scala 299:24]
  assign read_rs_0_value_mantissa = _zz_read_rs_0_value_mantissa_2[22 : 0]; // @[UInt.scala 381:56]
  assign read_rs_0_value_exponent = _zz_read_rs_0_value_mantissa_2[31 : 23]; // @[UInt.scala 381:56]
  assign read_rs_0_value_sign = _zz_read_rs_0_value_mantissa_2[32]; // @[Bool.scala 189:10]
  assign read_rs_0_value_special = _zz_read_rs_0_value_mantissa_2[33]; // @[Bool.scala 189:10]
  assign _zz_read_rs_1_value_mantissa = read_s0_payload_rs2; // @[BaseType.scala 318:22]
  assign read_output_isStall_1 = (read_output_valid && (! read_output_ready)); // @[BaseType.scala 305:24]
  assign _zz_read_rs_1_value_mantissa_1 = (! read_output_isStall_1); // @[BaseType.scala 299:24]
  assign _zz_read_rs_1_value_mantissa_2 = _zz_rf_ram_port1[33 : 0]; // @[BaseType.scala 299:24]
  assign read_rs_1_value_mantissa = _zz_read_rs_1_value_mantissa_2[22 : 0]; // @[UInt.scala 381:56]
  assign read_rs_1_value_exponent = _zz_read_rs_1_value_mantissa_2[31 : 23]; // @[UInt.scala 381:56]
  assign read_rs_1_value_sign = _zz_read_rs_1_value_mantissa_2[32]; // @[Bool.scala 189:10]
  assign read_rs_1_value_special = _zz_read_rs_1_value_mantissa_2[33]; // @[Bool.scala 189:10]
  assign _zz_read_rs_2_value_mantissa = read_s0_payload_rs3; // @[BaseType.scala 318:22]
  assign read_output_isStall_2 = (read_output_valid && (! read_output_ready)); // @[BaseType.scala 305:24]
  assign _zz_read_rs_2_value_mantissa_1 = (! read_output_isStall_2); // @[BaseType.scala 299:24]
  assign _zz_read_rs_2_value_mantissa_2 = _zz_rf_ram_port2[33 : 0]; // @[BaseType.scala 299:24]
  assign read_rs_2_value_mantissa = _zz_read_rs_2_value_mantissa_2[22 : 0]; // @[UInt.scala 381:56]
  assign read_rs_2_value_exponent = _zz_read_rs_2_value_mantissa_2[31 : 23]; // @[UInt.scala 381:56]
  assign read_rs_2_value_sign = _zz_read_rs_2_value_mantissa_2[32]; // @[Bool.scala 189:10]
  assign read_rs_2_value_special = _zz_read_rs_2_value_mantissa_2[33]; // @[Bool.scala 189:10]
  assign read_output_payload_opcode = read_s1_payload_opcode; // @[FpuCore.scala 291:19]
  assign read_output_payload_arg = read_s1_payload_arg; // @[FpuCore.scala 292:16]
  assign read_output_payload_roundMode = read_s1_payload_roundMode; // @[FpuCore.scala 293:22]
  assign read_output_payload_rd = read_s1_payload_rd; // @[FpuCore.scala 294:15]
  assign read_output_payload_rs1_mantissa = read_rs_0_value_mantissa; // @[FpuCore.scala 295:16]
  assign read_output_payload_rs1_exponent = read_rs_0_value_exponent; // @[FpuCore.scala 295:16]
  assign read_output_payload_rs1_sign = read_rs_0_value_sign; // @[FpuCore.scala 295:16]
  assign read_output_payload_rs1_special = read_rs_0_value_special; // @[FpuCore.scala 295:16]
  assign read_output_payload_rs2_mantissa = read_rs_1_value_mantissa; // @[FpuCore.scala 296:16]
  assign read_output_payload_rs2_exponent = read_rs_1_value_exponent; // @[FpuCore.scala 296:16]
  assign read_output_payload_rs2_sign = read_rs_1_value_sign; // @[FpuCore.scala 296:16]
  assign read_output_payload_rs2_special = read_rs_1_value_special; // @[FpuCore.scala 296:16]
  assign read_output_payload_rs3_mantissa = read_rs_2_value_mantissa; // @[FpuCore.scala 297:16]
  assign read_output_payload_rs3_exponent = read_rs_2_value_exponent; // @[FpuCore.scala 297:16]
  assign read_output_payload_rs3_sign = read_rs_2_value_sign; // @[FpuCore.scala 297:16]
  assign read_output_payload_rs3_special = read_rs_2_value_special; // @[FpuCore.scala 297:16]
  assign decode_input_valid = read_output_valid; // @[Stream.scala 294:16]
  assign read_output_ready = decode_input_ready; // @[Stream.scala 295:16]
  assign decode_input_payload_opcode = read_output_payload_opcode; // @[Stream.scala 296:18]
  assign decode_input_payload_rs1_mantissa = read_output_payload_rs1_mantissa; // @[Stream.scala 296:18]
  assign decode_input_payload_rs1_exponent = read_output_payload_rs1_exponent; // @[Stream.scala 296:18]
  assign decode_input_payload_rs1_sign = read_output_payload_rs1_sign; // @[Stream.scala 296:18]
  assign decode_input_payload_rs1_special = read_output_payload_rs1_special; // @[Stream.scala 296:18]
  assign decode_input_payload_rs2_mantissa = read_output_payload_rs2_mantissa; // @[Stream.scala 296:18]
  assign decode_input_payload_rs2_exponent = read_output_payload_rs2_exponent; // @[Stream.scala 296:18]
  assign decode_input_payload_rs2_sign = read_output_payload_rs2_sign; // @[Stream.scala 296:18]
  assign decode_input_payload_rs2_special = read_output_payload_rs2_special; // @[Stream.scala 296:18]
  assign decode_input_payload_rs3_mantissa = read_output_payload_rs3_mantissa; // @[Stream.scala 296:18]
  assign decode_input_payload_rs3_exponent = read_output_payload_rs3_exponent; // @[Stream.scala 296:18]
  assign decode_input_payload_rs3_sign = read_output_payload_rs3_sign; // @[Stream.scala 296:18]
  assign decode_input_payload_rs3_special = read_output_payload_rs3_special; // @[Stream.scala 296:18]
  assign decode_input_payload_rd = read_output_payload_rd; // @[Stream.scala 296:18]
  assign decode_input_payload_arg = read_output_payload_arg; // @[Stream.scala 296:18]
  assign decode_input_payload_roundMode = read_output_payload_roundMode; // @[Stream.scala 296:18]
  always @(*) begin
    decode_input_ready = 1'b0; // @[FpuCore.scala 324:17]
    if(when_FpuCore_l329) begin
      decode_input_ready = 1'b1; // @[FpuCore.scala 329:17]
    end
    if(when_FpuCore_l335) begin
      decode_input_ready = 1'b1; // @[FpuCore.scala 335:17]
    end
    if(when_FpuCore_l351) begin
      decode_input_ready = 1'b1; // @[FpuCore.scala 351:19]
    end
    if(when_FpuCore_l359) begin
      decode_input_ready = 1'b1; // @[FpuCore.scala 359:19]
    end
    if(when_FpuCore_l375) begin
      decode_input_ready = 1'b1; // @[FpuCore.scala 375:19]
    end
    if(when_FpuCore_l399) begin
      decode_input_ready = 1'b1; // @[FpuCore.scala 399:19]
    end
  end

  assign decode_loadHit = ({(decode_input_payload_opcode == FpuOpcode_I2F),{(decode_input_payload_opcode == FpuOpcode_FMV_W_X),(decode_input_payload_opcode == FpuOpcode_LOAD)}} != 3'b000); // @[BaseType.scala 305:24]
  assign decode_load_valid = (decode_input_valid && decode_loadHit); // @[FpuCore.scala 328:16]
  assign when_FpuCore_l329 = (decode_loadHit && decode_load_ready); // @[BaseType.scala 305:24]
  assign decode_load_payload_rd = decode_input_payload_rd; // @[Bundle.scala 141:37]
  assign decode_load_payload_arg = decode_input_payload_arg; // @[Bundle.scala 141:37]
  assign decode_load_payload_roundMode = decode_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign decode_load_payload_i2f = (decode_input_payload_opcode == FpuOpcode_I2F); // @[FpuCore.scala 331:14]
  assign decode_shortPipHit = ({(decode_input_payload_opcode == FpuOpcode_FCVT_X_X),{(decode_input_payload_opcode == FpuOpcode_FCLASS),{(decode_input_payload_opcode == FpuOpcode_FMV_X_W),{(decode_input_payload_opcode == FpuOpcode_SGNJ),{(decode_input_payload_opcode == _zz_decode_shortPipHit),{_zz_decode_shortPipHit_1,{_zz_decode_shortPipHit_2,_zz_decode_shortPipHit_3}}}}}}} != 8'h0); // @[BaseType.scala 305:24]
  assign when_FpuCore_l335 = (decode_shortPipHit && decode_shortPip_ready); // @[BaseType.scala 305:24]
  assign decode_shortPip_valid = (decode_input_valid && decode_shortPipHit); // @[FpuCore.scala 336:20]
  assign decode_shortPip_payload_opcode = decode_input_payload_opcode; // @[Bundle.scala 141:37]
  assign decode_shortPip_payload_rs1_mantissa = decode_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
  assign decode_shortPip_payload_rs1_exponent = decode_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
  assign decode_shortPip_payload_rs1_sign = decode_input_payload_rs1_sign; // @[Bundle.scala 141:37]
  assign decode_shortPip_payload_rs1_special = decode_input_payload_rs1_special; // @[Bundle.scala 141:37]
  assign decode_shortPip_payload_rs2_mantissa = decode_input_payload_rs2_mantissa; // @[Bundle.scala 141:37]
  assign decode_shortPip_payload_rs2_exponent = decode_input_payload_rs2_exponent; // @[Bundle.scala 141:37]
  assign decode_shortPip_payload_rs2_sign = decode_input_payload_rs2_sign; // @[Bundle.scala 141:37]
  assign decode_shortPip_payload_rs2_special = decode_input_payload_rs2_special; // @[Bundle.scala 141:37]
  assign decode_shortPip_payload_rd = decode_input_payload_rd; // @[Bundle.scala 141:37]
  assign decode_shortPip_payload_arg = decode_input_payload_arg; // @[Bundle.scala 141:37]
  assign decode_shortPip_payload_roundMode = decode_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign decode_divSqrtHit = ((decode_input_payload_opcode == FpuOpcode_DIV) || (decode_input_payload_opcode == FpuOpcode_SQRT)); // @[BaseType.scala 305:24]
  assign decode_divHit = (decode_input_payload_opcode == FpuOpcode_DIV); // @[BaseType.scala 305:24]
  assign when_FpuCore_l351 = (decode_divHit && decode_div_ready); // @[BaseType.scala 305:24]
  assign decode_div_valid = (decode_input_valid && decode_divHit); // @[FpuCore.scala 352:17]
  assign decode_div_payload_rs1_mantissa = decode_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
  assign decode_div_payload_rs1_exponent = decode_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
  assign decode_div_payload_rs1_sign = decode_input_payload_rs1_sign; // @[Bundle.scala 141:37]
  assign decode_div_payload_rs1_special = decode_input_payload_rs1_special; // @[Bundle.scala 141:37]
  assign decode_div_payload_rs2_mantissa = decode_input_payload_rs2_mantissa; // @[Bundle.scala 141:37]
  assign decode_div_payload_rs2_exponent = decode_input_payload_rs2_exponent; // @[Bundle.scala 141:37]
  assign decode_div_payload_rs2_sign = decode_input_payload_rs2_sign; // @[Bundle.scala 141:37]
  assign decode_div_payload_rs2_special = decode_input_payload_rs2_special; // @[Bundle.scala 141:37]
  assign decode_div_payload_rd = decode_input_payload_rd; // @[Bundle.scala 141:37]
  assign decode_div_payload_roundMode = decode_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign decode_sqrtHit = (decode_input_payload_opcode == FpuOpcode_SQRT); // @[BaseType.scala 305:24]
  assign when_FpuCore_l359 = (decode_sqrtHit && decode_sqrt_ready); // @[BaseType.scala 305:24]
  assign decode_sqrt_valid = (decode_input_valid && decode_sqrtHit); // @[FpuCore.scala 360:18]
  assign decode_sqrt_payload_rs1_mantissa = decode_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
  assign decode_sqrt_payload_rs1_exponent = decode_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
  assign decode_sqrt_payload_rs1_sign = decode_input_payload_rs1_sign; // @[Bundle.scala 141:37]
  assign decode_sqrt_payload_rs1_special = decode_input_payload_rs1_special; // @[Bundle.scala 141:37]
  assign decode_sqrt_payload_rd = decode_input_payload_rd; // @[Bundle.scala 141:37]
  assign decode_sqrt_payload_roundMode = decode_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign decode_fmaHit = (decode_input_payload_opcode == FpuOpcode_FMA); // @[BaseType.scala 305:24]
  assign decode_mulHit = ((decode_input_payload_opcode == FpuOpcode_MUL) || decode_fmaHit); // @[BaseType.scala 305:24]
  assign decode_divSqrtToMul_valid = 1'b0; // @[FpuCore.scala 370:26]
  assign decode_divSqrtToMul_payload_rs1_mantissa = 23'bxxxxxxxxxxxxxxxxxxxxxxx; // @[UInt.scala 467:20]
  assign decode_divSqrtToMul_payload_rs1_exponent = 9'bxxxxxxxxx; // @[UInt.scala 467:20]
  assign decode_divSqrtToMul_payload_rs1_sign = 1'bx; // @[Bool.scala 276:20]
  assign decode_divSqrtToMul_payload_rs1_special = 1'bx; // @[Bool.scala 276:20]
  assign decode_divSqrtToMul_payload_rs2_mantissa = 23'bxxxxxxxxxxxxxxxxxxxxxxx; // @[UInt.scala 467:20]
  assign decode_divSqrtToMul_payload_rs2_exponent = 9'bxxxxxxxxx; // @[UInt.scala 467:20]
  assign decode_divSqrtToMul_payload_rs2_sign = 1'bx; // @[Bool.scala 276:20]
  assign decode_divSqrtToMul_payload_rs2_special = 1'bx; // @[Bool.scala 276:20]
  assign decode_divSqrtToMul_payload_rs3_mantissa = 23'bxxxxxxxxxxxxxxxxxxxxxxx; // @[UInt.scala 467:20]
  assign decode_divSqrtToMul_payload_rs3_exponent = 9'bxxxxxxxxx; // @[UInt.scala 467:20]
  assign decode_divSqrtToMul_payload_rs3_sign = 1'bx; // @[Bool.scala 276:20]
  assign decode_divSqrtToMul_payload_rs3_special = 1'bx; // @[Bool.scala 276:20]
  assign decode_divSqrtToMul_payload_rd = 5'bxxxxx; // @[UInt.scala 467:20]
  assign decode_divSqrtToMul_payload_add = 1'bx; // @[Bool.scala 276:20]
  assign decode_divSqrtToMul_payload_divSqrt = 1'bx; // @[Bool.scala 276:20]
  assign decode_divSqrtToMul_payload_msb1 = 1'bx; // @[Bool.scala 276:20]
  assign decode_divSqrtToMul_payload_msb2 = 1'bx; // @[Bool.scala 276:20]
  assign decode_divSqrtToMul_payload_roundMode = (3'bxxx); // @[Enum.scala 231:20]
  assign when_FpuCore_l375 = ((decode_mulHit && decode_mul_ready) && (! decode_divSqrtToMul_valid)); // @[BaseType.scala 305:24]
  assign decode_mul_valid = ((decode_input_valid && decode_mulHit) || decode_divSqrtToMul_valid); // @[FpuCore.scala 376:17]
  assign decode_divSqrtToMul_ready = decode_mul_ready; // @[FpuCore.scala 378:26]
  always @(*) begin
    decode_mul_payload_rs1_mantissa = decode_divSqrtToMul_payload_rs1_mantissa; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs1_mantissa = decode_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
    end
  end

  always @(*) begin
    decode_mul_payload_rs1_exponent = decode_divSqrtToMul_payload_rs1_exponent; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs1_exponent = decode_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
    end
  end

  always @(*) begin
    decode_mul_payload_rs1_sign = decode_divSqrtToMul_payload_rs1_sign; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs1_sign = decode_input_payload_rs1_sign; // @[Bundle.scala 141:37]
    end
  end

  always @(*) begin
    decode_mul_payload_rs1_special = decode_divSqrtToMul_payload_rs1_special; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs1_special = decode_input_payload_rs1_special; // @[Bundle.scala 141:37]
    end
  end

  always @(*) begin
    decode_mul_payload_rs2_mantissa = decode_divSqrtToMul_payload_rs2_mantissa; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs2_mantissa = decode_input_payload_rs2_mantissa; // @[Bundle.scala 141:37]
    end
  end

  always @(*) begin
    decode_mul_payload_rs2_exponent = decode_divSqrtToMul_payload_rs2_exponent; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs2_exponent = decode_input_payload_rs2_exponent; // @[Bundle.scala 141:37]
    end
  end

  always @(*) begin
    decode_mul_payload_rs2_sign = decode_divSqrtToMul_payload_rs2_sign; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs2_sign = decode_input_payload_rs2_sign; // @[Bundle.scala 141:37]
      decode_mul_payload_rs2_sign = (decode_input_payload_rs2_sign ^ decode_input_payload_arg[0]); // @[FpuCore.scala 387:22]
    end
  end

  always @(*) begin
    decode_mul_payload_rs2_special = decode_divSqrtToMul_payload_rs2_special; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs2_special = decode_input_payload_rs2_special; // @[Bundle.scala 141:37]
    end
  end

  always @(*) begin
    decode_mul_payload_rs3_mantissa = decode_divSqrtToMul_payload_rs3_mantissa; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs3_mantissa = decode_input_payload_rs3_mantissa; // @[Bundle.scala 141:37]
    end
  end

  always @(*) begin
    decode_mul_payload_rs3_exponent = decode_divSqrtToMul_payload_rs3_exponent; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs3_exponent = decode_input_payload_rs3_exponent; // @[Bundle.scala 141:37]
    end
  end

  always @(*) begin
    decode_mul_payload_rs3_sign = decode_divSqrtToMul_payload_rs3_sign; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs3_sign = decode_input_payload_rs3_sign; // @[Bundle.scala 141:37]
      decode_mul_payload_rs3_sign = (decode_input_payload_rs3_sign ^ decode_input_payload_arg[1]); // @[FpuCore.scala 389:22]
    end
  end

  always @(*) begin
    decode_mul_payload_rs3_special = decode_divSqrtToMul_payload_rs3_special; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs3_special = decode_input_payload_rs3_special; // @[Bundle.scala 141:37]
    end
  end

  always @(*) begin
    decode_mul_payload_rd = decode_divSqrtToMul_payload_rd; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_rd = decode_input_payload_rd; // @[Bundle.scala 141:37]
    end
  end

  always @(*) begin
    decode_mul_payload_add = decode_divSqrtToMul_payload_add; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_add = decode_fmaHit; // @[FpuCore.scala 382:17]
    end
  end

  always @(*) begin
    decode_mul_payload_divSqrt = decode_divSqrtToMul_payload_divSqrt; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_divSqrt = 1'b0; // @[FpuCore.scala 383:21]
    end
  end

  always @(*) begin
    decode_mul_payload_msb1 = decode_divSqrtToMul_payload_msb1; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_msb1 = 1'b1; // @[FpuCore.scala 384:18]
    end
  end

  always @(*) begin
    decode_mul_payload_msb2 = decode_divSqrtToMul_payload_msb2; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_msb2 = 1'b1; // @[FpuCore.scala 385:18]
    end
  end

  always @(*) begin
    decode_mul_payload_roundMode = decode_divSqrtToMul_payload_roundMode; // @[FpuCore.scala 379:19]
    if(when_FpuCore_l380) begin
      decode_mul_payload_roundMode = decode_input_payload_roundMode; // @[Bundle.scala 141:37]
    end
  end

  assign when_FpuCore_l380 = (! decode_divSqrtToMul_valid); // @[BaseType.scala 299:24]
  assign decode_addHit = (decode_input_payload_opcode == FpuOpcode_ADD); // @[BaseType.scala 305:24]
  assign when_FpuCore_l399 = ((decode_addHit && decode_add_ready) && (! decode_mulToAdd_valid)); // @[BaseType.scala 305:24]
  assign decode_add_valid = ((decode_input_valid && decode_addHit) || decode_mulToAdd_valid); // @[FpuCore.scala 400:17]
  assign decode_mulToAdd_ready = decode_add_ready; // @[FpuCore.scala 402:22]
  always @(*) begin
    decode_add_payload_rs1_mantissa = decode_mulToAdd_payload_rs1_mantissa; // @[FpuCore.scala 403:19]
    if(when_FpuCore_l404) begin
      decode_add_payload_rs1_mantissa = ({2'd0,decode_input_payload_rs1_mantissa} <<< 2); // @[FpuCore.scala 416:26]
    end
  end

  always @(*) begin
    decode_add_payload_rs1_exponent = decode_mulToAdd_payload_rs1_exponent; // @[FpuCore.scala 403:19]
    if(when_FpuCore_l404) begin
      decode_add_payload_rs1_exponent = decode_input_payload_rs1_exponent; // @[FpuCore.scala 412:26]
    end
  end

  always @(*) begin
    decode_add_payload_rs1_sign = decode_mulToAdd_payload_rs1_sign; // @[FpuCore.scala 403:19]
    if(when_FpuCore_l404) begin
      decode_add_payload_rs1_sign = decode_input_payload_rs1_sign; // @[FpuCore.scala 414:22]
    end
  end

  always @(*) begin
    decode_add_payload_rs1_special = decode_mulToAdd_payload_rs1_special; // @[FpuCore.scala 403:19]
    if(when_FpuCore_l404) begin
      decode_add_payload_rs1_special = decode_input_payload_rs1_special; // @[FpuCore.scala 410:25]
    end
  end

  always @(*) begin
    decode_add_payload_rs2_mantissa = decode_mulToAdd_payload_rs2_mantissa; // @[FpuCore.scala 403:19]
    if(when_FpuCore_l404) begin
      decode_add_payload_rs2_mantissa = ({2'd0,decode_input_payload_rs2_mantissa} <<< 2); // @[FpuCore.scala 417:26]
    end
  end

  always @(*) begin
    decode_add_payload_rs2_exponent = decode_mulToAdd_payload_rs2_exponent; // @[FpuCore.scala 403:19]
    if(when_FpuCore_l404) begin
      decode_add_payload_rs2_exponent = decode_input_payload_rs2_exponent; // @[FpuCore.scala 413:26]
    end
  end

  always @(*) begin
    decode_add_payload_rs2_sign = decode_mulToAdd_payload_rs2_sign; // @[FpuCore.scala 403:19]
    if(when_FpuCore_l404) begin
      decode_add_payload_rs2_sign = (decode_input_payload_rs2_sign ^ decode_input_payload_arg[0]); // @[FpuCore.scala 415:22]
    end
  end

  always @(*) begin
    decode_add_payload_rs2_special = decode_mulToAdd_payload_rs2_special; // @[FpuCore.scala 403:19]
    if(when_FpuCore_l404) begin
      decode_add_payload_rs2_special = decode_input_payload_rs2_special; // @[FpuCore.scala 411:25]
    end
  end

  always @(*) begin
    decode_add_payload_rd = decode_mulToAdd_payload_rd; // @[FpuCore.scala 403:19]
    if(when_FpuCore_l404) begin
      decode_add_payload_rd = decode_input_payload_rd; // @[FpuCore.scala 406:16]
    end
  end

  always @(*) begin
    decode_add_payload_roundMode = decode_mulToAdd_payload_roundMode; // @[FpuCore.scala 403:19]
    if(when_FpuCore_l404) begin
      decode_add_payload_roundMode = decode_input_payload_roundMode; // @[FpuCore.scala 407:23]
    end
  end

  always @(*) begin
    decode_add_payload_needCommit = decode_mulToAdd_payload_needCommit; // @[FpuCore.scala 403:19]
    if(when_FpuCore_l404) begin
      decode_add_payload_needCommit = 1'b1; // @[FpuCore.scala 409:24]
    end
  end

  assign when_FpuCore_l404 = (! decode_mulToAdd_valid); // @[BaseType.scala 299:24]
  assign decode_load_ready = (! decode_load_rValid); // @[Stream.scala 380:16]
  assign decode_load_s2mPipe_valid = (decode_load_valid || decode_load_rValid); // @[Stream.scala 382:19]
  assign _zz_decode_load_s2mPipe_payload_roundMode = (decode_load_rValid ? decode_load_rData_roundMode : decode_load_payload_roundMode); // @[Expression.scala 1420:25]
  assign decode_load_s2mPipe_payload_rd = (decode_load_rValid ? decode_load_rData_rd : decode_load_payload_rd); // @[Stream.scala 383:21]
  assign decode_load_s2mPipe_payload_i2f = (decode_load_rValid ? decode_load_rData_i2f : decode_load_payload_i2f); // @[Stream.scala 383:21]
  assign decode_load_s2mPipe_payload_arg = (decode_load_rValid ? decode_load_rData_arg : decode_load_payload_arg); // @[Stream.scala 383:21]
  assign decode_load_s2mPipe_payload_roundMode = _zz_decode_load_s2mPipe_payload_roundMode; // @[Stream.scala 383:21]
  always @(*) begin
    decode_load_s2mPipe_ready = decode_load_s2mPipe_m2sPipe_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_1) begin
      decode_load_s2mPipe_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_1 = (! decode_load_s2mPipe_m2sPipe_valid); // @[BaseType.scala 299:24]
  assign decode_load_s2mPipe_m2sPipe_valid = decode_load_s2mPipe_rValid; // @[Stream.scala 370:19]
  assign decode_load_s2mPipe_m2sPipe_payload_rd = decode_load_s2mPipe_rData_rd; // @[Stream.scala 371:21]
  assign decode_load_s2mPipe_m2sPipe_payload_i2f = decode_load_s2mPipe_rData_i2f; // @[Stream.scala 371:21]
  assign decode_load_s2mPipe_m2sPipe_payload_arg = decode_load_s2mPipe_rData_arg; // @[Stream.scala 371:21]
  assign decode_load_s2mPipe_m2sPipe_payload_roundMode = decode_load_s2mPipe_rData_roundMode; // @[Stream.scala 371:21]
  always @(*) begin
    decode_load_s2mPipe_m2sPipe_ready = load_s0_input_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_2) begin
      decode_load_s2mPipe_m2sPipe_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_2 = (! load_s0_input_valid); // @[BaseType.scala 299:24]
  assign load_s0_input_valid = decode_load_s2mPipe_m2sPipe_rValid; // @[Stream.scala 370:19]
  assign load_s0_input_payload_rd = decode_load_s2mPipe_m2sPipe_rData_rd; // @[Stream.scala 371:21]
  assign load_s0_input_payload_i2f = decode_load_s2mPipe_m2sPipe_rData_i2f; // @[Stream.scala 371:21]
  assign load_s0_input_payload_arg = decode_load_s2mPipe_m2sPipe_rData_arg; // @[Stream.scala 371:21]
  assign load_s0_input_payload_roundMode = decode_load_s2mPipe_m2sPipe_rData_roundMode; // @[Stream.scala 371:21]
  assign when_Stream_l438 = (! ({(commitFork_load_0_payload_opcode == FpuOpcode_I2F),{(commitFork_load_0_payload_opcode == FpuOpcode_FMV_W_X),(commitFork_load_0_payload_opcode == FpuOpcode_LOAD)}} != 3'b000)); // @[BaseType.scala 299:24]
  always @(*) begin
    load_s0_filtred_0_valid = commitFork_load_0_valid; // @[Stream.scala 294:16]
    if(when_Stream_l438) begin
      load_s0_filtred_0_valid = 1'b0; // @[Stream.scala 439:18]
    end
  end

  always @(*) begin
    commitFork_load_0_ready = load_s0_filtred_0_ready; // @[Stream.scala 295:16]
    if(when_Stream_l438) begin
      commitFork_load_0_ready = 1'b1; // @[Stream.scala 440:18]
    end
  end

  assign load_s0_filtred_0_payload_opcode = commitFork_load_0_payload_opcode; // @[Stream.scala 296:18]
  assign load_s0_filtred_0_payload_rd = commitFork_load_0_payload_rd; // @[Stream.scala 296:18]
  assign load_s0_filtred_0_payload_write = commitFork_load_0_payload_write; // @[Stream.scala 296:18]
  assign load_s0_filtred_0_payload_value = commitFork_load_0_payload_value; // @[Stream.scala 296:18]
  assign load_s0_hazard = (! load_s0_filtred_0_valid); // @[BaseType.scala 299:24]
  assign _zz_load_s0_input_ready = (! load_s0_hazard); // @[BaseType.scala 299:24]
  assign load_s0_input_ready = (load_s0_output_ready && _zz_load_s0_input_ready); // @[Stream.scala 427:16]
  assign load_s0_output_valid = (load_s0_input_valid && _zz_load_s0_input_ready); // @[Stream.scala 303:16]
  always @(*) begin
    load_s0_filtred_0_ready = 1'b0; // @[FpuCore.scala 442:31]
    if(_zz_when[0]) begin
      load_s0_filtred_0_ready = (load_s0_input_valid && load_s0_output_ready); // @[FpuCore.scala 443:18]
    end
  end

  assign load_s0_output_payload_rd = load_s0_input_payload_rd; // @[FpuCore.scala 445:17]
  assign load_s0_output_payload_value = load_s0_filtred_0_payload_value; // @[FpuCore.scala 446:20]
  assign load_s0_output_payload_i2f = load_s0_input_payload_i2f; // @[FpuCore.scala 447:18]
  assign load_s0_output_payload_arg = load_s0_input_payload_arg; // @[FpuCore.scala 448:18]
  assign load_s0_output_payload_roundMode = load_s0_input_payload_roundMode; // @[FpuCore.scala 449:24]
  always @(*) begin
    load_s0_output_ready = load_s1_input_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_3) begin
      load_s0_output_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_3 = (! load_s1_input_valid); // @[BaseType.scala 299:24]
  assign load_s1_input_valid = load_s0_output_rValid; // @[Stream.scala 370:19]
  assign load_s1_input_payload_rd = load_s0_output_rData_rd; // @[Stream.scala 371:21]
  assign load_s1_input_payload_value = load_s0_output_rData_value; // @[Stream.scala 371:21]
  assign load_s1_input_payload_i2f = load_s0_output_rData_i2f; // @[Stream.scala 371:21]
  assign load_s1_input_payload_arg = load_s0_output_rData_arg; // @[Stream.scala 371:21]
  assign load_s1_input_payload_roundMode = load_s0_output_rData_roundMode; // @[Stream.scala 371:21]
  always @(*) begin
    load_s1_busy = 1'b0; // @[FpuCore.scala 460:18]
    if(when_FpuCore_l529) begin
      load_s1_busy = 1'b1; // @[FpuCore.scala 530:16]
    end
  end

  assign load_s1_f32_mantissa = load_s1_input_payload_value[22 : 0]; // @[BaseType.scala 318:22]
  assign load_s1_f32_exponent = load_s1_input_payload_value[30 : 23]; // @[BaseType.scala 318:22]
  assign load_s1_f32_sign = load_s1_input_payload_value[31]; // @[BaseType.scala 305:24]
  assign load_s1_passThroughFloat_special = 1'b0; // @[FpuCore.scala 475:32]
  assign load_s1_passThroughFloat_sign = load_s1_f32_sign; // @[FpuCore.scala 483:31]
  assign load_s1_passThroughFloat_exponent = {1'd0, load_s1_f32_exponent}; // @[FpuCore.scala 484:35]
  assign load_s1_passThroughFloat_mantissa = load_s1_f32_mantissa; // @[FpuCore.scala 485:35]
  assign load_s1_recodedExpOffset = 9'h080; // @[FpuCore.scala 486:26]
  assign load_s1_manZero = (load_s1_passThroughFloat_mantissa == 23'h0); // @[BaseType.scala 305:24]
  assign load_s1_expZero = (load_s1_passThroughFloat_exponent == 9'h0); // @[BaseType.scala 305:24]
  assign load_s1_expOne = (&load_s1_passThroughFloat_exponent[7 : 0]); // @[BaseType.scala 312:24]
  assign load_s1_isZero = (load_s1_expZero && load_s1_manZero); // @[BaseType.scala 305:24]
  assign load_s1_isSubnormal = (load_s1_expZero && (! load_s1_manZero)); // @[BaseType.scala 305:24]
  assign load_s1_isInfinity = (load_s1_expOne && load_s1_manZero); // @[BaseType.scala 305:24]
  assign load_s1_isNan = (load_s1_expOne && (! load_s1_manZero)); // @[BaseType.scala 305:24]
  always @(*) begin
    load_s1_fsm_ohInput = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; // @[Bits.scala 231:20]
    if(when_FpuCore_l508) begin
      load_s1_fsm_ohInput = ({9'd0,load_s1_input_payload_value[22 : 0]} <<< 9); // @[FpuCore.scala 509:37]
    end else begin
      load_s1_fsm_ohInput[31 : 0] = load_s1_input_payload_value[31 : 0]; // @[FpuCore.scala 513:45]
    end
  end

  assign when_FpuCore_l508 = (! load_s1_input_payload_i2f); // @[BaseType.scala 299:24]
  always @(*) begin
    load_s1_fsm_shift_input = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; // @[UInt.scala 467:20]
    load_s1_fsm_shift_input = (load_s1_fsm_ohInput <<< 1); // @[FpuCore.scala 527:21]
  end

  assign when_FpuCore_l525 = (! load_s1_fsm_done); // @[BaseType.scala 299:24]
  assign when_FpuCore_l529 = ((load_s1_input_valid && (load_s1_input_payload_i2f || load_s1_isSubnormal)) && (! load_s1_fsm_done)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l532 = (((load_s1_input_payload_i2f && (! load_s1_fsm_patched)) && load_s1_input_payload_value[31]) && load_s1_input_payload_arg[0]); // @[BaseType.scala 305:24]
  assign _zz_load_s0_output_rData_value = load_s1_input_payload_value; // @[BaseType.scala 318:22]
  assign _zz_load_s0_output_rData_value_1 = 1'b1; // @[FpuCore.scala 533:93]
  assign _zz_load_s1_fsm_shift_by = {load_s1_fsm_ohInput[0],{load_s1_fsm_ohInput[1],{load_s1_fsm_ohInput[2],{load_s1_fsm_ohInput[3],{load_s1_fsm_ohInput[4],{load_s1_fsm_ohInput[5],{load_s1_fsm_ohInput[6],{load_s1_fsm_ohInput[7],{load_s1_fsm_ohInput[8],{_zz__zz_load_s1_fsm_shift_by,{_zz__zz_load_s1_fsm_shift_by_1,_zz__zz_load_s1_fsm_shift_by_2}}}}}}}}}}}; // @[BaseType.scala 318:22]
  assign _zz_load_s1_fsm_shift_by_1 = (_zz_load_s1_fsm_shift_by & (~ _zz__zz_load_s1_fsm_shift_by_1_1)); // @[Bits.scala 133:56]
  assign _zz_load_s1_fsm_shift_by_2 = _zz_load_s1_fsm_shift_by_1[3]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_3 = _zz_load_s1_fsm_shift_by_1[5]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_4 = _zz_load_s1_fsm_shift_by_1[6]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_5 = _zz_load_s1_fsm_shift_by_1[7]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_6 = _zz_load_s1_fsm_shift_by_1[9]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_7 = _zz_load_s1_fsm_shift_by_1[10]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_8 = _zz_load_s1_fsm_shift_by_1[11]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_9 = _zz_load_s1_fsm_shift_by_1[12]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_10 = _zz_load_s1_fsm_shift_by_1[13]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_11 = _zz_load_s1_fsm_shift_by_1[14]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_12 = _zz_load_s1_fsm_shift_by_1[15]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_13 = _zz_load_s1_fsm_shift_by_1[17]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_14 = _zz_load_s1_fsm_shift_by_1[18]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_15 = _zz_load_s1_fsm_shift_by_1[19]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_16 = _zz_load_s1_fsm_shift_by_1[20]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_17 = _zz_load_s1_fsm_shift_by_1[21]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_18 = _zz_load_s1_fsm_shift_by_1[22]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_19 = _zz_load_s1_fsm_shift_by_1[23]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_20 = _zz_load_s1_fsm_shift_by_1[24]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_21 = _zz_load_s1_fsm_shift_by_1[25]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_22 = _zz_load_s1_fsm_shift_by_1[26]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_23 = _zz_load_s1_fsm_shift_by_1[27]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_24 = _zz_load_s1_fsm_shift_by_1[28]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_25 = _zz_load_s1_fsm_shift_by_1[29]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_26 = _zz_load_s1_fsm_shift_by_1[30]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_27 = _zz_load_s1_fsm_shift_by_1[31]; // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_28 = (((((((((((((((_zz_load_s1_fsm_shift_by_1[1] || _zz_load_s1_fsm_shift_by_2) || _zz_load_s1_fsm_shift_by_3) || _zz_load_s1_fsm_shift_by_5) || _zz_load_s1_fsm_shift_by_6) || _zz_load_s1_fsm_shift_by_8) || _zz_load_s1_fsm_shift_by_10) || _zz_load_s1_fsm_shift_by_12) || _zz_load_s1_fsm_shift_by_13) || _zz_load_s1_fsm_shift_by_15) || _zz_load_s1_fsm_shift_by_17) || _zz_load_s1_fsm_shift_by_19) || _zz_load_s1_fsm_shift_by_21) || _zz_load_s1_fsm_shift_by_23) || _zz_load_s1_fsm_shift_by_25) || _zz_load_s1_fsm_shift_by_27); // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_29 = (((((((((((((((_zz_load_s1_fsm_shift_by_1[2] || _zz_load_s1_fsm_shift_by_2) || _zz_load_s1_fsm_shift_by_4) || _zz_load_s1_fsm_shift_by_5) || _zz_load_s1_fsm_shift_by_7) || _zz_load_s1_fsm_shift_by_8) || _zz_load_s1_fsm_shift_by_11) || _zz_load_s1_fsm_shift_by_12) || _zz_load_s1_fsm_shift_by_14) || _zz_load_s1_fsm_shift_by_15) || _zz_load_s1_fsm_shift_by_18) || _zz_load_s1_fsm_shift_by_19) || _zz_load_s1_fsm_shift_by_22) || _zz_load_s1_fsm_shift_by_23) || _zz_load_s1_fsm_shift_by_26) || _zz_load_s1_fsm_shift_by_27); // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_30 = (((((((((((((((_zz_load_s1_fsm_shift_by_1[4] || _zz_load_s1_fsm_shift_by_3) || _zz_load_s1_fsm_shift_by_4) || _zz_load_s1_fsm_shift_by_5) || _zz_load_s1_fsm_shift_by_9) || _zz_load_s1_fsm_shift_by_10) || _zz_load_s1_fsm_shift_by_11) || _zz_load_s1_fsm_shift_by_12) || _zz_load_s1_fsm_shift_by_16) || _zz_load_s1_fsm_shift_by_17) || _zz_load_s1_fsm_shift_by_18) || _zz_load_s1_fsm_shift_by_19) || _zz_load_s1_fsm_shift_by_24) || _zz_load_s1_fsm_shift_by_25) || _zz_load_s1_fsm_shift_by_26) || _zz_load_s1_fsm_shift_by_27); // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_31 = (((((((((((((((_zz_load_s1_fsm_shift_by_1[8] || _zz_load_s1_fsm_shift_by_6) || _zz_load_s1_fsm_shift_by_7) || _zz_load_s1_fsm_shift_by_8) || _zz_load_s1_fsm_shift_by_9) || _zz_load_s1_fsm_shift_by_10) || _zz_load_s1_fsm_shift_by_11) || _zz_load_s1_fsm_shift_by_12) || _zz_load_s1_fsm_shift_by_20) || _zz_load_s1_fsm_shift_by_21) || _zz_load_s1_fsm_shift_by_22) || _zz_load_s1_fsm_shift_by_23) || _zz_load_s1_fsm_shift_by_24) || _zz_load_s1_fsm_shift_by_25) || _zz_load_s1_fsm_shift_by_26) || _zz_load_s1_fsm_shift_by_27); // @[BaseType.scala 305:24]
  assign _zz_load_s1_fsm_shift_by_32 = (((((((((((((((_zz_load_s1_fsm_shift_by_1[16] || _zz_load_s1_fsm_shift_by_13) || _zz_load_s1_fsm_shift_by_14) || _zz_load_s1_fsm_shift_by_15) || _zz_load_s1_fsm_shift_by_16) || _zz_load_s1_fsm_shift_by_17) || _zz_load_s1_fsm_shift_by_18) || _zz_load_s1_fsm_shift_by_19) || _zz_load_s1_fsm_shift_by_20) || _zz_load_s1_fsm_shift_by_21) || _zz_load_s1_fsm_shift_by_22) || _zz_load_s1_fsm_shift_by_23) || _zz_load_s1_fsm_shift_by_24) || _zz_load_s1_fsm_shift_by_25) || _zz_load_s1_fsm_shift_by_26) || _zz_load_s1_fsm_shift_by_27); // @[BaseType.scala 305:24]
  always @(*) begin
    load_s1_fsm_expOffset = 9'h0; // @[FpuCore.scala 546:19]
    if(load_s1_isSubnormal) begin
      load_s1_fsm_expOffset = {4'd0, load_s1_fsm_shift_by}; // @[FpuCore.scala 548:21]
    end
  end

  assign load_s1_input_isStall = (load_s1_input_valid && (! load_s1_input_ready)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l551 = (! load_s1_input_isStall); // @[BaseType.scala 299:24]
  assign load_s1_i2fHigh = load_s1_fsm_shift_output[31 : 8]; // @[BaseType.scala 318:22]
  assign load_s1_i2fLow = load_s1_fsm_shift_output[7 : 0]; // @[BaseType.scala 318:22]
  assign load_s1_scrap = (load_s1_i2fLow != 8'h0); // @[BaseType.scala 305:24]
  assign load_s1_recoded_mantissa = load_s1_passThroughFloat_mantissa; // @[FpuCore.scala 564:24]
  always @(*) begin
    load_s1_recoded_exponent = _zz_load_s1_recoded_exponent[8:0]; // @[FpuCore.scala 565:24]
    if(load_s1_isZero) begin
      load_s1_recoded_exponent[1 : 0] = 2'b00; // @[Interface.scala 57:63]
    end
    if(load_s1_isInfinity) begin
      load_s1_recoded_exponent[1 : 0] = 2'b01; // @[Interface.scala 58:63]
    end
    if(load_s1_isNan) begin
      load_s1_recoded_exponent[1 : 0] = 2'b10; // @[Interface.scala 59:63]
      load_s1_recoded_exponent[2] = 1'b0; // @[Interface.scala 59:117]
    end
  end

  assign load_s1_recoded_sign = load_s1_passThroughFloat_sign; // @[FpuCore.scala 566:24]
  always @(*) begin
    load_s1_recoded_special = 1'b0; // @[Interface.scala 56:33]
    if(load_s1_isZero) begin
      load_s1_recoded_special = 1'b1; // @[Interface.scala 57:33]
    end
    if(load_s1_isInfinity) begin
      load_s1_recoded_special = 1'b1; // @[Interface.scala 58:33]
    end
    if(load_s1_isNan) begin
      load_s1_recoded_special = 1'b1; // @[Interface.scala 59:33]
    end
  end

  assign _zz_load_s1_input_ready = (! load_s1_busy); // @[BaseType.scala 299:24]
  assign load_s1_input_ready = (load_s1_output_ready && _zz_load_s1_input_ready); // @[Stream.scala 427:16]
  assign load_s1_output_valid = (load_s1_input_valid && _zz_load_s1_input_ready); // @[Stream.scala 303:16]
  assign load_s1_output_payload_roundMode = load_s1_input_payload_roundMode; // @[FpuCore.scala 574:24]
  assign load_s1_output_payload_rd = load_s1_input_payload_rd; // @[FpuCore.scala 578:17]
  always @(*) begin
    load_s1_output_payload_value_sign = load_s1_recoded_sign; // @[FpuCore.scala 579:30]
    if(load_s1_input_payload_i2f) begin
      load_s1_output_payload_value_sign = load_s1_fsm_patched; // @[FpuCore.scala 587:27]
    end
  end

  always @(*) begin
    load_s1_output_payload_value_exponent = load_s1_recoded_exponent; // @[FpuCore.scala 580:30]
    if(load_s1_input_payload_i2f) begin
      load_s1_output_payload_value_exponent = (9'h11e - _zz_load_s1_output_payload_value_exponent); // @[FpuCore.scala 588:31]
      if(load_s1_fsm_i2fZero) begin
        load_s1_output_payload_value_exponent[1 : 0] = 2'b00; // @[Interface.scala 57:63]
      end
    end
  end

  always @(*) begin
    load_s1_output_payload_value_mantissa = {load_s1_recoded_mantissa,1'b0}; // @[FpuCore.scala 581:30]
    if(when_FpuCore_l594) begin
      load_s1_output_payload_value_mantissa = load_s1_i2fHigh; // @[FpuCore.scala 595:31]
    end
  end

  always @(*) begin
    load_s1_output_payload_value_special = load_s1_recoded_special; // @[FpuCore.scala 582:30]
    if(load_s1_input_payload_i2f) begin
      load_s1_output_payload_value_special = 1'b0; // @[Interface.scala 56:33]
      if(load_s1_fsm_i2fZero) begin
        load_s1_output_payload_value_special = 1'b1; // @[Interface.scala 57:33]
      end
    end
  end

  always @(*) begin
    load_s1_output_payload_scrap = 1'b0; // @[FpuCore.scala 583:20]
    if(load_s1_input_payload_i2f) begin
      load_s1_output_payload_scrap = load_s1_scrap; // @[FpuCore.scala 590:22]
    end
  end

  assign load_s1_output_payload_NV = 1'b0; // @[FpuCore.scala 584:17]
  assign load_s1_output_payload_DZ = 1'b0; // @[FpuCore.scala 585:17]
  assign when_FpuCore_l594 = (load_s1_input_payload_i2f || load_s1_isSubnormal); // @[BaseType.scala 305:24]
  always @(*) begin
    decode_shortPip_ready = shortPip_input_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_4) begin
      decode_shortPip_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_4 = (! shortPip_input_valid); // @[BaseType.scala 299:24]
  assign shortPip_input_valid = decode_shortPip_rValid; // @[Stream.scala 370:19]
  assign shortPip_input_payload_opcode = decode_shortPip_rData_opcode; // @[Stream.scala 371:21]
  assign shortPip_input_payload_rs1_mantissa = decode_shortPip_rData_rs1_mantissa; // @[Stream.scala 371:21]
  assign shortPip_input_payload_rs1_exponent = decode_shortPip_rData_rs1_exponent; // @[Stream.scala 371:21]
  assign shortPip_input_payload_rs1_sign = decode_shortPip_rData_rs1_sign; // @[Stream.scala 371:21]
  assign shortPip_input_payload_rs1_special = decode_shortPip_rData_rs1_special; // @[Stream.scala 371:21]
  assign shortPip_input_payload_rs2_mantissa = decode_shortPip_rData_rs2_mantissa; // @[Stream.scala 371:21]
  assign shortPip_input_payload_rs2_exponent = decode_shortPip_rData_rs2_exponent; // @[Stream.scala 371:21]
  assign shortPip_input_payload_rs2_sign = decode_shortPip_rData_rs2_sign; // @[Stream.scala 371:21]
  assign shortPip_input_payload_rs2_special = decode_shortPip_rData_rs2_special; // @[Stream.scala 371:21]
  assign shortPip_input_payload_rd = decode_shortPip_rData_rd; // @[Stream.scala 371:21]
  assign shortPip_input_payload_value = decode_shortPip_rData_value; // @[Stream.scala 371:21]
  assign shortPip_input_payload_arg = decode_shortPip_rData_arg; // @[Stream.scala 371:21]
  assign shortPip_input_payload_roundMode = decode_shortPip_rData_roundMode; // @[Stream.scala 371:21]
  assign shortPip_toFpuRf = ({(shortPip_input_payload_opcode == FpuOpcode_FCVT_X_X),{(shortPip_input_payload_opcode == FpuOpcode_SGNJ),(shortPip_input_payload_opcode == FpuOpcode_MIN_MAX)}} != 3'b000); // @[BaseType.scala 305:24]
  assign shortPip_input_fire = (shortPip_input_valid && shortPip_input_ready); // @[BaseType.scala 305:24]
  assign when_FpuCore_l221 = ((shortPip_input_fire && shortPip_toFpuRf) && 1'b1); // @[BaseType.scala 305:24]
  assign shortPip_isCommited = commitLogic_0_short_notEmpty; // @[Vec.scala 169:11]
  assign _zz_shortPip_rfOutput_ready = (! (! shortPip_isCommited)); // @[BaseType.scala 299:24]
  assign shortPip_output_valid = (shortPip_rfOutput_valid && _zz_shortPip_rfOutput_ready); // @[Stream.scala 426:16]
  assign shortPip_rfOutput_ready = (shortPip_output_ready && _zz_shortPip_rfOutput_ready); // @[Stream.scala 427:16]
  assign shortPip_output_payload_rd = shortPip_rfOutput_payload_rd; // @[Stream.scala 428:18]
  assign shortPip_output_payload_value_mantissa = shortPip_rfOutput_payload_value_mantissa; // @[Stream.scala 428:18]
  assign shortPip_output_payload_value_exponent = shortPip_rfOutput_payload_value_exponent; // @[Stream.scala 428:18]
  assign shortPip_output_payload_value_sign = shortPip_rfOutput_payload_value_sign; // @[Stream.scala 428:18]
  assign shortPip_output_payload_value_special = shortPip_rfOutput_payload_value_special; // @[Stream.scala 428:18]
  assign shortPip_output_payload_scrap = shortPip_rfOutput_payload_scrap; // @[Stream.scala 428:18]
  assign shortPip_output_payload_roundMode = shortPip_rfOutput_payload_roundMode; // @[Stream.scala 428:18]
  assign shortPip_output_payload_NV = shortPip_rfOutput_payload_NV; // @[Stream.scala 428:18]
  assign shortPip_output_payload_DZ = shortPip_rfOutput_payload_DZ; // @[Stream.scala 428:18]
  always @(*) begin
    shortPip_result = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; // @[Bits.scala 231:20]
    case(shortPip_input_payload_opcode)
      FpuOpcode_STORE : begin
        shortPip_result = shortPip_recodedResult; // @[FpuCore.scala 818:38]
      end
      FpuOpcode_FMV_X_W : begin
        shortPip_result = shortPip_recodedResult; // @[FpuCore.scala 819:38]
      end
      FpuOpcode_F2I : begin
        shortPip_result[31 : 0] = shortPip_f2i_result; // @[FpuCore.scala 820:51]
      end
      FpuOpcode_CMP : begin
        shortPip_result[31 : 0] = {31'd0, shortPip_cmpResult}; // @[FpuCore.scala 821:51]
      end
      FpuOpcode_FCLASS : begin
        shortPip_result[31 : 0] = shortPip_fclassResult; // @[FpuCore.scala 822:51]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    shortPip_halt = 1'b0; // @[FpuCore.scala 612:16]
    if(when_FpuCore_l658) begin
      shortPip_halt = 1'b1; // @[FpuCore.scala 659:14]
    end
  end

  assign shortPip_f32_exp = _zz_shortPip_f32_exp[7:0]; // @[BaseType.scala 299:24]
  assign shortPip_f32_man = shortPip_input_payload_rs1_mantissa[22 : 0]; // @[Misc.scala 552:9]
  always @(*) begin
    shortPip_recodedResult = {{shortPip_input_payload_rs1_sign,shortPip_f32_exp},shortPip_f32_man}; // @[FpuCore.scala 626:21]
    if(shortPip_isSubnormal) begin
      shortPip_recodedResult[22 : 0] = shortPip_fsm_shift_output[22 : 0]; // @[FpuCore.scala 716:32]
    end
    if(shortPip_mantissaForced) begin
      shortPip_recodedResult[22 : 0] = (shortPip_mantissaForcedValue ? 23'h7fffff : 23'h0); // @[BitVector.scala 463:10]
    end
    if(shortPip_exponentForced) begin
      shortPip_recodedResult[30 : 23] = (shortPip_exponentForcedValue ? 8'hff : 8'h0); // @[BitVector.scala 463:10]
    end
    if(shortPip_cononicalForced) begin
      shortPip_recodedResult[31] = 1'b0; // @[FpuCore.scala 739:27]
      shortPip_recodedResult[22] = 1'b1; // @[FpuCore.scala 740:27]
    end
  end

  assign shortPip_expSubnormalThreshold = 8'h80; // @[Expression.scala 2342:18]
  assign shortPip_expInSubnormalRange = (shortPip_input_payload_rs1_exponent <= _zz_shortPip_expInSubnormalRange); // @[BaseType.scala 305:24]
  assign shortPip_isSubnormal = ((! shortPip_input_payload_rs1_special) && shortPip_expInSubnormalRange); // @[BaseType.scala 305:24]
  assign shortPip_isNormal = ((! shortPip_input_payload_rs1_special) && (! shortPip_expInSubnormalRange)); // @[BaseType.scala 305:24]
  assign shortPip_fsm_f2iShift = (shortPip_input_payload_rs1_exponent - 9'h0ff); // @[BaseType.scala 299:24]
  assign shortPip_fsm_isF2i = (shortPip_input_payload_opcode == FpuOpcode_F2I); // @[BaseType.scala 305:24]
  assign shortPip_fsm_needRecoding = (({(shortPip_input_payload_opcode == FpuOpcode_STORE),(shortPip_input_payload_opcode == FpuOpcode_FMV_X_W)} != 2'b00) && shortPip_isSubnormal); // @[BaseType.scala 305:24]
  assign shortPip_fsm_isZero = (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b00)); // @[BaseType.scala 305:24]
  always @(*) begin
    shortPip_fsm_shift_input = 33'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; // @[UInt.scala 467:20]
    shortPip_fsm_shift_input = ({9'd0,{(! shortPip_fsm_isZero),shortPip_input_payload_rs1_mantissa}} <<< 9); // @[FpuCore.scala 655:19]
  end

  assign when_FpuCore_l646 = (shortPip_fsm_shift_by[5] && (shortPip_fsm_shift_input[31 : 0] != 32'h0)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l646_1 = (shortPip_fsm_shift_by[4] && (shortPip_fsm_shift_input_1[15 : 0] != 16'h0)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l646_2 = (shortPip_fsm_shift_by[3] && (shortPip_fsm_shift_input_2[7 : 0] != 8'h0)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l646_3 = (shortPip_fsm_shift_by[2] && (shortPip_fsm_shift_input_3[3 : 0] != 4'b0000)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l646_4 = (shortPip_fsm_shift_by[1] && (shortPip_fsm_shift_input_4[1 : 0] != 2'b00)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l646_5 = (shortPip_fsm_shift_by[0] && (shortPip_fsm_shift_input_5[0 : 0] != 1'b0)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l652 = (! shortPip_fsm_done); // @[BaseType.scala 299:24]
  assign shortPip_fsm_formatShiftOffset = 8'h8a; // @[Expression.scala 2342:18]
  assign when_FpuCore_l658 = ((shortPip_input_valid && (shortPip_fsm_needRecoding || shortPip_fsm_isF2i)) && (! shortPip_fsm_done)); // @[BaseType.scala 305:24]
  assign _zz_shortPip_fsm_shift_by = (9'h11e - shortPip_input_payload_rs1_exponent); // @[BaseType.scala 299:24]
  assign _zz_shortPip_fsm_shift_by_1 = 6'h21; // @[Expression.scala 2342:18]
  assign shortPip_input_isStall = (shortPip_input_valid && (! shortPip_input_ready)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l672 = (! shortPip_input_isStall); // @[BaseType.scala 299:24]
  always @(*) begin
    shortPip_mantissaForced = 1'b0; // @[FpuCore.scala 678:26]
    if(shortPip_input_payload_rs1_special) begin
      case(switch_FpuCore_l686)
        2'b00 : begin
          shortPip_mantissaForced = 1'b1; // @[FpuCore.scala 688:31]
        end
        2'b01 : begin
          shortPip_mantissaForced = 1'b1; // @[FpuCore.scala 694:31]
        end
        2'b10 : begin
          if(when_FpuCore_l702) begin
            shortPip_mantissaForced = 1'b1; // @[FpuCore.scala 704:33]
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    shortPip_exponentForced = 1'b0; // @[FpuCore.scala 679:26]
    if(shortPip_input_payload_rs1_special) begin
      case(switch_FpuCore_l686)
        2'b00 : begin
          shortPip_exponentForced = 1'b1; // @[FpuCore.scala 689:31]
        end
        2'b01 : begin
          shortPip_exponentForced = 1'b1; // @[FpuCore.scala 695:31]
        end
        2'b10 : begin
          shortPip_exponentForced = 1'b1; // @[FpuCore.scala 700:31]
        end
        default : begin
        end
      endcase
    end
    if(shortPip_isSubnormal) begin
      shortPip_exponentForced = 1'b1; // @[FpuCore.scala 714:27]
    end
  end

  always @(*) begin
    shortPip_mantissaForcedValue = 1'bx; // @[Bool.scala 276:20]
    if(shortPip_input_payload_rs1_special) begin
      case(switch_FpuCore_l686)
        2'b00 : begin
          shortPip_mantissaForcedValue = 1'b0; // @[FpuCore.scala 690:31]
        end
        2'b01 : begin
          shortPip_mantissaForcedValue = 1'b0; // @[FpuCore.scala 696:31]
        end
        2'b10 : begin
          if(when_FpuCore_l702) begin
            shortPip_mantissaForcedValue = 1'b0; // @[FpuCore.scala 705:33]
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    shortPip_exponentForcedValue = 1'bx; // @[Bool.scala 276:20]
    if(shortPip_input_payload_rs1_special) begin
      case(switch_FpuCore_l686)
        2'b00 : begin
          shortPip_exponentForcedValue = 1'b0; // @[FpuCore.scala 691:31]
        end
        2'b01 : begin
          shortPip_exponentForcedValue = 1'b1; // @[FpuCore.scala 697:31]
        end
        2'b10 : begin
          shortPip_exponentForcedValue = 1'b1; // @[FpuCore.scala 701:31]
        end
        default : begin
        end
      endcase
    end
    if(shortPip_isSubnormal) begin
      shortPip_exponentForcedValue = 1'b0; // @[FpuCore.scala 715:27]
    end
  end

  always @(*) begin
    shortPip_cononicalForced = 1'b0; // @[FpuCore.scala 682:27]
    if(shortPip_input_payload_rs1_special) begin
      case(switch_FpuCore_l686)
        2'b10 : begin
          if(when_FpuCore_l702) begin
            shortPip_cononicalForced = 1'b1; // @[FpuCore.scala 703:29]
          end
        end
        default : begin
        end
      endcase
    end
  end

  assign switch_FpuCore_l686 = shortPip_input_payload_rs1_exponent[1 : 0]; // @[BaseType.scala 299:24]
  assign when_FpuCore_l702 = shortPip_input_payload_rs1_exponent[2]; // @[BaseType.scala 305:24]
  always @(*) begin
    shortPip_rspNv = 1'b0; // @[FpuCore.scala 744:17]
    if(!shortPip_f2i_isZero) begin
      if(when_FpuCore_l767) begin
        shortPip_rspNv = (((shortPip_input_valid && (shortPip_input_payload_opcode == FpuOpcode_F2I)) && shortPip_fsm_done) && (! shortPip_f2i_isZero)); // @[FpuCore.scala 771:15]
      end
    end
    if(shortPip_NV) begin
      shortPip_rspNv = 1'b1; // @[FpuCore.scala 873:11]
    end
  end

  always @(*) begin
    shortPip_rspNx = 1'b0; // @[FpuCore.scala 745:17]
    if(!shortPip_f2i_isZero) begin
      if(!when_FpuCore_l767) begin
        shortPip_rspNx = (((shortPip_input_valid && (shortPip_input_payload_opcode == FpuOpcode_F2I)) && shortPip_fsm_done) && (shortPip_f2i_round != 2'b00)); // @[FpuCore.scala 773:15]
      end
    end
  end

  assign shortPip_f2i_unsigned = (shortPip_fsm_shift_output[32 : 0] >>> 1); // @[BaseType.scala 299:24]
  assign shortPip_f2i_resign = (shortPip_input_payload_arg[0] && shortPip_input_payload_rs1_sign); // @[BaseType.scala 305:24]
  assign shortPip_f2i_round = {shortPip_fsm_shift_output[0],shortPip_fsm_shift_scrap}; // @[BaseType.scala 299:24]
  always @(*) begin
    case(shortPip_input_payload_roundMode)
      FpuRoundMode_RNE : begin
        shortPip_f2i_increment = (shortPip_f2i_round[1] && (shortPip_f2i_round[0] || shortPip_f2i_unsigned[0])); // @[Misc.scala 239:22]
      end
      FpuRoundMode_RTZ : begin
        shortPip_f2i_increment = 1'b0; // @[Misc.scala 239:22]
      end
      FpuRoundMode_RDN : begin
        shortPip_f2i_increment = ((shortPip_f2i_round != 2'b00) && shortPip_input_payload_rs1_sign); // @[Misc.scala 239:22]
      end
      FpuRoundMode_RUP : begin
        shortPip_f2i_increment = ((shortPip_f2i_round != 2'b00) && (! shortPip_input_payload_rs1_sign)); // @[Misc.scala 239:22]
      end
      default : begin
        shortPip_f2i_increment = shortPip_f2i_round[1]; // @[Misc.scala 239:22]
      end
    endcase
  end

  always @(*) begin
    shortPip_f2i_result = ((shortPip_f2i_resign ? (~ shortPip_f2i_unsigned) : shortPip_f2i_unsigned) + _zz_shortPip_f2i_result); // @[BaseType.scala 299:24]
    if(shortPip_f2i_isZero) begin
      shortPip_f2i_result = 32'h0; // @[FpuCore.scala 766:16]
    end else begin
      if(when_FpuCore_l767) begin
        shortPip_f2i_result = (shortPip_f2i_overflow ? 32'hffffffff : 32'h0); // @[BitVector.scala 463:10]
        shortPip_f2i_result[31] = (shortPip_input_payload_arg[0] ^ shortPip_f2i_overflow); // @[Literal.scala 84:52]
      end
    end
  end

  assign shortPip_f2i_overflow = (((((shortPip_input_payload_arg[0] ? 9'h11d : 9'h11e) < shortPip_input_payload_rs1_exponent) || (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b01))) && (! shortPip_input_payload_rs1_sign)) || (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10))); // @[BaseType.scala 305:24]
  assign shortPip_f2i_underflow = (((((9'h11e < shortPip_input_payload_rs1_exponent) || ((shortPip_input_payload_arg[0] && shortPip_f2i_unsigned[31]) && ((shortPip_f2i_unsigned[30 : 0] != 31'h0) || shortPip_f2i_increment))) || ((! shortPip_input_payload_arg[0]) && ((shortPip_f2i_unsigned != 32'h0) || shortPip_f2i_increment))) || (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b01))) && shortPip_input_payload_rs1_sign); // @[BaseType.scala 305:24]
  assign shortPip_f2i_isZero = (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b00)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l767 = (shortPip_f2i_underflow || shortPip_f2i_overflow); // @[BaseType.scala 305:24]
  assign shortPip_bothZero = ((shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b00)) && (shortPip_input_payload_rs2_special && (shortPip_input_payload_rs2_exponent[1 : 0] == 2'b00))); // @[BaseType.scala 305:24]
  always @(*) begin
    shortPip_rs1Equal = ((((shortPip_input_payload_rs1_mantissa == shortPip_input_payload_rs2_mantissa) && (shortPip_input_payload_rs1_exponent == shortPip_input_payload_rs2_exponent)) && (shortPip_input_payload_rs1_sign == shortPip_input_payload_rs2_sign)) && (shortPip_input_payload_rs1_special == shortPip_input_payload_rs2_special)); // @[BaseType.scala 305:24]
    if(when_FpuCore_l784) begin
      shortPip_rs1Equal = 1'b1; // @[FpuCore.scala 784:14]
    end
  end

  always @(*) begin
    shortPip_rs1AbsSmaller = ({shortPip_input_payload_rs1_exponent,shortPip_input_payload_rs1_mantissa} < {shortPip_input_payload_rs2_exponent,shortPip_input_payload_rs2_mantissa}); // @[BaseType.scala 305:24]
    if(when_FpuCore_l780) begin
      shortPip_rs1AbsSmaller = 1'b1; // @[FpuCore.scala 780:26]
    end
    if(when_FpuCore_l781) begin
      shortPip_rs1AbsSmaller = 1'b1; // @[FpuCore.scala 781:26]
    end
    if(when_FpuCore_l782) begin
      shortPip_rs1AbsSmaller = 1'b0; // @[FpuCore.scala 782:28]
    end
    if(when_FpuCore_l783) begin
      shortPip_rs1AbsSmaller = 1'b0; // @[FpuCore.scala 783:28]
    end
  end

  assign when_FpuCore_l780 = (shortPip_input_payload_rs2_special && (shortPip_input_payload_rs2_exponent[1 : 0] == 2'b01)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l781 = (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b00)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l782 = (shortPip_input_payload_rs2_special && (shortPip_input_payload_rs2_exponent[1 : 0] == 2'b00)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l783 = (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b01)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l784 = (((shortPip_input_payload_rs1_sign == shortPip_input_payload_rs2_sign) && (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b01))) && (shortPip_input_payload_rs2_special && (shortPip_input_payload_rs2_exponent[1 : 0] == 2'b01))); // @[BaseType.scala 305:24]
  assign switch_Misc_l226 = {shortPip_input_payload_rs1_sign,shortPip_input_payload_rs2_sign}; // @[BaseType.scala 299:24]
  always @(*) begin
    case(switch_Misc_l226)
      2'b00 : begin
        shortPip_rs1Smaller = shortPip_rs1AbsSmaller; // @[Misc.scala 239:22]
      end
      2'b01 : begin
        shortPip_rs1Smaller = 1'b0; // @[Misc.scala 239:22]
      end
      2'b10 : begin
        shortPip_rs1Smaller = 1'b1; // @[Misc.scala 239:22]
      end
      default : begin
        shortPip_rs1Smaller = ((! shortPip_rs1AbsSmaller) && (! shortPip_rs1Equal)); // @[Misc.scala 239:22]
      end
    endcase
  end

  assign shortPip_minMaxSelectRs2 = (! (((shortPip_rs1Smaller ^ shortPip_input_payload_arg[0]) && (! (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10)))) || (shortPip_input_payload_rs2_special && (shortPip_input_payload_rs2_exponent[1 : 0] == 2'b10)))); // @[BaseType.scala 299:24]
  assign shortPip_minMaxSelectNanQuiet = ((shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10)) && (shortPip_input_payload_rs2_special && (shortPip_input_payload_rs2_exponent[1 : 0] == 2'b10))); // @[BaseType.scala 305:24]
  always @(*) begin
    shortPip_cmpResult = (((shortPip_rs1Smaller && (! shortPip_bothZero)) && (! shortPip_input_payload_arg[1])) || ((shortPip_rs1Equal || shortPip_bothZero) && (! shortPip_input_payload_arg[0]))); // @[BaseType.scala 318:22]
    if(when_FpuCore_l796) begin
      shortPip_cmpResult = 1'b0; // @[FpuCore.scala 796:58]
    end
  end

  assign when_FpuCore_l796 = ((shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10)) || (shortPip_input_payload_rs2_special && (shortPip_input_payload_rs2_exponent[1 : 0] == 2'b10))); // @[BaseType.scala 305:24]
  assign shortPip_sgnjRs1Sign = shortPip_input_payload_rs1_sign; // @[Misc.scala 552:9]
  assign shortPip_sgnjRs2Sign = shortPip_input_payload_rs2_sign; // @[Misc.scala 552:9]
  assign shortPip_sgnjResult = (((shortPip_sgnjRs1Sign && shortPip_input_payload_arg[1]) ^ shortPip_sgnjRs2Sign) ^ shortPip_input_payload_arg[0]); // @[BaseType.scala 305:24]
  always @(*) begin
    shortPip_fclassResult = 32'h0; // @[Expression.scala 2301:18]
    shortPip_fclassResult[0] = (shortPip_input_payload_rs1_sign && shortPip_decoded_isInfinity); // @[FpuCore.scala 805:21]
    shortPip_fclassResult[1] = (shortPip_input_payload_rs1_sign && shortPip_isNormal); // @[FpuCore.scala 806:21]
    shortPip_fclassResult[2] = (shortPip_input_payload_rs1_sign && shortPip_isSubnormal); // @[FpuCore.scala 807:21]
    shortPip_fclassResult[3] = (shortPip_input_payload_rs1_sign && shortPip_decoded_isZero); // @[FpuCore.scala 808:21]
    shortPip_fclassResult[4] = ((! shortPip_input_payload_rs1_sign) && shortPip_decoded_isZero); // @[FpuCore.scala 809:21]
    shortPip_fclassResult[5] = ((! shortPip_input_payload_rs1_sign) && shortPip_isSubnormal); // @[FpuCore.scala 810:21]
    shortPip_fclassResult[6] = ((! shortPip_input_payload_rs1_sign) && shortPip_isNormal); // @[FpuCore.scala 811:21]
    shortPip_fclassResult[7] = ((! shortPip_input_payload_rs1_sign) && shortPip_decoded_isInfinity); // @[FpuCore.scala 812:21]
    shortPip_fclassResult[8] = (shortPip_decoded_isNan && (! shortPip_decoded_isQuiet)); // @[FpuCore.scala 813:21]
    shortPip_fclassResult[9] = (shortPip_decoded_isNan && shortPip_decoded_isQuiet); // @[FpuCore.scala 814:21]
  end

  assign shortPip_decoded_isZero = (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b00)); // @[Interface.scala 64:21]
  assign shortPip_decoded_isNormal = (! shortPip_input_payload_rs1_special); // @[Interface.scala 65:21]
  assign shortPip_decoded_isInfinity = (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b01)); // @[Interface.scala 66:21]
  assign shortPip_decoded_isNan = (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10)); // @[Interface.scala 67:21]
  assign shortPip_decoded_isQuiet = shortPip_input_payload_rs1_mantissa[22]; // @[Interface.scala 68:21]
  assign shortPip_rfOutput_valid = ((shortPip_input_valid && shortPip_toFpuRf) && (! shortPip_halt)); // @[FpuCore.scala 826:20]
  assign shortPip_rfOutput_payload_rd = shortPip_input_payload_rd; // @[FpuCore.scala 828:17]
  assign shortPip_rfOutput_payload_roundMode = shortPip_input_payload_roundMode; // @[FpuCore.scala 829:24]
  assign shortPip_rfOutput_payload_scrap = 1'b0; // @[FpuCore.scala 831:20]
  always @(*) begin
    shortPip_rfOutput_payload_value_sign = shortPip_input_payload_rs1_sign; // @[FpuCore.scala 832:29]
    case(shortPip_input_payload_opcode)
      FpuOpcode_MIN_MAX : begin
        if(shortPip_minMaxSelectRs2) begin
          shortPip_rfOutput_payload_value_sign = shortPip_input_payload_rs2_sign; // @[FpuCore.scala 840:31]
        end
      end
      FpuOpcode_SGNJ : begin
        if(when_FpuCore_l850) begin
          shortPip_rfOutput_payload_value_sign = shortPip_sgnjResult; // @[FpuCore.scala 851:31]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    shortPip_rfOutput_payload_value_exponent = shortPip_input_payload_rs1_exponent; // @[FpuCore.scala 833:29]
    case(shortPip_input_payload_opcode)
      FpuOpcode_MIN_MAX : begin
        if(shortPip_minMaxSelectRs2) begin
          shortPip_rfOutput_payload_value_exponent = shortPip_input_payload_rs2_exponent; // @[FpuCore.scala 841:35]
        end
        if(shortPip_minMaxSelectNanQuiet) begin
          shortPip_rfOutput_payload_value_exponent[1 : 0] = 2'b10; // @[Interface.scala 60:63]
          shortPip_rfOutput_payload_value_exponent[2] = 1'b1; // @[Interface.scala 60:117]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    shortPip_rfOutput_payload_value_mantissa = {shortPip_input_payload_rs1_mantissa,1'b0}; // @[FpuCore.scala 834:29]
    case(shortPip_input_payload_opcode)
      FpuOpcode_MIN_MAX : begin
        if(shortPip_minMaxSelectRs2) begin
          shortPip_rfOutput_payload_value_mantissa = {shortPip_input_payload_rs2_mantissa,1'b0}; // @[FpuCore.scala 842:35]
        end
        if(shortPip_minMaxSelectNanQuiet) begin
          shortPip_rfOutput_payload_value_mantissa[23] = 1'b1; // @[Interface.scala 60:139]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    shortPip_rfOutput_payload_value_special = shortPip_input_payload_rs1_special; // @[FpuCore.scala 835:29]
    case(shortPip_input_payload_opcode)
      FpuOpcode_MIN_MAX : begin
        if(shortPip_minMaxSelectRs2) begin
          shortPip_rfOutput_payload_value_special = shortPip_input_payload_rs2_special; // @[FpuCore.scala 843:34]
        end
        if(shortPip_minMaxSelectNanQuiet) begin
          shortPip_rfOutput_payload_value_special = 1'b1; // @[Interface.scala 60:33]
        end
      end
      default : begin
      end
    endcase
  end

  assign when_FpuCore_l850 = (! (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10))); // @[BaseType.scala 299:24]
  assign shortPip_signalQuiet = ((shortPip_input_payload_opcode == FpuOpcode_CMP) && (shortPip_input_payload_arg != 2'b10)); // @[BaseType.scala 305:24]
  assign shortPip_rs1Nan = (shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10)); // @[BaseType.scala 305:24]
  assign shortPip_rs2Nan = (shortPip_input_payload_rs2_special && (shortPip_input_payload_rs2_exponent[1 : 0] == 2'b10)); // @[BaseType.scala 305:24]
  assign shortPip_rs1NanNv = ((shortPip_input_payload_rs1_special && (shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10)) && ((! shortPip_input_payload_rs1_mantissa[22]) || shortPip_signalQuiet)); // @[BaseType.scala 305:24]
  assign shortPip_rs2NanNv = ((shortPip_input_payload_rs2_special && (shortPip_input_payload_rs2_exponent[1 : 0] == 2'b10)) && ((! shortPip_input_payload_rs2_mantissa[22]) || shortPip_signalQuiet)); // @[BaseType.scala 305:24]
  assign shortPip_NV = ((({(shortPip_input_payload_opcode == FpuOpcode_FCVT_X_X),{(shortPip_input_payload_opcode == FpuOpcode_MIN_MAX),(shortPip_input_payload_opcode == FpuOpcode_CMP)}} != 3'b000) && shortPip_rs1NanNv) || (({(shortPip_input_payload_opcode == FpuOpcode_MIN_MAX),(shortPip_input_payload_opcode == FpuOpcode_CMP)} != 2'b00) && shortPip_rs2NanNv)); // @[BaseType.scala 305:24]
  assign shortPip_input_ready = ((! shortPip_halt) && (shortPip_toFpuRf ? shortPip_rfOutput_ready : shortPip_rspStreams_0_ready)); // @[FpuCore.scala 876:17]
  assign shortPip_rspStreams_0_valid = (((shortPip_input_valid && 1'b1) && (! shortPip_toFpuRf)) && (! shortPip_halt)); // @[FpuCore.scala 879:17]
  assign shortPip_rspStreams_0_payload_value = shortPip_result; // @[FpuCore.scala 880:17]
  assign shortPip_rspStreams_0_payload_NV = shortPip_rspNv; // @[FpuCore.scala 881:14]
  assign shortPip_rspStreams_0_payload_NX = shortPip_rspNx; // @[FpuCore.scala 882:14]
  always @(*) begin
    shortPip_rspStreams_0_ready = shortPip_rspStreams_0_m2sPipe_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_5) begin
      shortPip_rspStreams_0_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_5 = (! shortPip_rspStreams_0_m2sPipe_valid); // @[BaseType.scala 299:24]
  assign shortPip_rspStreams_0_m2sPipe_valid = shortPip_rspStreams_0_rValid; // @[Stream.scala 370:19]
  assign shortPip_rspStreams_0_m2sPipe_payload_value = shortPip_rspStreams_0_rData_value; // @[Stream.scala 371:21]
  assign shortPip_rspStreams_0_m2sPipe_payload_NV = shortPip_rspStreams_0_rData_NV; // @[Stream.scala 371:21]
  assign shortPip_rspStreams_0_m2sPipe_payload_NX = shortPip_rspStreams_0_rData_NX; // @[Stream.scala 371:21]
  assign io_port_0_rsp_valid = shortPip_rspStreams_0_m2sPipe_valid; // @[Stream.scala 294:16]
  assign shortPip_rspStreams_0_m2sPipe_ready = io_port_0_rsp_ready; // @[Stream.scala 295:16]
  assign io_port_0_rsp_payload_value = shortPip_rspStreams_0_m2sPipe_payload_value; // @[Stream.scala 296:18]
  assign io_port_0_rsp_payload_NV = shortPip_rspStreams_0_m2sPipe_payload_NV; // @[Stream.scala 296:18]
  assign io_port_0_rsp_payload_NX = shortPip_rspStreams_0_m2sPipe_payload_NX; // @[Stream.scala 296:18]
  assign shortPip_rfOutput_payload_NV = shortPip_NV; // @[FpuCore.scala 887:17]
  assign shortPip_rfOutput_payload_DZ = 1'b0; // @[FpuCore.scala 888:17]
  always @(*) begin
    decode_mul_ready = mul_preMul_input_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_6) begin
      decode_mul_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_6 = (! mul_preMul_input_valid); // @[BaseType.scala 299:24]
  assign mul_preMul_input_valid = decode_mul_rValid; // @[Stream.scala 370:19]
  assign mul_preMul_input_payload_rs1_mantissa = decode_mul_rData_rs1_mantissa; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_rs1_exponent = decode_mul_rData_rs1_exponent; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_rs1_sign = decode_mul_rData_rs1_sign; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_rs1_special = decode_mul_rData_rs1_special; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_rs2_mantissa = decode_mul_rData_rs2_mantissa; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_rs2_exponent = decode_mul_rData_rs2_exponent; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_rs2_sign = decode_mul_rData_rs2_sign; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_rs2_special = decode_mul_rData_rs2_special; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_rs3_mantissa = decode_mul_rData_rs3_mantissa; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_rs3_exponent = decode_mul_rData_rs3_exponent; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_rs3_sign = decode_mul_rData_rs3_sign; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_rs3_special = decode_mul_rData_rs3_special; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_rd = decode_mul_rData_rd; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_add = decode_mul_rData_add; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_divSqrt = decode_mul_rData_divSqrt; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_msb1 = decode_mul_rData_msb1; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_msb2 = decode_mul_rData_msb2; // @[Stream.scala 371:21]
  assign mul_preMul_input_payload_roundMode = decode_mul_rData_roundMode; // @[Stream.scala 371:21]
  assign mul_preMul_output_valid = mul_preMul_input_valid; // @[Stream.scala 303:16]
  assign mul_preMul_input_ready = mul_preMul_output_ready; // @[Stream.scala 304:16]
  assign mul_preMul_output_payload_rs1_mantissa = mul_preMul_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_rs1_exponent = mul_preMul_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_rs1_sign = mul_preMul_input_payload_rs1_sign; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_rs1_special = mul_preMul_input_payload_rs1_special; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_rs2_mantissa = mul_preMul_input_payload_rs2_mantissa; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_rs2_exponent = mul_preMul_input_payload_rs2_exponent; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_rs2_sign = mul_preMul_input_payload_rs2_sign; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_rs2_special = mul_preMul_input_payload_rs2_special; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_rs3_mantissa = mul_preMul_input_payload_rs3_mantissa; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_rs3_exponent = mul_preMul_input_payload_rs3_exponent; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_rs3_sign = mul_preMul_input_payload_rs3_sign; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_rs3_special = mul_preMul_input_payload_rs3_special; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_rd = mul_preMul_input_payload_rd; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_add = mul_preMul_input_payload_add; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_divSqrt = mul_preMul_input_payload_divSqrt; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_msb1 = mul_preMul_input_payload_msb1; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_msb2 = mul_preMul_input_payload_msb2; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_roundMode = mul_preMul_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign mul_preMul_output_payload_exp = ({1'b0,mul_preMul_input_payload_rs1_exponent} + {1'b0,mul_preMul_input_payload_rs2_exponent}); // @[FpuCore.scala 916:18]
  always @(*) begin
    mul_preMul_output_ready = mul_mul_input_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_7) begin
      mul_preMul_output_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_7 = (! mul_mul_input_valid); // @[BaseType.scala 299:24]
  assign mul_mul_input_valid = mul_preMul_output_rValid; // @[Stream.scala 370:19]
  assign mul_mul_input_payload_rs1_mantissa = mul_preMul_output_rData_rs1_mantissa; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_rs1_exponent = mul_preMul_output_rData_rs1_exponent; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_rs1_sign = mul_preMul_output_rData_rs1_sign; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_rs1_special = mul_preMul_output_rData_rs1_special; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_rs2_mantissa = mul_preMul_output_rData_rs2_mantissa; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_rs2_exponent = mul_preMul_output_rData_rs2_exponent; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_rs2_sign = mul_preMul_output_rData_rs2_sign; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_rs2_special = mul_preMul_output_rData_rs2_special; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_rs3_mantissa = mul_preMul_output_rData_rs3_mantissa; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_rs3_exponent = mul_preMul_output_rData_rs3_exponent; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_rs3_sign = mul_preMul_output_rData_rs3_sign; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_rs3_special = mul_preMul_output_rData_rs3_special; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_rd = mul_preMul_output_rData_rd; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_add = mul_preMul_output_rData_add; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_divSqrt = mul_preMul_output_rData_divSqrt; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_msb1 = mul_preMul_output_rData_msb1; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_msb2 = mul_preMul_output_rData_msb2; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_roundMode = mul_preMul_output_rData_roundMode; // @[Stream.scala 371:21]
  assign mul_mul_input_payload_exp = mul_preMul_output_rData_exp; // @[Stream.scala 371:21]
  assign mul_mul_output_valid = mul_mul_input_valid; // @[Stream.scala 303:16]
  assign mul_mul_input_ready = mul_mul_output_ready; // @[Stream.scala 304:16]
  assign mul_mul_mulA = {mul_mul_input_payload_msb1,mul_mul_input_payload_rs1_mantissa}; // @[BaseType.scala 318:22]
  assign mul_mul_mulB = {mul_mul_input_payload_msb2,mul_mul_input_payload_rs2_mantissa}; // @[BaseType.scala 318:22]
  assign mul_mul_output_payload_rs1_mantissa = mul_mul_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_rs1_exponent = mul_mul_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_rs1_sign = mul_mul_input_payload_rs1_sign; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_rs1_special = mul_mul_input_payload_rs1_special; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_rs2_mantissa = mul_mul_input_payload_rs2_mantissa; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_rs2_exponent = mul_mul_input_payload_rs2_exponent; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_rs2_sign = mul_mul_input_payload_rs2_sign; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_rs2_special = mul_mul_input_payload_rs2_special; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_rs3_mantissa = mul_mul_input_payload_rs3_mantissa; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_rs3_exponent = mul_mul_input_payload_rs3_exponent; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_rs3_sign = mul_mul_input_payload_rs3_sign; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_rs3_special = mul_mul_input_payload_rs3_special; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_rd = mul_mul_input_payload_rd; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_add = mul_mul_input_payload_add; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_divSqrt = mul_mul_input_payload_divSqrt; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_msb1 = mul_mul_input_payload_msb1; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_msb2 = mul_mul_input_payload_msb2; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_roundMode = mul_mul_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_exp = mul_mul_input_payload_exp; // @[Bundle.scala 141:37]
  assign mul_mul_output_payload_muls_0 = (mul_mul_mulA[17 : 0] * mul_mul_mulB[17 : 0]); // @[FpuCore.scala 927:45]
  assign mul_mul_output_payload_muls_1 = (mul_mul_mulA[17 : 0] * mul_mul_mulB[23 : 18]); // @[FpuCore.scala 927:45]
  assign mul_mul_output_payload_muls_2 = (mul_mul_mulA[23 : 18] * mul_mul_mulB[17 : 0]); // @[FpuCore.scala 927:45]
  assign mul_mul_output_payload_muls_3 = (mul_mul_mulA[23 : 18] * mul_mul_mulB[23 : 18]); // @[FpuCore.scala 927:45]
  always @(*) begin
    mul_mul_output_ready = mul_sum1_input_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_8) begin
      mul_mul_output_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_8 = (! mul_sum1_input_valid); // @[BaseType.scala 299:24]
  assign mul_sum1_input_valid = mul_mul_output_rValid; // @[Stream.scala 370:19]
  assign mul_sum1_input_payload_rs1_mantissa = mul_mul_output_rData_rs1_mantissa; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_rs1_exponent = mul_mul_output_rData_rs1_exponent; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_rs1_sign = mul_mul_output_rData_rs1_sign; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_rs1_special = mul_mul_output_rData_rs1_special; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_rs2_mantissa = mul_mul_output_rData_rs2_mantissa; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_rs2_exponent = mul_mul_output_rData_rs2_exponent; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_rs2_sign = mul_mul_output_rData_rs2_sign; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_rs2_special = mul_mul_output_rData_rs2_special; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_rs3_mantissa = mul_mul_output_rData_rs3_mantissa; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_rs3_exponent = mul_mul_output_rData_rs3_exponent; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_rs3_sign = mul_mul_output_rData_rs3_sign; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_rs3_special = mul_mul_output_rData_rs3_special; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_rd = mul_mul_output_rData_rd; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_add = mul_mul_output_rData_add; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_divSqrt = mul_mul_output_rData_divSqrt; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_msb1 = mul_mul_output_rData_msb1; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_msb2 = mul_mul_output_rData_msb2; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_roundMode = mul_mul_output_rData_roundMode; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_exp = mul_mul_output_rData_exp; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_muls_0 = mul_mul_output_rData_muls_0; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_muls_1 = mul_mul_output_rData_muls_1; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_muls_2 = mul_mul_output_rData_muls_2; // @[Stream.scala 371:21]
  assign mul_sum1_input_payload_muls_3 = mul_mul_output_rData_muls_3; // @[Stream.scala 371:21]
  assign mul_sum1_sum = (_zz_mul_sum1_sum + _zz_mul_sum1_sum_1); // @[BaseType.scala 299:24]
  assign mul_sum1_output_valid = mul_sum1_input_valid; // @[Stream.scala 303:16]
  assign mul_sum1_input_ready = mul_sum1_output_ready; // @[Stream.scala 304:16]
  assign mul_sum1_output_payload_rs1_mantissa = mul_sum1_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_rs1_exponent = mul_sum1_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_rs1_sign = mul_sum1_input_payload_rs1_sign; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_rs1_special = mul_sum1_input_payload_rs1_special; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_rs2_mantissa = mul_sum1_input_payload_rs2_mantissa; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_rs2_exponent = mul_sum1_input_payload_rs2_exponent; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_rs2_sign = mul_sum1_input_payload_rs2_sign; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_rs2_special = mul_sum1_input_payload_rs2_special; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_rs3_mantissa = mul_sum1_input_payload_rs3_mantissa; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_rs3_exponent = mul_sum1_input_payload_rs3_exponent; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_rs3_sign = mul_sum1_input_payload_rs3_sign; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_rs3_special = mul_sum1_input_payload_rs3_special; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_rd = mul_sum1_input_payload_rd; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_add = mul_sum1_input_payload_add; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_divSqrt = mul_sum1_input_payload_divSqrt; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_msb1 = mul_sum1_input_payload_msb1; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_msb2 = mul_sum1_input_payload_msb2; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_roundMode = mul_sum1_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_exp = mul_sum1_input_payload_exp; // @[Bundle.scala 141:37]
  assign mul_sum1_output_payload_mulC2 = mul_sum1_sum; // @[FpuCore.scala 946:20]
  assign mul_sum1_output_payload_muls2_0 = mul_sum1_input_payload_muls_2; // @[FpuCore.scala 947:20]
  assign mul_sum1_output_payload_muls2_1 = mul_sum1_input_payload_muls_3; // @[FpuCore.scala 947:20]
  always @(*) begin
    mul_sum1_output_ready = mul_sum2_input_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_9) begin
      mul_sum1_output_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_9 = (! mul_sum2_input_valid); // @[BaseType.scala 299:24]
  assign mul_sum2_input_valid = mul_sum1_output_rValid; // @[Stream.scala 370:19]
  assign mul_sum2_input_payload_rs1_mantissa = mul_sum1_output_rData_rs1_mantissa; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_rs1_exponent = mul_sum1_output_rData_rs1_exponent; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_rs1_sign = mul_sum1_output_rData_rs1_sign; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_rs1_special = mul_sum1_output_rData_rs1_special; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_rs2_mantissa = mul_sum1_output_rData_rs2_mantissa; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_rs2_exponent = mul_sum1_output_rData_rs2_exponent; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_rs2_sign = mul_sum1_output_rData_rs2_sign; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_rs2_special = mul_sum1_output_rData_rs2_special; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_rs3_mantissa = mul_sum1_output_rData_rs3_mantissa; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_rs3_exponent = mul_sum1_output_rData_rs3_exponent; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_rs3_sign = mul_sum1_output_rData_rs3_sign; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_rs3_special = mul_sum1_output_rData_rs3_special; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_rd = mul_sum1_output_rData_rd; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_add = mul_sum1_output_rData_add; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_divSqrt = mul_sum1_output_rData_divSqrt; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_msb1 = mul_sum1_output_rData_msb1; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_msb2 = mul_sum1_output_rData_msb2; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_roundMode = mul_sum1_output_rData_roundMode; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_exp = mul_sum1_output_rData_exp; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_muls2_0 = mul_sum1_output_rData_muls2_0; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_muls2_1 = mul_sum1_output_rData_muls2_1; // @[Stream.scala 371:21]
  assign mul_sum2_input_payload_mulC2 = mul_sum1_output_rData_mulC2; // @[Stream.scala 371:21]
  assign mul_sum2_sum = (mul_sum2_input_payload_mulC2 + _zz_mul_sum2_sum); // @[BaseType.scala 299:24]
  assign mul_sum2_input_fire = (mul_sum2_input_valid && mul_sum2_input_ready); // @[BaseType.scala 305:24]
  assign when_FpuCore_l221_1 = (mul_sum2_input_fire && 1'b1); // @[BaseType.scala 305:24]
  assign mul_sum2_isCommited = commitLogic_0_mul_notEmpty; // @[Vec.scala 169:11]
  assign _zz_mul_sum2_input_ready = (! (! mul_sum2_isCommited)); // @[BaseType.scala 299:24]
  assign mul_sum2_input_ready = (mul_sum2_output_ready && _zz_mul_sum2_input_ready); // @[Stream.scala 427:16]
  assign mul_sum2_output_valid = (mul_sum2_input_valid && _zz_mul_sum2_input_ready); // @[Stream.scala 303:16]
  assign mul_sum2_output_payload_rs1_mantissa = mul_sum2_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_rs1_exponent = mul_sum2_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_rs1_sign = mul_sum2_input_payload_rs1_sign; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_rs1_special = mul_sum2_input_payload_rs1_special; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_rs2_mantissa = mul_sum2_input_payload_rs2_mantissa; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_rs2_exponent = mul_sum2_input_payload_rs2_exponent; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_rs2_sign = mul_sum2_input_payload_rs2_sign; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_rs2_special = mul_sum2_input_payload_rs2_special; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_rs3_mantissa = mul_sum2_input_payload_rs3_mantissa; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_rs3_exponent = mul_sum2_input_payload_rs3_exponent; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_rs3_sign = mul_sum2_input_payload_rs3_sign; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_rs3_special = mul_sum2_input_payload_rs3_special; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_rd = mul_sum2_input_payload_rd; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_add = mul_sum2_input_payload_add; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_divSqrt = mul_sum2_input_payload_divSqrt; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_msb1 = mul_sum2_input_payload_msb1; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_msb2 = mul_sum2_input_payload_msb2; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_roundMode = mul_sum2_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_exp = mul_sum2_input_payload_exp; // @[Bundle.scala 141:37]
  assign mul_sum2_output_payload_mulC = mul_sum2_sum; // @[FpuCore.scala 957:19]
  always @(*) begin
    mul_sum2_output_ready = mul_norm_input_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_10) begin
      mul_sum2_output_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_10 = (! mul_norm_input_valid); // @[BaseType.scala 299:24]
  assign mul_norm_input_valid = mul_sum2_output_rValid; // @[Stream.scala 370:19]
  assign mul_norm_input_payload_rs1_mantissa = mul_sum2_output_rData_rs1_mantissa; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_rs1_exponent = mul_sum2_output_rData_rs1_exponent; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_rs1_sign = mul_sum2_output_rData_rs1_sign; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_rs1_special = mul_sum2_output_rData_rs1_special; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_rs2_mantissa = mul_sum2_output_rData_rs2_mantissa; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_rs2_exponent = mul_sum2_output_rData_rs2_exponent; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_rs2_sign = mul_sum2_output_rData_rs2_sign; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_rs2_special = mul_sum2_output_rData_rs2_special; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_rs3_mantissa = mul_sum2_output_rData_rs3_mantissa; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_rs3_exponent = mul_sum2_output_rData_rs3_exponent; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_rs3_sign = mul_sum2_output_rData_rs3_sign; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_rs3_special = mul_sum2_output_rData_rs3_special; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_rd = mul_sum2_output_rData_rd; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_add = mul_sum2_output_rData_add; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_divSqrt = mul_sum2_output_rData_divSqrt; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_msb1 = mul_sum2_output_rData_msb1; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_msb2 = mul_sum2_output_rData_msb2; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_roundMode = mul_sum2_output_rData_roundMode; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_exp = mul_sum2_output_rData_exp; // @[Stream.scala 371:21]
  assign mul_norm_input_payload_mulC = mul_sum2_output_rData_mulC; // @[Stream.scala 371:21]
  assign mul_norm_mulHigh = mul_norm_input_payload_mulC[47 : 22]; // @[BaseType.scala 318:22]
  assign mul_norm_mulLow = mul_norm_input_payload_mulC[21 : 0]; // @[BaseType.scala 318:22]
  always @(*) begin
    mul_norm_scrap = (mul_norm_mulLow != 22'h0); // @[BaseType.scala 305:24]
    if(when_FpuCore_l967) begin
      mul_norm_scrap = 1'b1; // @[FpuCore.scala 967:13]
    end
  end

  assign mul_norm_needShift = mul_norm_mulHigh[25]; // @[BaseType.scala 305:24]
  assign mul_norm_exp = (mul_norm_input_payload_exp + _zz_mul_norm_exp); // @[BaseType.scala 299:24]
  assign mul_norm_man = (mul_norm_needShift ? mul_norm_mulHigh[24 : 1] : mul_norm_mulHigh[23 : 0]); // @[Expression.scala 1420:25]
  assign when_FpuCore_l967 = (mul_norm_needShift && mul_norm_mulHigh[0]); // @[BaseType.scala 305:24]
  assign mul_norm_forceZero = ((mul_norm_input_payload_rs1_special && (mul_norm_input_payload_rs1_exponent[1 : 0] == 2'b00)) || (mul_norm_input_payload_rs2_special && (mul_norm_input_payload_rs2_exponent[1 : 0] == 2'b00))); // @[BaseType.scala 305:24]
  assign mul_norm_underflowThreshold = 9'h167; // @[Expression.scala 2342:18]
  assign mul_norm_underflowExp = 7'h67; // @[Expression.scala 2342:18]
  assign mul_norm_forceUnderflow = (mul_norm_exp < _zz_mul_norm_forceUnderflow); // @[BaseType.scala 305:24]
  assign mul_norm_forceOverflow = ((mul_norm_input_payload_rs1_special && (mul_norm_input_payload_rs1_exponent[1 : 0] == 2'b01)) || (mul_norm_input_payload_rs2_special && (mul_norm_input_payload_rs2_exponent[1 : 0] == 2'b01))); // @[BaseType.scala 305:24]
  assign mul_norm_infinitynan = (((mul_norm_input_payload_rs1_special && (mul_norm_input_payload_rs1_exponent[1 : 0] == 2'b01)) || (mul_norm_input_payload_rs2_special && (mul_norm_input_payload_rs2_exponent[1 : 0] == 2'b01))) && ((mul_norm_input_payload_rs1_special && (mul_norm_input_payload_rs1_exponent[1 : 0] == 2'b00)) || (mul_norm_input_payload_rs2_special && (mul_norm_input_payload_rs2_exponent[1 : 0] == 2'b00)))); // @[BaseType.scala 305:24]
  assign mul_norm_forceNan = (((mul_norm_input_payload_rs1_special && (mul_norm_input_payload_rs1_exponent[1 : 0] == 2'b10)) || (mul_norm_input_payload_rs2_special && (mul_norm_input_payload_rs2_exponent[1 : 0] == 2'b10))) || mul_norm_infinitynan); // @[BaseType.scala 305:24]
  assign mul_norm_output_sign = (mul_norm_input_payload_rs1_sign ^ mul_norm_input_payload_rs2_sign); // @[FpuCore.scala 977:19]
  always @(*) begin
    mul_norm_output_exponent = _zz_mul_norm_output_exponent[8:0]; // @[FpuCore.scala 978:23]
    if(when_FpuCore_l983) begin
      mul_norm_output_exponent[8 : 7] = 2'b11; // @[FpuCore.scala 983:98]
    end
    if(mul_norm_forceNan) begin
      mul_norm_output_exponent[1 : 0] = 2'b10; // @[Interface.scala 60:63]
      mul_norm_output_exponent[2] = 1'b1; // @[Interface.scala 60:117]
    end else begin
      if(mul_norm_forceOverflow) begin
        mul_norm_output_exponent[1 : 0] = 2'b01; // @[Interface.scala 58:63]
      end else begin
        if(mul_norm_forceZero) begin
          mul_norm_output_exponent[1 : 0] = 2'b00; // @[Interface.scala 57:63]
        end else begin
          if(mul_norm_forceUnderflow) begin
            mul_norm_output_exponent = {2'd0, mul_norm_underflowExp}; // @[FpuCore.scala 993:25]
          end
        end
      end
    end
  end

  always @(*) begin
    mul_norm_output_mantissa = mul_norm_man; // @[FpuCore.scala 979:23]
    if(mul_norm_forceNan) begin
      mul_norm_output_mantissa[23] = 1'b1; // @[Interface.scala 60:139]
    end
  end

  always @(*) begin
    mul_norm_output_special = 1'b0; // @[Interface.scala 56:33]
    if(mul_norm_forceNan) begin
      mul_norm_output_special = 1'b1; // @[Interface.scala 60:33]
    end else begin
      if(mul_norm_forceOverflow) begin
        mul_norm_output_special = 1'b1; // @[Interface.scala 58:33]
      end else begin
        if(mul_norm_forceZero) begin
          mul_norm_output_special = 1'b1; // @[Interface.scala 57:33]
        end
      end
    end
  end

  always @(*) begin
    mul_norm_NV = 1'b0; // @[FpuCore.scala 981:16]
    if(mul_norm_forceNan) begin
      if(when_FpuCore_l987) begin
        mul_norm_NV = 1'b1; // @[FpuCore.scala 987:12]
      end
    end
  end

  assign when_FpuCore_l983 = (3'b101 <= mul_norm_exp[9 : 7]); // @[BaseType.scala 305:24]
  assign when_FpuCore_l987 = ((mul_norm_infinitynan || ((mul_norm_input_payload_rs1_special && (mul_norm_input_payload_rs1_exponent[1 : 0] == 2'b10)) && (! mul_norm_input_payload_rs1_mantissa[22]))) || ((mul_norm_input_payload_rs2_special && (mul_norm_input_payload_rs2_exponent[1 : 0] == 2'b10)) && (! mul_norm_input_payload_rs2_mantissa[22]))); // @[BaseType.scala 305:24]
  assign mul_result_notMul_output_valid = (mul_norm_input_valid && mul_norm_input_payload_divSqrt); // @[FpuCore.scala 1003:22]
  assign mul_result_notMul_output_payload = mul_norm_input_payload_mulC[46 : 23]; // @[FpuCore.scala 1004:24]
  assign mul_result_output_valid = ((mul_norm_input_valid && (! mul_norm_input_payload_add)) && (! mul_norm_input_payload_divSqrt)); // @[FpuCore.scala 1008:20]
  assign mul_result_output_payload_rd = mul_norm_input_payload_rd; // @[FpuCore.scala 1010:17]
  assign mul_result_output_payload_roundMode = mul_norm_input_payload_roundMode; // @[FpuCore.scala 1012:24]
  assign mul_result_output_payload_scrap = mul_norm_scrap; // @[FpuCore.scala 1013:20]
  assign mul_result_output_payload_value_mantissa = mul_norm_output_mantissa; // @[FpuCore.scala 1014:20]
  assign mul_result_output_payload_value_exponent = mul_norm_output_exponent; // @[FpuCore.scala 1014:20]
  assign mul_result_output_payload_value_sign = mul_norm_output_sign; // @[FpuCore.scala 1014:20]
  assign mul_result_output_payload_value_special = mul_norm_output_special; // @[FpuCore.scala 1014:20]
  assign mul_result_output_payload_NV = mul_norm_NV; // @[FpuCore.scala 1015:17]
  assign mul_result_output_payload_DZ = 1'b0; // @[FpuCore.scala 1016:17]
  always @(*) begin
    mul_result_mulToAdd_ready = mul_result_mulToAdd_m2sPipe_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_11) begin
      mul_result_mulToAdd_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_11 = (! mul_result_mulToAdd_m2sPipe_valid); // @[BaseType.scala 299:24]
  assign mul_result_mulToAdd_m2sPipe_valid = mul_result_mulToAdd_rValid; // @[Stream.scala 370:19]
  assign mul_result_mulToAdd_m2sPipe_payload_rs1_mantissa = mul_result_mulToAdd_rData_rs1_mantissa; // @[Stream.scala 371:21]
  assign mul_result_mulToAdd_m2sPipe_payload_rs1_exponent = mul_result_mulToAdd_rData_rs1_exponent; // @[Stream.scala 371:21]
  assign mul_result_mulToAdd_m2sPipe_payload_rs1_sign = mul_result_mulToAdd_rData_rs1_sign; // @[Stream.scala 371:21]
  assign mul_result_mulToAdd_m2sPipe_payload_rs1_special = mul_result_mulToAdd_rData_rs1_special; // @[Stream.scala 371:21]
  assign mul_result_mulToAdd_m2sPipe_payload_rs2_mantissa = mul_result_mulToAdd_rData_rs2_mantissa; // @[Stream.scala 371:21]
  assign mul_result_mulToAdd_m2sPipe_payload_rs2_exponent = mul_result_mulToAdd_rData_rs2_exponent; // @[Stream.scala 371:21]
  assign mul_result_mulToAdd_m2sPipe_payload_rs2_sign = mul_result_mulToAdd_rData_rs2_sign; // @[Stream.scala 371:21]
  assign mul_result_mulToAdd_m2sPipe_payload_rs2_special = mul_result_mulToAdd_rData_rs2_special; // @[Stream.scala 371:21]
  assign mul_result_mulToAdd_m2sPipe_payload_rd = mul_result_mulToAdd_rData_rd; // @[Stream.scala 371:21]
  assign mul_result_mulToAdd_m2sPipe_payload_roundMode = mul_result_mulToAdd_rData_roundMode; // @[Stream.scala 371:21]
  assign mul_result_mulToAdd_m2sPipe_payload_needCommit = mul_result_mulToAdd_rData_needCommit; // @[Stream.scala 371:21]
  assign decode_mulToAdd_valid = mul_result_mulToAdd_m2sPipe_valid; // @[Stream.scala 294:16]
  assign mul_result_mulToAdd_m2sPipe_ready = decode_mulToAdd_ready; // @[Stream.scala 295:16]
  assign decode_mulToAdd_payload_rs1_mantissa = mul_result_mulToAdd_m2sPipe_payload_rs1_mantissa; // @[Stream.scala 296:18]
  assign decode_mulToAdd_payload_rs1_exponent = mul_result_mulToAdd_m2sPipe_payload_rs1_exponent; // @[Stream.scala 296:18]
  assign decode_mulToAdd_payload_rs1_sign = mul_result_mulToAdd_m2sPipe_payload_rs1_sign; // @[Stream.scala 296:18]
  assign decode_mulToAdd_payload_rs1_special = mul_result_mulToAdd_m2sPipe_payload_rs1_special; // @[Stream.scala 296:18]
  assign decode_mulToAdd_payload_rs2_mantissa = mul_result_mulToAdd_m2sPipe_payload_rs2_mantissa; // @[Stream.scala 296:18]
  assign decode_mulToAdd_payload_rs2_exponent = mul_result_mulToAdd_m2sPipe_payload_rs2_exponent; // @[Stream.scala 296:18]
  assign decode_mulToAdd_payload_rs2_sign = mul_result_mulToAdd_m2sPipe_payload_rs2_sign; // @[Stream.scala 296:18]
  assign decode_mulToAdd_payload_rs2_special = mul_result_mulToAdd_m2sPipe_payload_rs2_special; // @[Stream.scala 296:18]
  assign decode_mulToAdd_payload_rd = mul_result_mulToAdd_m2sPipe_payload_rd; // @[Stream.scala 296:18]
  assign decode_mulToAdd_payload_roundMode = mul_result_mulToAdd_m2sPipe_payload_roundMode; // @[Stream.scala 296:18]
  assign decode_mulToAdd_payload_needCommit = mul_result_mulToAdd_m2sPipe_payload_needCommit; // @[Stream.scala 296:18]
  assign mul_result_mulToAdd_valid = (mul_norm_input_valid && mul_norm_input_payload_add); // @[FpuCore.scala 1021:22]
  always @(*) begin
    mul_result_mulToAdd_payload_rs1_mantissa = {mul_norm_output_mantissa,mul_norm_scrap}; // @[FpuCore.scala 1023:29]
    if(mul_norm_NV) begin
      mul_result_mulToAdd_payload_rs1_mantissa[24] = 1'b0; // @[FpuCore.scala 1035:35]
    end
  end

  assign mul_result_mulToAdd_payload_rs1_exponent = mul_norm_output_exponent; // @[FpuCore.scala 1024:29]
  assign mul_result_mulToAdd_payload_rs1_sign = mul_norm_output_sign; // @[FpuCore.scala 1025:25]
  assign mul_result_mulToAdd_payload_rs1_special = mul_norm_output_special; // @[FpuCore.scala 1026:28]
  assign mul_result_mulToAdd_payload_rs2_exponent = mul_norm_input_payload_rs3_exponent; // @[FpuCore.scala 1027:20]
  assign mul_result_mulToAdd_payload_rs2_sign = mul_norm_input_payload_rs3_sign; // @[FpuCore.scala 1027:20]
  assign mul_result_mulToAdd_payload_rs2_special = mul_norm_input_payload_rs3_special; // @[FpuCore.scala 1027:20]
  assign mul_result_mulToAdd_payload_rs2_mantissa = ({2'd0,mul_norm_input_payload_rs3_mantissa} <<< 2); // @[FpuCore.scala 1028:49]
  assign mul_result_mulToAdd_payload_rd = mul_norm_input_payload_rd; // @[FpuCore.scala 1029:19]
  assign mul_result_mulToAdd_payload_roundMode = mul_norm_input_payload_roundMode; // @[FpuCore.scala 1030:26]
  assign mul_result_mulToAdd_payload_needCommit = 1'b0; // @[FpuCore.scala 1031:27]
  assign mul_norm_input_ready = ((mul_norm_input_payload_add ? mul_result_mulToAdd_ready : mul_result_output_ready) || mul_norm_input_payload_divSqrt); // @[FpuCore.scala 1038:19]
  assign div_input_fire = (div_input_valid && div_input_ready); // @[BaseType.scala 305:24]
  assign decode_div_ready = (! decode_div_rValid); // @[Stream.scala 414:16]
  assign div_input_valid = decode_div_rValid; // @[Stream.scala 416:20]
  assign div_input_payload_rs1_mantissa = decode_div_rData_rs1_mantissa; // @[Stream.scala 417:22]
  assign div_input_payload_rs1_exponent = decode_div_rData_rs1_exponent; // @[Stream.scala 417:22]
  assign div_input_payload_rs1_sign = decode_div_rData_rs1_sign; // @[Stream.scala 417:22]
  assign div_input_payload_rs1_special = decode_div_rData_rs1_special; // @[Stream.scala 417:22]
  assign div_input_payload_rs2_mantissa = decode_div_rData_rs2_mantissa; // @[Stream.scala 417:22]
  assign div_input_payload_rs2_exponent = decode_div_rData_rs2_exponent; // @[Stream.scala 417:22]
  assign div_input_payload_rs2_sign = decode_div_rData_rs2_sign; // @[Stream.scala 417:22]
  assign div_input_payload_rs2_special = decode_div_rData_rs2_special; // @[Stream.scala 417:22]
  assign div_input_payload_rd = decode_div_rData_rd; // @[Stream.scala 417:22]
  assign div_input_payload_roundMode = decode_div_rData_roundMode; // @[Stream.scala 417:22]
  always @(*) begin
    div_haltIt = 1'b1; // @[FpuCore.scala 1045:18]
    if(div_divider_io_output_valid) begin
      div_haltIt = 1'b0; // @[FpuCore.scala 1103:12]
    end
  end

  assign div_input_fire_1 = (div_input_valid && div_input_ready); // @[BaseType.scala 305:24]
  assign when_FpuCore_l221_2 = (div_input_fire_1 && 1'b1); // @[BaseType.scala 305:24]
  assign _zz_div_input_ready = (! (div_haltIt || (! div_isCommited))); // @[BaseType.scala 299:24]
  assign div_input_ready = (div_output_ready && _zz_div_input_ready); // @[Stream.scala 427:16]
  assign div_output_valid = (div_input_valid && _zz_div_input_ready); // @[Stream.scala 303:16]
  assign div_divider_io_input_payload_a = ({1'd0,div_input_payload_rs1_mantissa} <<< 1); // @[FpuCore.scala 1051:24]
  assign div_divider_io_input_payload_b = ({1'd0,div_input_payload_rs2_mantissa} <<< 1); // @[FpuCore.scala 1052:24]
  assign div_dividerResult = (div_divider_io_output_payload_result >>> 1); // @[BaseType.scala 299:24]
  assign div_dividerScrap = ((div_divider_io_output_payload_remain != 25'h0) || (div_divider_io_output_payload_result[0 : 0] != 1'b0)); // @[BaseType.scala 305:24]
  assign FpuPlugin_fpu_div_divider_io_input_fire = (div_divider_io_input_valid && div_divider_io_input_ready); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1056 = (! div_haltIt); // @[BaseType.scala 299:24]
  assign div_divider_io_input_valid = (div_input_valid && (! div_cmdSent)); // @[FpuCore.scala 1057:28]
  assign div_output_payload_rd = div_input_payload_rd; // @[Bundle.scala 141:37]
  assign div_output_payload_roundMode = div_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign div_needShift = (! div_dividerResult[25]); // @[BaseType.scala 299:24]
  assign div_mantissa = (div_needShift ? div_dividerResult[23 : 0] : div_dividerResult[24 : 1]); // @[Expression.scala 1420:25]
  assign div_scrap = (div_dividerScrap || ((! div_needShift) && div_dividerResult[0])); // @[BaseType.scala 305:24]
  assign div_exponent = (_zz_div_exponent - _zz_div_exponent_4); // @[BaseType.scala 299:24]
  always @(*) begin
    div_output_payload_value_special = 1'b0; // @[Interface.scala 56:33]
    if(div_forceNan) begin
      div_output_payload_value_special = 1'b1; // @[Interface.scala 60:33]
    end else begin
      if(div_forceOverflow) begin
        div_output_payload_value_special = 1'b1; // @[Interface.scala 58:33]
      end else begin
        if(div_forceZero) begin
          div_output_payload_value_special = 1'b1; // @[Interface.scala 57:33]
        end
      end
    end
  end

  assign div_output_payload_value_sign = (div_input_payload_rs1_sign ^ div_input_payload_rs2_sign); // @[FpuCore.scala 1068:23]
  always @(*) begin
    div_output_payload_value_exponent = div_exponent[8:0]; // @[FpuCore.scala 1069:27]
    if(when_FpuCore_l1072) begin
      div_output_payload_value_exponent[8 : 6] = 3'b111; // @[FpuCore.scala 1072:95]
    end
    if(when_FpuCore_l1089) begin
      div_output_payload_value_exponent[8 : 7] = 2'b11; // @[FpuCore.scala 1089:113]
    end
    if(div_forceNan) begin
      div_output_payload_value_exponent[1 : 0] = 2'b10; // @[Interface.scala 60:63]
      div_output_payload_value_exponent[2] = 1'b1; // @[Interface.scala 60:117]
    end else begin
      if(div_forceOverflow) begin
        div_output_payload_value_exponent[1 : 0] = 2'b01; // @[Interface.scala 58:63]
      end else begin
        if(div_forceZero) begin
          div_output_payload_value_exponent[1 : 0] = 2'b00; // @[Interface.scala 57:63]
        end else begin
          if(div_forceUnderflow) begin
            div_output_payload_value_exponent = div_underflowExp[8:0]; // @[FpuCore.scala 1099:29]
          end
        end
      end
    end
  end

  always @(*) begin
    div_output_payload_value_mantissa = div_mantissa; // @[FpuCore.scala 1070:27]
    if(div_forceNan) begin
      div_output_payload_value_mantissa[23] = 1'b1; // @[Interface.scala 60:139]
    end
  end

  assign div_output_payload_scrap = div_scrap; // @[FpuCore.scala 1071:18]
  assign when_FpuCore_l1072 = (div_exponent[10 : 9] == 2'b11); // @[BaseType.scala 305:24]
  assign div_underflowThreshold = 11'h468; // @[Expression.scala 2342:18]
  assign div_underflowExp = 11'h467; // @[Expression.scala 2342:18]
  assign div_forceUnderflow = (div_exponent < div_underflowThreshold); // @[BaseType.scala 305:24]
  assign div_forceOverflow = ((div_input_payload_rs1_special && (div_input_payload_rs1_exponent[1 : 0] == 2'b01)) || (div_input_payload_rs2_special && (div_input_payload_rs2_exponent[1 : 0] == 2'b00))); // @[BaseType.scala 305:24]
  assign div_infinitynan = (((div_input_payload_rs1_special && (div_input_payload_rs1_exponent[1 : 0] == 2'b00)) && (div_input_payload_rs2_special && (div_input_payload_rs2_exponent[1 : 0] == 2'b00))) || ((div_input_payload_rs1_special && (div_input_payload_rs1_exponent[1 : 0] == 2'b01)) && (div_input_payload_rs2_special && (div_input_payload_rs2_exponent[1 : 0] == 2'b01)))); // @[BaseType.scala 305:24]
  assign div_forceNan = (((div_input_payload_rs1_special && (div_input_payload_rs1_exponent[1 : 0] == 2'b10)) || (div_input_payload_rs2_special && (div_input_payload_rs2_exponent[1 : 0] == 2'b10))) || div_infinitynan); // @[BaseType.scala 305:24]
  assign div_forceZero = ((div_input_payload_rs1_special && (div_input_payload_rs1_exponent[1 : 0] == 2'b00)) || (div_input_payload_rs2_special && (div_input_payload_rs2_exponent[1 : 0] == 2'b01))); // @[BaseType.scala 305:24]
  always @(*) begin
    div_output_payload_NV = 1'b0; // @[FpuCore.scala 1086:15]
    if(div_forceNan) begin
      if(when_FpuCore_l1093) begin
        div_output_payload_NV = 1'b1; // @[FpuCore.scala 1093:17]
      end
    end
  end

  assign div_output_payload_DZ = (((! div_forceNan) && (! (div_input_payload_rs1_special && (div_input_payload_rs1_exponent[1 : 0] == 2'b01)))) && (div_input_payload_rs2_special && (div_input_payload_rs2_exponent[1 : 0] == 2'b00))); // @[FpuCore.scala 1087:15]
  assign when_FpuCore_l1089 = (div_exponent[10 : 8] == 3'b111); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1093 = ((div_infinitynan || ((div_input_payload_rs1_special && (div_input_payload_rs1_exponent[1 : 0] == 2'b10)) && (! div_input_payload_rs1_mantissa[22]))) || ((div_input_payload_rs2_special && (div_input_payload_rs2_exponent[1 : 0] == 2'b10)) && (! div_input_payload_rs2_mantissa[22]))); // @[BaseType.scala 305:24]
  assign sqrt_input_fire = (sqrt_input_valid && sqrt_input_ready); // @[BaseType.scala 305:24]
  assign decode_sqrt_ready = (! decode_sqrt_rValid); // @[Stream.scala 414:16]
  assign sqrt_input_valid = decode_sqrt_rValid; // @[Stream.scala 416:20]
  assign sqrt_input_payload_rs1_mantissa = decode_sqrt_rData_rs1_mantissa; // @[Stream.scala 417:22]
  assign sqrt_input_payload_rs1_exponent = decode_sqrt_rData_rs1_exponent; // @[Stream.scala 417:22]
  assign sqrt_input_payload_rs1_sign = decode_sqrt_rData_rs1_sign; // @[Stream.scala 417:22]
  assign sqrt_input_payload_rs1_special = decode_sqrt_rData_rs1_special; // @[Stream.scala 417:22]
  assign sqrt_input_payload_rd = decode_sqrt_rData_rd; // @[Stream.scala 417:22]
  assign sqrt_input_payload_roundMode = decode_sqrt_rData_roundMode; // @[Stream.scala 417:22]
  always @(*) begin
    sqrt_haltIt = 1'b1; // @[FpuCore.scala 1110:18]
    if(sqrt_sqrt_io_output_valid) begin
      sqrt_haltIt = 1'b0; // @[FpuCore.scala 1180:12]
    end
  end

  assign sqrt_input_fire_1 = (sqrt_input_valid && sqrt_input_ready); // @[BaseType.scala 305:24]
  assign when_FpuCore_l221_3 = (sqrt_input_fire_1 && 1'b1); // @[BaseType.scala 305:24]
  assign _zz_sqrt_input_ready = (! (sqrt_haltIt || (! sqrt_isCommited))); // @[BaseType.scala 299:24]
  assign sqrt_input_ready = (sqrt_output_ready && _zz_sqrt_input_ready); // @[Stream.scala 427:16]
  assign sqrt_output_valid = (sqrt_input_valid && _zz_sqrt_input_ready); // @[Stream.scala 303:16]
  assign sqrt_needShift = (! sqrt_input_payload_rs1_exponent[0]); // @[BaseType.scala 299:24]
  assign sqrt_sqrt_io_input_payload_a = (sqrt_needShift ? {{1'b1,sqrt_input_payload_rs1_mantissa},1'b0} : {2'b01,sqrt_input_payload_rs1_mantissa}); // @[FpuCore.scala 1116:21]
  assign FpuPlugin_fpu_sqrt_sqrt_io_input_fire = (sqrt_sqrt_io_input_valid && sqrt_sqrt_io_input_ready); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1118 = (! sqrt_haltIt); // @[BaseType.scala 299:24]
  assign sqrt_sqrt_io_input_valid = (sqrt_input_valid && (! sqrt_cmdSent)); // @[FpuCore.scala 1119:25]
  assign sqrt_output_payload_rd = sqrt_input_payload_rd; // @[Bundle.scala 141:37]
  assign sqrt_output_payload_roundMode = sqrt_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign sqrt_scrap = (sqrt_sqrt_io_output_payload_remain != 28'h0); // @[BaseType.scala 305:24]
  always @(*) begin
    sqrt_output_payload_value_special = 1'b0; // @[Interface.scala 56:33]
    if(when_FpuCore_l1137) begin
      sqrt_output_payload_value_special = 1'b1; // @[Interface.scala 58:33]
    end
    if(sqrt_negative) begin
      sqrt_output_payload_value_special = 1'b1; // @[Interface.scala 60:33]
    end
    if(when_FpuCore_l1144) begin
      sqrt_output_payload_value_special = 1'b1; // @[Interface.scala 60:33]
    end
    if(when_FpuCore_l1148) begin
      sqrt_output_payload_value_special = 1'b1; // @[Interface.scala 57:33]
    end
  end

  assign sqrt_output_payload_value_sign = sqrt_input_payload_rs1_sign; // @[FpuCore.scala 1128:23]
  always @(*) begin
    sqrt_output_payload_value_exponent = sqrt_exponent; // @[FpuCore.scala 1129:27]
    if(when_FpuCore_l1137) begin
      sqrt_output_payload_value_exponent[1 : 0] = 2'b01; // @[Interface.scala 58:63]
    end
    if(sqrt_negative) begin
      sqrt_output_payload_value_exponent[1 : 0] = 2'b10; // @[Interface.scala 60:63]
      sqrt_output_payload_value_exponent[2] = 1'b1; // @[Interface.scala 60:117]
    end
    if(when_FpuCore_l1144) begin
      sqrt_output_payload_value_exponent[1 : 0] = 2'b10; // @[Interface.scala 60:63]
      sqrt_output_payload_value_exponent[2] = 1'b1; // @[Interface.scala 60:117]
    end
    if(when_FpuCore_l1148) begin
      sqrt_output_payload_value_exponent[1 : 0] = 2'b00; // @[Interface.scala 57:63]
    end
  end

  always @(*) begin
    sqrt_output_payload_value_mantissa = sqrt_sqrt_io_output_payload_result; // @[FpuCore.scala 1130:27]
    if(sqrt_negative) begin
      sqrt_output_payload_value_mantissa[23] = 1'b1; // @[Interface.scala 60:139]
    end
    if(when_FpuCore_l1144) begin
      sqrt_output_payload_value_mantissa[23] = 1'b1; // @[Interface.scala 60:139]
    end
  end

  assign sqrt_output_payload_scrap = sqrt_scrap; // @[FpuCore.scala 1131:18]
  always @(*) begin
    sqrt_output_payload_NV = 1'b0; // @[FpuCore.scala 1132:15]
    if(sqrt_negative) begin
      sqrt_output_payload_NV = 1'b1; // @[FpuCore.scala 1142:17]
    end
    if(when_FpuCore_l1144) begin
      sqrt_output_payload_NV = (! sqrt_input_payload_rs1_mantissa[22]); // @[FpuCore.scala 1146:17]
    end
  end

  assign sqrt_output_payload_DZ = 1'b0; // @[FpuCore.scala 1133:15]
  assign sqrt_negative = (((! (sqrt_input_payload_rs1_special && (sqrt_input_payload_rs1_exponent[1 : 0] == 2'b10))) && (! (sqrt_input_payload_rs1_special && (sqrt_input_payload_rs1_exponent[1 : 0] == 2'b00)))) && sqrt_input_payload_rs1_sign); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1137 = (sqrt_input_payload_rs1_special && (sqrt_input_payload_rs1_exponent[1 : 0] == 2'b01)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1144 = (sqrt_input_payload_rs1_special && (sqrt_input_payload_rs1_exponent[1 : 0] == 2'b10)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1148 = (sqrt_input_payload_rs1_special && (sqrt_input_payload_rs1_exponent[1 : 0] == 2'b00)); // @[BaseType.scala 305:24]
  assign add_preShifter_input_valid = decode_add_valid; // @[Stream.scala 294:16]
  assign decode_add_ready = add_preShifter_input_ready; // @[Stream.scala 295:16]
  assign add_preShifter_input_payload_rs1_mantissa = decode_add_payload_rs1_mantissa; // @[Stream.scala 296:18]
  assign add_preShifter_input_payload_rs1_exponent = decode_add_payload_rs1_exponent; // @[Stream.scala 296:18]
  assign add_preShifter_input_payload_rs1_sign = decode_add_payload_rs1_sign; // @[Stream.scala 296:18]
  assign add_preShifter_input_payload_rs1_special = decode_add_payload_rs1_special; // @[Stream.scala 296:18]
  assign add_preShifter_input_payload_rs2_mantissa = decode_add_payload_rs2_mantissa; // @[Stream.scala 296:18]
  assign add_preShifter_input_payload_rs2_exponent = decode_add_payload_rs2_exponent; // @[Stream.scala 296:18]
  assign add_preShifter_input_payload_rs2_sign = decode_add_payload_rs2_sign; // @[Stream.scala 296:18]
  assign add_preShifter_input_payload_rs2_special = decode_add_payload_rs2_special; // @[Stream.scala 296:18]
  assign add_preShifter_input_payload_rd = decode_add_payload_rd; // @[Stream.scala 296:18]
  assign add_preShifter_input_payload_roundMode = decode_add_payload_roundMode; // @[Stream.scala 296:18]
  assign add_preShifter_input_payload_needCommit = decode_add_payload_needCommit; // @[Stream.scala 296:18]
  assign add_preShifter_output_valid = add_preShifter_input_valid; // @[Stream.scala 303:16]
  assign add_preShifter_input_ready = add_preShifter_output_ready; // @[Stream.scala 304:16]
  assign add_preShifter_exp21 = ({1'b0,add_preShifter_input_payload_rs2_exponent} - {1'b0,add_preShifter_input_payload_rs1_exponent}); // @[BaseType.scala 299:24]
  assign add_preShifter_rs1ExponentBigger = ((add_preShifter_exp21[9] || (add_preShifter_input_payload_rs2_special && (add_preShifter_input_payload_rs2_exponent[1 : 0] == 2'b00))) && (! (add_preShifter_input_payload_rs1_special && (add_preShifter_input_payload_rs1_exponent[1 : 0] == 2'b00)))); // @[BaseType.scala 305:24]
  assign add_preShifter_rs1ExponentEqual = (add_preShifter_input_payload_rs1_exponent == add_preShifter_input_payload_rs2_exponent); // @[BaseType.scala 305:24]
  assign add_preShifter_rs1MantissaBigger = (add_preShifter_input_payload_rs2_mantissa < add_preShifter_input_payload_rs1_mantissa); // @[BaseType.scala 305:24]
  assign add_preShifter_absRs1Bigger = ((((add_preShifter_rs1ExponentBigger || (add_preShifter_rs1ExponentEqual && add_preShifter_rs1MantissaBigger)) && (! (add_preShifter_input_payload_rs1_special && (add_preShifter_input_payload_rs1_exponent[1 : 0] == 2'b00)))) || (add_preShifter_input_payload_rs1_special && (add_preShifter_input_payload_rs1_exponent[1 : 0] == 2'b01))) && (! (add_preShifter_input_payload_rs2_special && (add_preShifter_input_payload_rs2_exponent[1 : 0] == 2'b01)))); // @[BaseType.scala 305:24]
  assign add_preShifter_output_payload_rs1_mantissa = add_preShifter_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
  assign add_preShifter_output_payload_rs1_exponent = add_preShifter_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
  assign add_preShifter_output_payload_rs1_sign = add_preShifter_input_payload_rs1_sign; // @[Bundle.scala 141:37]
  assign add_preShifter_output_payload_rs1_special = add_preShifter_input_payload_rs1_special; // @[Bundle.scala 141:37]
  assign add_preShifter_output_payload_rs2_mantissa = add_preShifter_input_payload_rs2_mantissa; // @[Bundle.scala 141:37]
  assign add_preShifter_output_payload_rs2_exponent = add_preShifter_input_payload_rs2_exponent; // @[Bundle.scala 141:37]
  assign add_preShifter_output_payload_rs2_sign = add_preShifter_input_payload_rs2_sign; // @[Bundle.scala 141:37]
  assign add_preShifter_output_payload_rs2_special = add_preShifter_input_payload_rs2_special; // @[Bundle.scala 141:37]
  assign add_preShifter_output_payload_rd = add_preShifter_input_payload_rd; // @[Bundle.scala 141:37]
  assign add_preShifter_output_payload_roundMode = add_preShifter_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign add_preShifter_output_payload_needCommit = add_preShifter_input_payload_needCommit; // @[Bundle.scala 141:37]
  assign add_preShifter_output_payload_absRs1Bigger = add_preShifter_absRs1Bigger; // @[FpuCore.scala 1385:27]
  assign add_preShifter_output_payload_rs1ExponentBigger = add_preShifter_rs1ExponentBigger; // @[FpuCore.scala 1386:32]
  always @(*) begin
    add_preShifter_output_ready = add_shifter_input_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_12) begin
      add_preShifter_output_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_12 = (! add_shifter_input_valid); // @[BaseType.scala 299:24]
  assign add_shifter_input_valid = add_preShifter_output_rValid; // @[Stream.scala 370:19]
  assign add_shifter_input_payload_rs1_mantissa = add_preShifter_output_rData_rs1_mantissa; // @[Stream.scala 371:21]
  assign add_shifter_input_payload_rs1_exponent = add_preShifter_output_rData_rs1_exponent; // @[Stream.scala 371:21]
  assign add_shifter_input_payload_rs1_sign = add_preShifter_output_rData_rs1_sign; // @[Stream.scala 371:21]
  assign add_shifter_input_payload_rs1_special = add_preShifter_output_rData_rs1_special; // @[Stream.scala 371:21]
  assign add_shifter_input_payload_rs2_mantissa = add_preShifter_output_rData_rs2_mantissa; // @[Stream.scala 371:21]
  assign add_shifter_input_payload_rs2_exponent = add_preShifter_output_rData_rs2_exponent; // @[Stream.scala 371:21]
  assign add_shifter_input_payload_rs2_sign = add_preShifter_output_rData_rs2_sign; // @[Stream.scala 371:21]
  assign add_shifter_input_payload_rs2_special = add_preShifter_output_rData_rs2_special; // @[Stream.scala 371:21]
  assign add_shifter_input_payload_rd = add_preShifter_output_rData_rd; // @[Stream.scala 371:21]
  assign add_shifter_input_payload_roundMode = add_preShifter_output_rData_roundMode; // @[Stream.scala 371:21]
  assign add_shifter_input_payload_needCommit = add_preShifter_output_rData_needCommit; // @[Stream.scala 371:21]
  assign add_shifter_input_payload_absRs1Bigger = add_preShifter_output_rData_absRs1Bigger; // @[Stream.scala 371:21]
  assign add_shifter_input_payload_rs1ExponentBigger = add_preShifter_output_rData_rs1ExponentBigger; // @[Stream.scala 371:21]
  assign add_shifter_output_valid = add_shifter_input_valid; // @[Stream.scala 303:16]
  assign add_shifter_input_ready = add_shifter_output_ready; // @[Stream.scala 304:16]
  assign add_shifter_output_payload_rs1_mantissa = add_shifter_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
  assign add_shifter_output_payload_rs1_exponent = add_shifter_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
  assign add_shifter_output_payload_rs1_sign = add_shifter_input_payload_rs1_sign; // @[Bundle.scala 141:37]
  assign add_shifter_output_payload_rs1_special = add_shifter_input_payload_rs1_special; // @[Bundle.scala 141:37]
  assign add_shifter_output_payload_rs2_mantissa = add_shifter_input_payload_rs2_mantissa; // @[Bundle.scala 141:37]
  assign add_shifter_output_payload_rs2_exponent = add_shifter_input_payload_rs2_exponent; // @[Bundle.scala 141:37]
  assign add_shifter_output_payload_rs2_sign = add_shifter_input_payload_rs2_sign; // @[Bundle.scala 141:37]
  assign add_shifter_output_payload_rs2_special = add_shifter_input_payload_rs2_special; // @[Bundle.scala 141:37]
  assign add_shifter_output_payload_rd = add_shifter_input_payload_rd; // @[Bundle.scala 141:37]
  assign add_shifter_output_payload_roundMode = add_shifter_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign add_shifter_output_payload_needCommit = add_shifter_input_payload_needCommit; // @[Bundle.scala 141:37]
  assign add_shifter_exp21 = ({1'b0,add_shifter_input_payload_rs2_exponent} - {1'b0,add_shifter_input_payload_rs1_exponent}); // @[BaseType.scala 299:24]
  assign _zz_add_shifter_shiftBy = add_shifter_exp21; // @[BaseType.scala 318:22]
  assign add_shifter_shiftBy = (_zz_add_shifter_shiftBy_1 + _zz_add_shifter_shiftBy_3); // @[BaseType.scala 299:24]
  assign add_shifter_shiftOverflow = (10'h01a <= add_shifter_shiftBy); // @[BaseType.scala 305:24]
  assign add_shifter_passThrough = ((add_shifter_shiftOverflow || (add_shifter_input_payload_rs1_special && (add_shifter_input_payload_rs1_exponent[1 : 0] == 2'b00))) || (add_shifter_input_payload_rs2_special && (add_shifter_input_payload_rs2_exponent[1 : 0] == 2'b00))); // @[BaseType.scala 305:24]
  assign add_shifter_xySign = (add_shifter_input_payload_absRs1Bigger ? add_shifter_input_payload_rs1_sign : add_shifter_input_payload_rs2_sign); // @[Expression.scala 1420:25]
  assign add_shifter_output_payload_xSign = (add_shifter_xySign ^ (add_shifter_input_payload_rs1ExponentBigger ? add_shifter_input_payload_rs1_sign : add_shifter_input_payload_rs2_sign)); // @[FpuCore.scala 1412:20]
  assign add_shifter_output_payload_ySign = (add_shifter_xySign ^ (add_shifter_input_payload_rs1ExponentBigger ? add_shifter_input_payload_rs2_sign : add_shifter_input_payload_rs1_sign)); // @[FpuCore.scala 1413:20]
  assign add_shifter_xMantissa = {1'b1,(add_shifter_input_payload_rs1ExponentBigger ? add_shifter_input_payload_rs1_mantissa : add_shifter_input_payload_rs2_mantissa)}; // @[BaseType.scala 318:22]
  assign add_shifter_yMantissaUnshifted = {1'b1,(add_shifter_input_payload_rs1ExponentBigger ? add_shifter_input_payload_rs2_mantissa : add_shifter_input_payload_rs1_mantissa)}; // @[BaseType.scala 318:22]
  assign add_shifter_yMantissa = add_shifter_yMantissaUnshifted; // @[Misc.scala 552:9]
  always @(*) begin
    add_shifter_roundingScrap = 1'b0; // @[FpuCore.scala 1417:27]
    if(when_FpuCore_l1419) begin
      add_shifter_roundingScrap = 1'b1; // @[FpuCore.scala 1419:23]
    end
    if(when_FpuCore_l1419_1) begin
      add_shifter_roundingScrap = 1'b1; // @[FpuCore.scala 1419:23]
    end
    if(when_FpuCore_l1419_2) begin
      add_shifter_roundingScrap = 1'b1; // @[FpuCore.scala 1419:23]
    end
    if(when_FpuCore_l1419_3) begin
      add_shifter_roundingScrap = 1'b1; // @[FpuCore.scala 1419:23]
    end
    if(when_FpuCore_l1419_4) begin
      add_shifter_roundingScrap = 1'b1; // @[FpuCore.scala 1419:23]
    end
    if(add_shifter_shiftOverflow) begin
      add_shifter_roundingScrap = 1'b1; // @[FpuCore.scala 1423:43]
    end
    if(when_FpuCore_l1424) begin
      add_shifter_roundingScrap = 1'b0; // @[FpuCore.scala 1424:67]
    end
  end

  assign when_FpuCore_l1419 = (add_shifter_shiftBy[4] && (add_shifter_yMantissa[15 : 0] != 16'h0)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1419_1 = (add_shifter_shiftBy[3] && (add_shifter_yMantissa_1[7 : 0] != 8'h0)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1419_2 = (add_shifter_shiftBy[2] && (add_shifter_yMantissa_2[3 : 0] != 4'b0000)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1419_3 = (add_shifter_shiftBy[1] && (add_shifter_yMantissa_3[1 : 0] != 2'b00)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1419_4 = (add_shifter_shiftBy[0] && (add_shifter_yMantissa_4[0 : 0] != 1'b0)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1424 = (add_shifter_input_payload_rs1_special || add_shifter_input_payload_rs2_special); // @[BaseType.scala 305:24]
  assign add_shifter_output_payload_xyExponent = (add_shifter_input_payload_rs1ExponentBigger ? add_shifter_input_payload_rs1_exponent : add_shifter_input_payload_rs2_exponent); // @[FpuCore.scala 1425:25]
  assign add_shifter_output_payload_xMantissa = add_shifter_xMantissa; // @[FpuCore.scala 1426:24]
  assign add_shifter_output_payload_yMantissa = add_shifter_yMantissa_5; // @[FpuCore.scala 1427:24]
  assign add_shifter_output_payload_xySign = add_shifter_xySign; // @[FpuCore.scala 1428:21]
  assign add_shifter_output_payload_roundingScrap = add_shifter_roundingScrap; // @[FpuCore.scala 1429:28]
  always @(*) begin
    add_shifter_output_ready = add_math_input_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_13) begin
      add_shifter_output_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_13 = (! add_math_input_valid); // @[BaseType.scala 299:24]
  assign add_math_input_valid = add_shifter_output_rValid; // @[Stream.scala 370:19]
  assign add_math_input_payload_rs1_mantissa = add_shifter_output_rData_rs1_mantissa; // @[Stream.scala 371:21]
  assign add_math_input_payload_rs1_exponent = add_shifter_output_rData_rs1_exponent; // @[Stream.scala 371:21]
  assign add_math_input_payload_rs1_sign = add_shifter_output_rData_rs1_sign; // @[Stream.scala 371:21]
  assign add_math_input_payload_rs1_special = add_shifter_output_rData_rs1_special; // @[Stream.scala 371:21]
  assign add_math_input_payload_rs2_mantissa = add_shifter_output_rData_rs2_mantissa; // @[Stream.scala 371:21]
  assign add_math_input_payload_rs2_exponent = add_shifter_output_rData_rs2_exponent; // @[Stream.scala 371:21]
  assign add_math_input_payload_rs2_sign = add_shifter_output_rData_rs2_sign; // @[Stream.scala 371:21]
  assign add_math_input_payload_rs2_special = add_shifter_output_rData_rs2_special; // @[Stream.scala 371:21]
  assign add_math_input_payload_rd = add_shifter_output_rData_rd; // @[Stream.scala 371:21]
  assign add_math_input_payload_roundMode = add_shifter_output_rData_roundMode; // @[Stream.scala 371:21]
  assign add_math_input_payload_needCommit = add_shifter_output_rData_needCommit; // @[Stream.scala 371:21]
  assign add_math_input_payload_xSign = add_shifter_output_rData_xSign; // @[Stream.scala 371:21]
  assign add_math_input_payload_ySign = add_shifter_output_rData_ySign; // @[Stream.scala 371:21]
  assign add_math_input_payload_xMantissa = add_shifter_output_rData_xMantissa; // @[Stream.scala 371:21]
  assign add_math_input_payload_yMantissa = add_shifter_output_rData_yMantissa; // @[Stream.scala 371:21]
  assign add_math_input_payload_xyExponent = add_shifter_output_rData_xyExponent; // @[Stream.scala 371:21]
  assign add_math_input_payload_xySign = add_shifter_output_rData_xySign; // @[Stream.scala 371:21]
  assign add_math_input_payload_roundingScrap = add_shifter_output_rData_roundingScrap; // @[Stream.scala 371:21]
  assign add_math_output_valid = add_math_input_valid; // @[Stream.scala 303:16]
  assign add_math_input_ready = add_math_output_ready; // @[Stream.scala 304:16]
  assign add_math_output_payload_rs1_mantissa = add_math_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
  assign add_math_output_payload_rs1_exponent = add_math_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
  assign add_math_output_payload_rs1_sign = add_math_input_payload_rs1_sign; // @[Bundle.scala 141:37]
  assign add_math_output_payload_rs1_special = add_math_input_payload_rs1_special; // @[Bundle.scala 141:37]
  assign add_math_output_payload_rs2_mantissa = add_math_input_payload_rs2_mantissa; // @[Bundle.scala 141:37]
  assign add_math_output_payload_rs2_exponent = add_math_input_payload_rs2_exponent; // @[Bundle.scala 141:37]
  assign add_math_output_payload_rs2_sign = add_math_input_payload_rs2_sign; // @[Bundle.scala 141:37]
  assign add_math_output_payload_rs2_special = add_math_input_payload_rs2_special; // @[Bundle.scala 141:37]
  assign add_math_output_payload_rd = add_math_input_payload_rd; // @[Bundle.scala 141:37]
  assign add_math_output_payload_roundMode = add_math_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign add_math_output_payload_needCommit = add_math_input_payload_needCommit; // @[Bundle.scala 141:37]
  assign add_math_output_payload_xSign = add_math_input_payload_xSign; // @[Bundle.scala 141:37]
  assign add_math_output_payload_ySign = add_math_input_payload_ySign; // @[Bundle.scala 141:37]
  assign add_math_output_payload_xMantissa = add_math_input_payload_xMantissa; // @[Bundle.scala 141:37]
  assign add_math_output_payload_yMantissa = add_math_input_payload_yMantissa; // @[Bundle.scala 141:37]
  assign add_math_output_payload_xyExponent = add_math_input_payload_xyExponent; // @[Bundle.scala 141:37]
  assign add_math_output_payload_xySign = add_math_input_payload_xySign; // @[Bundle.scala 141:37]
  assign add_math_output_payload_roundingScrap = add_math_input_payload_roundingScrap; // @[Bundle.scala 141:37]
  assign add_math_xSigned = _zz_add_math_xSigned; // @[BaseType.scala 318:22]
  assign add_math_ySigned = _zz_add_math_ySigned; // @[BaseType.scala 318:22]
  assign add_math_output_payload_xyMantissa = _zz_add_math_output_payload_xyMantissa[26 : 0]; // @[FpuCore.scala 1444:25]
  always @(*) begin
    add_math_output_ready = add_oh_input_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_14) begin
      add_math_output_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_14 = (! add_oh_input_valid); // @[BaseType.scala 299:24]
  assign add_oh_input_valid = add_math_output_rValid; // @[Stream.scala 370:19]
  assign add_oh_input_payload_rs1_mantissa = add_math_output_rData_rs1_mantissa; // @[Stream.scala 371:21]
  assign add_oh_input_payload_rs1_exponent = add_math_output_rData_rs1_exponent; // @[Stream.scala 371:21]
  assign add_oh_input_payload_rs1_sign = add_math_output_rData_rs1_sign; // @[Stream.scala 371:21]
  assign add_oh_input_payload_rs1_special = add_math_output_rData_rs1_special; // @[Stream.scala 371:21]
  assign add_oh_input_payload_rs2_mantissa = add_math_output_rData_rs2_mantissa; // @[Stream.scala 371:21]
  assign add_oh_input_payload_rs2_exponent = add_math_output_rData_rs2_exponent; // @[Stream.scala 371:21]
  assign add_oh_input_payload_rs2_sign = add_math_output_rData_rs2_sign; // @[Stream.scala 371:21]
  assign add_oh_input_payload_rs2_special = add_math_output_rData_rs2_special; // @[Stream.scala 371:21]
  assign add_oh_input_payload_rd = add_math_output_rData_rd; // @[Stream.scala 371:21]
  assign add_oh_input_payload_roundMode = add_math_output_rData_roundMode; // @[Stream.scala 371:21]
  assign add_oh_input_payload_needCommit = add_math_output_rData_needCommit; // @[Stream.scala 371:21]
  assign add_oh_input_payload_xSign = add_math_output_rData_xSign; // @[Stream.scala 371:21]
  assign add_oh_input_payload_ySign = add_math_output_rData_ySign; // @[Stream.scala 371:21]
  assign add_oh_input_payload_xMantissa = add_math_output_rData_xMantissa; // @[Stream.scala 371:21]
  assign add_oh_input_payload_yMantissa = add_math_output_rData_yMantissa; // @[Stream.scala 371:21]
  assign add_oh_input_payload_xyExponent = add_math_output_rData_xyExponent; // @[Stream.scala 371:21]
  assign add_oh_input_payload_xySign = add_math_output_rData_xySign; // @[Stream.scala 371:21]
  assign add_oh_input_payload_roundingScrap = add_math_output_rData_roundingScrap; // @[Stream.scala 371:21]
  assign add_oh_input_payload_xyMantissa = add_math_output_rData_xyMantissa; // @[Stream.scala 371:21]
  assign add_oh_input_fire = (add_oh_input_valid && add_oh_input_ready); // @[BaseType.scala 305:24]
  assign when_FpuCore_l221_4 = ((add_oh_input_fire && add_oh_input_payload_needCommit) && 1'b1); // @[BaseType.scala 305:24]
  assign add_oh_isCommited = commitLogic_0_add_notEmpty; // @[Vec.scala 169:11]
  assign _zz_add_oh_input_ready = (! (add_oh_input_payload_needCommit && (! add_oh_isCommited))); // @[BaseType.scala 299:24]
  assign add_oh_input_ready = (add_oh_output_ready && _zz_add_oh_input_ready); // @[Stream.scala 427:16]
  assign add_oh_output_valid = (add_oh_input_valid && _zz_add_oh_input_ready); // @[Stream.scala 303:16]
  assign add_oh_output_payload_rs1_mantissa = add_oh_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_rs1_exponent = add_oh_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_rs1_sign = add_oh_input_payload_rs1_sign; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_rs1_special = add_oh_input_payload_rs1_special; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_rs2_mantissa = add_oh_input_payload_rs2_mantissa; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_rs2_exponent = add_oh_input_payload_rs2_exponent; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_rs2_sign = add_oh_input_payload_rs2_sign; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_rs2_special = add_oh_input_payload_rs2_special; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_rd = add_oh_input_payload_rd; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_roundMode = add_oh_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_needCommit = add_oh_input_payload_needCommit; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_xSign = add_oh_input_payload_xSign; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_ySign = add_oh_input_payload_ySign; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_xMantissa = add_oh_input_payload_xMantissa; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_yMantissa = add_oh_input_payload_yMantissa; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_xyExponent = add_oh_input_payload_xyExponent; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_xySign = add_oh_input_payload_xySign; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_roundingScrap = add_oh_input_payload_roundingScrap; // @[Bundle.scala 141:37]
  assign add_oh_output_payload_xyMantissa = add_oh_input_payload_xyMantissa; // @[Bundle.scala 141:37]
  assign _zz_add_oh_shift = {add_oh_output_payload_xyMantissa[0],{add_oh_output_payload_xyMantissa[1],{add_oh_output_payload_xyMantissa[2],{add_oh_output_payload_xyMantissa[3],{add_oh_output_payload_xyMantissa[4],{add_oh_output_payload_xyMantissa[5],{add_oh_output_payload_xyMantissa[6],{add_oh_output_payload_xyMantissa[7],{add_oh_output_payload_xyMantissa[8],{_zz__zz_add_oh_shift,{_zz__zz_add_oh_shift_1,_zz__zz_add_oh_shift_2}}}}}}}}}}}; // @[BaseType.scala 318:22]
  assign _zz_add_oh_shift_1 = (_zz_add_oh_shift & (~ _zz__zz_add_oh_shift_1_1)); // @[Bits.scala 133:56]
  assign _zz_add_oh_shift_2 = _zz_add_oh_shift_1[3]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_3 = _zz_add_oh_shift_1[5]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_4 = _zz_add_oh_shift_1[6]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_5 = _zz_add_oh_shift_1[7]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_6 = _zz_add_oh_shift_1[9]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_7 = _zz_add_oh_shift_1[10]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_8 = _zz_add_oh_shift_1[11]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_9 = _zz_add_oh_shift_1[12]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_10 = _zz_add_oh_shift_1[13]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_11 = _zz_add_oh_shift_1[14]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_12 = _zz_add_oh_shift_1[15]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_13 = _zz_add_oh_shift_1[17]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_14 = _zz_add_oh_shift_1[18]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_15 = _zz_add_oh_shift_1[19]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_16 = _zz_add_oh_shift_1[20]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_17 = _zz_add_oh_shift_1[21]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_18 = _zz_add_oh_shift_1[22]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_19 = _zz_add_oh_shift_1[23]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_20 = _zz_add_oh_shift_1[24]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_21 = _zz_add_oh_shift_1[25]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_22 = _zz_add_oh_shift_1[26]; // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_23 = ((((((((((((_zz_add_oh_shift_1[1] || _zz_add_oh_shift_2) || _zz_add_oh_shift_3) || _zz_add_oh_shift_5) || _zz_add_oh_shift_6) || _zz_add_oh_shift_8) || _zz_add_oh_shift_10) || _zz_add_oh_shift_12) || _zz_add_oh_shift_13) || _zz_add_oh_shift_15) || _zz_add_oh_shift_17) || _zz_add_oh_shift_19) || _zz_add_oh_shift_21); // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_24 = ((((((((((((_zz_add_oh_shift_1[2] || _zz_add_oh_shift_2) || _zz_add_oh_shift_4) || _zz_add_oh_shift_5) || _zz_add_oh_shift_7) || _zz_add_oh_shift_8) || _zz_add_oh_shift_11) || _zz_add_oh_shift_12) || _zz_add_oh_shift_14) || _zz_add_oh_shift_15) || _zz_add_oh_shift_18) || _zz_add_oh_shift_19) || _zz_add_oh_shift_22); // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_25 = (((((((((((_zz_add_oh_shift_1[4] || _zz_add_oh_shift_3) || _zz_add_oh_shift_4) || _zz_add_oh_shift_5) || _zz_add_oh_shift_9) || _zz_add_oh_shift_10) || _zz_add_oh_shift_11) || _zz_add_oh_shift_12) || _zz_add_oh_shift_16) || _zz_add_oh_shift_17) || _zz_add_oh_shift_18) || _zz_add_oh_shift_19); // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_26 = ((((((((((_zz_add_oh_shift_1[8] || _zz_add_oh_shift_6) || _zz_add_oh_shift_7) || _zz_add_oh_shift_8) || _zz_add_oh_shift_9) || _zz_add_oh_shift_10) || _zz_add_oh_shift_11) || _zz_add_oh_shift_12) || _zz_add_oh_shift_20) || _zz_add_oh_shift_21) || _zz_add_oh_shift_22); // @[BaseType.scala 305:24]
  assign _zz_add_oh_shift_27 = ((((((((((_zz_add_oh_shift_1[16] || _zz_add_oh_shift_13) || _zz_add_oh_shift_14) || _zz_add_oh_shift_15) || _zz_add_oh_shift_16) || _zz_add_oh_shift_17) || _zz_add_oh_shift_18) || _zz_add_oh_shift_19) || _zz_add_oh_shift_20) || _zz_add_oh_shift_21) || _zz_add_oh_shift_22); // @[BaseType.scala 305:24]
  assign add_oh_shift = {_zz_add_oh_shift_27,{_zz_add_oh_shift_26,{_zz_add_oh_shift_25,{_zz_add_oh_shift_24,_zz_add_oh_shift_23}}}}; // @[BaseType.scala 318:22]
  assign add_oh_output_payload_shift = add_oh_shift; // @[FpuCore.scala 1463:20]
  always @(*) begin
    add_oh_output_ready = add_norm_input_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_15) begin
      add_oh_output_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_15 = (! add_norm_input_valid); // @[BaseType.scala 299:24]
  assign add_norm_input_valid = add_oh_output_rValid; // @[Stream.scala 370:19]
  assign add_norm_input_payload_rs1_mantissa = add_oh_output_rData_rs1_mantissa; // @[Stream.scala 371:21]
  assign add_norm_input_payload_rs1_exponent = add_oh_output_rData_rs1_exponent; // @[Stream.scala 371:21]
  assign add_norm_input_payload_rs1_sign = add_oh_output_rData_rs1_sign; // @[Stream.scala 371:21]
  assign add_norm_input_payload_rs1_special = add_oh_output_rData_rs1_special; // @[Stream.scala 371:21]
  assign add_norm_input_payload_rs2_mantissa = add_oh_output_rData_rs2_mantissa; // @[Stream.scala 371:21]
  assign add_norm_input_payload_rs2_exponent = add_oh_output_rData_rs2_exponent; // @[Stream.scala 371:21]
  assign add_norm_input_payload_rs2_sign = add_oh_output_rData_rs2_sign; // @[Stream.scala 371:21]
  assign add_norm_input_payload_rs2_special = add_oh_output_rData_rs2_special; // @[Stream.scala 371:21]
  assign add_norm_input_payload_rd = add_oh_output_rData_rd; // @[Stream.scala 371:21]
  assign add_norm_input_payload_roundMode = add_oh_output_rData_roundMode; // @[Stream.scala 371:21]
  assign add_norm_input_payload_needCommit = add_oh_output_rData_needCommit; // @[Stream.scala 371:21]
  assign add_norm_input_payload_xSign = add_oh_output_rData_xSign; // @[Stream.scala 371:21]
  assign add_norm_input_payload_ySign = add_oh_output_rData_ySign; // @[Stream.scala 371:21]
  assign add_norm_input_payload_xMantissa = add_oh_output_rData_xMantissa; // @[Stream.scala 371:21]
  assign add_norm_input_payload_yMantissa = add_oh_output_rData_yMantissa; // @[Stream.scala 371:21]
  assign add_norm_input_payload_xyExponent = add_oh_output_rData_xyExponent; // @[Stream.scala 371:21]
  assign add_norm_input_payload_xySign = add_oh_output_rData_xySign; // @[Stream.scala 371:21]
  assign add_norm_input_payload_roundingScrap = add_oh_output_rData_roundingScrap; // @[Stream.scala 371:21]
  assign add_norm_input_payload_xyMantissa = add_oh_output_rData_xyMantissa; // @[Stream.scala 371:21]
  assign add_norm_input_payload_shift = add_oh_output_rData_shift; // @[Stream.scala 371:21]
  assign add_norm_output_valid = add_norm_input_valid; // @[Stream.scala 303:16]
  assign add_norm_input_ready = add_norm_output_ready; // @[Stream.scala 304:16]
  assign add_norm_output_payload_rs1_mantissa = add_norm_input_payload_rs1_mantissa; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_rs1_exponent = add_norm_input_payload_rs1_exponent; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_rs1_sign = add_norm_input_payload_rs1_sign; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_rs1_special = add_norm_input_payload_rs1_special; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_rs2_mantissa = add_norm_input_payload_rs2_mantissa; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_rs2_exponent = add_norm_input_payload_rs2_exponent; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_rs2_sign = add_norm_input_payload_rs2_sign; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_rs2_special = add_norm_input_payload_rs2_special; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_rd = add_norm_input_payload_rd; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_roundMode = add_norm_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_needCommit = add_norm_input_payload_needCommit; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_xySign = add_norm_input_payload_xySign; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_roundingScrap = add_norm_input_payload_roundingScrap; // @[Bundle.scala 141:37]
  assign add_norm_output_payload_mantissa = (add_norm_input_payload_xyMantissa <<< add_norm_input_payload_shift); // @[FpuCore.scala 1481:23]
  assign add_norm_output_payload_exponent = (_zz_add_norm_output_payload_exponent + 10'h001); // @[FpuCore.scala 1482:23]
  assign add_norm_output_payload_forceInfinity = ((add_norm_input_payload_rs1_special && (add_norm_input_payload_rs1_exponent[1 : 0] == 2'b01)) || (add_norm_input_payload_rs2_special && (add_norm_input_payload_rs2_exponent[1 : 0] == 2'b01))); // @[FpuCore.scala 1483:28]
  assign add_norm_output_payload_forceZero = ((add_norm_input_payload_xyMantissa == 27'h0) || ((add_norm_input_payload_rs1_special && (add_norm_input_payload_rs1_exponent[1 : 0] == 2'b00)) && (add_norm_input_payload_rs2_special && (add_norm_input_payload_rs2_exponent[1 : 0] == 2'b00)))); // @[FpuCore.scala 1484:24]
  assign add_norm_output_payload_infinityNan = (((add_norm_input_payload_rs1_special && (add_norm_input_payload_rs1_exponent[1 : 0] == 2'b01)) && (add_norm_input_payload_rs2_special && (add_norm_input_payload_rs2_exponent[1 : 0] == 2'b01))) && (add_norm_input_payload_rs1_sign ^ add_norm_input_payload_rs2_sign)); // @[FpuCore.scala 1485:26]
  assign add_norm_output_payload_forceNan = (((add_norm_input_payload_rs1_special && (add_norm_input_payload_rs1_exponent[1 : 0] == 2'b10)) || (add_norm_input_payload_rs2_special && (add_norm_input_payload_rs2_exponent[1 : 0] == 2'b10))) || add_norm_output_payload_infinityNan); // @[FpuCore.scala 1486:23]
  assign add_norm_output_payload_xyMantissaZero = (add_norm_input_payload_xyMantissa == 27'h0); // @[FpuCore.scala 1487:29]
  assign add_result_input_valid = add_norm_output_valid; // @[Stream.scala 294:16]
  assign add_norm_output_ready = add_result_input_ready; // @[Stream.scala 295:16]
  assign add_result_input_payload_rs1_mantissa = add_norm_output_payload_rs1_mantissa; // @[Stream.scala 296:18]
  assign add_result_input_payload_rs1_exponent = add_norm_output_payload_rs1_exponent; // @[Stream.scala 296:18]
  assign add_result_input_payload_rs1_sign = add_norm_output_payload_rs1_sign; // @[Stream.scala 296:18]
  assign add_result_input_payload_rs1_special = add_norm_output_payload_rs1_special; // @[Stream.scala 296:18]
  assign add_result_input_payload_rs2_mantissa = add_norm_output_payload_rs2_mantissa; // @[Stream.scala 296:18]
  assign add_result_input_payload_rs2_exponent = add_norm_output_payload_rs2_exponent; // @[Stream.scala 296:18]
  assign add_result_input_payload_rs2_sign = add_norm_output_payload_rs2_sign; // @[Stream.scala 296:18]
  assign add_result_input_payload_rs2_special = add_norm_output_payload_rs2_special; // @[Stream.scala 296:18]
  assign add_result_input_payload_rd = add_norm_output_payload_rd; // @[Stream.scala 296:18]
  assign add_result_input_payload_roundMode = add_norm_output_payload_roundMode; // @[Stream.scala 296:18]
  assign add_result_input_payload_needCommit = add_norm_output_payload_needCommit; // @[Stream.scala 296:18]
  assign add_result_input_payload_mantissa = add_norm_output_payload_mantissa; // @[Stream.scala 296:18]
  assign add_result_input_payload_exponent = add_norm_output_payload_exponent; // @[Stream.scala 296:18]
  assign add_result_input_payload_infinityNan = add_norm_output_payload_infinityNan; // @[Stream.scala 296:18]
  assign add_result_input_payload_forceNan = add_norm_output_payload_forceNan; // @[Stream.scala 296:18]
  assign add_result_input_payload_forceZero = add_norm_output_payload_forceZero; // @[Stream.scala 296:18]
  assign add_result_input_payload_forceInfinity = add_norm_output_payload_forceInfinity; // @[Stream.scala 296:18]
  assign add_result_input_payload_xySign = add_norm_output_payload_xySign; // @[Stream.scala 296:18]
  assign add_result_input_payload_roundingScrap = add_norm_output_payload_roundingScrap; // @[Stream.scala 296:18]
  assign add_result_input_payload_xyMantissaZero = add_norm_output_payload_xyMantissaZero; // @[Stream.scala 296:18]
  assign add_result_output_valid = add_result_input_valid; // @[Stream.scala 303:16]
  assign add_result_input_ready = add_result_output_ready; // @[Stream.scala 304:16]
  assign add_result_output_payload_rd = add_result_input_payload_rd; // @[FpuCore.scala 1496:17]
  always @(*) begin
    add_result_output_payload_value_sign = add_result_input_payload_xySign; // @[FpuCore.scala 1497:25]
    if(!add_result_input_payload_forceNan) begin
      if(!add_result_input_payload_forceInfinity) begin
        if(add_result_input_payload_forceZero) begin
          if(when_FpuCore_l1513) begin
            add_result_output_payload_value_sign = (add_result_input_payload_rs1_sign && add_result_input_payload_rs2_sign); // @[FpuCore.scala 1514:29]
          end
          if(when_FpuCore_l1516) begin
            add_result_output_payload_value_sign = 1'b1; // @[FpuCore.scala 1517:29]
          end
        end
      end
    end
  end

  always @(*) begin
    add_result_output_payload_value_mantissa = _zz_add_result_output_payload_value_mantissa[23:0]; // @[FpuCore.scala 1498:29]
    if(add_result_input_payload_forceNan) begin
      add_result_output_payload_value_mantissa[23] = 1'b1; // @[Interface.scala 60:139]
    end
  end

  always @(*) begin
    add_result_output_payload_value_exponent = add_result_input_payload_exponent[8:0]; // @[FpuCore.scala 1499:29]
    if(add_result_input_payload_forceNan) begin
      add_result_output_payload_value_exponent[1 : 0] = 2'b10; // @[Interface.scala 60:63]
      add_result_output_payload_value_exponent[2] = 1'b1; // @[Interface.scala 60:117]
    end else begin
      if(add_result_input_payload_forceInfinity) begin
        add_result_output_payload_value_exponent[1 : 0] = 2'b01; // @[Interface.scala 58:63]
      end else begin
        if(add_result_input_payload_forceZero) begin
          add_result_output_payload_value_exponent[1 : 0] = 2'b00; // @[Interface.scala 57:63]
        end
      end
    end
  end

  always @(*) begin
    add_result_output_payload_value_special = 1'b0; // @[FpuCore.scala 1500:28]
    if(add_result_input_payload_forceNan) begin
      add_result_output_payload_value_special = 1'b1; // @[Interface.scala 60:33]
    end else begin
      if(add_result_input_payload_forceInfinity) begin
        add_result_output_payload_value_special = 1'b1; // @[Interface.scala 58:33]
      end else begin
        if(add_result_input_payload_forceZero) begin
          add_result_output_payload_value_special = 1'b1; // @[Interface.scala 57:33]
        end
      end
    end
  end

  assign add_result_output_payload_roundMode = add_result_input_payload_roundMode; // @[FpuCore.scala 1501:24]
  assign add_result_output_payload_scrap = ((add_result_input_payload_mantissa[1] || add_result_input_payload_mantissa[0]) || add_result_input_payload_roundingScrap); // @[FpuCore.scala 1503:20]
  assign add_result_output_payload_NV = ((add_result_input_payload_infinityNan || ((add_result_input_payload_rs1_special && (add_result_input_payload_rs1_exponent[1 : 0] == 2'b10)) && (! add_result_input_payload_rs1_mantissa[24]))) || ((add_result_input_payload_rs2_special && (add_result_input_payload_rs2_exponent[1 : 0] == 2'b10)) && (! add_result_input_payload_rs2_mantissa[24]))); // @[FpuCore.scala 1505:17]
  assign add_result_output_payload_DZ = 1'b0; // @[FpuCore.scala 1506:17]
  assign when_FpuCore_l1513 = (add_result_input_payload_xyMantissaZero || ((add_result_input_payload_rs1_special && (add_result_input_payload_rs1_exponent[1 : 0] == 2'b00)) && (add_result_input_payload_rs2_special && (add_result_input_payload_rs2_exponent[1 : 0] == 2'b00)))); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1516 = ((add_result_input_payload_rs1_sign || add_result_input_payload_rs2_sign) && (add_result_input_payload_roundMode == FpuRoundMode_RDN)); // @[BaseType.scala 305:24]
  always @(*) begin
    load_s1_output_ready = load_s1_output_m2sPipe_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_16) begin
      load_s1_output_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_16 = (! load_s1_output_m2sPipe_valid); // @[BaseType.scala 299:24]
  assign load_s1_output_m2sPipe_valid = load_s1_output_rValid; // @[Stream.scala 370:19]
  assign load_s1_output_m2sPipe_payload_rd = load_s1_output_rData_rd; // @[Stream.scala 371:21]
  assign load_s1_output_m2sPipe_payload_value_mantissa = load_s1_output_rData_value_mantissa; // @[Stream.scala 371:21]
  assign load_s1_output_m2sPipe_payload_value_exponent = load_s1_output_rData_value_exponent; // @[Stream.scala 371:21]
  assign load_s1_output_m2sPipe_payload_value_sign = load_s1_output_rData_value_sign; // @[Stream.scala 371:21]
  assign load_s1_output_m2sPipe_payload_value_special = load_s1_output_rData_value_special; // @[Stream.scala 371:21]
  assign load_s1_output_m2sPipe_payload_scrap = load_s1_output_rData_scrap; // @[Stream.scala 371:21]
  assign load_s1_output_m2sPipe_payload_roundMode = load_s1_output_rData_roundMode; // @[Stream.scala 371:21]
  assign load_s1_output_m2sPipe_payload_NV = load_s1_output_rData_NV; // @[Stream.scala 371:21]
  assign load_s1_output_m2sPipe_payload_DZ = load_s1_output_rData_DZ; // @[Stream.scala 371:21]
  always @(*) begin
    shortPip_output_ready = shortPip_output_m2sPipe_ready; // @[Stream.scala 367:16]
    if(when_Stream_l368_17) begin
      shortPip_output_ready = 1'b1; // @[Stream.scala 368:35]
    end
  end

  assign when_Stream_l368_17 = (! shortPip_output_m2sPipe_valid); // @[BaseType.scala 299:24]
  assign shortPip_output_m2sPipe_valid = shortPip_output_rValid; // @[Stream.scala 370:19]
  assign shortPip_output_m2sPipe_payload_rd = shortPip_output_rData_rd; // @[Stream.scala 371:21]
  assign shortPip_output_m2sPipe_payload_value_mantissa = shortPip_output_rData_value_mantissa; // @[Stream.scala 371:21]
  assign shortPip_output_m2sPipe_payload_value_exponent = shortPip_output_rData_value_exponent; // @[Stream.scala 371:21]
  assign shortPip_output_m2sPipe_payload_value_sign = shortPip_output_rData_value_sign; // @[Stream.scala 371:21]
  assign shortPip_output_m2sPipe_payload_value_special = shortPip_output_rData_value_special; // @[Stream.scala 371:21]
  assign shortPip_output_m2sPipe_payload_scrap = shortPip_output_rData_scrap; // @[Stream.scala 371:21]
  assign shortPip_output_m2sPipe_payload_roundMode = shortPip_output_rData_roundMode; // @[Stream.scala 371:21]
  assign shortPip_output_m2sPipe_payload_NV = shortPip_output_rData_NV; // @[Stream.scala 371:21]
  assign shortPip_output_m2sPipe_payload_DZ = shortPip_output_rData_DZ; // @[Stream.scala 371:21]
  assign load_s1_output_m2sPipe_ready = streamArbiter_2_io_inputs_0_ready; // @[Stream.scala 295:16]
  assign sqrt_output_ready = streamArbiter_2_io_inputs_1_ready; // @[Stream.scala 295:16]
  assign div_output_ready = streamArbiter_2_io_inputs_2_ready; // @[Stream.scala 295:16]
  assign add_result_output_ready = streamArbiter_2_io_inputs_3_ready; // @[Stream.scala 295:16]
  assign mul_result_output_ready = streamArbiter_2_io_inputs_4_ready; // @[Stream.scala 295:16]
  assign shortPip_output_m2sPipe_ready = streamArbiter_2_io_inputs_5_ready; // @[Stream.scala 295:16]
  assign merge_arbitrated_valid = streamArbiter_2_io_output_valid; // @[Stream.scala 78:15]
  assign merge_arbitrated_payload_rd = streamArbiter_2_io_output_payload_rd; // @[Stream.scala 79:17]
  assign merge_arbitrated_payload_value_mantissa = streamArbiter_2_io_output_payload_value_mantissa; // @[Stream.scala 79:17]
  assign merge_arbitrated_payload_value_exponent = streamArbiter_2_io_output_payload_value_exponent; // @[Stream.scala 79:17]
  assign merge_arbitrated_payload_value_sign = streamArbiter_2_io_output_payload_value_sign; // @[Stream.scala 79:17]
  assign merge_arbitrated_payload_value_special = streamArbiter_2_io_output_payload_value_special; // @[Stream.scala 79:17]
  assign merge_arbitrated_payload_scrap = streamArbiter_2_io_output_payload_scrap; // @[Stream.scala 79:17]
  assign merge_arbitrated_payload_roundMode = streamArbiter_2_io_output_payload_roundMode; // @[Stream.scala 79:17]
  assign merge_arbitrated_payload_NV = streamArbiter_2_io_output_payload_NV; // @[Stream.scala 79:17]
  assign merge_arbitrated_payload_DZ = streamArbiter_2_io_output_payload_DZ; // @[Stream.scala 79:17]
  assign roundFront_output_valid = roundFront_input_valid; // @[Flow.scala 64:16]
  assign roundFront_output_payload_rd = roundFront_input_payload_rd; // @[Bundle.scala 141:37]
  assign roundFront_output_payload_value_mantissa = roundFront_input_payload_value_mantissa; // @[Bundle.scala 141:37]
  assign roundFront_output_payload_value_exponent = roundFront_input_payload_value_exponent; // @[Bundle.scala 141:37]
  assign roundFront_output_payload_value_sign = roundFront_input_payload_value_sign; // @[Bundle.scala 141:37]
  assign roundFront_output_payload_value_special = roundFront_input_payload_value_special; // @[Bundle.scala 141:37]
  assign roundFront_output_payload_scrap = roundFront_input_payload_scrap; // @[Bundle.scala 141:37]
  assign roundFront_output_payload_roundMode = roundFront_input_payload_roundMode; // @[Bundle.scala 141:37]
  assign roundFront_output_payload_NV = roundFront_input_payload_NV; // @[Bundle.scala 141:37]
  assign roundFront_output_payload_DZ = roundFront_input_payload_DZ; // @[Bundle.scala 141:37]
  assign roundFront_manAggregate = {roundFront_input_payload_value_mantissa,roundFront_input_payload_scrap}; // @[BaseType.scala 318:22]
  assign roundFront_expBase = 8'h81; // @[Expression.scala 2342:18]
  assign roundFront_expDif = (_zz_roundFront_expDif - {1'b0,roundFront_input_payload_value_exponent}); // @[BaseType.scala 299:24]
  assign roundFront_expSubnormal = (! roundFront_expDif[9]); // @[BaseType.scala 299:24]
  assign roundFront_discardCount = (roundFront_expSubnormal ? _zz_roundFront_discardCount : 5'h0); // @[Expression.scala 1420:25]
  assign roundFront_exactMask = {(5'h17 < roundFront_discardCount),{(5'h16 < roundFront_discardCount),{(5'h15 < roundFront_discardCount),{(5'h14 < roundFront_discardCount),{(_zz_roundFront_exactMask < roundFront_discardCount),{_zz_roundFront_exactMask_1,{_zz_roundFront_exactMask_2,_zz_roundFront_exactMask_3}}}}}}}; // @[BaseType.scala 318:22]
  assign roundFront_roundAdjusted = {_zz_roundFront_roundAdjusted[roundFront_discardCount],((roundFront_manAggregate & roundFront_exactMask) != 25'h0)}; // @[BaseType.scala 299:24]
  always @(*) begin
    case(roundFront_input_payload_roundMode)
      FpuRoundMode_RNE : begin
        _zz_roundFront_mantissaIncrement = (roundFront_roundAdjusted[1] && (roundFront_roundAdjusted[0] || _zz__zz_roundFront_mantissaIncrement[roundFront_discardCount])); // @[Misc.scala 239:22]
      end
      FpuRoundMode_RTZ : begin
        _zz_roundFront_mantissaIncrement = 1'b0; // @[Misc.scala 239:22]
      end
      FpuRoundMode_RDN : begin
        _zz_roundFront_mantissaIncrement = ((roundFront_roundAdjusted != 2'b00) && roundFront_input_payload_value_sign); // @[Misc.scala 239:22]
      end
      FpuRoundMode_RUP : begin
        _zz_roundFront_mantissaIncrement = ((roundFront_roundAdjusted != 2'b00) && (! roundFront_input_payload_value_sign)); // @[Misc.scala 239:22]
      end
      default : begin
        _zz_roundFront_mantissaIncrement = roundFront_roundAdjusted[1]; // @[Misc.scala 239:22]
      end
    endcase
  end

  assign roundFront_mantissaIncrement = ((! roundFront_input_payload_value_special) && _zz_roundFront_mantissaIncrement); // @[BaseType.scala 305:24]
  assign roundFront_output_payload_mantissaIncrement = roundFront_mantissaIncrement; // @[FpuCore.scala 1565:30]
  assign roundFront_output_payload_roundAdjusted = roundFront_roundAdjusted; // @[FpuCore.scala 1566:26]
  assign roundFront_output_payload_exactMask = roundFront_exactMask; // @[FpuCore.scala 1567:22]
  assign roundBack_output_valid = roundBack_input_valid; // @[Flow.scala 64:16]
  assign roundBack_adderMantissa = (roundBack_input_payload_value_mantissa[23 : 1] & (roundBack_input_payload_mantissaIncrement ? (~ _zz_roundBack_adderMantissa) : 23'h7fffff)); // @[BaseType.scala 299:24]
  assign roundBack_adderRightOp = _zz_roundBack_adderRightOp[22:0]; // @[BaseType.scala 299:24]
  assign _zz_roundBack_adder = {roundBack_input_payload_value_exponent,roundBack_adderMantissa}; // @[BaseType.scala 318:22]
  assign _zz_roundBack_adder_1 = roundBack_input_payload_mantissaIncrement; // @[BaseType.scala 318:22]
  assign roundBack_adder = (_zz_roundBack_adder_2 + _zz_roundBack_adder_4); // @[BaseType.scala 299:24]
  assign roundBack_math_special = roundBack_input_payload_value_special; // @[FpuCore.scala 1580:18]
  assign roundBack_math_sign = roundBack_input_payload_value_sign; // @[FpuCore.scala 1581:15]
  assign roundBack_math_exponent = roundBack_adder[31 : 23]; // @[FpuCore.scala 1582:19]
  assign roundBack_math_mantissa = roundBack_adder[22 : 0]; // @[FpuCore.scala 1583:19]
  always @(*) begin
    roundBack_patched_mantissa = roundBack_math_mantissa; // @[Misc.scala 552:9]
    if(when_FpuCore_l1611) begin
      if(when_FpuCore_l1621) begin
        roundBack_patched_mantissa = 23'h7fffff; // @[UInt.scala 462:10]
      end
    end
    if(when_FpuCore_l1630) begin
      if(when_FpuCore_l1640) begin
        roundBack_patched_mantissa = 23'h0; // @[FpuCore.scala 1642:26]
      end
    end
  end

  always @(*) begin
    roundBack_patched_exponent = roundBack_math_exponent; // @[Misc.scala 552:9]
    if(when_FpuCore_l1611) begin
      if(when_FpuCore_l1621) begin
        roundBack_patched_exponent = roundBack_ofThreshold; // @[FpuCore.scala 1622:26]
      end else begin
        roundBack_patched_exponent[1 : 0] = 2'b01; // @[Interface.scala 58:63]
      end
    end
    if(when_FpuCore_l1630) begin
      if(when_FpuCore_l1640) begin
        roundBack_patched_exponent = {2'd0, roundBack_ufThreshold}; // @[FpuCore.scala 1641:26]
      end else begin
        roundBack_patched_exponent[1 : 0] = 2'b00; // @[Interface.scala 57:63]
      end
    end
  end

  assign roundBack_patched_sign = roundBack_math_sign; // @[Misc.scala 552:9]
  always @(*) begin
    roundBack_patched_special = roundBack_math_special; // @[Misc.scala 552:9]
    if(when_FpuCore_l1611) begin
      if(!when_FpuCore_l1621) begin
        roundBack_patched_special = 1'b1; // @[Interface.scala 58:33]
      end
    end
    if(when_FpuCore_l1630) begin
      if(!when_FpuCore_l1640) begin
        roundBack_patched_special = 1'b1; // @[Interface.scala 57:33]
      end
    end
  end

  always @(*) begin
    roundBack_nx = 1'b0; // @[FpuCore.scala 1586:20]
    if(when_FpuCore_l1611) begin
      roundBack_nx = 1'b1; // @[FpuCore.scala 1612:10]
    end
    if(when_FpuCore_l1630) begin
      roundBack_nx = 1'b1; // @[FpuCore.scala 1631:10]
    end
    if(when_FpuCore_l1649) begin
      roundBack_nx = 1'b1; // @[FpuCore.scala 1649:8]
    end
  end

  always @(*) begin
    roundBack_of = 1'b0; // @[FpuCore.scala 1586:20]
    if(when_FpuCore_l1611) begin
      roundBack_of = 1'b1; // @[FpuCore.scala 1613:10]
    end
  end

  always @(*) begin
    roundBack_uf = 1'b0; // @[FpuCore.scala 1586:20]
    if(when_FpuCore_l1608) begin
      roundBack_uf = 1'b1; // @[FpuCore.scala 1609:10]
    end
    if(when_FpuCore_l1630) begin
      roundBack_uf = 1'b1; // @[FpuCore.scala 1632:10]
    end
  end

  assign roundBack_ufSubnormalThreshold = 8'h80; // @[Expression.scala 2342:18]
  assign roundBack_ufThreshold = 7'h6a; // @[Expression.scala 2342:18]
  assign roundBack_ofThreshold = 9'h17e; // @[Expression.scala 2342:18]
  always @(*) begin
    case(roundBack_input_payload_roundMode)
      FpuRoundMode_RNE : begin
        roundBack_threshold = 3'b110; // @[Misc.scala 239:22]
      end
      FpuRoundMode_RTZ : begin
        roundBack_threshold = 3'b110; // @[Misc.scala 239:22]
      end
      FpuRoundMode_RDN : begin
        roundBack_threshold = (roundBack_input_payload_value_sign ? 3'b101 : 3'b111); // @[Misc.scala 239:22]
      end
      FpuRoundMode_RUP : begin
        roundBack_threshold = (roundBack_input_payload_value_sign ? 3'b111 : 3'b101); // @[Misc.scala 239:22]
      end
      default : begin
        roundBack_threshold = 3'b110; // @[Misc.scala 239:22]
      end
    endcase
  end

  assign roundBack_borringRound = {roundBack_input_payload_value_mantissa[1 : 0],roundBack_input_payload_scrap}; // @[BaseType.scala 299:24]
  assign roundBack_borringCase = ((roundBack_input_payload_value_exponent == _zz_roundBack_borringCase) && (roundBack_borringRound < roundBack_threshold)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1608 = (((! roundBack_math_special) && ((roundBack_math_exponent <= _zz_when_FpuCore_l1608) || roundBack_borringCase)) && (roundBack_input_payload_roundAdjusted != 2'b00)); // @[BaseType.scala 305:24]
  assign when_FpuCore_l1611 = ((! roundBack_math_special) && (roundBack_ofThreshold < roundBack_math_exponent)); // @[BaseType.scala 305:24]
  always @(*) begin
    case(roundBack_input_payload_roundMode)
      FpuRoundMode_RNE : begin
        when_FpuCore_l1621 = 1'b0; // @[Misc.scala 239:22]
      end
      FpuRoundMode_RTZ : begin
        when_FpuCore_l1621 = 1'b1; // @[Misc.scala 239:22]
      end
      FpuRoundMode_RDN : begin
        when_FpuCore_l1621 = (! roundBack_math_sign); // @[Misc.scala 239:22]
      end
      FpuRoundMode_RUP : begin
        when_FpuCore_l1621 = roundBack_math_sign; // @[Misc.scala 239:22]
      end
      default : begin
        when_FpuCore_l1621 = 1'b0; // @[Misc.scala 239:22]
      end
    endcase
  end

  assign when_FpuCore_l1630 = ((! roundBack_math_special) && (roundBack_math_exponent < _zz_when_FpuCore_l1630)); // @[BaseType.scala 305:24]
  always @(*) begin
    case(roundBack_input_payload_roundMode)
      FpuRoundMode_RNE : begin
        when_FpuCore_l1640 = 1'b0; // @[Misc.scala 239:22]
      end
      FpuRoundMode_RTZ : begin
        when_FpuCore_l1640 = 1'b0; // @[Misc.scala 239:22]
      end
      FpuRoundMode_RDN : begin
        when_FpuCore_l1640 = roundBack_math_sign; // @[Misc.scala 239:22]
      end
      FpuRoundMode_RUP : begin
        when_FpuCore_l1640 = (! roundBack_math_sign); // @[Misc.scala 239:22]
      end
      default : begin
        when_FpuCore_l1640 = 1'b0; // @[Misc.scala 239:22]
      end
    endcase
  end

  assign when_FpuCore_l1649 = ((! roundBack_input_payload_value_special) && (roundBack_input_payload_roundAdjusted != 2'b00)); // @[BaseType.scala 305:24]
  assign roundBack_writes_0 = _zz_rf_scoreboards_0_writes_port1[0]; // @[Bool.scala 189:10]
  assign roundBack_write = roundBack_writes_0; // @[Vec.scala 169:11]
  assign roundBack_output_payload_NX = (roundBack_nx && roundBack_write); // @[FpuCore.scala 1652:15]
  assign roundBack_output_payload_OF = (roundBack_of && roundBack_write); // @[FpuCore.scala 1653:15]
  assign roundBack_output_payload_UF = (roundBack_uf && roundBack_write); // @[FpuCore.scala 1654:15]
  assign roundBack_output_payload_NV = (roundBack_input_payload_NV && roundBack_write); // @[FpuCore.scala 1655:15]
  assign roundBack_output_payload_DZ = (roundBack_input_payload_DZ && roundBack_write); // @[FpuCore.scala 1656:15]
  assign roundBack_output_payload_rd = roundBack_input_payload_rd; // @[FpuCore.scala 1658:15]
  assign roundBack_output_payload_write = roundBack_write; // @[FpuCore.scala 1659:18]
  assign roundBack_output_payload_value_mantissa = roundBack_patched_mantissa; // @[FpuCore.scala 1661:18]
  assign roundBack_output_payload_value_exponent = roundBack_patched_exponent; // @[FpuCore.scala 1661:18]
  assign roundBack_output_payload_value_sign = roundBack_patched_sign; // @[FpuCore.scala 1661:18]
  assign roundBack_output_payload_value_special = roundBack_patched_special; // @[FpuCore.scala 1661:18]
  assign io_port_0_completion_valid = (writeback_input_valid && 1'b1); // @[FpuCore.scala 1669:15]
  assign io_port_0_completion_payload_flags_NX = writeback_input_payload_NX; // @[FpuCore.scala 1670:18]
  assign io_port_0_completion_payload_flags_OF = writeback_input_payload_OF; // @[FpuCore.scala 1671:18]
  assign io_port_0_completion_payload_flags_UF = writeback_input_payload_UF; // @[FpuCore.scala 1672:18]
  assign io_port_0_completion_payload_flags_NV = writeback_input_payload_NV; // @[FpuCore.scala 1673:18]
  assign io_port_0_completion_payload_flags_DZ = writeback_input_payload_DZ; // @[FpuCore.scala 1674:18]
  assign io_port_0_completion_payload_written = writeback_input_payload_write; // @[FpuCore.scala 1675:17]
  assign when_FpuCore_l1681 = 1'b1; // @[BaseType.scala 305:24]
  assign writeback_port_valid = (writeback_input_valid && writeback_input_payload_write); // @[FpuCore.scala 1688:16]
  assign writeback_port_payload_address = writeback_input_payload_rd; // @[FpuCore.scala 1689:18]
  assign writeback_port_payload_data_value_mantissa = writeback_input_payload_value_mantissa; // @[FpuCore.scala 1690:21]
  assign writeback_port_payload_data_value_exponent = writeback_input_payload_value_exponent; // @[FpuCore.scala 1690:21]
  assign writeback_port_payload_data_value_sign = writeback_input_payload_value_sign; // @[FpuCore.scala 1690:21]
  assign writeback_port_payload_data_value_special = writeback_input_payload_value_special; // @[FpuCore.scala 1690:21]
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      rf_init_counter <= 6'h0; // @[Data.scala 400:33]
      FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid <= 1'b0; // @[Data.scala 400:33]
      commitLogic_0_pending_counter <= 4'b0000; // @[Data.scala 400:33]
      commitLogic_0_add_counter <= 4'b0000; // @[Data.scala 400:33]
      commitLogic_0_mul_counter <= 4'b0000; // @[Data.scala 400:33]
      commitLogic_0_div_counter <= 4'b0000; // @[Data.scala 400:33]
      commitLogic_0_sqrt_counter <= 4'b0000; // @[Data.scala 400:33]
      commitLogic_0_short_counter <= 4'b0000; // @[Data.scala 400:33]
      io_port_0_cmd_rValid <= 1'b0; // @[Data.scala 400:33]
      read_s0_rValid <= 1'b0; // @[Data.scala 400:33]
      decode_load_rValid <= 1'b0; // @[Data.scala 400:33]
      decode_load_s2mPipe_rValid <= 1'b0; // @[Data.scala 400:33]
      decode_load_s2mPipe_m2sPipe_rValid <= 1'b0; // @[Data.scala 400:33]
      load_s0_output_rValid <= 1'b0; // @[Data.scala 400:33]
      decode_shortPip_rValid <= 1'b0; // @[Data.scala 400:33]
      shortPip_rspStreams_0_rValid <= 1'b0; // @[Data.scala 400:33]
      decode_mul_rValid <= 1'b0; // @[Data.scala 400:33]
      mul_preMul_output_rValid <= 1'b0; // @[Data.scala 400:33]
      mul_mul_output_rValid <= 1'b0; // @[Data.scala 400:33]
      mul_sum1_output_rValid <= 1'b0; // @[Data.scala 400:33]
      mul_sum2_output_rValid <= 1'b0; // @[Data.scala 400:33]
      mul_result_mulToAdd_rValid <= 1'b0; // @[Data.scala 400:33]
      decode_div_rValid <= 1'b0; // @[Data.scala 400:33]
      div_cmdSent <= 1'b0; // @[Data.scala 400:33]
      decode_sqrt_rValid <= 1'b0; // @[Data.scala 400:33]
      sqrt_cmdSent <= 1'b0; // @[Data.scala 400:33]
      add_preShifter_output_rValid <= 1'b0; // @[Data.scala 400:33]
      add_shifter_output_rValid <= 1'b0; // @[Data.scala 400:33]
      add_math_output_rValid <= 1'b0; // @[Data.scala 400:33]
      add_oh_output_rValid <= 1'b0; // @[Data.scala 400:33]
      load_s1_output_rValid <= 1'b0; // @[Data.scala 400:33]
      shortPip_output_rValid <= 1'b0; // @[Data.scala 400:33]
      roundFront_input_valid <= 1'b0; // @[Data.scala 400:33]
      roundBack_input_valid <= 1'b0; // @[Data.scala 400:33]
      writeback_input_valid <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(when_FpuCore_l163) begin
        rf_init_counter <= (rf_init_counter + 6'h01); // @[FpuCore.scala 164:17]
      end
      if(streamFork_1_io_outputs_1_valid) begin
        FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid <= 1'b1; // @[Stream.scala 377:33]
      end
      if(FpuPlugin_fpu_streamFork_1_io_outputs_1_s2mPipe_ready) begin
        FpuPlugin_fpu_streamFork_1_io_outputs_1_rValid <= 1'b0; // @[Stream.scala 377:53]
      end
      commitLogic_0_pending_counter <= (_zz_commitLogic_0_pending_counter - _zz_commitLogic_0_pending_counter_3); // @[FpuCore.scala 199:13]
      commitLogic_0_add_counter <= (_zz_commitLogic_0_add_counter - _zz_commitLogic_0_add_counter_3); // @[FpuCore.scala 199:13]
      commitLogic_0_mul_counter <= (_zz_commitLogic_0_mul_counter - _zz_commitLogic_0_mul_counter_3); // @[FpuCore.scala 199:13]
      commitLogic_0_div_counter <= (_zz_commitLogic_0_div_counter - _zz_commitLogic_0_div_counter_3); // @[FpuCore.scala 199:13]
      commitLogic_0_sqrt_counter <= (_zz_commitLogic_0_sqrt_counter - _zz_commitLogic_0_sqrt_counter_3); // @[FpuCore.scala 199:13]
      commitLogic_0_short_counter <= (_zz_commitLogic_0_short_counter - _zz_commitLogic_0_short_counter_3); // @[FpuCore.scala 199:13]
      if(io_port_0_cmd_valid) begin
        io_port_0_cmd_rValid <= 1'b1; // @[Stream.scala 377:33]
      end
      if(scheduler_0_input_ready) begin
        io_port_0_cmd_rValid <= 1'b0; // @[Stream.scala 377:53]
      end
      if(read_s0_ready) begin
        read_s0_rValid <= read_s0_valid; // @[Stream.scala 361:29]
      end
      if(decode_load_valid) begin
        decode_load_rValid <= 1'b1; // @[Stream.scala 377:33]
      end
      if(decode_load_s2mPipe_ready) begin
        decode_load_rValid <= 1'b0; // @[Stream.scala 377:53]
      end
      if(decode_load_s2mPipe_ready) begin
        decode_load_s2mPipe_rValid <= decode_load_s2mPipe_valid; // @[Stream.scala 361:29]
      end
      if(decode_load_s2mPipe_m2sPipe_ready) begin
        decode_load_s2mPipe_m2sPipe_rValid <= decode_load_s2mPipe_m2sPipe_valid; // @[Stream.scala 361:29]
      end
      if(load_s0_output_ready) begin
        load_s0_output_rValid <= load_s0_output_valid; // @[Stream.scala 361:29]
      end
      if(decode_shortPip_ready) begin
        decode_shortPip_rValid <= decode_shortPip_valid; // @[Stream.scala 361:29]
      end
      if(shortPip_rspStreams_0_ready) begin
        shortPip_rspStreams_0_rValid <= shortPip_rspStreams_0_valid; // @[Stream.scala 361:29]
      end
      if(decode_mul_ready) begin
        decode_mul_rValid <= decode_mul_valid; // @[Stream.scala 361:29]
      end
      if(mul_preMul_output_ready) begin
        mul_preMul_output_rValid <= mul_preMul_output_valid; // @[Stream.scala 361:29]
      end
      if(mul_mul_output_ready) begin
        mul_mul_output_rValid <= mul_mul_output_valid; // @[Stream.scala 361:29]
      end
      if(mul_sum1_output_ready) begin
        mul_sum1_output_rValid <= mul_sum1_output_valid; // @[Stream.scala 361:29]
      end
      if(mul_sum2_output_ready) begin
        mul_sum2_output_rValid <= mul_sum2_output_valid; // @[Stream.scala 361:29]
      end
      if(mul_result_mulToAdd_ready) begin
        mul_result_mulToAdd_rValid <= mul_result_mulToAdd_valid; // @[Stream.scala 361:29]
      end
      if(decode_div_valid) begin
        decode_div_rValid <= 1'b1; // @[Stream.scala 411:33]
      end
      if(div_input_fire) begin
        decode_div_rValid <= 1'b0; // @[Stream.scala 411:53]
      end
      if(FpuPlugin_fpu_div_divider_io_input_fire) begin
        div_cmdSent <= 1'b1; // @[FpuCore.scala 1056:34]
      end
      if(when_FpuCore_l1056) begin
        div_cmdSent <= 1'b0; // @[FpuCore.scala 1056:65]
      end
      if(decode_sqrt_valid) begin
        decode_sqrt_rValid <= 1'b1; // @[Stream.scala 411:33]
      end
      if(sqrt_input_fire) begin
        decode_sqrt_rValid <= 1'b0; // @[Stream.scala 411:53]
      end
      if(FpuPlugin_fpu_sqrt_sqrt_io_input_fire) begin
        sqrt_cmdSent <= 1'b1; // @[FpuCore.scala 1118:34]
      end
      if(when_FpuCore_l1118) begin
        sqrt_cmdSent <= 1'b0; // @[FpuCore.scala 1118:62]
      end
      if(add_preShifter_output_ready) begin
        add_preShifter_output_rValid <= add_preShifter_output_valid; // @[Stream.scala 361:29]
      end
      if(add_shifter_output_ready) begin
        add_shifter_output_rValid <= add_shifter_output_valid; // @[Stream.scala 361:29]
      end
      if(add_math_output_ready) begin
        add_math_output_rValid <= add_math_output_valid; // @[Stream.scala 361:29]
      end
      if(add_oh_output_ready) begin
        add_oh_output_rValid <= add_oh_output_valid; // @[Stream.scala 361:29]
      end
      if(load_s1_output_ready) begin
        load_s1_output_rValid <= load_s1_output_valid; // @[Stream.scala 361:29]
      end
      if(shortPip_output_ready) begin
        shortPip_output_rValid <= shortPip_output_valid; // @[Stream.scala 361:29]
      end
      roundFront_input_valid <= merge_arbitrated_valid; // @[Reg.scala 39:30]
      roundBack_input_valid <= roundFront_output_valid; // @[Reg.scala 39:30]
      writeback_input_valid <= roundBack_output_valid; // @[Reg.scala 39:30]
      if(writeback_port_valid) begin
        `ifndef SYNTHESIS
          `ifdef FORMAL
            assert((! ((writeback_port_payload_data_value_exponent == 9'h0) && (! writeback_port_payload_data_value_special)))); // FpuCore.scala:L1705
          `else
            if(!(! ((writeback_port_payload_data_value_exponent == 9'h0) && (! writeback_port_payload_data_value_special)))) begin
              $display("FAILURE Special violation"); // FpuCore.scala:L1705
              $finish;
            end
          `endif
        `endif
        `ifndef SYNTHESIS
          `ifdef FORMAL
            assert((! ((writeback_port_payload_data_value_exponent == 9'h1ff) && (! writeback_port_payload_data_value_special)))); // FpuCore.scala:L1706
          `else
            if(!(! ((writeback_port_payload_data_value_exponent == 9'h1ff) && (! writeback_port_payload_data_value_special)))) begin
              $display("FAILURE Special violation"); // FpuCore.scala:L1706
              $finish;
            end
          `endif
        `endif
      end
    end
  end

  always @(posedge clk) begin
    if(streamFork_1_io_outputs_1_ready) begin
      FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_opcode <= streamFork_1_io_outputs_1_payload_opcode; // @[Stream.scala 378:28]
      FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_rd <= streamFork_1_io_outputs_1_payload_rd; // @[Stream.scala 378:28]
      FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_write <= streamFork_1_io_outputs_1_payload_write; // @[Stream.scala 378:28]
      FpuPlugin_fpu_streamFork_1_io_outputs_1_rData_value <= streamFork_1_io_outputs_1_payload_value; // @[Stream.scala 378:28]
    end
    if(io_port_0_cmd_ready) begin
      io_port_0_cmd_rData_opcode <= io_port_0_cmd_payload_opcode; // @[Stream.scala 378:28]
      io_port_0_cmd_rData_arg <= io_port_0_cmd_payload_arg; // @[Stream.scala 378:28]
      io_port_0_cmd_rData_rs1 <= io_port_0_cmd_payload_rs1; // @[Stream.scala 378:28]
      io_port_0_cmd_rData_rs2 <= io_port_0_cmd_payload_rs2; // @[Stream.scala 378:28]
      io_port_0_cmd_rData_rs3 <= io_port_0_cmd_payload_rs3; // @[Stream.scala 378:28]
      io_port_0_cmd_rData_rd <= io_port_0_cmd_payload_rd; // @[Stream.scala 378:28]
      io_port_0_cmd_rData_format <= io_port_0_cmd_payload_format; // @[Stream.scala 378:28]
      io_port_0_cmd_rData_roundMode <= io_port_0_cmd_payload_roundMode; // @[Stream.scala 378:28]
    end
    if(read_s0_ready) begin
      read_s0_rData_opcode <= read_s0_payload_opcode; // @[Stream.scala 362:28]
      read_s0_rData_rs1 <= read_s0_payload_rs1; // @[Stream.scala 362:28]
      read_s0_rData_rs2 <= read_s0_payload_rs2; // @[Stream.scala 362:28]
      read_s0_rData_rs3 <= read_s0_payload_rs3; // @[Stream.scala 362:28]
      read_s0_rData_rd <= read_s0_payload_rd; // @[Stream.scala 362:28]
      read_s0_rData_arg <= read_s0_payload_arg; // @[Stream.scala 362:28]
      read_s0_rData_roundMode <= read_s0_payload_roundMode; // @[Stream.scala 362:28]
    end
    if(decode_load_ready) begin
      decode_load_rData_rd <= decode_load_payload_rd; // @[Stream.scala 378:28]
      decode_load_rData_i2f <= decode_load_payload_i2f; // @[Stream.scala 378:28]
      decode_load_rData_arg <= decode_load_payload_arg; // @[Stream.scala 378:28]
      decode_load_rData_roundMode <= decode_load_payload_roundMode; // @[Stream.scala 378:28]
    end
    if(decode_load_s2mPipe_ready) begin
      decode_load_s2mPipe_rData_rd <= decode_load_s2mPipe_payload_rd; // @[Stream.scala 362:28]
      decode_load_s2mPipe_rData_i2f <= decode_load_s2mPipe_payload_i2f; // @[Stream.scala 362:28]
      decode_load_s2mPipe_rData_arg <= decode_load_s2mPipe_payload_arg; // @[Stream.scala 362:28]
      decode_load_s2mPipe_rData_roundMode <= decode_load_s2mPipe_payload_roundMode; // @[Stream.scala 362:28]
    end
    if(decode_load_s2mPipe_m2sPipe_ready) begin
      decode_load_s2mPipe_m2sPipe_rData_rd <= decode_load_s2mPipe_m2sPipe_payload_rd; // @[Stream.scala 362:28]
      decode_load_s2mPipe_m2sPipe_rData_i2f <= decode_load_s2mPipe_m2sPipe_payload_i2f; // @[Stream.scala 362:28]
      decode_load_s2mPipe_m2sPipe_rData_arg <= decode_load_s2mPipe_m2sPipe_payload_arg; // @[Stream.scala 362:28]
      decode_load_s2mPipe_m2sPipe_rData_roundMode <= decode_load_s2mPipe_m2sPipe_payload_roundMode; // @[Stream.scala 362:28]
    end
    if(load_s0_output_ready) begin
      load_s0_output_rData_rd <= load_s0_output_payload_rd; // @[Stream.scala 362:28]
      load_s0_output_rData_value <= load_s0_output_payload_value; // @[Stream.scala 362:28]
      load_s0_output_rData_i2f <= load_s0_output_payload_i2f; // @[Stream.scala 362:28]
      load_s0_output_rData_arg <= load_s0_output_payload_arg; // @[Stream.scala 362:28]
      load_s0_output_rData_roundMode <= load_s0_output_payload_roundMode; // @[Stream.scala 362:28]
    end
    if(when_FpuCore_l525) begin
      load_s1_fsm_shift_output <= load_s1_fsm_shift_input_5; // @[FpuCore.scala 525:35]
    end
    if(when_FpuCore_l529) begin
      if(load_s1_fsm_boot) begin
        if(when_FpuCore_l532) begin
          load_s0_output_rData_value[31 : 0] <= _zz_load_s0_output_rData_value_2; // @[FpuCore.scala 533:55]
          load_s1_fsm_patched <= 1'b1; // @[FpuCore.scala 534:23]
        end else begin
          load_s1_fsm_shift_by <= {_zz_load_s1_fsm_shift_by_32,{_zz_load_s1_fsm_shift_by_31,{_zz_load_s1_fsm_shift_by_30,{_zz_load_s1_fsm_shift_by_29,_zz_load_s1_fsm_shift_by_28}}}}; // @[FpuCore.scala 536:24]
          load_s1_fsm_boot <= 1'b0; // @[FpuCore.scala 537:20]
          load_s1_fsm_i2fZero <= (load_s1_input_payload_value[31 : 0] == 32'h0); // @[FpuCore.scala 538:23]
        end
      end else begin
        load_s1_fsm_done <= 1'b1; // @[FpuCore.scala 541:18]
      end
    end
    if(when_FpuCore_l551) begin
      load_s1_fsm_done <= 1'b0; // @[FpuCore.scala 552:16]
      load_s1_fsm_boot <= 1'b1; // @[FpuCore.scala 553:16]
      load_s1_fsm_patched <= 1'b0; // @[FpuCore.scala 554:19]
    end
    if(decode_shortPip_ready) begin
      decode_shortPip_rData_opcode <= decode_shortPip_payload_opcode; // @[Stream.scala 362:28]
      decode_shortPip_rData_rs1_mantissa <= decode_shortPip_payload_rs1_mantissa; // @[Stream.scala 362:28]
      decode_shortPip_rData_rs1_exponent <= decode_shortPip_payload_rs1_exponent; // @[Stream.scala 362:28]
      decode_shortPip_rData_rs1_sign <= decode_shortPip_payload_rs1_sign; // @[Stream.scala 362:28]
      decode_shortPip_rData_rs1_special <= decode_shortPip_payload_rs1_special; // @[Stream.scala 362:28]
      decode_shortPip_rData_rs2_mantissa <= decode_shortPip_payload_rs2_mantissa; // @[Stream.scala 362:28]
      decode_shortPip_rData_rs2_exponent <= decode_shortPip_payload_rs2_exponent; // @[Stream.scala 362:28]
      decode_shortPip_rData_rs2_sign <= decode_shortPip_payload_rs2_sign; // @[Stream.scala 362:28]
      decode_shortPip_rData_rs2_special <= decode_shortPip_payload_rs2_special; // @[Stream.scala 362:28]
      decode_shortPip_rData_rd <= decode_shortPip_payload_rd; // @[Stream.scala 362:28]
      decode_shortPip_rData_value <= decode_shortPip_payload_value; // @[Stream.scala 362:28]
      decode_shortPip_rData_arg <= decode_shortPip_payload_arg; // @[Stream.scala 362:28]
      decode_shortPip_rData_roundMode <= decode_shortPip_payload_roundMode; // @[Stream.scala 362:28]
    end
    if(when_FpuCore_l646) begin
      shortPip_fsm_shift_scrap <= 1'b1; // @[FpuCore.scala 646:17]
    end
    if(when_FpuCore_l646_1) begin
      shortPip_fsm_shift_scrap <= 1'b1; // @[FpuCore.scala 646:17]
    end
    if(when_FpuCore_l646_2) begin
      shortPip_fsm_shift_scrap <= 1'b1; // @[FpuCore.scala 646:17]
    end
    if(when_FpuCore_l646_3) begin
      shortPip_fsm_shift_scrap <= 1'b1; // @[FpuCore.scala 646:17]
    end
    if(when_FpuCore_l646_4) begin
      shortPip_fsm_shift_scrap <= 1'b1; // @[FpuCore.scala 646:17]
    end
    if(when_FpuCore_l646_5) begin
      shortPip_fsm_shift_scrap <= 1'b1; // @[FpuCore.scala 646:17]
    end
    if(shortPip_fsm_boot) begin
      shortPip_fsm_shift_scrap <= 1'b0; // @[FpuCore.scala 650:17]
    end
    if(when_FpuCore_l652) begin
      shortPip_fsm_shift_output <= shortPip_fsm_shift_input_6; // @[FpuCore.scala 652:33]
    end
    if(when_FpuCore_l658) begin
      if(shortPip_fsm_boot) begin
        if(shortPip_fsm_isF2i) begin
          shortPip_fsm_shift_by <= _zz_shortPip_fsm_shift_by_2[5:0]; // @[FpuCore.scala 662:22]
        end else begin
          shortPip_fsm_shift_by <= _zz_shortPip_fsm_shift_by_5[5:0]; // @[FpuCore.scala 664:22]
        end
        shortPip_fsm_boot <= 1'b0; // @[FpuCore.scala 666:16]
      end else begin
        shortPip_fsm_done <= 1'b1; // @[FpuCore.scala 668:16]
      end
    end
    if(when_FpuCore_l672) begin
      shortPip_fsm_done <= 1'b0; // @[FpuCore.scala 673:14]
      shortPip_fsm_boot <= 1'b1; // @[FpuCore.scala 674:14]
    end
    if(shortPip_rspStreams_0_ready) begin
      shortPip_rspStreams_0_rData_value <= shortPip_rspStreams_0_payload_value; // @[Stream.scala 362:28]
      shortPip_rspStreams_0_rData_NV <= shortPip_rspStreams_0_payload_NV; // @[Stream.scala 362:28]
      shortPip_rspStreams_0_rData_NX <= shortPip_rspStreams_0_payload_NX; // @[Stream.scala 362:28]
    end
    if(decode_mul_ready) begin
      decode_mul_rData_rs1_mantissa <= decode_mul_payload_rs1_mantissa; // @[Stream.scala 362:28]
      decode_mul_rData_rs1_exponent <= decode_mul_payload_rs1_exponent; // @[Stream.scala 362:28]
      decode_mul_rData_rs1_sign <= decode_mul_payload_rs1_sign; // @[Stream.scala 362:28]
      decode_mul_rData_rs1_special <= decode_mul_payload_rs1_special; // @[Stream.scala 362:28]
      decode_mul_rData_rs2_mantissa <= decode_mul_payload_rs2_mantissa; // @[Stream.scala 362:28]
      decode_mul_rData_rs2_exponent <= decode_mul_payload_rs2_exponent; // @[Stream.scala 362:28]
      decode_mul_rData_rs2_sign <= decode_mul_payload_rs2_sign; // @[Stream.scala 362:28]
      decode_mul_rData_rs2_special <= decode_mul_payload_rs2_special; // @[Stream.scala 362:28]
      decode_mul_rData_rs3_mantissa <= decode_mul_payload_rs3_mantissa; // @[Stream.scala 362:28]
      decode_mul_rData_rs3_exponent <= decode_mul_payload_rs3_exponent; // @[Stream.scala 362:28]
      decode_mul_rData_rs3_sign <= decode_mul_payload_rs3_sign; // @[Stream.scala 362:28]
      decode_mul_rData_rs3_special <= decode_mul_payload_rs3_special; // @[Stream.scala 362:28]
      decode_mul_rData_rd <= decode_mul_payload_rd; // @[Stream.scala 362:28]
      decode_mul_rData_add <= decode_mul_payload_add; // @[Stream.scala 362:28]
      decode_mul_rData_divSqrt <= decode_mul_payload_divSqrt; // @[Stream.scala 362:28]
      decode_mul_rData_msb1 <= decode_mul_payload_msb1; // @[Stream.scala 362:28]
      decode_mul_rData_msb2 <= decode_mul_payload_msb2; // @[Stream.scala 362:28]
      decode_mul_rData_roundMode <= decode_mul_payload_roundMode; // @[Stream.scala 362:28]
    end
    if(mul_preMul_output_ready) begin
      mul_preMul_output_rData_rs1_mantissa <= mul_preMul_output_payload_rs1_mantissa; // @[Stream.scala 362:28]
      mul_preMul_output_rData_rs1_exponent <= mul_preMul_output_payload_rs1_exponent; // @[Stream.scala 362:28]
      mul_preMul_output_rData_rs1_sign <= mul_preMul_output_payload_rs1_sign; // @[Stream.scala 362:28]
      mul_preMul_output_rData_rs1_special <= mul_preMul_output_payload_rs1_special; // @[Stream.scala 362:28]
      mul_preMul_output_rData_rs2_mantissa <= mul_preMul_output_payload_rs2_mantissa; // @[Stream.scala 362:28]
      mul_preMul_output_rData_rs2_exponent <= mul_preMul_output_payload_rs2_exponent; // @[Stream.scala 362:28]
      mul_preMul_output_rData_rs2_sign <= mul_preMul_output_payload_rs2_sign; // @[Stream.scala 362:28]
      mul_preMul_output_rData_rs2_special <= mul_preMul_output_payload_rs2_special; // @[Stream.scala 362:28]
      mul_preMul_output_rData_rs3_mantissa <= mul_preMul_output_payload_rs3_mantissa; // @[Stream.scala 362:28]
      mul_preMul_output_rData_rs3_exponent <= mul_preMul_output_payload_rs3_exponent; // @[Stream.scala 362:28]
      mul_preMul_output_rData_rs3_sign <= mul_preMul_output_payload_rs3_sign; // @[Stream.scala 362:28]
      mul_preMul_output_rData_rs3_special <= mul_preMul_output_payload_rs3_special; // @[Stream.scala 362:28]
      mul_preMul_output_rData_rd <= mul_preMul_output_payload_rd; // @[Stream.scala 362:28]
      mul_preMul_output_rData_add <= mul_preMul_output_payload_add; // @[Stream.scala 362:28]
      mul_preMul_output_rData_divSqrt <= mul_preMul_output_payload_divSqrt; // @[Stream.scala 362:28]
      mul_preMul_output_rData_msb1 <= mul_preMul_output_payload_msb1; // @[Stream.scala 362:28]
      mul_preMul_output_rData_msb2 <= mul_preMul_output_payload_msb2; // @[Stream.scala 362:28]
      mul_preMul_output_rData_roundMode <= mul_preMul_output_payload_roundMode; // @[Stream.scala 362:28]
      mul_preMul_output_rData_exp <= mul_preMul_output_payload_exp; // @[Stream.scala 362:28]
    end
    if(mul_mul_output_ready) begin
      mul_mul_output_rData_rs1_mantissa <= mul_mul_output_payload_rs1_mantissa; // @[Stream.scala 362:28]
      mul_mul_output_rData_rs1_exponent <= mul_mul_output_payload_rs1_exponent; // @[Stream.scala 362:28]
      mul_mul_output_rData_rs1_sign <= mul_mul_output_payload_rs1_sign; // @[Stream.scala 362:28]
      mul_mul_output_rData_rs1_special <= mul_mul_output_payload_rs1_special; // @[Stream.scala 362:28]
      mul_mul_output_rData_rs2_mantissa <= mul_mul_output_payload_rs2_mantissa; // @[Stream.scala 362:28]
      mul_mul_output_rData_rs2_exponent <= mul_mul_output_payload_rs2_exponent; // @[Stream.scala 362:28]
      mul_mul_output_rData_rs2_sign <= mul_mul_output_payload_rs2_sign; // @[Stream.scala 362:28]
      mul_mul_output_rData_rs2_special <= mul_mul_output_payload_rs2_special; // @[Stream.scala 362:28]
      mul_mul_output_rData_rs3_mantissa <= mul_mul_output_payload_rs3_mantissa; // @[Stream.scala 362:28]
      mul_mul_output_rData_rs3_exponent <= mul_mul_output_payload_rs3_exponent; // @[Stream.scala 362:28]
      mul_mul_output_rData_rs3_sign <= mul_mul_output_payload_rs3_sign; // @[Stream.scala 362:28]
      mul_mul_output_rData_rs3_special <= mul_mul_output_payload_rs3_special; // @[Stream.scala 362:28]
      mul_mul_output_rData_rd <= mul_mul_output_payload_rd; // @[Stream.scala 362:28]
      mul_mul_output_rData_add <= mul_mul_output_payload_add; // @[Stream.scala 362:28]
      mul_mul_output_rData_divSqrt <= mul_mul_output_payload_divSqrt; // @[Stream.scala 362:28]
      mul_mul_output_rData_msb1 <= mul_mul_output_payload_msb1; // @[Stream.scala 362:28]
      mul_mul_output_rData_msb2 <= mul_mul_output_payload_msb2; // @[Stream.scala 362:28]
      mul_mul_output_rData_roundMode <= mul_mul_output_payload_roundMode; // @[Stream.scala 362:28]
      mul_mul_output_rData_exp <= mul_mul_output_payload_exp; // @[Stream.scala 362:28]
      mul_mul_output_rData_muls_0 <= mul_mul_output_payload_muls_0; // @[Stream.scala 362:28]
      mul_mul_output_rData_muls_1 <= mul_mul_output_payload_muls_1; // @[Stream.scala 362:28]
      mul_mul_output_rData_muls_2 <= mul_mul_output_payload_muls_2; // @[Stream.scala 362:28]
      mul_mul_output_rData_muls_3 <= mul_mul_output_payload_muls_3; // @[Stream.scala 362:28]
    end
    if(mul_sum1_output_ready) begin
      mul_sum1_output_rData_rs1_mantissa <= mul_sum1_output_payload_rs1_mantissa; // @[Stream.scala 362:28]
      mul_sum1_output_rData_rs1_exponent <= mul_sum1_output_payload_rs1_exponent; // @[Stream.scala 362:28]
      mul_sum1_output_rData_rs1_sign <= mul_sum1_output_payload_rs1_sign; // @[Stream.scala 362:28]
      mul_sum1_output_rData_rs1_special <= mul_sum1_output_payload_rs1_special; // @[Stream.scala 362:28]
      mul_sum1_output_rData_rs2_mantissa <= mul_sum1_output_payload_rs2_mantissa; // @[Stream.scala 362:28]
      mul_sum1_output_rData_rs2_exponent <= mul_sum1_output_payload_rs2_exponent; // @[Stream.scala 362:28]
      mul_sum1_output_rData_rs2_sign <= mul_sum1_output_payload_rs2_sign; // @[Stream.scala 362:28]
      mul_sum1_output_rData_rs2_special <= mul_sum1_output_payload_rs2_special; // @[Stream.scala 362:28]
      mul_sum1_output_rData_rs3_mantissa <= mul_sum1_output_payload_rs3_mantissa; // @[Stream.scala 362:28]
      mul_sum1_output_rData_rs3_exponent <= mul_sum1_output_payload_rs3_exponent; // @[Stream.scala 362:28]
      mul_sum1_output_rData_rs3_sign <= mul_sum1_output_payload_rs3_sign; // @[Stream.scala 362:28]
      mul_sum1_output_rData_rs3_special <= mul_sum1_output_payload_rs3_special; // @[Stream.scala 362:28]
      mul_sum1_output_rData_rd <= mul_sum1_output_payload_rd; // @[Stream.scala 362:28]
      mul_sum1_output_rData_add <= mul_sum1_output_payload_add; // @[Stream.scala 362:28]
      mul_sum1_output_rData_divSqrt <= mul_sum1_output_payload_divSqrt; // @[Stream.scala 362:28]
      mul_sum1_output_rData_msb1 <= mul_sum1_output_payload_msb1; // @[Stream.scala 362:28]
      mul_sum1_output_rData_msb2 <= mul_sum1_output_payload_msb2; // @[Stream.scala 362:28]
      mul_sum1_output_rData_roundMode <= mul_sum1_output_payload_roundMode; // @[Stream.scala 362:28]
      mul_sum1_output_rData_exp <= mul_sum1_output_payload_exp; // @[Stream.scala 362:28]
      mul_sum1_output_rData_muls2_0 <= mul_sum1_output_payload_muls2_0; // @[Stream.scala 362:28]
      mul_sum1_output_rData_muls2_1 <= mul_sum1_output_payload_muls2_1; // @[Stream.scala 362:28]
      mul_sum1_output_rData_mulC2 <= mul_sum1_output_payload_mulC2; // @[Stream.scala 362:28]
    end
    if(mul_sum2_output_ready) begin
      mul_sum2_output_rData_rs1_mantissa <= mul_sum2_output_payload_rs1_mantissa; // @[Stream.scala 362:28]
      mul_sum2_output_rData_rs1_exponent <= mul_sum2_output_payload_rs1_exponent; // @[Stream.scala 362:28]
      mul_sum2_output_rData_rs1_sign <= mul_sum2_output_payload_rs1_sign; // @[Stream.scala 362:28]
      mul_sum2_output_rData_rs1_special <= mul_sum2_output_payload_rs1_special; // @[Stream.scala 362:28]
      mul_sum2_output_rData_rs2_mantissa <= mul_sum2_output_payload_rs2_mantissa; // @[Stream.scala 362:28]
      mul_sum2_output_rData_rs2_exponent <= mul_sum2_output_payload_rs2_exponent; // @[Stream.scala 362:28]
      mul_sum2_output_rData_rs2_sign <= mul_sum2_output_payload_rs2_sign; // @[Stream.scala 362:28]
      mul_sum2_output_rData_rs2_special <= mul_sum2_output_payload_rs2_special; // @[Stream.scala 362:28]
      mul_sum2_output_rData_rs3_mantissa <= mul_sum2_output_payload_rs3_mantissa; // @[Stream.scala 362:28]
      mul_sum2_output_rData_rs3_exponent <= mul_sum2_output_payload_rs3_exponent; // @[Stream.scala 362:28]
      mul_sum2_output_rData_rs3_sign <= mul_sum2_output_payload_rs3_sign; // @[Stream.scala 362:28]
      mul_sum2_output_rData_rs3_special <= mul_sum2_output_payload_rs3_special; // @[Stream.scala 362:28]
      mul_sum2_output_rData_rd <= mul_sum2_output_payload_rd; // @[Stream.scala 362:28]
      mul_sum2_output_rData_add <= mul_sum2_output_payload_add; // @[Stream.scala 362:28]
      mul_sum2_output_rData_divSqrt <= mul_sum2_output_payload_divSqrt; // @[Stream.scala 362:28]
      mul_sum2_output_rData_msb1 <= mul_sum2_output_payload_msb1; // @[Stream.scala 362:28]
      mul_sum2_output_rData_msb2 <= mul_sum2_output_payload_msb2; // @[Stream.scala 362:28]
      mul_sum2_output_rData_roundMode <= mul_sum2_output_payload_roundMode; // @[Stream.scala 362:28]
      mul_sum2_output_rData_exp <= mul_sum2_output_payload_exp; // @[Stream.scala 362:28]
      mul_sum2_output_rData_mulC <= mul_sum2_output_payload_mulC; // @[Stream.scala 362:28]
    end
    if(mul_result_mulToAdd_ready) begin
      mul_result_mulToAdd_rData_rs1_mantissa <= mul_result_mulToAdd_payload_rs1_mantissa; // @[Stream.scala 362:28]
      mul_result_mulToAdd_rData_rs1_exponent <= mul_result_mulToAdd_payload_rs1_exponent; // @[Stream.scala 362:28]
      mul_result_mulToAdd_rData_rs1_sign <= mul_result_mulToAdd_payload_rs1_sign; // @[Stream.scala 362:28]
      mul_result_mulToAdd_rData_rs1_special <= mul_result_mulToAdd_payload_rs1_special; // @[Stream.scala 362:28]
      mul_result_mulToAdd_rData_rs2_mantissa <= mul_result_mulToAdd_payload_rs2_mantissa; // @[Stream.scala 362:28]
      mul_result_mulToAdd_rData_rs2_exponent <= mul_result_mulToAdd_payload_rs2_exponent; // @[Stream.scala 362:28]
      mul_result_mulToAdd_rData_rs2_sign <= mul_result_mulToAdd_payload_rs2_sign; // @[Stream.scala 362:28]
      mul_result_mulToAdd_rData_rs2_special <= mul_result_mulToAdd_payload_rs2_special; // @[Stream.scala 362:28]
      mul_result_mulToAdd_rData_rd <= mul_result_mulToAdd_payload_rd; // @[Stream.scala 362:28]
      mul_result_mulToAdd_rData_roundMode <= mul_result_mulToAdd_payload_roundMode; // @[Stream.scala 362:28]
      mul_result_mulToAdd_rData_needCommit <= mul_result_mulToAdd_payload_needCommit; // @[Stream.scala 362:28]
    end
    if(decode_div_ready) begin
      decode_div_rData_rs1_mantissa <= decode_div_payload_rs1_mantissa; // @[Stream.scala 412:28]
      decode_div_rData_rs1_exponent <= decode_div_payload_rs1_exponent; // @[Stream.scala 412:28]
      decode_div_rData_rs1_sign <= decode_div_payload_rs1_sign; // @[Stream.scala 412:28]
      decode_div_rData_rs1_special <= decode_div_payload_rs1_special; // @[Stream.scala 412:28]
      decode_div_rData_rs2_mantissa <= decode_div_payload_rs2_mantissa; // @[Stream.scala 412:28]
      decode_div_rData_rs2_exponent <= decode_div_payload_rs2_exponent; // @[Stream.scala 412:28]
      decode_div_rData_rs2_sign <= decode_div_payload_rs2_sign; // @[Stream.scala 412:28]
      decode_div_rData_rs2_special <= decode_div_payload_rs2_special; // @[Stream.scala 412:28]
      decode_div_rData_rd <= decode_div_payload_rd; // @[Stream.scala 412:28]
      decode_div_rData_roundMode <= decode_div_payload_roundMode; // @[Stream.scala 412:28]
    end
    div_isCommited <= commitLogic_0_div_notEmpty; // @[Reg.scala 39:30]
    if(decode_sqrt_ready) begin
      decode_sqrt_rData_rs1_mantissa <= decode_sqrt_payload_rs1_mantissa; // @[Stream.scala 412:28]
      decode_sqrt_rData_rs1_exponent <= decode_sqrt_payload_rs1_exponent; // @[Stream.scala 412:28]
      decode_sqrt_rData_rs1_sign <= decode_sqrt_payload_rs1_sign; // @[Stream.scala 412:28]
      decode_sqrt_rData_rs1_special <= decode_sqrt_payload_rs1_special; // @[Stream.scala 412:28]
      decode_sqrt_rData_rd <= decode_sqrt_payload_rd; // @[Stream.scala 412:28]
      decode_sqrt_rData_roundMode <= decode_sqrt_payload_roundMode; // @[Stream.scala 412:28]
    end
    sqrt_isCommited <= commitLogic_0_sqrt_notEmpty; // @[Reg.scala 39:30]
    sqrt_exponent <= (_zz_sqrt_exponent + _zz_sqrt_exponent_4); // @[Reg.scala 39:30]
    if(add_preShifter_output_ready) begin
      add_preShifter_output_rData_rs1_mantissa <= add_preShifter_output_payload_rs1_mantissa; // @[Stream.scala 362:28]
      add_preShifter_output_rData_rs1_exponent <= add_preShifter_output_payload_rs1_exponent; // @[Stream.scala 362:28]
      add_preShifter_output_rData_rs1_sign <= add_preShifter_output_payload_rs1_sign; // @[Stream.scala 362:28]
      add_preShifter_output_rData_rs1_special <= add_preShifter_output_payload_rs1_special; // @[Stream.scala 362:28]
      add_preShifter_output_rData_rs2_mantissa <= add_preShifter_output_payload_rs2_mantissa; // @[Stream.scala 362:28]
      add_preShifter_output_rData_rs2_exponent <= add_preShifter_output_payload_rs2_exponent; // @[Stream.scala 362:28]
      add_preShifter_output_rData_rs2_sign <= add_preShifter_output_payload_rs2_sign; // @[Stream.scala 362:28]
      add_preShifter_output_rData_rs2_special <= add_preShifter_output_payload_rs2_special; // @[Stream.scala 362:28]
      add_preShifter_output_rData_rd <= add_preShifter_output_payload_rd; // @[Stream.scala 362:28]
      add_preShifter_output_rData_roundMode <= add_preShifter_output_payload_roundMode; // @[Stream.scala 362:28]
      add_preShifter_output_rData_needCommit <= add_preShifter_output_payload_needCommit; // @[Stream.scala 362:28]
      add_preShifter_output_rData_absRs1Bigger <= add_preShifter_output_payload_absRs1Bigger; // @[Stream.scala 362:28]
      add_preShifter_output_rData_rs1ExponentBigger <= add_preShifter_output_payload_rs1ExponentBigger; // @[Stream.scala 362:28]
    end
    if(add_shifter_output_ready) begin
      add_shifter_output_rData_rs1_mantissa <= add_shifter_output_payload_rs1_mantissa; // @[Stream.scala 362:28]
      add_shifter_output_rData_rs1_exponent <= add_shifter_output_payload_rs1_exponent; // @[Stream.scala 362:28]
      add_shifter_output_rData_rs1_sign <= add_shifter_output_payload_rs1_sign; // @[Stream.scala 362:28]
      add_shifter_output_rData_rs1_special <= add_shifter_output_payload_rs1_special; // @[Stream.scala 362:28]
      add_shifter_output_rData_rs2_mantissa <= add_shifter_output_payload_rs2_mantissa; // @[Stream.scala 362:28]
      add_shifter_output_rData_rs2_exponent <= add_shifter_output_payload_rs2_exponent; // @[Stream.scala 362:28]
      add_shifter_output_rData_rs2_sign <= add_shifter_output_payload_rs2_sign; // @[Stream.scala 362:28]
      add_shifter_output_rData_rs2_special <= add_shifter_output_payload_rs2_special; // @[Stream.scala 362:28]
      add_shifter_output_rData_rd <= add_shifter_output_payload_rd; // @[Stream.scala 362:28]
      add_shifter_output_rData_roundMode <= add_shifter_output_payload_roundMode; // @[Stream.scala 362:28]
      add_shifter_output_rData_needCommit <= add_shifter_output_payload_needCommit; // @[Stream.scala 362:28]
      add_shifter_output_rData_xSign <= add_shifter_output_payload_xSign; // @[Stream.scala 362:28]
      add_shifter_output_rData_ySign <= add_shifter_output_payload_ySign; // @[Stream.scala 362:28]
      add_shifter_output_rData_xMantissa <= add_shifter_output_payload_xMantissa; // @[Stream.scala 362:28]
      add_shifter_output_rData_yMantissa <= add_shifter_output_payload_yMantissa; // @[Stream.scala 362:28]
      add_shifter_output_rData_xyExponent <= add_shifter_output_payload_xyExponent; // @[Stream.scala 362:28]
      add_shifter_output_rData_xySign <= add_shifter_output_payload_xySign; // @[Stream.scala 362:28]
      add_shifter_output_rData_roundingScrap <= add_shifter_output_payload_roundingScrap; // @[Stream.scala 362:28]
    end
    if(add_math_output_ready) begin
      add_math_output_rData_rs1_mantissa <= add_math_output_payload_rs1_mantissa; // @[Stream.scala 362:28]
      add_math_output_rData_rs1_exponent <= add_math_output_payload_rs1_exponent; // @[Stream.scala 362:28]
      add_math_output_rData_rs1_sign <= add_math_output_payload_rs1_sign; // @[Stream.scala 362:28]
      add_math_output_rData_rs1_special <= add_math_output_payload_rs1_special; // @[Stream.scala 362:28]
      add_math_output_rData_rs2_mantissa <= add_math_output_payload_rs2_mantissa; // @[Stream.scala 362:28]
      add_math_output_rData_rs2_exponent <= add_math_output_payload_rs2_exponent; // @[Stream.scala 362:28]
      add_math_output_rData_rs2_sign <= add_math_output_payload_rs2_sign; // @[Stream.scala 362:28]
      add_math_output_rData_rs2_special <= add_math_output_payload_rs2_special; // @[Stream.scala 362:28]
      add_math_output_rData_rd <= add_math_output_payload_rd; // @[Stream.scala 362:28]
      add_math_output_rData_roundMode <= add_math_output_payload_roundMode; // @[Stream.scala 362:28]
      add_math_output_rData_needCommit <= add_math_output_payload_needCommit; // @[Stream.scala 362:28]
      add_math_output_rData_xSign <= add_math_output_payload_xSign; // @[Stream.scala 362:28]
      add_math_output_rData_ySign <= add_math_output_payload_ySign; // @[Stream.scala 362:28]
      add_math_output_rData_xMantissa <= add_math_output_payload_xMantissa; // @[Stream.scala 362:28]
      add_math_output_rData_yMantissa <= add_math_output_payload_yMantissa; // @[Stream.scala 362:28]
      add_math_output_rData_xyExponent <= add_math_output_payload_xyExponent; // @[Stream.scala 362:28]
      add_math_output_rData_xySign <= add_math_output_payload_xySign; // @[Stream.scala 362:28]
      add_math_output_rData_roundingScrap <= add_math_output_payload_roundingScrap; // @[Stream.scala 362:28]
      add_math_output_rData_xyMantissa <= add_math_output_payload_xyMantissa; // @[Stream.scala 362:28]
    end
    if(add_oh_output_ready) begin
      add_oh_output_rData_rs1_mantissa <= add_oh_output_payload_rs1_mantissa; // @[Stream.scala 362:28]
      add_oh_output_rData_rs1_exponent <= add_oh_output_payload_rs1_exponent; // @[Stream.scala 362:28]
      add_oh_output_rData_rs1_sign <= add_oh_output_payload_rs1_sign; // @[Stream.scala 362:28]
      add_oh_output_rData_rs1_special <= add_oh_output_payload_rs1_special; // @[Stream.scala 362:28]
      add_oh_output_rData_rs2_mantissa <= add_oh_output_payload_rs2_mantissa; // @[Stream.scala 362:28]
      add_oh_output_rData_rs2_exponent <= add_oh_output_payload_rs2_exponent; // @[Stream.scala 362:28]
      add_oh_output_rData_rs2_sign <= add_oh_output_payload_rs2_sign; // @[Stream.scala 362:28]
      add_oh_output_rData_rs2_special <= add_oh_output_payload_rs2_special; // @[Stream.scala 362:28]
      add_oh_output_rData_rd <= add_oh_output_payload_rd; // @[Stream.scala 362:28]
      add_oh_output_rData_roundMode <= add_oh_output_payload_roundMode; // @[Stream.scala 362:28]
      add_oh_output_rData_needCommit <= add_oh_output_payload_needCommit; // @[Stream.scala 362:28]
      add_oh_output_rData_xSign <= add_oh_output_payload_xSign; // @[Stream.scala 362:28]
      add_oh_output_rData_ySign <= add_oh_output_payload_ySign; // @[Stream.scala 362:28]
      add_oh_output_rData_xMantissa <= add_oh_output_payload_xMantissa; // @[Stream.scala 362:28]
      add_oh_output_rData_yMantissa <= add_oh_output_payload_yMantissa; // @[Stream.scala 362:28]
      add_oh_output_rData_xyExponent <= add_oh_output_payload_xyExponent; // @[Stream.scala 362:28]
      add_oh_output_rData_xySign <= add_oh_output_payload_xySign; // @[Stream.scala 362:28]
      add_oh_output_rData_roundingScrap <= add_oh_output_payload_roundingScrap; // @[Stream.scala 362:28]
      add_oh_output_rData_xyMantissa <= add_oh_output_payload_xyMantissa; // @[Stream.scala 362:28]
      add_oh_output_rData_shift <= add_oh_output_payload_shift; // @[Stream.scala 362:28]
    end
    if(load_s1_output_ready) begin
      load_s1_output_rData_rd <= load_s1_output_payload_rd; // @[Stream.scala 362:28]
      load_s1_output_rData_value_mantissa <= load_s1_output_payload_value_mantissa; // @[Stream.scala 362:28]
      load_s1_output_rData_value_exponent <= load_s1_output_payload_value_exponent; // @[Stream.scala 362:28]
      load_s1_output_rData_value_sign <= load_s1_output_payload_value_sign; // @[Stream.scala 362:28]
      load_s1_output_rData_value_special <= load_s1_output_payload_value_special; // @[Stream.scala 362:28]
      load_s1_output_rData_scrap <= load_s1_output_payload_scrap; // @[Stream.scala 362:28]
      load_s1_output_rData_roundMode <= load_s1_output_payload_roundMode; // @[Stream.scala 362:28]
      load_s1_output_rData_NV <= load_s1_output_payload_NV; // @[Stream.scala 362:28]
      load_s1_output_rData_DZ <= load_s1_output_payload_DZ; // @[Stream.scala 362:28]
    end
    if(shortPip_output_ready) begin
      shortPip_output_rData_rd <= shortPip_output_payload_rd; // @[Stream.scala 362:28]
      shortPip_output_rData_value_mantissa <= shortPip_output_payload_value_mantissa; // @[Stream.scala 362:28]
      shortPip_output_rData_value_exponent <= shortPip_output_payload_value_exponent; // @[Stream.scala 362:28]
      shortPip_output_rData_value_sign <= shortPip_output_payload_value_sign; // @[Stream.scala 362:28]
      shortPip_output_rData_value_special <= shortPip_output_payload_value_special; // @[Stream.scala 362:28]
      shortPip_output_rData_scrap <= shortPip_output_payload_scrap; // @[Stream.scala 362:28]
      shortPip_output_rData_roundMode <= shortPip_output_payload_roundMode; // @[Stream.scala 362:28]
      shortPip_output_rData_NV <= shortPip_output_payload_NV; // @[Stream.scala 362:28]
      shortPip_output_rData_DZ <= shortPip_output_payload_DZ; // @[Stream.scala 362:28]
    end
    roundFront_input_payload_rd <= merge_arbitrated_payload_rd; // @[Reg.scala 39:30]
    roundFront_input_payload_value_mantissa <= merge_arbitrated_payload_value_mantissa; // @[Reg.scala 39:30]
    roundFront_input_payload_value_exponent <= merge_arbitrated_payload_value_exponent; // @[Reg.scala 39:30]
    roundFront_input_payload_value_sign <= merge_arbitrated_payload_value_sign; // @[Reg.scala 39:30]
    roundFront_input_payload_value_special <= merge_arbitrated_payload_value_special; // @[Reg.scala 39:30]
    roundFront_input_payload_scrap <= merge_arbitrated_payload_scrap; // @[Reg.scala 39:30]
    roundFront_input_payload_roundMode <= merge_arbitrated_payload_roundMode; // @[Reg.scala 39:30]
    roundFront_input_payload_NV <= merge_arbitrated_payload_NV; // @[Reg.scala 39:30]
    roundFront_input_payload_DZ <= merge_arbitrated_payload_DZ; // @[Reg.scala 39:30]
    roundBack_input_payload_rd <= roundFront_output_payload_rd; // @[Reg.scala 39:30]
    roundBack_input_payload_value_mantissa <= roundFront_output_payload_value_mantissa; // @[Reg.scala 39:30]
    roundBack_input_payload_value_exponent <= roundFront_output_payload_value_exponent; // @[Reg.scala 39:30]
    roundBack_input_payload_value_sign <= roundFront_output_payload_value_sign; // @[Reg.scala 39:30]
    roundBack_input_payload_value_special <= roundFront_output_payload_value_special; // @[Reg.scala 39:30]
    roundBack_input_payload_scrap <= roundFront_output_payload_scrap; // @[Reg.scala 39:30]
    roundBack_input_payload_roundMode <= roundFront_output_payload_roundMode; // @[Reg.scala 39:30]
    roundBack_input_payload_NV <= roundFront_output_payload_NV; // @[Reg.scala 39:30]
    roundBack_input_payload_DZ <= roundFront_output_payload_DZ; // @[Reg.scala 39:30]
    roundBack_input_payload_mantissaIncrement <= roundFront_output_payload_mantissaIncrement; // @[Reg.scala 39:30]
    roundBack_input_payload_roundAdjusted <= roundFront_output_payload_roundAdjusted; // @[Reg.scala 39:30]
    roundBack_input_payload_exactMask <= roundFront_output_payload_exactMask; // @[Reg.scala 39:30]
    writeback_input_payload_rd <= roundBack_output_payload_rd; // @[Reg.scala 39:30]
    writeback_input_payload_value_mantissa <= roundBack_output_payload_value_mantissa; // @[Reg.scala 39:30]
    writeback_input_payload_value_exponent <= roundBack_output_payload_value_exponent; // @[Reg.scala 39:30]
    writeback_input_payload_value_sign <= roundBack_output_payload_value_sign; // @[Reg.scala 39:30]
    writeback_input_payload_value_special <= roundBack_output_payload_value_special; // @[Reg.scala 39:30]
    writeback_input_payload_NV <= roundBack_output_payload_NV; // @[Reg.scala 39:30]
    writeback_input_payload_NX <= roundBack_output_payload_NX; // @[Reg.scala 39:30]
    writeback_input_payload_OF <= roundBack_output_payload_OF; // @[Reg.scala 39:30]
    writeback_input_payload_UF <= roundBack_output_payload_UF; // @[Reg.scala 39:30]
    writeback_input_payload_DZ <= roundBack_output_payload_DZ; // @[Reg.scala 39:30]
    writeback_input_payload_write <= roundBack_output_payload_write; // @[Reg.scala 39:30]
  end


endmodule

module DataCache (
  input               io_cpu_execute_isValid,
  input      [31:0]   io_cpu_execute_address,
  output reg          io_cpu_execute_haltIt,
  input               io_cpu_execute_args_wr,
  input      [1:0]    io_cpu_execute_args_size,
  input               io_cpu_execute_args_totalyConsistent,
  output              io_cpu_execute_refilling,
  input               io_cpu_memory_isValid,
  input               io_cpu_memory_isStuck,
  output              io_cpu_memory_isWrite,
  input      [31:0]   io_cpu_memory_address,
  input      [31:0]   io_cpu_memory_mmuRsp_physicalAddress,
  input               io_cpu_memory_mmuRsp_isIoAccess,
  input               io_cpu_memory_mmuRsp_isPaging,
  input               io_cpu_memory_mmuRsp_allowRead,
  input               io_cpu_memory_mmuRsp_allowWrite,
  input               io_cpu_memory_mmuRsp_allowExecute,
  input               io_cpu_memory_mmuRsp_exception,
  input               io_cpu_memory_mmuRsp_refilling,
  input               io_cpu_memory_mmuRsp_bypassTranslation,
  input               io_cpu_writeBack_isValid,
  input               io_cpu_writeBack_isStuck,
  input               io_cpu_writeBack_isFiring,
  input               io_cpu_writeBack_isUser,
  output reg          io_cpu_writeBack_haltIt,
  output              io_cpu_writeBack_isWrite,
  input      [31:0]   io_cpu_writeBack_storeData,
  output reg [31:0]   io_cpu_writeBack_data,
  input      [31:0]   io_cpu_writeBack_address,
  output              io_cpu_writeBack_mmuException,
  output              io_cpu_writeBack_unalignedAccess,
  output reg          io_cpu_writeBack_accessError,
  output              io_cpu_writeBack_keepMemRspData,
  input               io_cpu_writeBack_fence_SW,
  input               io_cpu_writeBack_fence_SR,
  input               io_cpu_writeBack_fence_SO,
  input               io_cpu_writeBack_fence_SI,
  input               io_cpu_writeBack_fence_PW,
  input               io_cpu_writeBack_fence_PR,
  input               io_cpu_writeBack_fence_PO,
  input               io_cpu_writeBack_fence_PI,
  input      [3:0]    io_cpu_writeBack_fence_FM,
  output              io_cpu_writeBack_exclusiveOk,
  output reg          io_cpu_redo,
  input               io_cpu_flush_valid,
  output              io_cpu_flush_ready,
  input               io_cpu_flush_payload_singleLine,
  output reg          io_mem_cmd_valid,
  input               io_mem_cmd_ready,
  output reg          io_mem_cmd_payload_wr,
  output              io_mem_cmd_payload_uncached,
  output reg [31:0]   io_mem_cmd_payload_address,
  output     [31:0]   io_mem_cmd_payload_data,
  output     [3:0]    io_mem_cmd_payload_mask,
  output reg [1:0]    io_mem_cmd_payload_size,
  output              io_mem_cmd_payload_last,
  input               io_mem_rsp_valid,
  input               io_mem_rsp_payload_last,
  input      [31:0]   io_mem_rsp_payload_data,
  input               io_mem_rsp_payload_error,
  input               clk,
  input               reset
);

  wire       [0:0]    _zz_when;
  wire       [1:0]    _zz_loader_waysAllocator;
  reg                 when_Phase_l648;
  reg                 when_Phase_l648_1;
  wire                haltCpu;
  reg                 tagsReadCmd_valid;
  reg                 tagsWriteCmd_valid;
  reg        [0:0]    tagsWriteCmd_payload_way;
  reg                 tagsWriteCmd_payload_data_valid;
  reg                 tagsWriteCmd_payload_data_error;
  reg        [29:0]   tagsWriteCmd_payload_data_address;
  reg                 tagsWriteLastCmd_valid;
  reg        [0:0]    tagsWriteLastCmd_payload_way;
  reg                 tagsWriteLastCmd_payload_data_valid;
  reg                 tagsWriteLastCmd_payload_data_error;
  reg        [29:0]   tagsWriteLastCmd_payload_data_address;
  reg                 dataReadCmd_valid;
  reg                 dataWriteCmd_valid;
  reg        [0:0]    dataWriteCmd_payload_way;
  reg        [31:0]   dataWriteCmd_payload_data;
  reg        [3:0]    dataWriteCmd_payload_mask;
  wire                when_Phase_l675;
  wire                ways_0_tagsReadRsp_valid;
  wire                ways_0_tagsReadRsp_error;
  wire       [29:0]   ways_0_tagsReadRsp_address;
  wire       [31:0]   _zz_ways_0_tagsReadRsp_valid;
  wire                when_Phase_l675_1;
  wire       [31:0]   ways_0_dataReadRspMem;
  wire       [31:0]   ways_0_dataReadRsp;
  wire                when_DataCache_l642;
  wire                when_DataCache_l645;
  wire       [31:0]   _zz_ways_0_dataReadRspMem;
  wire                when_DataCache_l664;
  wire                rspSync;
  wire                rspLast;
  reg                 memCmdSent;
  wire                io_mem_cmd_fire;
  wire                when_DataCache_l686;
  reg        [3:0]    _zz_stage0_mask;
  wire       [3:0]    stage0_mask;
  wire       [0:0]    stage0_dataColisions;
  wire       [0:0]    stage0_wayInvalidate;
  wire                stage0_isAmo;
  wire                when_DataCache_l771;
  reg                 stageA_request_wr;
  reg        [1:0]    stageA_request_size;
  reg                 stageA_request_totalyConsistent;
  wire                when_DataCache_l771_1;
  reg        [3:0]    stageA_mask;
  wire                stageA_isAmo;
  wire                stageA_isLrsc;
  wire       [0:0]    stageA_wayHits;
  wire                when_DataCache_l771_2;
  reg        [0:0]    stageA_wayInvalidate;
  wire                when_DataCache_l771_3;
  reg        [0:0]    stage0_dataColisions_regNextWhen;
  wire       [0:0]    _zz_stageA_dataColisions;
  wire       [0:0]    stageA_dataColisions;
  wire                when_DataCache_l822;
  reg                 stageB_request_wr;
  reg        [1:0]    stageB_request_size;
  reg                 stageB_request_totalyConsistent;
  reg                 stageB_mmuRspFreeze;
  wire                when_DataCache_l824;
  reg        [31:0]   stageB_mmuRsp_physicalAddress;
  reg                 stageB_mmuRsp_isIoAccess;
  reg                 stageB_mmuRsp_isPaging;
  reg                 stageB_mmuRsp_allowRead;
  reg                 stageB_mmuRsp_allowWrite;
  reg                 stageB_mmuRsp_allowExecute;
  reg                 stageB_mmuRsp_exception;
  reg                 stageB_mmuRsp_refilling;
  reg                 stageB_mmuRsp_bypassTranslation;
  wire                when_DataCache_l821;
  reg                 stageB_tagsReadRsp_0_valid;
  reg                 stageB_tagsReadRsp_0_error;
  reg        [29:0]   stageB_tagsReadRsp_0_address;
  wire                when_DataCache_l821_1;
  reg        [31:0]   stageB_dataReadRsp_0;
  wire                when_DataCache_l820;
  reg        [0:0]    stageB_wayInvalidate;
  wire                stageB_consistancyHazard;
  wire                when_DataCache_l820_1;
  reg        [0:0]    stageB_dataColisions;
  wire                when_DataCache_l820_2;
  reg                 stageB_unaligned;
  wire                when_DataCache_l820_3;
  reg        [0:0]    stageB_waysHitsBeforeInvalidate;
  wire       [0:0]    stageB_waysHits;
  wire                stageB_waysHit;
  wire       [31:0]   stageB_dataMux;
  wire                when_DataCache_l820_4;
  reg        [3:0]    stageB_mask;
  reg                 stageB_loaderValid;
  wire       [31:0]   stageB_ioMemRspMuxed;
  reg                 stageB_flusher_waitDone;
  wire                stageB_flusher_hold;
  reg        [0:0]    stageB_flusher_counter;
  wire                when_DataCache_l850;
  wire                when_DataCache_l856;
  reg                 stageB_flusher_start;
  wire                stageB_isAmo;
  wire                stageB_isAmoCached;
  wire                stageB_isExternalLsrc;
  wire                stageB_isExternalAmo;
  wire       [31:0]   stageB_requestDataBypass;
  reg                 stageB_cpuWriteToCache;
  wire                when_DataCache_l926;
  wire                stageB_badPermissions;
  wire                stageB_loadStoreFault;
  wire                stageB_bypassCache;
  wire                when_DataCache_l995;
  wire                when_DataCache_l1004;
  wire                when_DataCache_l1009;
  wire                when_DataCache_l1020;
  wire                when_DataCache_l1032;
  wire                when_DataCache_l991;
  wire                when_DataCache_l1066;
  wire                when_DataCache_l1075;
  reg                 loader_valid;
  reg                 loader_counter_willIncrement;
  wire                loader_counter_willClear;
  wire                loader_counter_willOverflowIfInc;
  wire                loader_counter_willOverflow;
  reg        [0:0]    loader_waysAllocator;
  reg                 loader_error;
  wire                loader_kill;
  reg                 loader_killReg;
  wire                when_DataCache_l1090;
  wire                loader_done;
  wire                when_DataCache_l1118;
  reg                 loader_valid_regNext;
  wire                when_DataCache_l1122;
  wire                when_DataCache_l1125;
  wire       [31:0]   _zz_ways_0_tagsReadRsp_valid_1;
  reg        [31:0]   _zz_ways_0_tagsReadRsp_valid_2;
  reg        [31:0]   _zz_ways_0_tagsReadRsp_valid_3;
  wire       [31:0]   _zz_ways_0_dataReadRspMem_1;
  reg        [31:0]   _zz_ways_0_dataReadRspMem_2;
  reg        [31:0]   _zz_ways_0_dataReadRspMem_3;
  wire                when_Phase_l655;
  wire                when_Phase_l655_1;
  wire                when_Phase_l655_2;
  wire                when_Phase_l655_3;

  assign _zz_when = 1'b1;
  assign _zz_loader_waysAllocator = {loader_waysAllocator,loader_waysAllocator[0]};
  always @(*) begin
    when_Phase_l648 = 1'b0; // @[when.scala 47:16]
    if(when_DataCache_l645) begin
      when_Phase_l648 = 1'b1; // @[when.scala 52:10]
    end
  end

  always @(*) begin
    when_Phase_l648_1 = 1'b0; // @[when.scala 47:16]
    if(when_DataCache_l642) begin
      when_Phase_l648_1 = 1'b1; // @[when.scala 52:10]
    end
  end

  assign haltCpu = 1'b0; // @[DataCache.scala 575:17]
  assign when_Phase_l675 = (tagsReadCmd_valid && (! io_cpu_memory_isStuck)); // @[BaseType.scala 305:24]
  assign _zz_ways_0_tagsReadRsp_valid = _zz_ways_0_tagsReadRsp_valid_2; // @[Mem.scala 310:24]
  assign ways_0_tagsReadRsp_valid = _zz_ways_0_tagsReadRsp_valid[0]; // @[Bool.scala 189:10]
  assign ways_0_tagsReadRsp_error = _zz_ways_0_tagsReadRsp_valid[1]; // @[Bool.scala 189:10]
  assign ways_0_tagsReadRsp_address = _zz_ways_0_tagsReadRsp_valid[31 : 2]; // @[UInt.scala 381:56]
  assign when_Phase_l675_1 = (dataReadCmd_valid && (! io_cpu_memory_isStuck)); // @[BaseType.scala 305:24]
  assign ways_0_dataReadRspMem = _zz_ways_0_dataReadRspMem_2; // @[Bits.scala 133:56]
  assign ways_0_dataReadRsp = ways_0_dataReadRspMem[31 : 0]; // @[Vec.scala 169:11]
  assign when_DataCache_l642 = (tagsWriteCmd_valid && tagsWriteCmd_payload_way[0]); // @[BaseType.scala 305:24]
  assign when_DataCache_l645 = (dataWriteCmd_valid && dataWriteCmd_payload_way[0]); // @[BaseType.scala 305:24]
  assign _zz_ways_0_dataReadRspMem = dataWriteCmd_payload_data; // @[Bits.scala 152:9]
  always @(*) begin
    tagsReadCmd_valid = 1'b0; // @[DataCache.scala 655:21]
    if(when_DataCache_l664) begin
      tagsReadCmd_valid = 1'b1; // @[DataCache.scala 665:25]
    end
  end

  always @(*) begin
    dataReadCmd_valid = 1'b0; // @[DataCache.scala 657:21]
    if(when_DataCache_l664) begin
      dataReadCmd_valid = 1'b1; // @[DataCache.scala 666:25]
    end
  end

  always @(*) begin
    tagsWriteCmd_valid = 1'b0; // @[DataCache.scala 659:22]
    if(when_DataCache_l850) begin
      tagsWriteCmd_valid = 1'b1; // @[DataCache.scala 851:28]
    end
    if(when_DataCache_l1066) begin
      tagsWriteCmd_valid = 1'b0; // @[DataCache.scala 1068:26]
    end
    if(loader_done) begin
      tagsWriteCmd_valid = 1'b1; // @[DataCache.scala 1107:26]
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_way = 1'bx; // @[Bits.scala 231:20]
    if(when_DataCache_l850) begin
      tagsWriteCmd_payload_way = 1'b1; // @[Bits.scala 226:10]
    end
    if(loader_done) begin
      tagsWriteCmd_payload_way = loader_waysAllocator; // @[DataCache.scala 1112:24]
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_data_valid = 1'bx; // @[Bool.scala 276:20]
    if(when_DataCache_l850) begin
      tagsWriteCmd_payload_data_valid = 1'b0; // @[DataCache.scala 854:33]
    end
    if(loader_done) begin
      tagsWriteCmd_payload_data_valid = (! (loader_kill || loader_killReg)); // @[DataCache.scala 1109:31]
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_data_error = 1'bx; // @[Bool.scala 276:20]
    if(loader_done) begin
      tagsWriteCmd_payload_data_error = (loader_error || (io_mem_rsp_valid && io_mem_rsp_payload_error)); // @[DataCache.scala 1111:31]
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_data_address = 30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; // @[UInt.scala 467:20]
    if(loader_done) begin
      tagsWriteCmd_payload_data_address = stageB_mmuRsp_physicalAddress[31 : 2]; // @[DataCache.scala 1110:33]
    end
  end

  always @(*) begin
    dataWriteCmd_valid = 1'b0; // @[DataCache.scala 661:22]
    if(stageB_cpuWriteToCache) begin
      if(when_DataCache_l926) begin
        dataWriteCmd_valid = 1'b1; // @[DataCache.scala 926:26]
      end
    end
    if(when_DataCache_l1066) begin
      dataWriteCmd_valid = 1'b0; // @[DataCache.scala 1069:26]
    end
    if(when_DataCache_l1090) begin
      dataWriteCmd_valid = 1'b1; // @[DataCache.scala 1091:26]
    end
  end

  always @(*) begin
    dataWriteCmd_payload_way = 1'bx; // @[Bits.scala 231:20]
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_way = stageB_waysHits; // @[DataCache.scala 931:24]
    end
    if(when_DataCache_l1090) begin
      dataWriteCmd_payload_way = loader_waysAllocator; // @[DataCache.scala 1095:24]
    end
  end

  always @(*) begin
    dataWriteCmd_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; // @[Bits.scala 231:20]
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_data[31 : 0] = stageB_requestDataBypass; // @[DataCache.scala 928:66]
    end
    if(when_DataCache_l1090) begin
      dataWriteCmd_payload_data = io_mem_rsp_payload_data; // @[DataCache.scala 1093:25]
    end
  end

  always @(*) begin
    dataWriteCmd_payload_mask = 4'bxxxx; // @[Bits.scala 231:20]
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_mask = 4'b0000; // @[DataCache.scala 929:25]
      if(_zz_when[0]) begin
        dataWriteCmd_payload_mask[3 : 0] = stageB_mask; // @[Utils.scala 1049:24]
      end
    end
    if(when_DataCache_l1090) begin
      dataWriteCmd_payload_mask = 4'b1111; // @[Bits.scala 226:10]
    end
  end

  assign when_DataCache_l664 = (io_cpu_execute_isValid && (! io_cpu_memory_isStuck)); // @[BaseType.scala 305:24]
  always @(*) begin
    io_cpu_execute_haltIt = 1'b0; // @[DataCache.scala 682:25]
    if(when_DataCache_l850) begin
      io_cpu_execute_haltIt = 1'b1; // @[DataCache.scala 855:31]
    end
  end

  assign rspSync = 1'b1; // @[DataCache.scala 684:17]
  assign rspLast = 1'b1; // @[DataCache.scala 685:17]
  assign io_mem_cmd_fire = (io_mem_cmd_valid && io_mem_cmd_ready); // @[BaseType.scala 305:24]
  assign when_DataCache_l686 = (! io_cpu_writeBack_isStuck); // @[BaseType.scala 299:24]
  always @(*) begin
    _zz_stage0_mask = 4'bxxxx; // @[Bits.scala 231:20]
    case(io_cpu_execute_args_size)
      2'b00 : begin
        _zz_stage0_mask = 4'b0001; // @[Misc.scala 260:22]
      end
      2'b01 : begin
        _zz_stage0_mask = 4'b0011; // @[Misc.scala 260:22]
      end
      2'b10 : begin
        _zz_stage0_mask = 4'b1111; // @[Misc.scala 260:22]
      end
      default : begin
      end
    endcase
  end

  assign stage0_mask = (_zz_stage0_mask <<< io_cpu_execute_address[1 : 0]); // @[BaseType.scala 299:24]
  assign stage0_dataColisions[0] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && 1'b1) && ((stage0_mask & dataWriteCmd_payload_mask[3 : 0]) != 4'b0000)); // @[DataCache.scala 676:14]
  assign stage0_wayInvalidate = 1'b0; // @[Expression.scala 2301:18]
  assign stage0_isAmo = 1'b0; // @[DataCache.scala 767:55]
  assign when_DataCache_l771 = (! io_cpu_memory_isStuck); // @[BaseType.scala 299:24]
  assign when_DataCache_l771_1 = (! io_cpu_memory_isStuck); // @[BaseType.scala 299:24]
  assign io_cpu_memory_isWrite = stageA_request_wr; // @[DataCache.scala 774:27]
  assign stageA_isAmo = 1'b0; // @[DataCache.scala 776:48]
  assign stageA_isLrsc = 1'b0; // @[DataCache.scala 777:50]
  assign stageA_wayHits = ((io_cpu_memory_mmuRsp_physicalAddress[31 : 2] == ways_0_tagsReadRsp_address) && ways_0_tagsReadRsp_valid); // @[DataCache.scala 798:15]
  assign when_DataCache_l771_2 = (! io_cpu_memory_isStuck); // @[BaseType.scala 299:24]
  assign when_DataCache_l771_3 = (! io_cpu_memory_isStuck); // @[BaseType.scala 299:24]
  assign _zz_stageA_dataColisions[0] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && 1'b1) && ((stageA_mask & dataWriteCmd_payload_mask[3 : 0]) != 4'b0000)); // @[DataCache.scala 676:14]
  assign stageA_dataColisions = (stage0_dataColisions_regNextWhen | _zz_stageA_dataColisions); // @[BaseType.scala 299:24]
  assign when_DataCache_l822 = (! io_cpu_writeBack_isStuck); // @[BaseType.scala 299:24]
  always @(*) begin
    stageB_mmuRspFreeze = 1'b0; // @[DataCache.scala 823:24]
    if(when_DataCache_l1125) begin
      stageB_mmuRspFreeze = 1'b1; // @[DataCache.scala 1125:25]
    end
  end

  assign when_DataCache_l824 = ((! io_cpu_writeBack_isStuck) && (! stageB_mmuRspFreeze)); // @[BaseType.scala 305:24]
  assign when_DataCache_l821 = (! io_cpu_writeBack_isStuck); // @[BaseType.scala 299:24]
  assign when_DataCache_l821_1 = (! io_cpu_writeBack_isStuck); // @[BaseType.scala 299:24]
  assign when_DataCache_l820 = (! io_cpu_writeBack_isStuck); // @[BaseType.scala 299:24]
  assign stageB_consistancyHazard = 1'b0; // @[DataCache.scala 828:112]
  assign when_DataCache_l820_1 = (! io_cpu_writeBack_isStuck); // @[BaseType.scala 299:24]
  assign when_DataCache_l820_2 = (! io_cpu_writeBack_isStuck); // @[BaseType.scala 299:24]
  assign when_DataCache_l820_3 = (! io_cpu_writeBack_isStuck); // @[BaseType.scala 299:24]
  assign stageB_waysHits = (stageB_waysHitsBeforeInvalidate & (~ stageB_wayInvalidate)); // @[BaseType.scala 299:24]
  assign stageB_waysHit = (|stageB_waysHits); // @[BaseType.scala 312:24]
  assign stageB_dataMux = stageB_dataReadRsp_0; // @[Vec.scala 169:11]
  assign when_DataCache_l820_4 = (! io_cpu_writeBack_isStuck); // @[BaseType.scala 299:24]
  always @(*) begin
    stageB_loaderValid = 1'b0; // @[DataCache.scala 839:23]
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l991) begin
          if(!when_DataCache_l1004) begin
            if(io_mem_cmd_ready) begin
              stageB_loaderValid = 1'b1; // @[DataCache.scala 1037:23]
            end
          end
        end
      end
    end
    if(when_DataCache_l1066) begin
      stageB_loaderValid = 1'b0; // @[DataCache.scala 1070:19]
    end
  end

  assign stageB_ioMemRspMuxed = io_mem_rsp_payload_data[31 : 0]; // @[Vec.scala 169:11]
  always @(*) begin
    io_cpu_writeBack_haltIt = 1'b1; // @[DataCache.scala 843:29]
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(when_DataCache_l991) begin
          if(when_DataCache_l995) begin
            io_cpu_writeBack_haltIt = 1'b0; // @[DataCache.scala 995:42]
          end
        end else begin
          if(when_DataCache_l1004) begin
            if(when_DataCache_l1009) begin
              io_cpu_writeBack_haltIt = 1'b0; // @[DataCache.scala 1009:35]
            end
          end
        end
      end
    end
    if(when_DataCache_l1066) begin
      io_cpu_writeBack_haltIt = 1'b0; // @[DataCache.scala 1071:31]
    end
  end

  assign stageB_flusher_hold = 1'b0; // @[DataCache.scala 848:18]
  assign when_DataCache_l850 = (! stageB_flusher_counter[0]); // @[BaseType.scala 299:24]
  assign when_DataCache_l856 = (! stageB_flusher_hold); // @[BaseType.scala 299:24]
  assign io_cpu_flush_ready = (stageB_flusher_waitDone && stageB_flusher_counter[0]); // @[DataCache.scala 864:26]
  assign stageB_isAmo = 1'b0; // @[DataCache.scala 886:48]
  assign stageB_isAmoCached = 1'b0; // @[DataCache.scala 887:54]
  assign stageB_isExternalLsrc = 1'b0; // @[DataCache.scala 888:67]
  assign stageB_isExternalAmo = 1'b0; // @[DataCache.scala 889:67]
  assign stageB_requestDataBypass = io_cpu_writeBack_storeData; // @[Misc.scala 552:9]
  always @(*) begin
    stageB_cpuWriteToCache = 1'b0; // @[DataCache.scala 924:27]
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l991) begin
          if(when_DataCache_l1004) begin
            stageB_cpuWriteToCache = 1'b1; // @[DataCache.scala 1005:27]
          end
        end
      end
    end
  end

  assign when_DataCache_l926 = (stageB_request_wr && stageB_waysHit); // @[BaseType.scala 305:24]
  assign stageB_badPermissions = (((! stageB_mmuRsp_allowWrite) && stageB_request_wr) || ((! stageB_mmuRsp_allowRead) && ((! stageB_request_wr) || stageB_isAmo))); // @[BaseType.scala 305:24]
  assign stageB_loadStoreFault = (io_cpu_writeBack_isValid && (stageB_mmuRsp_exception || stageB_badPermissions)); // @[BaseType.scala 305:24]
  always @(*) begin
    io_cpu_redo = 1'b0; // @[DataCache.scala 937:17]
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l991) begin
          if(when_DataCache_l1004) begin
            if(when_DataCache_l1020) begin
              io_cpu_redo = 1'b1; // @[DataCache.scala 1021:25]
            end
          end
        end
      end
    end
    if(when_DataCache_l1075) begin
      io_cpu_redo = 1'b1; // @[DataCache.scala 1075:17]
    end
    if(when_DataCache_l1122) begin
      io_cpu_redo = 1'b1; // @[DataCache.scala 1122:17]
    end
  end

  always @(*) begin
    io_cpu_writeBack_accessError = 1'b0; // @[DataCache.scala 938:34]
    if(stageB_bypassCache) begin
      io_cpu_writeBack_accessError = ((((! stageB_request_wr) && 1'b1) && io_mem_rsp_valid) && io_mem_rsp_payload_error); // @[DataCache.scala 1045:57]
    end else begin
      io_cpu_writeBack_accessError = (((stageB_waysHits & stageB_tagsReadRsp_0_error) != 1'b0) || (stageB_loadStoreFault && (! stageB_mmuRsp_isPaging))); // @[DataCache.scala 1048:57]
    end
  end

  assign io_cpu_writeBack_mmuException = (stageB_loadStoreFault && stageB_mmuRsp_isPaging); // @[DataCache.scala 939:35]
  assign io_cpu_writeBack_unalignedAccess = (io_cpu_writeBack_isValid && stageB_unaligned); // @[DataCache.scala 940:38]
  assign io_cpu_writeBack_isWrite = stageB_request_wr; // @[DataCache.scala 941:30]
  always @(*) begin
    io_mem_cmd_valid = 1'b0; // @[DataCache.scala 944:22]
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(when_DataCache_l991) begin
          io_mem_cmd_valid = (! memCmdSent); // @[DataCache.scala 997:26]
        end else begin
          if(when_DataCache_l1004) begin
            if(stageB_request_wr) begin
              io_mem_cmd_valid = 1'b1; // @[DataCache.scala 1008:28]
            end
          end else begin
            if(when_DataCache_l1032) begin
              io_mem_cmd_valid = 1'b1; // @[DataCache.scala 1032:28]
            end
          end
        end
      end
    end
    if(when_DataCache_l1066) begin
      io_mem_cmd_valid = 1'b0; // @[DataCache.scala 1067:24]
    end
  end

  always @(*) begin
    io_mem_cmd_payload_address = stageB_mmuRsp_physicalAddress; // @[DataCache.scala 945:24]
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l991) begin
          if(!when_DataCache_l1004) begin
            io_mem_cmd_payload_address[1 : 0] = 2'b00; // @[DataCache.scala 1034:53]
          end
        end
      end
    end
  end

  assign io_mem_cmd_payload_last = 1'b1; // @[DataCache.scala 946:21]
  always @(*) begin
    io_mem_cmd_payload_wr = stageB_request_wr; // @[DataCache.scala 947:19]
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l991) begin
          if(!when_DataCache_l1004) begin
            io_mem_cmd_payload_wr = 1'b0; // @[DataCache.scala 1033:25]
          end
        end
      end
    end
  end

  assign io_mem_cmd_payload_mask = stageB_mask; // @[DataCache.scala 948:21]
  assign io_mem_cmd_payload_data = stageB_requestDataBypass; // @[DataCache.scala 949:21]
  assign io_mem_cmd_payload_uncached = stageB_mmuRsp_isIoAccess; // @[DataCache.scala 950:25]
  always @(*) begin
    io_mem_cmd_payload_size = stageB_request_size; // @[DataCache.scala 951:21]
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l991) begin
          if(!when_DataCache_l1004) begin
            io_mem_cmd_payload_size = 2'b10; // @[DataCache.scala 1035:27]
          end
        end
      end
    end
  end

  assign stageB_bypassCache = ((stageB_mmuRsp_isIoAccess || stageB_isExternalLsrc) || stageB_isExternalAmo); // @[BaseType.scala 305:24]
  assign io_cpu_writeBack_keepMemRspData = 1'b0; // @[DataCache.scala 957:37]
  assign when_DataCache_l995 = ((! stageB_request_wr) ? (io_mem_rsp_valid && rspSync) : io_mem_cmd_ready); // @[Expression.scala 1420:25]
  assign when_DataCache_l1004 = (stageB_waysHit || (stageB_request_wr && (! stageB_isAmoCached))); // @[BaseType.scala 305:24]
  assign when_DataCache_l1009 = ((! stageB_request_wr) || io_mem_cmd_ready); // @[BaseType.scala 305:24]
  assign when_DataCache_l1020 = (((! stageB_request_wr) || stageB_isAmoCached) && ((stageB_dataColisions & stageB_waysHits) != 1'b0)); // @[BaseType.scala 305:24]
  assign when_DataCache_l1032 = (! memCmdSent); // @[BaseType.scala 299:24]
  assign when_DataCache_l991 = (stageB_mmuRsp_isIoAccess || stageB_isExternalLsrc); // @[BaseType.scala 305:24]
  always @(*) begin
    if(stageB_bypassCache) begin
      io_cpu_writeBack_data = stageB_ioMemRspMuxed; // @[DataCache.scala 1043:29]
    end else begin
      io_cpu_writeBack_data = stageB_dataMux; // @[DataCache.scala 1047:29]
    end
  end

  assign when_DataCache_l1066 = ((((stageB_consistancyHazard || stageB_mmuRsp_refilling) || io_cpu_writeBack_accessError) || io_cpu_writeBack_mmuException) || io_cpu_writeBack_unalignedAccess); // @[BaseType.scala 305:24]
  assign when_DataCache_l1075 = (io_cpu_writeBack_isValid && (stageB_mmuRsp_refilling || stageB_consistancyHazard)); // @[BaseType.scala 305:24]
  always @(*) begin
    loader_counter_willIncrement = 1'b0; // @[Utils.scala 536:23]
    if(when_DataCache_l1090) begin
      loader_counter_willIncrement = 1'b1; // @[Utils.scala 540:41]
    end
  end

  assign loader_counter_willClear = 1'b0; // @[Utils.scala 537:19]
  assign loader_counter_willOverflowIfInc = 1'b1; // @[BaseType.scala 305:24]
  assign loader_counter_willOverflow = (loader_counter_willOverflowIfInc && loader_counter_willIncrement); // @[BaseType.scala 305:24]
  assign loader_kill = 1'b0; // @[DataCache.scala 1087:16]
  assign when_DataCache_l1090 = ((loader_valid && io_mem_rsp_valid) && rspLast); // @[BaseType.scala 305:24]
  assign loader_done = loader_counter_willOverflow; // @[Misc.scala 552:9]
  assign when_DataCache_l1118 = (! loader_valid); // @[BaseType.scala 299:24]
  assign when_DataCache_l1122 = (loader_valid && (! loader_valid_regNext)); // @[BaseType.scala 305:24]
  assign io_cpu_execute_refilling = loader_valid; // @[DataCache.scala 1123:30]
  assign when_DataCache_l1125 = (stageB_loaderValid || loader_valid); // @[BaseType.scala 305:24]
  assign _zz_ways_0_tagsReadRsp_valid_1 = _zz_ways_0_tagsReadRsp_valid_3; // @[Phase.scala 647:23]
  assign _zz_ways_0_dataReadRspMem_1 = _zz_ways_0_dataReadRspMem_3; // @[Phase.scala 647:23]
  assign when_Phase_l655 = dataWriteCmd_payload_mask[0]; // @[BaseType.scala 305:24]
  assign when_Phase_l655_1 = dataWriteCmd_payload_mask[1]; // @[BaseType.scala 305:24]
  assign when_Phase_l655_2 = dataWriteCmd_payload_mask[2]; // @[BaseType.scala 305:24]
  assign when_Phase_l655_3 = dataWriteCmd_payload_mask[3]; // @[BaseType.scala 305:24]
  always @(posedge clk) begin
    tagsWriteLastCmd_valid <= tagsWriteCmd_valid; // @[Reg.scala 39:30]
    tagsWriteLastCmd_payload_way <= tagsWriteCmd_payload_way; // @[Reg.scala 39:30]
    tagsWriteLastCmd_payload_data_valid <= tagsWriteCmd_payload_data_valid; // @[Reg.scala 39:30]
    tagsWriteLastCmd_payload_data_error <= tagsWriteCmd_payload_data_error; // @[Reg.scala 39:30]
    tagsWriteLastCmd_payload_data_address <= tagsWriteCmd_payload_data_address; // @[Reg.scala 39:30]
    if(when_DataCache_l771) begin
      stageA_request_wr <= io_cpu_execute_args_wr; // @[DataCache.scala 771:96]
      stageA_request_size <= io_cpu_execute_args_size; // @[DataCache.scala 771:96]
      stageA_request_totalyConsistent <= io_cpu_execute_args_totalyConsistent; // @[DataCache.scala 771:96]
    end
    if(when_DataCache_l771_1) begin
      stageA_mask <= stage0_mask; // @[DataCache.scala 771:96]
    end
    if(when_DataCache_l771_2) begin
      stageA_wayInvalidate <= stage0_wayInvalidate; // @[DataCache.scala 771:96]
    end
    if(when_DataCache_l771_3) begin
      stage0_dataColisions_regNextWhen <= stage0_dataColisions; // @[DataCache.scala 771:96]
    end
    if(when_DataCache_l822) begin
      stageB_request_wr <= stageA_request_wr; // @[DataCache.scala 822:30]
      stageB_request_size <= stageA_request_size; // @[DataCache.scala 822:30]
      stageB_request_totalyConsistent <= stageA_request_totalyConsistent; // @[DataCache.scala 822:30]
    end
    if(when_DataCache_l824) begin
      stageB_mmuRsp_physicalAddress <= io_cpu_memory_mmuRsp_physicalAddress; // @[DataCache.scala 824:29]
      stageB_mmuRsp_isIoAccess <= io_cpu_memory_mmuRsp_isIoAccess; // @[DataCache.scala 824:29]
      stageB_mmuRsp_isPaging <= io_cpu_memory_mmuRsp_isPaging; // @[DataCache.scala 824:29]
      stageB_mmuRsp_allowRead <= io_cpu_memory_mmuRsp_allowRead; // @[DataCache.scala 824:29]
      stageB_mmuRsp_allowWrite <= io_cpu_memory_mmuRsp_allowWrite; // @[DataCache.scala 824:29]
      stageB_mmuRsp_allowExecute <= io_cpu_memory_mmuRsp_allowExecute; // @[DataCache.scala 824:29]
      stageB_mmuRsp_exception <= io_cpu_memory_mmuRsp_exception; // @[DataCache.scala 824:29]
      stageB_mmuRsp_refilling <= io_cpu_memory_mmuRsp_refilling; // @[DataCache.scala 824:29]
      stageB_mmuRsp_bypassTranslation <= io_cpu_memory_mmuRsp_bypassTranslation; // @[DataCache.scala 824:29]
    end
    if(when_DataCache_l821) begin
      stageB_tagsReadRsp_0_valid <= ways_0_tagsReadRsp_valid; // @[DataCache.scala 821:95]
      stageB_tagsReadRsp_0_error <= ways_0_tagsReadRsp_error; // @[DataCache.scala 821:95]
      stageB_tagsReadRsp_0_address <= ways_0_tagsReadRsp_address; // @[DataCache.scala 821:95]
    end
    if(when_DataCache_l821_1) begin
      stageB_dataReadRsp_0 <= ways_0_dataReadRsp; // @[DataCache.scala 821:95]
    end
    if(when_DataCache_l820) begin
      stageB_wayInvalidate <= stageA_wayInvalidate; // @[DataCache.scala 820:53]
    end
    if(when_DataCache_l820_1) begin
      stageB_dataColisions <= stageA_dataColisions; // @[DataCache.scala 820:53]
    end
    if(when_DataCache_l820_2) begin
      stageB_unaligned <= ({((stageA_request_size == 2'b10) && (io_cpu_memory_address[1 : 0] != 2'b00)),((stageA_request_size == 2'b01) && (io_cpu_memory_address[0 : 0] != 1'b0))} != 2'b00); // @[DataCache.scala 820:53]
    end
    if(when_DataCache_l820_3) begin
      stageB_waysHitsBeforeInvalidate <= stageA_wayHits; // @[DataCache.scala 820:53]
    end
    if(when_DataCache_l820_4) begin
      stageB_mask <= stageA_mask; // @[DataCache.scala 820:53]
    end
    loader_valid_regNext <= loader_valid; // @[Reg.scala 39:30]
    if(when_Phase_l675) begin
      _zz_ways_0_tagsReadRsp_valid_2 <= _zz_ways_0_tagsReadRsp_valid_1; // @[Phase.scala 676:24]
    end
    if(when_Phase_l648_1) begin
      _zz_ways_0_tagsReadRsp_valid_3 <= {tagsWriteCmd_payload_data_address,{tagsWriteCmd_payload_data_error,tagsWriteCmd_payload_data_valid}}; // @[Phase.scala 650:27]
    end
    if(when_Phase_l675_1) begin
      _zz_ways_0_dataReadRspMem_2 <= _zz_ways_0_dataReadRspMem_1; // @[Phase.scala 676:24]
    end
    if(when_Phase_l648) begin
      if(when_Phase_l655) begin
        _zz_ways_0_dataReadRspMem_3[7 : 0] <= _zz_ways_0_dataReadRspMem[7 : 0]; // @[Phase.scala 656:30]
      end
      if(when_Phase_l655_1) begin
        _zz_ways_0_dataReadRspMem_3[15 : 8] <= _zz_ways_0_dataReadRspMem[15 : 8]; // @[Phase.scala 656:30]
      end
      if(when_Phase_l655_2) begin
        _zz_ways_0_dataReadRspMem_3[23 : 16] <= _zz_ways_0_dataReadRspMem[23 : 16]; // @[Phase.scala 656:30]
      end
      if(when_Phase_l655_3) begin
        _zz_ways_0_dataReadRspMem_3[31 : 24] <= _zz_ways_0_dataReadRspMem[31 : 24]; // @[Phase.scala 656:30]
      end
    end
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      memCmdSent <= 1'b0; // @[Data.scala 400:33]
      stageB_flusher_waitDone <= 1'b0; // @[Data.scala 400:33]
      stageB_flusher_counter <= 1'b0; // @[Data.scala 400:33]
      stageB_flusher_start <= 1'b1; // @[Data.scala 400:33]
      loader_valid <= 1'b0; // @[Data.scala 400:33]
      loader_waysAllocator <= 1'b1; // @[Data.scala 400:33]
      loader_error <= 1'b0; // @[Data.scala 400:33]
      loader_killReg <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(io_mem_cmd_fire) begin
        memCmdSent <= 1'b1; // @[DataCache.scala 686:35]
      end
      if(when_DataCache_l686) begin
        memCmdSent <= 1'b0; // @[DataCache.scala 686:61]
      end
      if(io_cpu_flush_ready) begin
        stageB_flusher_waitDone <= 1'b0; // @[DataCache.scala 847:37]
      end
      if(when_DataCache_l850) begin
        if(when_DataCache_l856) begin
          stageB_flusher_counter <= (stageB_flusher_counter + 1'b1); // @[DataCache.scala 857:19]
          if(io_cpu_flush_payload_singleLine) begin
            stageB_flusher_counter[0] <= 1'b1; // @[DataCache.scala 859:25]
          end
        end
      end
      stageB_flusher_start <= (((((((! stageB_flusher_waitDone) && (! stageB_flusher_start)) && io_cpu_flush_valid) && (! io_cpu_execute_isValid)) && (! io_cpu_memory_isValid)) && (! io_cpu_writeBack_isValid)) && (! io_cpu_redo)); // @[DataCache.scala 867:13]
      if(stageB_flusher_start) begin
        stageB_flusher_waitDone <= 1'b1; // @[DataCache.scala 870:18]
        stageB_flusher_counter <= 1'b0; // @[DataCache.scala 871:17]
        if(io_cpu_flush_payload_singleLine) begin
          stageB_flusher_counter <= 1'b0; // @[DataCache.scala 873:19]
        end
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! ((io_cpu_writeBack_isValid && (! io_cpu_writeBack_haltIt)) && io_cpu_writeBack_isStuck))); // DataCache.scala:L1077
        `else
          if(!(! ((io_cpu_writeBack_isValid && (! io_cpu_writeBack_haltIt)) && io_cpu_writeBack_isStuck))) begin
            $display("ERROR writeBack stuck by another plugin is not allowed"); // DataCache.scala:L1077
          end
        `endif
      `endif
      if(stageB_loaderValid) begin
        loader_valid <= 1'b1; // @[DataCache.scala 1081:32]
      end
      if(loader_kill) begin
        loader_killReg <= 1'b1; // @[DataCache.scala 1088:34]
      end
      if(when_DataCache_l1090) begin
        loader_error <= (loader_error || io_mem_rsp_payload_error); // @[DataCache.scala 1096:13]
      end
      if(loader_done) begin
        loader_valid <= 1'b0; // @[DataCache.scala 1104:13]
        loader_error <= 1'b0; // @[DataCache.scala 1114:13]
        loader_killReg <= 1'b0; // @[DataCache.scala 1115:15]
      end
      if(when_DataCache_l1118) begin
        loader_waysAllocator <= _zz_loader_waysAllocator[0:0]; // @[DataCache.scala 1119:21]
      end
    end
  end


endmodule

module InstructionCache (
  input               io_flush,
  input               io_cpu_prefetch_isValid,
  output reg          io_cpu_prefetch_haltIt,
  input      [31:0]   io_cpu_prefetch_pc,
  input               io_cpu_fetch_isValid,
  input               io_cpu_fetch_isStuck,
  input               io_cpu_fetch_isRemoved,
  input      [31:0]   io_cpu_fetch_pc,
  output     [31:0]   io_cpu_fetch_data,
  input      [31:0]   io_cpu_fetch_mmuRsp_physicalAddress,
  input               io_cpu_fetch_mmuRsp_isIoAccess,
  input               io_cpu_fetch_mmuRsp_isPaging,
  input               io_cpu_fetch_mmuRsp_allowRead,
  input               io_cpu_fetch_mmuRsp_allowWrite,
  input               io_cpu_fetch_mmuRsp_allowExecute,
  input               io_cpu_fetch_mmuRsp_exception,
  input               io_cpu_fetch_mmuRsp_refilling,
  input               io_cpu_fetch_mmuRsp_bypassTranslation,
  output     [31:0]   io_cpu_fetch_physicalAddress,
  input               io_cpu_decode_isValid,
  input               io_cpu_decode_isStuck,
  input      [31:0]   io_cpu_decode_pc,
  output     [31:0]   io_cpu_decode_physicalAddress,
  output     [31:0]   io_cpu_decode_data,
  output              io_cpu_decode_cacheMiss,
  output              io_cpu_decode_error,
  output              io_cpu_decode_mmuRefilling,
  output              io_cpu_decode_mmuException,
  input               io_cpu_decode_isUser,
  input               io_cpu_fill_valid,
  input      [31:0]   io_cpu_fill_payload,
  output              io_mem_cmd_valid,
  input               io_mem_cmd_ready,
  output     [31:0]   io_mem_cmd_payload_address,
  output     [2:0]    io_mem_cmd_payload_size,
  input               io_mem_rsp_valid,
  input      [31:0]   io_mem_rsp_payload_data,
  input               io_mem_rsp_payload_error,
  input      [2:0]    _zz_when_Fetcher_l401,
  input      [31:0]   _zz_decodeStage_hit_data_1,
  input               clk,
  input               reset
);

  reg        [31:0]   _zz_banks_0_port1;
  reg        [21:0]   _zz_ways_0_tags_port1;
  wire       [21:0]   _zz_ways_0_tags_port;
  reg                 _zz_1;
  reg                 _zz_2;
  reg                 lineLoader_fire;
  reg                 lineLoader_valid;
  (* keep , syn_keep *) reg        [31:0]   lineLoader_address /* synthesis syn_keep = 1 */ ;
  reg                 lineLoader_hadError;
  reg                 lineLoader_flushPending;
  reg        [7:0]    lineLoader_flushCounter;
  wire                when_InstructionCache_l338;
  reg                 _zz_when_InstructionCache_l342;
  wire                when_InstructionCache_l342;
  wire                when_InstructionCache_l351;
  reg                 lineLoader_cmdSent;
  wire                io_mem_cmd_fire;
  wire                when_Utils_l520;
  reg                 lineLoader_wayToAllocate_willIncrement;
  wire                lineLoader_wayToAllocate_willClear;
  wire                lineLoader_wayToAllocate_willOverflowIfInc;
  wire                lineLoader_wayToAllocate_willOverflow;
  (* keep , syn_keep *) reg        [2:0]    lineLoader_wordIndex /* synthesis syn_keep = 1 */ ;
  wire                lineLoader_write_tag_0_valid;
  wire       [6:0]    lineLoader_write_tag_0_payload_address;
  wire                lineLoader_write_tag_0_payload_data_valid;
  wire                lineLoader_write_tag_0_payload_data_error;
  wire       [19:0]   lineLoader_write_tag_0_payload_data_address;
  wire                lineLoader_write_data_0_valid;
  wire       [9:0]    lineLoader_write_data_0_payload_address;
  wire       [31:0]   lineLoader_write_data_0_payload_data;
  wire                when_InstructionCache_l401;
  wire       [9:0]    _zz_fetchStage_read_banksValue_0_dataMem;
  wire                _zz_fetchStage_read_banksValue_0_dataMem_1;
  wire       [31:0]   fetchStage_read_banksValue_0_dataMem;
  wire       [31:0]   fetchStage_read_banksValue_0_data;
  wire       [6:0]    _zz_fetchStage_read_waysValues_0_tag_valid;
  wire                _zz_fetchStage_read_waysValues_0_tag_valid_1;
  wire                fetchStage_read_waysValues_0_tag_valid;
  wire                fetchStage_read_waysValues_0_tag_error;
  wire       [19:0]   fetchStage_read_waysValues_0_tag_address;
  wire       [21:0]   _zz_fetchStage_read_waysValues_0_tag_valid_2;
  wire                when_InstructionCache_l459;
  reg        [31:0]   decodeStage_mmuRsp_physicalAddress;
  reg                 decodeStage_mmuRsp_isIoAccess;
  reg                 decodeStage_mmuRsp_isPaging;
  reg                 decodeStage_mmuRsp_allowRead;
  reg                 decodeStage_mmuRsp_allowWrite;
  reg                 decodeStage_mmuRsp_allowExecute;
  reg                 decodeStage_mmuRsp_exception;
  reg                 decodeStage_mmuRsp_refilling;
  reg                 decodeStage_mmuRsp_bypassTranslation;
  wire                when_InstructionCache_l459_1;
  reg                 decodeStage_hit_tags_0_valid;
  reg                 decodeStage_hit_tags_0_error;
  reg        [19:0]   decodeStage_hit_tags_0_address;
  wire                decodeStage_hit_hits_0;
  wire                decodeStage_hit_valid;
  wire                when_InstructionCache_l459_2;
  reg        [31:0]   _zz_decodeStage_hit_data;
  wire       [31:0]   decodeStage_hit_data;
  wire                when_Fetcher_l401;
  reg [31:0] banks_0 [0:1023];
  reg [21:0] ways_0_tags [0:127];

  assign _zz_ways_0_tags_port = {lineLoader_write_tag_0_payload_data_address,{lineLoader_write_tag_0_payload_data_error,lineLoader_write_tag_0_payload_data_valid}};
  always @(posedge clk) begin
    if(_zz_1) begin
      banks_0[lineLoader_write_data_0_payload_address] <= lineLoader_write_data_0_payload_data;
    end
  end

  always @(posedge clk) begin
    if(_zz_fetchStage_read_banksValue_0_dataMem_1) begin
      _zz_banks_0_port1 <= banks_0[_zz_fetchStage_read_banksValue_0_dataMem];
    end
  end

  always @(posedge clk) begin
    if(_zz_2) begin
      ways_0_tags[lineLoader_write_tag_0_payload_address] <= _zz_ways_0_tags_port;
    end
  end

  always @(posedge clk) begin
    if(_zz_fetchStage_read_waysValues_0_tag_valid_1) begin
      _zz_ways_0_tags_port1 <= ways_0_tags[_zz_fetchStage_read_waysValues_0_tag_valid];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0; // @[when.scala 47:16]
    if(lineLoader_write_data_0_valid) begin
      _zz_1 = 1'b1; // @[when.scala 52:10]
    end
  end

  always @(*) begin
    _zz_2 = 1'b0; // @[when.scala 47:16]
    if(lineLoader_write_tag_0_valid) begin
      _zz_2 = 1'b1; // @[when.scala 52:10]
    end
  end

  always @(*) begin
    lineLoader_fire = 1'b0; // @[InstructionCache.scala 324:16]
    if(io_mem_rsp_valid) begin
      if(when_InstructionCache_l401) begin
        lineLoader_fire = 1'b1; // @[InstructionCache.scala 402:14]
      end
    end
  end

  always @(*) begin
    io_cpu_prefetch_haltIt = (lineLoader_valid || lineLoader_flushPending); // @[InstructionCache.scala 335:28]
    if(when_InstructionCache_l338) begin
      io_cpu_prefetch_haltIt = 1'b1; // @[InstructionCache.scala 339:30]
    end
    if(when_InstructionCache_l342) begin
      io_cpu_prefetch_haltIt = 1'b1; // @[InstructionCache.scala 343:30]
    end
    if(io_flush) begin
      io_cpu_prefetch_haltIt = 1'b1; // @[InstructionCache.scala 347:30]
    end
  end

  assign when_InstructionCache_l338 = (! lineLoader_flushCounter[7]); // @[BaseType.scala 299:24]
  assign when_InstructionCache_l342 = (! _zz_when_InstructionCache_l342); // @[BaseType.scala 299:24]
  assign when_InstructionCache_l351 = (lineLoader_flushPending && (! (lineLoader_valid || io_cpu_fetch_isValid))); // @[BaseType.scala 305:24]
  assign io_mem_cmd_fire = (io_mem_cmd_valid && io_mem_cmd_ready); // @[BaseType.scala 305:24]
  assign io_mem_cmd_valid = (lineLoader_valid && (! lineLoader_cmdSent)); // @[InstructionCache.scala 359:22]
  assign io_mem_cmd_payload_address = {lineLoader_address[31 : 5],5'h0}; // @[InstructionCache.scala 360:24]
  assign io_mem_cmd_payload_size = 3'b101; // @[InstructionCache.scala 361:21]
  assign when_Utils_l520 = (! lineLoader_valid); // @[BaseType.scala 299:24]
  always @(*) begin
    lineLoader_wayToAllocate_willIncrement = 1'b0; // @[Utils.scala 536:23]
    if(when_Utils_l520) begin
      lineLoader_wayToAllocate_willIncrement = 1'b1; // @[Utils.scala 540:41]
    end
  end

  assign lineLoader_wayToAllocate_willClear = 1'b0; // @[Utils.scala 537:19]
  assign lineLoader_wayToAllocate_willOverflowIfInc = 1'b1; // @[BaseType.scala 305:24]
  assign lineLoader_wayToAllocate_willOverflow = (lineLoader_wayToAllocate_willOverflowIfInc && lineLoader_wayToAllocate_willIncrement); // @[BaseType.scala 305:24]
  assign lineLoader_write_tag_0_valid = ((1'b1 && lineLoader_fire) || (! lineLoader_flushCounter[7])); // @[InstructionCache.scala 375:17]
  assign lineLoader_write_tag_0_payload_address = (lineLoader_flushCounter[7] ? lineLoader_address[11 : 5] : lineLoader_flushCounter[6 : 0]); // @[InstructionCache.scala 376:19]
  assign lineLoader_write_tag_0_payload_data_valid = lineLoader_flushCounter[7]; // @[InstructionCache.scala 377:22]
  assign lineLoader_write_tag_0_payload_data_error = (lineLoader_hadError || io_mem_rsp_payload_error); // @[InstructionCache.scala 378:22]
  assign lineLoader_write_tag_0_payload_data_address = lineLoader_address[31 : 12]; // @[InstructionCache.scala 379:24]
  assign lineLoader_write_data_0_valid = (io_mem_rsp_valid && 1'b1); // @[InstructionCache.scala 384:25]
  assign lineLoader_write_data_0_payload_address = {lineLoader_address[11 : 5],lineLoader_wordIndex}; // @[InstructionCache.scala 385:27]
  assign lineLoader_write_data_0_payload_data = io_mem_rsp_payload_data; // @[InstructionCache.scala 386:24]
  assign when_InstructionCache_l401 = (lineLoader_wordIndex == 3'b111); // @[BaseType.scala 305:24]
  assign _zz_fetchStage_read_banksValue_0_dataMem = io_cpu_prefetch_pc[11 : 2]; // @[BaseType.scala 299:24]
  assign _zz_fetchStage_read_banksValue_0_dataMem_1 = (! io_cpu_fetch_isStuck); // @[BaseType.scala 299:24]
  assign fetchStage_read_banksValue_0_dataMem = _zz_banks_0_port1; // @[Bits.scala 133:56]
  assign fetchStage_read_banksValue_0_data = fetchStage_read_banksValue_0_dataMem[31 : 0]; // @[Vec.scala 169:11]
  assign _zz_fetchStage_read_waysValues_0_tag_valid = io_cpu_prefetch_pc[11 : 5]; // @[BaseType.scala 299:24]
  assign _zz_fetchStage_read_waysValues_0_tag_valid_1 = (! io_cpu_fetch_isStuck); // @[BaseType.scala 299:24]
  assign _zz_fetchStage_read_waysValues_0_tag_valid_2 = _zz_ways_0_tags_port1; // @[Mem.scala 310:24]
  assign fetchStage_read_waysValues_0_tag_valid = _zz_fetchStage_read_waysValues_0_tag_valid_2[0]; // @[Bool.scala 189:10]
  assign fetchStage_read_waysValues_0_tag_error = _zz_fetchStage_read_waysValues_0_tag_valid_2[1]; // @[Bool.scala 189:10]
  assign fetchStage_read_waysValues_0_tag_address = _zz_fetchStage_read_waysValues_0_tag_valid_2[21 : 2]; // @[UInt.scala 381:56]
  assign io_cpu_fetch_data = fetchStage_read_banksValue_0_data; // @[InstructionCache.scala 441:25]
  assign io_cpu_fetch_physicalAddress = io_cpu_fetch_mmuRsp_physicalAddress; // @[InstructionCache.scala 444:34]
  assign when_InstructionCache_l459 = (! io_cpu_decode_isStuck); // @[BaseType.scala 299:24]
  assign when_InstructionCache_l459_1 = (! io_cpu_decode_isStuck); // @[BaseType.scala 299:24]
  assign decodeStage_hit_hits_0 = (decodeStage_hit_tags_0_valid && (decodeStage_hit_tags_0_address == decodeStage_mmuRsp_physicalAddress[31 : 12])); // @[BaseType.scala 305:24]
  assign decodeStage_hit_valid = (|decodeStage_hit_hits_0); // @[BaseType.scala 312:24]
  assign when_InstructionCache_l459_2 = (! io_cpu_decode_isStuck); // @[BaseType.scala 299:24]
  assign decodeStage_hit_data = _zz_decodeStage_hit_data; // @[Vec.scala 169:11]
  assign io_cpu_decode_data = decodeStage_hit_data; // @[InstructionCache.scala 477:26]
  assign io_cpu_decode_cacheMiss = (! decodeStage_hit_valid); // @[InstructionCache.scala 480:29]
  assign io_cpu_decode_error = (decodeStage_hit_tags_0_error || ((! decodeStage_mmuRsp_isPaging) && (decodeStage_mmuRsp_exception || (! decodeStage_mmuRsp_allowExecute)))); // @[InstructionCache.scala 481:25]
  assign io_cpu_decode_mmuRefilling = decodeStage_mmuRsp_refilling; // @[InstructionCache.scala 482:32]
  assign io_cpu_decode_mmuException = (((! decodeStage_mmuRsp_refilling) && decodeStage_mmuRsp_isPaging) && (decodeStage_mmuRsp_exception || (! decodeStage_mmuRsp_allowExecute))); // @[InstructionCache.scala 483:32]
  assign io_cpu_decode_physicalAddress = decodeStage_mmuRsp_physicalAddress; // @[InstructionCache.scala 484:35]
  assign when_Fetcher_l401 = (_zz_when_Fetcher_l401 != 3'b000); // @[BaseType.scala 305:24]
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      lineLoader_valid <= 1'b0; // @[Data.scala 400:33]
      lineLoader_hadError <= 1'b0; // @[Data.scala 400:33]
      lineLoader_flushPending <= 1'b1; // @[Data.scala 400:33]
      lineLoader_cmdSent <= 1'b0; // @[Data.scala 400:33]
      lineLoader_wordIndex <= 3'b000; // @[Data.scala 400:33]
    end else begin
      if(lineLoader_fire) begin
        lineLoader_valid <= 1'b0; // @[InstructionCache.scala 325:32]
      end
      if(lineLoader_fire) begin
        lineLoader_hadError <= 1'b0; // @[InstructionCache.scala 327:35]
      end
      if(io_cpu_fill_valid) begin
        lineLoader_valid <= 1'b1; // @[InstructionCache.scala 331:13]
      end
      if(io_flush) begin
        lineLoader_flushPending <= 1'b1; // @[InstructionCache.scala 348:20]
      end
      if(when_InstructionCache_l351) begin
        lineLoader_flushPending <= 1'b0; // @[InstructionCache.scala 353:20]
      end
      if(io_mem_cmd_fire) begin
        lineLoader_cmdSent <= 1'b1; // @[InstructionCache.scala 358:34]
      end
      if(lineLoader_fire) begin
        lineLoader_cmdSent <= 1'b0; // @[InstructionCache.scala 358:59]
      end
      if(io_mem_rsp_valid) begin
        lineLoader_wordIndex <= (lineLoader_wordIndex + 3'b001); // @[InstructionCache.scala 399:17]
        if(io_mem_rsp_payload_error) begin
          lineLoader_hadError <= 1'b1; // @[InstructionCache.scala 400:23]
        end
      end
    end
  end

  always @(posedge clk) begin
    if(io_cpu_fill_valid) begin
      lineLoader_address <= io_cpu_fill_payload; // @[InstructionCache.scala 332:15]
    end
    if(when_InstructionCache_l338) begin
      lineLoader_flushCounter <= (lineLoader_flushCounter + 8'h01); // @[InstructionCache.scala 340:20]
    end
    _zz_when_InstructionCache_l342 <= lineLoader_flushCounter[7]; // @[Reg.scala 39:30]
    if(when_InstructionCache_l351) begin
      lineLoader_flushCounter <= 8'h0; // @[InstructionCache.scala 352:20]
    end
    if(when_InstructionCache_l459) begin
      decodeStage_mmuRsp_physicalAddress <= io_cpu_fetch_mmuRsp_physicalAddress; // @[InstructionCache.scala 459:49]
      decodeStage_mmuRsp_isIoAccess <= io_cpu_fetch_mmuRsp_isIoAccess; // @[InstructionCache.scala 459:49]
      decodeStage_mmuRsp_isPaging <= io_cpu_fetch_mmuRsp_isPaging; // @[InstructionCache.scala 459:49]
      decodeStage_mmuRsp_allowRead <= io_cpu_fetch_mmuRsp_allowRead; // @[InstructionCache.scala 459:49]
      decodeStage_mmuRsp_allowWrite <= io_cpu_fetch_mmuRsp_allowWrite; // @[InstructionCache.scala 459:49]
      decodeStage_mmuRsp_allowExecute <= io_cpu_fetch_mmuRsp_allowExecute; // @[InstructionCache.scala 459:49]
      decodeStage_mmuRsp_exception <= io_cpu_fetch_mmuRsp_exception; // @[InstructionCache.scala 459:49]
      decodeStage_mmuRsp_refilling <= io_cpu_fetch_mmuRsp_refilling; // @[InstructionCache.scala 459:49]
      decodeStage_mmuRsp_bypassTranslation <= io_cpu_fetch_mmuRsp_bypassTranslation; // @[InstructionCache.scala 459:49]
    end
    if(when_InstructionCache_l459_1) begin
      decodeStage_hit_tags_0_valid <= fetchStage_read_waysValues_0_tag_valid; // @[InstructionCache.scala 459:49]
      decodeStage_hit_tags_0_error <= fetchStage_read_waysValues_0_tag_error; // @[InstructionCache.scala 459:49]
      decodeStage_hit_tags_0_address <= fetchStage_read_waysValues_0_tag_address; // @[InstructionCache.scala 459:49]
    end
    if(when_InstructionCache_l459_2) begin
      _zz_decodeStage_hit_data <= fetchStage_read_banksValue_0_data; // @[InstructionCache.scala 459:49]
    end
    if(when_Fetcher_l401) begin
      _zz_decodeStage_hit_data <= _zz_decodeStage_hit_data_1; // @[Fetcher.scala 402:35]
    end
  end


endmodule

module StreamArbiter (
  input               io_inputs_0_valid,
  output              io_inputs_0_ready,
  input      [4:0]    io_inputs_0_payload_rd,
  input      [23:0]   io_inputs_0_payload_value_mantissa,
  input      [8:0]    io_inputs_0_payload_value_exponent,
  input               io_inputs_0_payload_value_sign,
  input               io_inputs_0_payload_value_special,
  input               io_inputs_0_payload_scrap,
  input      [2:0]    io_inputs_0_payload_roundMode,
  input               io_inputs_0_payload_NV,
  input               io_inputs_0_payload_DZ,
  input               io_inputs_1_valid,
  output              io_inputs_1_ready,
  input      [4:0]    io_inputs_1_payload_rd,
  input      [23:0]   io_inputs_1_payload_value_mantissa,
  input      [8:0]    io_inputs_1_payload_value_exponent,
  input               io_inputs_1_payload_value_sign,
  input               io_inputs_1_payload_value_special,
  input               io_inputs_1_payload_scrap,
  input      [2:0]    io_inputs_1_payload_roundMode,
  input               io_inputs_1_payload_NV,
  input               io_inputs_1_payload_DZ,
  input               io_inputs_2_valid,
  output              io_inputs_2_ready,
  input      [4:0]    io_inputs_2_payload_rd,
  input      [23:0]   io_inputs_2_payload_value_mantissa,
  input      [8:0]    io_inputs_2_payload_value_exponent,
  input               io_inputs_2_payload_value_sign,
  input               io_inputs_2_payload_value_special,
  input               io_inputs_2_payload_scrap,
  input      [2:0]    io_inputs_2_payload_roundMode,
  input               io_inputs_2_payload_NV,
  input               io_inputs_2_payload_DZ,
  input               io_inputs_3_valid,
  output              io_inputs_3_ready,
  input      [4:0]    io_inputs_3_payload_rd,
  input      [23:0]   io_inputs_3_payload_value_mantissa,
  input      [8:0]    io_inputs_3_payload_value_exponent,
  input               io_inputs_3_payload_value_sign,
  input               io_inputs_3_payload_value_special,
  input               io_inputs_3_payload_scrap,
  input      [2:0]    io_inputs_3_payload_roundMode,
  input               io_inputs_3_payload_NV,
  input               io_inputs_3_payload_DZ,
  input               io_inputs_4_valid,
  output              io_inputs_4_ready,
  input      [4:0]    io_inputs_4_payload_rd,
  input      [23:0]   io_inputs_4_payload_value_mantissa,
  input      [8:0]    io_inputs_4_payload_value_exponent,
  input               io_inputs_4_payload_value_sign,
  input               io_inputs_4_payload_value_special,
  input               io_inputs_4_payload_scrap,
  input      [2:0]    io_inputs_4_payload_roundMode,
  input               io_inputs_4_payload_NV,
  input               io_inputs_4_payload_DZ,
  input               io_inputs_5_valid,
  output              io_inputs_5_ready,
  input      [4:0]    io_inputs_5_payload_rd,
  input      [23:0]   io_inputs_5_payload_value_mantissa,
  input      [8:0]    io_inputs_5_payload_value_exponent,
  input               io_inputs_5_payload_value_sign,
  input               io_inputs_5_payload_value_special,
  input               io_inputs_5_payload_scrap,
  input      [2:0]    io_inputs_5_payload_roundMode,
  input               io_inputs_5_payload_NV,
  input               io_inputs_5_payload_DZ,
  output              io_output_valid,
  input               io_output_ready,
  output     [4:0]    io_output_payload_rd,
  output     [23:0]   io_output_payload_value_mantissa,
  output     [8:0]    io_output_payload_value_exponent,
  output              io_output_payload_value_sign,
  output              io_output_payload_value_special,
  output              io_output_payload_scrap,
  output     [2:0]    io_output_payload_roundMode,
  output              io_output_payload_NV,
  output              io_output_payload_DZ,
  output     [2:0]    io_chosen,
  output     [5:0]    io_chosenOH,
  input               clk,
  input               reset
);
  localparam FpuRoundMode_RNE = 3'd0;
  localparam FpuRoundMode_RTZ = 3'd1;
  localparam FpuRoundMode_RDN = 3'd2;
  localparam FpuRoundMode_RUP = 3'd3;
  localparam FpuRoundMode_RMM = 3'd4;

  wire       [5:0]    _zz__zz_maskProposal_1_1;
  reg        [2:0]    _zz__zz_io_output_payload_roundMode;
  reg        [4:0]    _zz_io_output_payload_rd_4;
  reg        [23:0]   _zz_io_output_payload_value_mantissa;
  reg        [8:0]    _zz_io_output_payload_value_exponent;
  reg                 _zz_io_output_payload_value_sign;
  reg                 _zz_io_output_payload_value_special;
  reg                 _zz_io_output_payload_scrap;
  reg                 _zz_io_output_payload_NV;
  reg                 _zz_io_output_payload_DZ;
  wire                locked;
  wire                maskProposal_0;
  wire                maskProposal_1;
  wire                maskProposal_2;
  wire                maskProposal_3;
  wire                maskProposal_4;
  wire                maskProposal_5;
  reg                 maskLocked_0;
  reg                 maskLocked_1;
  reg                 maskLocked_2;
  reg                 maskLocked_3;
  reg                 maskLocked_4;
  reg                 maskLocked_5;
  wire                maskRouted_0;
  wire                maskRouted_1;
  wire                maskRouted_2;
  wire                maskRouted_3;
  wire                maskRouted_4;
  wire                maskRouted_5;
  wire       [5:0]    _zz_maskProposal_1;
  wire       [5:0]    _zz_maskProposal_1_1;
  wire                _zz_io_output_payload_rd;
  wire                _zz_io_output_payload_rd_1;
  wire                _zz_io_output_payload_rd_2;
  wire       [2:0]    _zz_io_output_payload_rd_3;
  wire       [2:0]    _zz_io_output_payload_roundMode;
  wire                _zz_io_chosen;
  wire                _zz_io_chosen_1;
  wire                _zz_io_chosen_2;
  wire                _zz_io_chosen_3;
  wire                _zz_io_chosen_4;
  `ifndef SYNTHESIS
  reg [23:0] io_inputs_0_payload_roundMode_string;
  reg [23:0] io_inputs_1_payload_roundMode_string;
  reg [23:0] io_inputs_2_payload_roundMode_string;
  reg [23:0] io_inputs_3_payload_roundMode_string;
  reg [23:0] io_inputs_4_payload_roundMode_string;
  reg [23:0] io_inputs_5_payload_roundMode_string;
  reg [23:0] io_output_payload_roundMode_string;
  reg [23:0] _zz_io_output_payload_roundMode_string;
  `endif


  assign _zz__zz_maskProposal_1_1 = (_zz_maskProposal_1 - 6'h01);
  always @(*) begin
    case(_zz_io_output_payload_rd_3)
      3'b000 : begin
        _zz__zz_io_output_payload_roundMode = io_inputs_0_payload_roundMode;
        _zz_io_output_payload_rd_4 = io_inputs_0_payload_rd;
        _zz_io_output_payload_value_mantissa = io_inputs_0_payload_value_mantissa;
        _zz_io_output_payload_value_exponent = io_inputs_0_payload_value_exponent;
        _zz_io_output_payload_value_sign = io_inputs_0_payload_value_sign;
        _zz_io_output_payload_value_special = io_inputs_0_payload_value_special;
        _zz_io_output_payload_scrap = io_inputs_0_payload_scrap;
        _zz_io_output_payload_NV = io_inputs_0_payload_NV;
        _zz_io_output_payload_DZ = io_inputs_0_payload_DZ;
      end
      3'b001 : begin
        _zz__zz_io_output_payload_roundMode = io_inputs_1_payload_roundMode;
        _zz_io_output_payload_rd_4 = io_inputs_1_payload_rd;
        _zz_io_output_payload_value_mantissa = io_inputs_1_payload_value_mantissa;
        _zz_io_output_payload_value_exponent = io_inputs_1_payload_value_exponent;
        _zz_io_output_payload_value_sign = io_inputs_1_payload_value_sign;
        _zz_io_output_payload_value_special = io_inputs_1_payload_value_special;
        _zz_io_output_payload_scrap = io_inputs_1_payload_scrap;
        _zz_io_output_payload_NV = io_inputs_1_payload_NV;
        _zz_io_output_payload_DZ = io_inputs_1_payload_DZ;
      end
      3'b010 : begin
        _zz__zz_io_output_payload_roundMode = io_inputs_2_payload_roundMode;
        _zz_io_output_payload_rd_4 = io_inputs_2_payload_rd;
        _zz_io_output_payload_value_mantissa = io_inputs_2_payload_value_mantissa;
        _zz_io_output_payload_value_exponent = io_inputs_2_payload_value_exponent;
        _zz_io_output_payload_value_sign = io_inputs_2_payload_value_sign;
        _zz_io_output_payload_value_special = io_inputs_2_payload_value_special;
        _zz_io_output_payload_scrap = io_inputs_2_payload_scrap;
        _zz_io_output_payload_NV = io_inputs_2_payload_NV;
        _zz_io_output_payload_DZ = io_inputs_2_payload_DZ;
      end
      3'b011 : begin
        _zz__zz_io_output_payload_roundMode = io_inputs_3_payload_roundMode;
        _zz_io_output_payload_rd_4 = io_inputs_3_payload_rd;
        _zz_io_output_payload_value_mantissa = io_inputs_3_payload_value_mantissa;
        _zz_io_output_payload_value_exponent = io_inputs_3_payload_value_exponent;
        _zz_io_output_payload_value_sign = io_inputs_3_payload_value_sign;
        _zz_io_output_payload_value_special = io_inputs_3_payload_value_special;
        _zz_io_output_payload_scrap = io_inputs_3_payload_scrap;
        _zz_io_output_payload_NV = io_inputs_3_payload_NV;
        _zz_io_output_payload_DZ = io_inputs_3_payload_DZ;
      end
      3'b100 : begin
        _zz__zz_io_output_payload_roundMode = io_inputs_4_payload_roundMode;
        _zz_io_output_payload_rd_4 = io_inputs_4_payload_rd;
        _zz_io_output_payload_value_mantissa = io_inputs_4_payload_value_mantissa;
        _zz_io_output_payload_value_exponent = io_inputs_4_payload_value_exponent;
        _zz_io_output_payload_value_sign = io_inputs_4_payload_value_sign;
        _zz_io_output_payload_value_special = io_inputs_4_payload_value_special;
        _zz_io_output_payload_scrap = io_inputs_4_payload_scrap;
        _zz_io_output_payload_NV = io_inputs_4_payload_NV;
        _zz_io_output_payload_DZ = io_inputs_4_payload_DZ;
      end
      default : begin
        _zz__zz_io_output_payload_roundMode = io_inputs_5_payload_roundMode;
        _zz_io_output_payload_rd_4 = io_inputs_5_payload_rd;
        _zz_io_output_payload_value_mantissa = io_inputs_5_payload_value_mantissa;
        _zz_io_output_payload_value_exponent = io_inputs_5_payload_value_exponent;
        _zz_io_output_payload_value_sign = io_inputs_5_payload_value_sign;
        _zz_io_output_payload_value_special = io_inputs_5_payload_value_special;
        _zz_io_output_payload_scrap = io_inputs_5_payload_scrap;
        _zz_io_output_payload_NV = io_inputs_5_payload_NV;
        _zz_io_output_payload_DZ = io_inputs_5_payload_DZ;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(io_inputs_0_payload_roundMode)
      FpuRoundMode_RNE : io_inputs_0_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : io_inputs_0_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : io_inputs_0_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : io_inputs_0_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : io_inputs_0_payload_roundMode_string = "RMM";
      default : io_inputs_0_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_inputs_1_payload_roundMode)
      FpuRoundMode_RNE : io_inputs_1_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : io_inputs_1_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : io_inputs_1_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : io_inputs_1_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : io_inputs_1_payload_roundMode_string = "RMM";
      default : io_inputs_1_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_inputs_2_payload_roundMode)
      FpuRoundMode_RNE : io_inputs_2_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : io_inputs_2_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : io_inputs_2_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : io_inputs_2_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : io_inputs_2_payload_roundMode_string = "RMM";
      default : io_inputs_2_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_inputs_3_payload_roundMode)
      FpuRoundMode_RNE : io_inputs_3_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : io_inputs_3_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : io_inputs_3_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : io_inputs_3_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : io_inputs_3_payload_roundMode_string = "RMM";
      default : io_inputs_3_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_inputs_4_payload_roundMode)
      FpuRoundMode_RNE : io_inputs_4_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : io_inputs_4_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : io_inputs_4_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : io_inputs_4_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : io_inputs_4_payload_roundMode_string = "RMM";
      default : io_inputs_4_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_inputs_5_payload_roundMode)
      FpuRoundMode_RNE : io_inputs_5_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : io_inputs_5_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : io_inputs_5_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : io_inputs_5_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : io_inputs_5_payload_roundMode_string = "RMM";
      default : io_inputs_5_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_output_payload_roundMode)
      FpuRoundMode_RNE : io_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : io_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : io_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : io_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : io_output_payload_roundMode_string = "RMM";
      default : io_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_payload_roundMode)
      FpuRoundMode_RNE : _zz_io_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : _zz_io_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : _zz_io_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : _zz_io_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : _zz_io_output_payload_roundMode_string = "RMM";
      default : _zz_io_output_payload_roundMode_string = "???";
    endcase
  end
  `endif

  assign locked = 1'b0;
  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0); // @[Expression.scala 1420:25]
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1); // @[Expression.scala 1420:25]
  assign maskRouted_2 = (locked ? maskLocked_2 : maskProposal_2); // @[Expression.scala 1420:25]
  assign maskRouted_3 = (locked ? maskLocked_3 : maskProposal_3); // @[Expression.scala 1420:25]
  assign maskRouted_4 = (locked ? maskLocked_4 : maskProposal_4); // @[Expression.scala 1420:25]
  assign maskRouted_5 = (locked ? maskLocked_5 : maskProposal_5); // @[Expression.scala 1420:25]
  assign _zz_maskProposal_1 = {io_inputs_5_valid,{io_inputs_4_valid,{io_inputs_3_valid,{io_inputs_2_valid,{io_inputs_1_valid,io_inputs_0_valid}}}}}; // @[BaseType.scala 318:22]
  assign _zz_maskProposal_1_1 = (_zz_maskProposal_1 & (~ _zz__zz_maskProposal_1_1)); // @[Bits.scala 133:56]
  assign maskProposal_0 = io_inputs_0_valid; // @[Stream.scala 612:20]
  assign maskProposal_1 = _zz_maskProposal_1_1[1]; // @[Stream.scala 612:20]
  assign maskProposal_2 = _zz_maskProposal_1_1[2]; // @[Stream.scala 612:20]
  assign maskProposal_3 = _zz_maskProposal_1_1[3]; // @[Stream.scala 612:20]
  assign maskProposal_4 = _zz_maskProposal_1_1[4]; // @[Stream.scala 612:20]
  assign maskProposal_5 = _zz_maskProposal_1_1[5]; // @[Stream.scala 612:20]
  assign io_output_valid = ((((((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1)) || (io_inputs_2_valid && maskRouted_2)) || (io_inputs_3_valid && maskRouted_3)) || (io_inputs_4_valid && maskRouted_4)) || (io_inputs_5_valid && maskRouted_5)); // @[Stream.scala 693:19]
  assign _zz_io_output_payload_rd = ((maskRouted_1 || maskRouted_3) || maskRouted_5); // @[BaseType.scala 305:24]
  assign _zz_io_output_payload_rd_1 = (maskRouted_2 || maskRouted_3); // @[BaseType.scala 305:24]
  assign _zz_io_output_payload_rd_2 = (maskRouted_4 || maskRouted_5); // @[BaseType.scala 305:24]
  assign _zz_io_output_payload_rd_3 = {_zz_io_output_payload_rd_2,{_zz_io_output_payload_rd_1,_zz_io_output_payload_rd}}; // @[BaseType.scala 318:22]
  assign _zz_io_output_payload_roundMode = _zz__zz_io_output_payload_roundMode; // @[Vec.scala 202:25]
  assign io_output_payload_rd = _zz_io_output_payload_rd_4; // @[Stream.scala 694:21]
  assign io_output_payload_value_mantissa = _zz_io_output_payload_value_mantissa; // @[Stream.scala 694:21]
  assign io_output_payload_value_exponent = _zz_io_output_payload_value_exponent; // @[Stream.scala 694:21]
  assign io_output_payload_value_sign = _zz_io_output_payload_value_sign; // @[Stream.scala 694:21]
  assign io_output_payload_value_special = _zz_io_output_payload_value_special; // @[Stream.scala 694:21]
  assign io_output_payload_scrap = _zz_io_output_payload_scrap; // @[Stream.scala 694:21]
  assign io_output_payload_roundMode = _zz_io_output_payload_roundMode; // @[Stream.scala 694:21]
  assign io_output_payload_NV = _zz_io_output_payload_NV; // @[Stream.scala 694:21]
  assign io_output_payload_DZ = _zz_io_output_payload_DZ; // @[Stream.scala 694:21]
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready); // @[Stream.scala 695:50]
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready); // @[Stream.scala 695:50]
  assign io_inputs_2_ready = (maskRouted_2 && io_output_ready); // @[Stream.scala 695:50]
  assign io_inputs_3_ready = (maskRouted_3 && io_output_ready); // @[Stream.scala 695:50]
  assign io_inputs_4_ready = (maskRouted_4 && io_output_ready); // @[Stream.scala 695:50]
  assign io_inputs_5_ready = (maskRouted_5 && io_output_ready); // @[Stream.scala 695:50]
  assign io_chosenOH = {maskRouted_5,{maskRouted_4,{maskRouted_3,{maskRouted_2,{maskRouted_1,maskRouted_0}}}}}; // @[Stream.scala 697:15]
  assign _zz_io_chosen = io_chosenOH[3]; // @[BaseType.scala 305:24]
  assign _zz_io_chosen_1 = io_chosenOH[5]; // @[BaseType.scala 305:24]
  assign _zz_io_chosen_2 = ((io_chosenOH[1] || _zz_io_chosen) || _zz_io_chosen_1); // @[BaseType.scala 305:24]
  assign _zz_io_chosen_3 = (io_chosenOH[2] || _zz_io_chosen); // @[BaseType.scala 305:24]
  assign _zz_io_chosen_4 = (io_chosenOH[4] || _zz_io_chosen_1); // @[BaseType.scala 305:24]
  assign io_chosen = {_zz_io_chosen_4,{_zz_io_chosen_3,_zz_io_chosen_2}}; // @[Stream.scala 698:13]
  always @(posedge clk) begin
    if(io_output_valid) begin
      maskLocked_0 <= maskRouted_0; // @[Stream.scala 687:16]
      maskLocked_1 <= maskRouted_1; // @[Stream.scala 687:16]
      maskLocked_2 <= maskRouted_2; // @[Stream.scala 687:16]
      maskLocked_3 <= maskRouted_3; // @[Stream.scala 687:16]
      maskLocked_4 <= maskRouted_4; // @[Stream.scala 687:16]
      maskLocked_5 <= maskRouted_5; // @[Stream.scala 687:16]
    end
  end


endmodule

module FpuSqrt (
  input               io_input_valid,
  output              io_input_ready,
  input      [24:0]   io_input_payload_a,
  output              io_output_valid,
  input               io_output_ready,
  output     [23:0]   io_output_payload_result,
  output     [27:0]   io_output_payload_remain,
  input               clk,
  input               reset
);

  wire       [27:0]   _zz_t;
  wire       [25:0]   _zz_t_1;
  wire       [24:0]   _zz_q;
  wire       [29:0]   _zz_a_1;
  wire       [1:0]    _zz_a_2;
  reg        [4:0]    counter;
  reg                 busy;
  wire                io_output_fire;
  reg                 done;
  wire                when_FpuSqrt_l28;
  wire                io_output_fire_1;
  reg        [27:0]   a;
  reg        [22:0]   x;
  reg        [23:0]   q;
  wire       [27:0]   t;
  wire                when_FpuSqrt_l41;
  reg        [27:0]   _zz_a;
  wire                when_FpuSqrt_l44;
  wire                when_FpuSqrt_l52;

  assign _zz_t_1 = {q,2'b01};
  assign _zz_t = {2'd0, _zz_t_1};
  assign _zz_q = {q,(! t[27])};
  assign _zz_a_1 = {_zz_a,x[22 : 21]};
  assign _zz_a_2 = io_input_payload_a[24 : 23];
  assign io_output_fire = (io_output_valid && io_output_ready); // @[BaseType.scala 305:24]
  assign when_FpuSqrt_l28 = (busy && (counter == 5'h18)); // @[BaseType.scala 305:24]
  assign io_output_fire_1 = (io_output_valid && io_output_ready); // @[BaseType.scala 305:24]
  assign t = (a - _zz_t); // @[BaseType.scala 299:24]
  assign io_output_valid = done; // @[FpuSqrt.scala 36:19]
  assign io_output_payload_result = q; // @[FpuSqrt.scala 37:20]
  assign io_output_payload_remain = a; // @[FpuSqrt.scala 38:20]
  assign io_input_ready = (! busy); // @[FpuSqrt.scala 39:18]
  assign when_FpuSqrt_l41 = (! done); // @[BaseType.scala 299:24]
  always @(*) begin
    _zz_a = a; // @[Misc.scala 552:9]
    if(when_FpuSqrt_l44) begin
      _zz_a = t; // @[FpuSqrt.scala 45:11]
    end
  end

  assign when_FpuSqrt_l44 = (! t[27]); // @[BaseType.scala 299:24]
  assign when_FpuSqrt_l52 = (! busy); // @[BaseType.scala 299:24]
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      busy <= 1'b0; // @[Data.scala 400:33]
      done <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(io_output_fire) begin
        busy <= 1'b0; // @[FpuSqrt.scala 27:29]
      end
      if(when_FpuSqrt_l28) begin
        done <= 1'b1; // @[FpuSqrt.scala 28:29]
      end
      if(io_output_fire_1) begin
        done <= 1'b0; // @[FpuSqrt.scala 28:71]
      end
      if(when_FpuSqrt_l52) begin
        if(io_input_valid) begin
          busy <= 1'b1; // @[FpuSqrt.scala 58:12]
        end
      end
    end
  end

  always @(posedge clk) begin
    if(when_FpuSqrt_l41) begin
      counter <= (counter + 5'h01); // @[FpuSqrt.scala 42:13]
      q <= _zz_q[23:0]; // @[FpuSqrt.scala 47:7]
      a <= _zz_a_1[27:0]; // @[FpuSqrt.scala 48:7]
      x <= (x <<< 2); // @[FpuSqrt.scala 49:7]
    end
    if(when_FpuSqrt_l52) begin
      q <= 24'h0; // @[FpuSqrt.scala 53:7]
      a <= {26'd0, _zz_a_2}; // @[FpuSqrt.scala 54:7]
      x <= io_input_payload_a[22:0]; // @[FpuSqrt.scala 55:7]
      counter <= 5'h0; // @[FpuSqrt.scala 56:13]
    end
  end


endmodule

module FpuDiv (
  input               io_input_valid,
  output              io_input_ready,
  input      [23:0]   io_input_payload_a,
  input      [23:0]   io_input_payload_b,
  output              io_output_valid,
  input               io_output_ready,
  output     [26:0]   io_output_payload_result,
  output     [24:0]   io_output_payload_remain,
  input               clk,
  input               reset
);

  wire       [24:0]   _zz_shifter_1;
  wire       [24:0]   _zz_div1;
  wire       [26:0]   _zz_div3;
  wire       [25:0]   _zz_div3_1;
  wire       [25:0]   _zz_div3_2;
  reg        [3:0]    counter;
  reg                 busy;
  wire                io_output_fire;
  reg                 done;
  wire                when_FpuDiv_l31;
  wire                io_output_fire_1;
  reg        [26:0]   shifter;
  reg        [26:0]   result;
  reg        [26:0]   div1;
  reg        [26:0]   div3;
  wire       [26:0]   div2;
  wire       [27:0]   sub1;
  wire       [27:0]   sub2;
  wire       [27:0]   sub3;
  wire                when_FpuDiv_l48;
  reg        [26:0]   _zz_shifter;
  wire                when_FpuDiv_l52;
  wire                when_FpuDiv_l56;
  wire                when_FpuDiv_l60;
  wire                when_FpuDiv_l67;

  assign _zz_shifter_1 = {1'b1,io_input_payload_a};
  assign _zz_div1 = {1'b1,io_input_payload_b};
  assign _zz_div3_1 = {1'b0,{1'b1,io_input_payload_b}};
  assign _zz_div3 = {1'd0, _zz_div3_1};
  assign _zz_div3_2 = ({1'd0,{1'b1,io_input_payload_b}} <<< 1);
  assign io_output_fire = (io_output_valid && io_output_ready); // @[BaseType.scala 305:24]
  assign when_FpuDiv_l31 = (busy && (counter == 4'b1101)); // @[BaseType.scala 305:24]
  assign io_output_fire_1 = (io_output_valid && io_output_ready); // @[BaseType.scala 305:24]
  assign div2 = (div1 <<< 1); // @[BaseType.scala 299:24]
  assign sub1 = ({1'b0,shifter} - {1'b0,div1}); // @[BaseType.scala 299:24]
  assign sub2 = ({1'b0,shifter} - {1'b0,div2}); // @[BaseType.scala 299:24]
  assign sub3 = ({1'b0,shifter} - {1'b0,div3}); // @[BaseType.scala 299:24]
  assign io_output_valid = done; // @[FpuDiv.scala 43:19]
  assign io_output_payload_result = result; // @[FpuDiv.scala 44:20]
  assign io_output_payload_remain = (shifter >>> 2); // @[FpuDiv.scala 45:20]
  assign io_input_ready = (! busy); // @[FpuDiv.scala 46:18]
  assign when_FpuDiv_l48 = (! done); // @[BaseType.scala 299:24]
  always @(*) begin
    _zz_shifter = shifter; // @[Misc.scala 552:9]
    if(when_FpuDiv_l52) begin
      _zz_shifter = sub1[26:0]; // @[FpuDiv.scala 53:11]
    end
    if(when_FpuDiv_l56) begin
      _zz_shifter = sub2[26:0]; // @[FpuDiv.scala 57:11]
    end
    if(when_FpuDiv_l60) begin
      _zz_shifter = sub3[26:0]; // @[FpuDiv.scala 61:11]
    end
  end

  assign when_FpuDiv_l52 = (! sub1[27]); // @[BaseType.scala 299:24]
  assign when_FpuDiv_l56 = (! sub2[27]); // @[BaseType.scala 299:24]
  assign when_FpuDiv_l60 = (! sub3[27]); // @[BaseType.scala 299:24]
  assign when_FpuDiv_l67 = (! busy); // @[BaseType.scala 299:24]
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      busy <= 1'b0; // @[Data.scala 400:33]
      done <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(io_output_fire) begin
        busy <= 1'b0; // @[FpuDiv.scala 30:29]
      end
      if(when_FpuDiv_l31) begin
        done <= 1'b1; // @[FpuDiv.scala 31:29]
      end
      if(io_output_fire_1) begin
        done <= 1'b0; // @[FpuDiv.scala 31:71]
      end
      if(when_FpuDiv_l67) begin
        busy <= io_input_valid; // @[FpuDiv.scala 72:10]
      end
    end
  end

  always @(posedge clk) begin
    if(when_FpuDiv_l48) begin
      counter <= (counter + 4'b0001); // @[FpuDiv.scala 49:13]
      result <= (result <<< 2); // @[FpuDiv.scala 51:12]
      if(when_FpuDiv_l52) begin
        result[1 : 0] <= 2'b01; // @[FpuDiv.scala 54:26]
      end
      if(when_FpuDiv_l56) begin
        result[1 : 0] <= 2'b10; // @[FpuDiv.scala 58:26]
      end
      if(when_FpuDiv_l60) begin
        result[1 : 0] <= 2'b11; // @[FpuDiv.scala 62:26]
      end
      shifter <= (_zz_shifter <<< 2); // @[FpuDiv.scala 64:13]
    end
    if(when_FpuDiv_l67) begin
      counter <= 4'b0000; // @[FpuDiv.scala 68:13]
      shifter <= {2'd0, _zz_shifter_1}; // @[FpuDiv.scala 69:13]
      div1 <= {2'd0, _zz_div1}; // @[FpuDiv.scala 70:13]
      div3 <= (_zz_div3 + {1'b0,_zz_div3_2}); // @[FpuDiv.scala 71:13]
    end
  end


endmodule

module StreamArbiter_1 (
  input               io_inputs_0_valid,
  output              io_inputs_0_ready,
  input      [3:0]    io_inputs_0_payload_opcode,
  input      [1:0]    io_inputs_0_payload_arg,
  input      [4:0]    io_inputs_0_payload_rs1,
  input      [4:0]    io_inputs_0_payload_rs2,
  input      [4:0]    io_inputs_0_payload_rs3,
  input      [4:0]    io_inputs_0_payload_rd,
  input      [0:0]    io_inputs_0_payload_format,
  input      [2:0]    io_inputs_0_payload_roundMode,
  output              io_output_valid,
  input               io_output_ready,
  output     [3:0]    io_output_payload_opcode,
  output     [1:0]    io_output_payload_arg,
  output     [4:0]    io_output_payload_rs1,
  output     [4:0]    io_output_payload_rs2,
  output     [4:0]    io_output_payload_rs3,
  output     [4:0]    io_output_payload_rd,
  output     [0:0]    io_output_payload_format,
  output     [2:0]    io_output_payload_roundMode,
  output     [0:0]    io_chosenOH,
  input               clk,
  input               reset
);
  localparam FpuOpcode_LOAD = 4'd0;
  localparam FpuOpcode_STORE = 4'd1;
  localparam FpuOpcode_MUL = 4'd2;
  localparam FpuOpcode_ADD = 4'd3;
  localparam FpuOpcode_FMA = 4'd4;
  localparam FpuOpcode_I2F = 4'd5;
  localparam FpuOpcode_F2I = 4'd6;
  localparam FpuOpcode_CMP = 4'd7;
  localparam FpuOpcode_DIV = 4'd8;
  localparam FpuOpcode_SQRT = 4'd9;
  localparam FpuOpcode_MIN_MAX = 4'd10;
  localparam FpuOpcode_SGNJ = 4'd11;
  localparam FpuOpcode_FMV_X_W = 4'd12;
  localparam FpuOpcode_FMV_W_X = 4'd13;
  localparam FpuOpcode_FCLASS = 4'd14;
  localparam FpuOpcode_FCVT_X_X = 4'd15;
  localparam FpuFormat_FLOAT = 1'd0;
  localparam FpuFormat_DOUBLE = 1'd1;
  localparam FpuRoundMode_RNE = 3'd0;
  localparam FpuRoundMode_RTZ = 3'd1;
  localparam FpuRoundMode_RDN = 3'd2;
  localparam FpuRoundMode_RUP = 3'd3;
  localparam FpuRoundMode_RMM = 3'd4;

  wire       [1:0]    _zz__zz_maskProposal_0_2;
  wire       [1:0]    _zz__zz_maskProposal_0_2_1;
  wire       [0:0]    _zz__zz_maskProposal_0_2_2;
  wire       [0:0]    _zz_maskProposal_0_3;
  wire                locked;
  wire                maskProposal_0;
  reg                 maskLocked_0;
  wire                maskRouted_0;
  wire       [0:0]    _zz_maskProposal_0;
  wire       [1:0]    _zz_maskProposal_0_1;
  wire       [1:0]    _zz_maskProposal_0_2;
  wire       [3:0]    _zz_io_output_payload_opcode;
  wire       [0:0]    _zz_io_output_payload_format;
  wire       [2:0]    _zz_io_output_payload_roundMode;
  `ifndef SYNTHESIS
  reg [63:0] io_inputs_0_payload_opcode_string;
  reg [47:0] io_inputs_0_payload_format_string;
  reg [23:0] io_inputs_0_payload_roundMode_string;
  reg [63:0] io_output_payload_opcode_string;
  reg [47:0] io_output_payload_format_string;
  reg [23:0] io_output_payload_roundMode_string;
  reg [63:0] _zz_io_output_payload_opcode_string;
  reg [47:0] _zz_io_output_payload_format_string;
  reg [23:0] _zz_io_output_payload_roundMode_string;
  `endif


  assign _zz__zz_maskProposal_0_2 = (_zz_maskProposal_0_1 - _zz__zz_maskProposal_0_2_1);
  assign _zz__zz_maskProposal_0_2_2 = maskLocked_0;
  assign _zz__zz_maskProposal_0_2_1 = {1'd0, _zz__zz_maskProposal_0_2_2};
  assign _zz_maskProposal_0_3 = (_zz_maskProposal_0_2[1 : 1] | _zz_maskProposal_0_2[0 : 0]);
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_inputs_0_payload_opcode)
      FpuOpcode_LOAD : io_inputs_0_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : io_inputs_0_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : io_inputs_0_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : io_inputs_0_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : io_inputs_0_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : io_inputs_0_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : io_inputs_0_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : io_inputs_0_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : io_inputs_0_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : io_inputs_0_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : io_inputs_0_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : io_inputs_0_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : io_inputs_0_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : io_inputs_0_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : io_inputs_0_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : io_inputs_0_payload_opcode_string = "FCVT_X_X";
      default : io_inputs_0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_inputs_0_payload_format)
      FpuFormat_FLOAT : io_inputs_0_payload_format_string = "FLOAT ";
      FpuFormat_DOUBLE : io_inputs_0_payload_format_string = "DOUBLE";
      default : io_inputs_0_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(io_inputs_0_payload_roundMode)
      FpuRoundMode_RNE : io_inputs_0_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : io_inputs_0_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : io_inputs_0_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : io_inputs_0_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : io_inputs_0_payload_roundMode_string = "RMM";
      default : io_inputs_0_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_output_payload_opcode)
      FpuOpcode_LOAD : io_output_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : io_output_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : io_output_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : io_output_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : io_output_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : io_output_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : io_output_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : io_output_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : io_output_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : io_output_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : io_output_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : io_output_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : io_output_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : io_output_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : io_output_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : io_output_payload_opcode_string = "FCVT_X_X";
      default : io_output_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_output_payload_format)
      FpuFormat_FLOAT : io_output_payload_format_string = "FLOAT ";
      FpuFormat_DOUBLE : io_output_payload_format_string = "DOUBLE";
      default : io_output_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(io_output_payload_roundMode)
      FpuRoundMode_RNE : io_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : io_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : io_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : io_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : io_output_payload_roundMode_string = "RMM";
      default : io_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_payload_opcode)
      FpuOpcode_LOAD : _zz_io_output_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : _zz_io_output_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : _zz_io_output_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : _zz_io_output_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : _zz_io_output_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : _zz_io_output_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : _zz_io_output_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : _zz_io_output_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : _zz_io_output_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : _zz_io_output_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : _zz_io_output_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : _zz_io_output_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : _zz_io_output_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : _zz_io_output_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : _zz_io_output_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : _zz_io_output_payload_opcode_string = "FCVT_X_X";
      default : _zz_io_output_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_payload_format)
      FpuFormat_FLOAT : _zz_io_output_payload_format_string = "FLOAT ";
      FpuFormat_DOUBLE : _zz_io_output_payload_format_string = "DOUBLE";
      default : _zz_io_output_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_payload_roundMode)
      FpuRoundMode_RNE : _zz_io_output_payload_roundMode_string = "RNE";
      FpuRoundMode_RTZ : _zz_io_output_payload_roundMode_string = "RTZ";
      FpuRoundMode_RDN : _zz_io_output_payload_roundMode_string = "RDN";
      FpuRoundMode_RUP : _zz_io_output_payload_roundMode_string = "RUP";
      FpuRoundMode_RMM : _zz_io_output_payload_roundMode_string = "RMM";
      default : _zz_io_output_payload_roundMode_string = "???";
    endcase
  end
  `endif

  assign locked = 1'b0;
  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0); // @[Expression.scala 1420:25]
  assign _zz_maskProposal_0 = io_inputs_0_valid; // @[BaseType.scala 318:22]
  assign _zz_maskProposal_0_1 = {_zz_maskProposal_0,_zz_maskProposal_0}; // @[BaseType.scala 318:22]
  assign _zz_maskProposal_0_2 = (_zz_maskProposal_0_1 & (~ _zz__zz_maskProposal_0_2)); // @[BaseType.scala 299:24]
  assign maskProposal_0 = _zz_maskProposal_0_3[0]; // @[Stream.scala 631:20]
  assign io_output_valid = (io_inputs_0_valid && maskRouted_0); // @[Stream.scala 693:19]
  assign _zz_io_output_payload_opcode = io_inputs_0_payload_opcode; // @[Vec.scala 169:11]
  assign _zz_io_output_payload_format = io_inputs_0_payload_format; // @[Vec.scala 169:11]
  assign _zz_io_output_payload_roundMode = io_inputs_0_payload_roundMode; // @[Vec.scala 169:11]
  assign io_output_payload_opcode = _zz_io_output_payload_opcode; // @[Stream.scala 694:21]
  assign io_output_payload_arg = io_inputs_0_payload_arg; // @[Stream.scala 694:21]
  assign io_output_payload_rs1 = io_inputs_0_payload_rs1; // @[Stream.scala 694:21]
  assign io_output_payload_rs2 = io_inputs_0_payload_rs2; // @[Stream.scala 694:21]
  assign io_output_payload_rs3 = io_inputs_0_payload_rs3; // @[Stream.scala 694:21]
  assign io_output_payload_rd = io_inputs_0_payload_rd; // @[Stream.scala 694:21]
  assign io_output_payload_format = _zz_io_output_payload_format; // @[Stream.scala 694:21]
  assign io_output_payload_roundMode = _zz_io_output_payload_roundMode; // @[Stream.scala 694:21]
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready); // @[Stream.scala 695:50]
  assign io_chosenOH = maskRouted_0; // @[Stream.scala 697:15]
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      maskLocked_0 <= 1'b1; // @[Data.scala 400:33]
    end else begin
      if(io_output_valid) begin
        maskLocked_0 <= maskRouted_0; // @[Stream.scala 687:16]
      end
    end
  end


endmodule

module StreamFork (
  input               io_input_valid,
  output              io_input_ready,
  input      [3:0]    io_input_payload_opcode,
  input      [4:0]    io_input_payload_rd,
  input               io_input_payload_write,
  input      [31:0]   io_input_payload_value,
  output              io_outputs_0_valid,
  input               io_outputs_0_ready,
  output     [3:0]    io_outputs_0_payload_opcode,
  output     [4:0]    io_outputs_0_payload_rd,
  output              io_outputs_0_payload_write,
  output     [31:0]   io_outputs_0_payload_value,
  output              io_outputs_1_valid,
  input               io_outputs_1_ready,
  output     [3:0]    io_outputs_1_payload_opcode,
  output     [4:0]    io_outputs_1_payload_rd,
  output              io_outputs_1_payload_write,
  output     [31:0]   io_outputs_1_payload_value
);
  localparam FpuOpcode_LOAD = 4'd0;
  localparam FpuOpcode_STORE = 4'd1;
  localparam FpuOpcode_MUL = 4'd2;
  localparam FpuOpcode_ADD = 4'd3;
  localparam FpuOpcode_FMA = 4'd4;
  localparam FpuOpcode_I2F = 4'd5;
  localparam FpuOpcode_F2I = 4'd6;
  localparam FpuOpcode_CMP = 4'd7;
  localparam FpuOpcode_DIV = 4'd8;
  localparam FpuOpcode_SQRT = 4'd9;
  localparam FpuOpcode_MIN_MAX = 4'd10;
  localparam FpuOpcode_SGNJ = 4'd11;
  localparam FpuOpcode_FMV_X_W = 4'd12;
  localparam FpuOpcode_FMV_W_X = 4'd13;
  localparam FpuOpcode_FCLASS = 4'd14;
  localparam FpuOpcode_FCVT_X_X = 4'd15;

  `ifndef SYNTHESIS
  reg [63:0] io_input_payload_opcode_string;
  reg [63:0] io_outputs_0_payload_opcode_string;
  reg [63:0] io_outputs_1_payload_opcode_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(io_input_payload_opcode)
      FpuOpcode_LOAD : io_input_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : io_input_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : io_input_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : io_input_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : io_input_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : io_input_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : io_input_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : io_input_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : io_input_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : io_input_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : io_input_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : io_input_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : io_input_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : io_input_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : io_input_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : io_input_payload_opcode_string = "FCVT_X_X";
      default : io_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_outputs_0_payload_opcode)
      FpuOpcode_LOAD : io_outputs_0_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : io_outputs_0_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : io_outputs_0_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : io_outputs_0_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : io_outputs_0_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : io_outputs_0_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : io_outputs_0_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : io_outputs_0_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : io_outputs_0_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : io_outputs_0_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : io_outputs_0_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : io_outputs_0_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : io_outputs_0_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : io_outputs_0_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : io_outputs_0_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : io_outputs_0_payload_opcode_string = "FCVT_X_X";
      default : io_outputs_0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_outputs_1_payload_opcode)
      FpuOpcode_LOAD : io_outputs_1_payload_opcode_string = "LOAD    ";
      FpuOpcode_STORE : io_outputs_1_payload_opcode_string = "STORE   ";
      FpuOpcode_MUL : io_outputs_1_payload_opcode_string = "MUL     ";
      FpuOpcode_ADD : io_outputs_1_payload_opcode_string = "ADD     ";
      FpuOpcode_FMA : io_outputs_1_payload_opcode_string = "FMA     ";
      FpuOpcode_I2F : io_outputs_1_payload_opcode_string = "I2F     ";
      FpuOpcode_F2I : io_outputs_1_payload_opcode_string = "F2I     ";
      FpuOpcode_CMP : io_outputs_1_payload_opcode_string = "CMP     ";
      FpuOpcode_DIV : io_outputs_1_payload_opcode_string = "DIV     ";
      FpuOpcode_SQRT : io_outputs_1_payload_opcode_string = "SQRT    ";
      FpuOpcode_MIN_MAX : io_outputs_1_payload_opcode_string = "MIN_MAX ";
      FpuOpcode_SGNJ : io_outputs_1_payload_opcode_string = "SGNJ    ";
      FpuOpcode_FMV_X_W : io_outputs_1_payload_opcode_string = "FMV_X_W ";
      FpuOpcode_FMV_W_X : io_outputs_1_payload_opcode_string = "FMV_W_X ";
      FpuOpcode_FCLASS : io_outputs_1_payload_opcode_string = "FCLASS  ";
      FpuOpcode_FCVT_X_X : io_outputs_1_payload_opcode_string = "FCVT_X_X";
      default : io_outputs_1_payload_opcode_string = "????????";
    endcase
  end
  `endif

  assign io_input_ready = (io_outputs_0_ready && io_outputs_1_ready); // @[Stream.scala 964:17]
  assign io_outputs_0_valid = (io_input_valid && io_input_ready); // @[Stream.scala 965:29]
  assign io_outputs_1_valid = (io_input_valid && io_input_ready); // @[Stream.scala 965:29]
  assign io_outputs_0_payload_opcode = io_input_payload_opcode; // @[Stream.scala 966:31]
  assign io_outputs_0_payload_rd = io_input_payload_rd; // @[Stream.scala 966:31]
  assign io_outputs_0_payload_write = io_input_payload_write; // @[Stream.scala 966:31]
  assign io_outputs_0_payload_value = io_input_payload_value; // @[Stream.scala 966:31]
  assign io_outputs_1_payload_opcode = io_input_payload_opcode; // @[Stream.scala 966:31]
  assign io_outputs_1_payload_rd = io_input_payload_rd; // @[Stream.scala 966:31]
  assign io_outputs_1_payload_write = io_input_payload_write; // @[Stream.scala 966:31]
  assign io_outputs_1_payload_value = io_input_payload_value; // @[Stream.scala 966:31]

endmodule
