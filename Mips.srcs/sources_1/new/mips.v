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
        parameter   TAM_CAMPO_OP    =   6,
        parameter   TAM_DIREC_REG   =   5,
        parameter   TAM_DIREC_MEM   =   7,      
        parameter   NUM_LATCHS      =   5,
        parameter   SIGNALS_SIZE    =   18       
    
    )(
        input                           i_clk,
        input                           i_reset,
        input                           i_bootload_wr_en,
        input                           i_pc_reset,
        input                           i_borrar_programa,
        input   [NUM_LATCHS - 1 :  0]   i_latches_en,
        input   [8 - 1 : 0]  i_bootload_byte,
        input   [TAM_DIREC_MEM - 1 : 0] i_debug_ptr_mem,
        input   [TAM_DIREC_REG - 1 : 0] i_debug_ptr_reg,
        
        output                          o_is_end,
        output  [TAM_DATA - 1 : 0]      o_debug_read_reg,
        output  [TAM_DATA - 1 : 0]      o_debug_read_mem,
        output  [TAM_DATA - 1 : 0]      o_read_debug_pc
);
localparam BITS_EN_BYTE = 8;

//  17	    16	    15	      14	 13	     12   11	10	  9	      8	      7	      6	       5	    4	     3	       2	      1        0
//RegDst MemToReg MemRead	Branch MemWrite	Ope2 Ope1 Ope0 ALUSrc RegWrite ShiftSrc JmpSrc JReturnDst EQorNE DataMask1 DataMask0 IsUnsigned JmpOrBrch
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
wire    [TAM_DATA-1:0]          instruction;
wire    [TAM_DATA-1:0]          pc_value;
/*====================================== Latch IF/ID ======================================*/
wire    [TAM_DATA * 2 - 1:0]    de_if_a_id; 
/*====================================== MUXES IF/ID ======================================*/
wire    [TAM_DATA-1:0]          new_pc;
wire    [TAM_DATA-1:0]          o_mux_dir;
wire    [TAM_DATA-1:0]          o_mux_pc_immediate;
/*====================================== Sumador IMMEDIATE ======================================*/
wire    [TAM_DATA-1:0]          immediate_suma_result;
/*====================================== Sumador PC ======================================*/
wire    [TAM_DATA-1:0]          pc_suma_result;
/*====================================== Control Unit ======================================*/
wire    [SIGNALS_SIZE-1:0]      o_signals;
/*====================================== Instruction Decode ======================================*/
wire    [TAM_DATA-1:0]          o_dato_ra_para_condicion;
wire    [TAM_DATA-1:0]          o_dato_rb_para_condicion;
wire    [TAM_DATA-1:0]          o_dato_direc_branch;
wire    [TAM_CAMPO_JUMP-1:0]    o_dato_direc_jump;
wire    [TAM_DATA-1:0]          o_dato_ra;
wire    [TAM_DATA-1:0]          o_dato_rb;
wire    [TAM_DATA-1:0]          o_dato_inmediato;
wire    [TAM_DIREC_REG-1:0]     o_direccion_rs;
wire    [TAM_DIREC_REG-1:0]     o_direccion_rd;
wire    [TAM_DIREC_REG-1:0]     o_direccion_rt;
wire    [TAM_CAMPO_OP-1:0]      o_campo_op;
/*====================================== Latch ID/EX ======================================*/
wire    [120-1:0]               de_id_a_ex;
/*====================================== Excecution ======================================*/
wire    [TAM_DATA-1:0]          o_mem_data;
wire    [TAM_DATA-1:0]          o_alu_data;
wire    [TAM_DIREC_REG-1:0]     o_reg_address;
/*====================================== Latch EX/MEM ======================================*/
wire    [76-1:0]                de_ex_a_mem;
/*====================================== Memory Access ======================================*/
wire    [TAM_DATA-1:0]          o_data_salida_de_memoria;
/*====================================== Latch MEM/WB ======================================*/
wire    [39-1:0]                de_mem_a_wb;
/*====================================== Write Back ======================================*/
wire    [TAM_DATA-1:0]          dato_salido_wb;
wire    [TAM_DIREC_REG-1:0]     direccion_de_wb;
/*====================================== Instruction fetch ======================================*/
instruction_fetch #(
    .TAM_DATA(TAM_DATA)
)
IF(
    .i_clk(i_clk),
    .i_reset(i_reset || i_borrar_programa),
    .i_pc_reset(i_pc_reset),
    .i_stall(i_latches_en[4] && stall_latch),
    .i_new_pc(new_pc),
    .i_bootloader_write_enable(i_bootload_wr_en),
    .i_byte_de_bootloader(i_bootload_byte),
    .o_instruction(instruction),
    .o_is_end(o_is_end),
    .o_pc_value(pc_value)
);
assign o_read_debug_pc  =  pc_value; 
/*====================================== Latch IF/ID ======================================*/
latch #(
    .BUS_DATA(TAM_DATA)
)
if_id_latch_pc_mas_cuatro(
    .i_clock(i_clk),
    .i_reset(i_reset || i_pc_reset),
    .i_enable(i_latches_en[3] && stall_latch),
    .i_data(pc_suma_result), 
    .o_data(de_if_a_id[31:0])
);
latch #(
    .BUS_DATA(TAM_DATA)
)
if_id_latch_inst(
    .i_clock(i_clk),
    .i_reset(i_reset || (i_latches_en[3] && if_flush) || i_pc_reset),
    .i_enable(i_latches_en[3] && stall_latch),
    .i_data(instruction), 
    .o_data(de_if_a_id[63:32])
);
/*====================================== MUXES IF/ID ======================================*/


