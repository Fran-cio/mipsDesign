`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2022 00:26:30
// Design Name: 
// Module Name: mips
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module mips#(
        parameter   TAM_DATA        =   32,
        parameter   TAM_CAMPO_JUMP  =   26,
        parameter   TAM_CAMPO_OP    =   5,
        parameter   TAM_DIREC_REG   =   5,   
        parameter   NUM_LATCHS      =   5       
    
    )(
        input                           i_clk,
        input                           i_reset,
        input                           i_bootload_wr_en,
        input                           i_pc_reset,
        input   [NUM_LATCHS - 1 :  0]   i_latches_en,
        input   [BITS_EN_BYTE - 1 : 0]  i_bootload_byte,
        input   [TAM_DATA - 1 : 0]      i_debug_ptr_mem,
        input   [TAM_DATA - 1 : 0]      i_debug_ptr_reg,
        
        output                          o_is_end,
        output                          o_is_halt,
        output  [TAM_DATA - 1 : 0]      o_debug_read_reg,
        output  [TAM_DATA - 1 : 0]      o_debug_read_mem,
        output  [TAM_DATA - 1 : 0]      o_read_debug_pc
);

//  17	    16	    15	      14	 13	     12   11	10	  9	      8	      7	      6	       5	    4	     3	       2	      1        0
//RegDst MemToReg MemRead	Branch MemWrite	Ope2 Ope1 Ope0 ALUSrc RegWrite ShiftSrc JmpSrc JReturnDst EQorNE DataMask1 DataMask0 IsUnsigned JmpOrBrch
 
localparam  BITS_EN_BYTE = 8;

localparam  REG_DST         =   17;
localparam  MEM_TO_REG      =   16;
localparam  MEM_READ        =   15;
localparam  BRANCH          =   14;
localparam  MEM_WRITE       =   13;
localparam  OP2             =   12;
localparam  OP1             =   11;
localparam  OP0             =   10;
localparam  ALU_SRC         =    9;
localparam  REG_WRITE       =    8;
localparam  SHIFT_SRC       =    7;
localparam  JMP_SRC         =    6;
localparam  J_RETURN_DST    =    5;
localparam  EQ_OR_NEQ       =    4;
localparam  DATA_MASK_1     =    3;
localparam  DATA_MASK_0     =    2;
localparam  IS_UNSIGNED     =    1;
localparam  JMP_OR_BRCH     =    0;

/*====================================== Instruction fetch ======================================*/

instruction_fetch #(
    .TAM_DATA(TAM_DATA)
)
IF(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_pc_reset(i_pc_reset),
    .i_stall(stall_latch),
    .i_new_pc(new_pc),
    .i_bootloader_write_enable(i_bootload_wr_en),
    .i_byte_de_bootloader(i_bootload_byte),
    .o_instruction(instruction),
    .o_is_end(o_is_halt),
    .o_pc_value(pc_value)
);

/*====================================== Latch IF/ID ======================================*/

latch #(
    .BUS_DATA(TAM_DATA * 2)
)
if_id_latch(
    .i_clock(i_clk),
    .i_reset(i_reset),
    .i_enable(i_latches_en[3] || stall_latch),
    .i_data({instruction, pc_value}), 
    .o_data(de_if_a_id)
);

/*====================================== MUXES IF/ID ======================================*/

mux #(
    .BITS_ENABLES(1),
    .BUS_SIZE(TAM_DATA * 2)
)
mux_jmp_brch(
    .i_en(o_signals[JMP_OR_BRCH]),
    .i_data({o_mux_dir, o_mux_pc_immediate}),
    .o_data(new_pc)
);

mux #(
    .BITS_ENABLES(1),
    .BUS_SIZE(TAM_DATA * 2)
)
mux_dir(
    .i_en(o_signals[JMP_SRC]),
    .i_data({de_if_a_id[57 : 32] << 2, o_dato_ra_para_condicion}), //TODO: creo que esto se puede tomar de ID pero no sabía cual era
    .o_data(o_mux_dir)
);

mux #(
    .BITS_ENABLES(1),
    .BUS_SIZE(TAM_DATA * 2)
)
mux_pc_immediate(
    .i_en(o_signals[JMP_SRC]),
    .i_data({immediate_suma_result, pc_suma_result}),
    .o_data(o_mux_pc_immediate)
);
assign o_mux_pc_immediate = o_mux_eq_neq && o_signals[BRANCH];

mux #(
    .BITS_ENABLES(1),
    .BUS_SIZE(TAM_DATA * 2)
)
mux_eq_neq(
    .i_en(o_signals[EQ_OR_NEQ]),
    .i_data({i_eq_neq, ~i_eq_neq}),
    .o_data(o_mux_eq_neq)
);

assign i_eq_neq = o_dato_ra_para_condicion ^ o_dato_rb_para_condicion;

/*====================================== Sumador IMMEDIATE ======================================*/

sumador #(
    .TAM_DATO(TAM_DATA)
)
sum_if(
    .i_a(pc_value), //TODO: en el diagrama hay un shift 2, hay que hacerlo? son 32 bits...
    .i_b(de_if_a_id[48 : 32]), //TODO: se puede hacer mejor?
    .out_result(immediate_suma_result)
);

/*====================================== Hazard Unit ======================================*/

hazard_unit #(
    .REG_SIZE(5)
)
hazard_unit(
    .i_jmp_brch(o_signals[JMP_OR_BRCH]),
    .i_brch(o_signals[BRANCH]),
    .i_mem_read_id_ex(de_id_a_ex[4]),
    .i_rs_if_id(o_direccion_rs),
    .i_rt_if_id(o_direccion_rt),
    .i_rt_id_ex(de_id_a_ex[117 : 113]), //TODO: controlar que esto esté bien
    .o_latch_en(stall_latch),
    .o_is_risky(stall_ctl)
);

/*====================================== Sumador PC ======================================*/

sumador #(
    .TAM_DATO(TAM_DATA)
)
sum_if(
    .i_a(pc_value),
    .i_b(4),
    .out_result(pc_suma_result)
);

/*====================================== Control Unit ======================================*/

mod_control control_unit #(
    .FUN_SIZE(6),
    .SIGNALS_SIZE(18)
)
(
    .i_function(de_if_a_id[63 : 58]), //controlar
    .i_operation(o_campo_op), //TODO: está bien eso o flasheo???
    .i_enable_control(stall_ctl),
    .o_control(o_signals)
)

/*====================================== Instruction Decode ======================================*/

instruction_decode ID(
    i_clk,
    i_reset,
    //Intruccion
    .i_sign_extender_data(de_if_a_id[63:32]),
    // Cortocircuito
    i_reg_write_id_ex,
    i_reg_write_ex_mem,
    i_reg_write_mem_wb,
    i_direc_rd_id_ex, 
    i_direc_rd_ex_mem,     
    i_direc_rd_mem_wb,     
    i_dato_de_id_ex, 
    i_dato_de_ex_mem, 
    i_dato_de_mem_wb, 
    //Al registro
    i_dato_de_escritura_en_reg,
    i_direc_de_escritura_en_reg,
    // Para Debug
    .o_dato_a_debug(o_debug_read_reg),
    .i_direc_de_lectura_de_debug(i_debug_ptr_reg),
    // Para comparar salto
    o_dato_ra_para_condicion,
    o_dato_rb_para_condicion,
    //Para Branch
    o_dato_direc_branch,
    //Para Jump
    o_dato_direc_jump,
    // Para direccion de retorno
    i_dato_nuevo_pc,
    //Datos
    o_dato_ra,
    o_dato_rb,
    o_dato_inmediato,
    o_direccion_rs,
    o_direccion_rt,
    o_direccion_rd,
    // A control
    o_campo_op,
    // Flags de control
    o_signals[JMP_OR_BRCH] //TODO: Controlar
);

/*====================================== Latch ID/EX ======================================*/

latch #(
    .BUS_DATA(118),
)
id_ex_latch(
    i_clk,
    i_reset,
    i_latches_en[2] || ,//enable de la hazard unit
    ,//instrucción concatenada con la salida de la program counter 
    de_id_a_ex
);

/*====================================== Excecution ======================================*/

execution EX(
    .i_shift_src(de_id_a_ex[8]),
    .i_reg_dst(de_id_a_ex[11]),
    .i_alu_src(de_id_a_ex[10]),
    .i_alu_op(de_id_a_ex[9]),
    .i_ra_data(de_id_a_ex[43:12]),
    .i_rb_data(de_id_a_ex[75:44]),
    .i_sign_extender_data(de_id_a_ex[106:76]), 
    .i_rt_address(de_id_a_ex[111:107]),
    .i_rd_address(de_id_a_ex[116:112]),
    output  [5 - 1 : 0]     o_reg_address,
    output  [32 - 1 : 0]    o_mem_data,
    output  [32 - 1 : 0]    o_alu_data
);

/*====================================== Latch EX/MEM ======================================*/

latch #(
    .BUS_DATA(77),
)
ex_mem_latch(
    i_clk,
    i_reset,
    i_latches_en[1] || ,//enable de la hazard unit
    ,{o_reg_address, o_mem_data, o_alu_data, de_id_a_ex[5:0]} //instrucción concatenada con la salida de la program counter 
    de_ex_a_mem
);

/*====================================== Memory Access ======================================*/

memory_access MEM(
    i_clk,
    i_reset,
    .i_wr_mem(de_ex_a_mem[4]),
    .i_is_unsigned(de_ex_a_mem[3]),
    .i_data_mask(de_ex_a_mem[6:5]), 
    .i_direc_mem(de_ex_a_mem[38:7]),
    .i_data(de_ex_a_mem[70:39]),
    .i_debug_pointer(i_debug_ptr_mem),
    .o_debug_read(o_debug_read_mem),
    o_data
);

/*====================================== Latch MEM/WB ======================================*/

latch #(
    .BUS_DATA(72),
)
mem_wb_latch(
    i_clk,
    i_reset,
    i_latches_en[0] || ,//enable de la hazard unit
    {de_ex_a_mem[38:7], de_ex_a_mem[76:71], o_data, de_id_a_ex[2:0]} //instrucción concatenada con la salida de la program counter 
    de_mem_a_wb
);
endmodule