mux #(
    .BITS_ENABLES(1),
    .BUS_SIZE(TAM_DATA)
)
mux_jmp_brch(
    .i_en(o_signals[JMP_OR_BRCH]),
    .i_data({o_mux_dir, o_mux_pc_immediate}),
    .o_data(new_pc)
);

mux #(
    .BITS_ENABLES(1),
    .BUS_SIZE(TAM_DATA)
)
mux_dir(
    .i_en(o_signals[JMP_SRC]),
    .i_data({{6'b0,o_dato_direc_jump} << 2 , o_dato_ra_para_condicion}), 
    .o_data(o_mux_dir)
);

mux #(
    .BITS_ENABLES(1),
    .BUS_SIZE(TAM_DATA)
)
mux_pc_immediate(
    .i_en(enable_mux_pc_immediate),
    .i_data({immediate_suma_result, pc_suma_result}),
    .o_data(o_mux_pc_immediate)
);
assign enable_mux_pc_immediate = o_mux_eq_neq && o_signals[BRANCH];

mux #(
    .BITS_ENABLES(1),
    .BUS_SIZE(1)
)
mux_eq_neq(
    .i_en(o_signals[EQ_OR_NEQ]),
    .i_data({i_eq_neq, ~i_eq_neq}),
    .o_data(o_mux_eq_neq)
);

assign i_eq_neq = o_dato_ra_para_condicion != o_dato_rb_para_condicion;

/*====================================== Sumador IMMEDIATE ======================================*/
sumador #(
    .TAM_DATO(TAM_DATA)
)
sum_if(
    .i_a(pc_suma_result), 
    .i_b(o_dato_direc_branch<<2), 
    .o_result(immediate_suma_result)
);

/*====================================== Hazard Unit ======================================*/

hazard_unit #(
    .REG_SIZE(5)
)
hazard_unit(
    .i_jmp_brch(o_signals[JMP_OR_BRCH]),
    .i_brch(enable_mux_pc_immediate),
    .i_mem_read_id_ex(de_id_a_ex[4]),
    .i_rs_if_id(o_direccion_rs),
    .i_rt_if_id(o_direccion_rt),
    .i_rt_id_ex(de_id_a_ex[114 : 110]), 
    .o_latch_en(stall_latch),
    .o_if_flush(if_flush),
    .o_is_risky(stall_ctl)
);

/*====================================== Sumador PC ======================================*/
sumador #(
    .TAM_DATO(TAM_DATA)
)
sum_ip_mas_cuatro(
    .i_a(pc_value),
    .i_b(4),
    .o_result(pc_suma_result)
);

/*====================================== Control Unit ======================================*/
mod_control#(
    .FUN_SIZE(6),
    .SIGNALS_SIZE(18)
)
control_unit(
    .i_function(de_if_a_id[37 : 32]), 
    .i_operation(o_campo_op), 
    .i_enable_control(stall_ctl),
    .o_control(o_signals)
);
/*====================================== Instruction Decode ======================================*/
instruction_decode ID(
    .i_clk(i_clk),
    .i_reset(i_reset || i_pc_reset),
    //Intruccion
    .i_instruccion(de_if_a_id[63:32]),
    // Cortocircuito
    .i_reg_write_id_ex(de_id_a_ex[2]),
    .i_reg_write_ex_mem(de_ex_a_mem[2]),
    .i_reg_write_mem_wb(de_mem_a_wb[1]),
    .i_direc_rd_id_ex(o_reg_address), 
    .i_direc_rd_ex_mem(de_ex_a_mem[75:71]),     
    .i_direc_rd_mem_wb(direccion_de_wb),     
    .i_dato_de_id_ex(o_alu_data), 
    .i_dato_de_ex_mem(o_data_salida_de_memoria), 
    .i_dato_de_mem_wb(dato_salido_wb), 
    //Al registro
    .i_dato_de_escritura_en_reg(dato_salido_wb),
    .i_direc_de_escritura_en_reg(direccion_de_wb),
    // Para Debug
    .o_dato_a_debug(o_debug_read_reg),
    .i_direc_de_lectura_de_debug(i_debug_ptr_reg),
    // Para comparar salto
    .o_dato_ra_para_condicion(o_dato_ra_para_condicion),
    .o_dato_rb_para_condicion(o_dato_rb_para_condicion),
    //Para Branch
    .o_dato_direc_branch(o_dato_direc_branch),
    //Para Jump
    .o_dato_direc_jump(o_dato_direc_jump),
    // Para direccion de retorno
    .i_dato_nuevo_pc(de_if_a_id[31:0]),
    //Datos
    .o_dato_ra(o_dato_ra),
    .o_dato_rb(o_dato_rb),
    .o_dato_inmediato(o_dato_inmediato),
    .o_direccion_rs(o_direccion_rs),
    .o_direccion_rt(o_direccion_rt),
    .o_direccion_rd(o_direccion_rd),
    // A control
    .o_campo_op(o_campo_op),
    // Flags de control
    .i_jump_o_branch(o_signals[JMP_OR_BRCH]) //TODO: Controlar
);

/*====================================== Latch ID/EX ======================================*/
latch #(
    .BUS_DATA(120)
)
id_ex_latch(
    i_clk,
    i_reset || i_pc_reset,
    i_latches_en[2],
    {   o_direccion_rd, o_direccion_rt,o_dato_inmediato, o_dato_rb,
        o_dato_ra, o_signals[REG_DST], o_signals[ALU_SRC],o_signals[OP2:OP0],
        o_signals[SHIFT_SRC], o_signals[DATA_MASK_1:DATA_MASK_0],
        o_signals[MEM_WRITE], o_signals[MEM_READ],  o_signals[IS_UNSIGNED],
        o_signals[REG_WRITE], o_signals[MEM_TO_REG],o_signals[J_RETURN_DST]}, 
    de_id_a_ex
);

/*====================================== Excecution ======================================*/
execution EX(
    .i_shift_src(de_id_a_ex[8]),
    .i_reg_dst(de_id_a_ex[13]),
    .i_alu_src(de_id_a_ex[12]),
    .i_alu_op(de_id_a_ex[11:9]),
    .i_ra_data(de_id_a_ex[45:14]),
    .i_rb_data(de_id_a_ex[77:46]),
    .i_sign_extender_data(de_id_a_ex[109:78]), 
    .i_rt_address(de_id_a_ex[114 : 110]),
    .i_rd_address(de_id_a_ex[119 : 115]),
    .o_reg_address(o_reg_address),
    .o_mem_data(o_mem_data),
    .o_alu_data(o_alu_data)
);

/*====================================== Latch EX/MEM ======================================*/
latch #(
    .BUS_DATA(76)
)
ex_mem_latch(
    i_clk,
    i_reset || i_pc_reset,
    i_latches_en[1],
    {o_reg_address, o_mem_data, o_alu_data, de_id_a_ex[7:5], de_id_a_ex[3:0]},  
    de_ex_a_mem
);

/*====================================== Memory Access ======================================*/
memory_access MEM(
    .i_clk(i_clk),
    .i_reset(i_reset|| i_pc_reset),
    .i_wr_mem(de_ex_a_mem[4]),
    .i_is_unsigned(de_ex_a_mem[3]),
    .i_mem_to_reg(de_ex_a_mem[1]),
    .i_data_mask(de_ex_a_mem[6:5]), 
    .i_direc_mem(de_ex_a_mem[38:7]),
    .i_data(de_ex_a_mem[70:39]),
    .i_debug_pointer(i_debug_ptr_mem),
    .o_debug_read(o_debug_read_mem),
    .o_data(o_data_salida_de_memoria)
);

/*====================================== Latch MEM/WB ======================================*/
latch #(
    .BUS_DATA(39)
)
mem_wb_latch(
    i_clk,
    i_reset || i_pc_reset,
    i_latches_en[0],
    {de_ex_a_mem[75:71], o_data_salida_de_memoria,de_ex_a_mem[2] ,de_ex_a_mem[0]}, 
    de_mem_a_wb
);
/*====================================== Write Back ======================================*/
write_back WB(
    .i_dato_de_mem(de_mem_a_wb[33:2]),
        //direcciones
    .i_direc_reg(de_mem_a_wb[38:34]), 
        //seniales de control
    .i_j_return_dest(de_mem_a_wb[0]),
        
    .o_dato(dato_salido_wb),
    .o_direccion(direccion_de_wb)
);
endmodule