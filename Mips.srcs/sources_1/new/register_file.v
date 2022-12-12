`timescale 1ns/100ps

module register_file
#(
    parameter NUM_BITS = 32,
    parameter NUM_REGS  = 32,
    parameter TAM_DIREC = $clog2(NUM_REGS)
 )
 (
    input  wire                      i_clk,
    input  wire                      i_reset,
    input  wire                      i_write_enable,
    input  wire [ NUM_BITS-1 : 0]     i_data,
    input  wire [TAM_DIREC-1 : 0]     i_write_direc,
    input  wire [TAM_DIREC-1 : 0]     i_read_direc_A,
    input  wire [TAM_DIREC-1 : 0]     i_read_direc_B,

    input  wire [TAM_DIREC-1 : 0]     i_read_direc_debug,
    output wire [NUM_BITS - 1 : 0]    o_data_debug,

    output wire [NUM_BITS-1 : 0]     o_data_A,
    output wire [NUM_BITS-1 : 0]     o_data_B
 );


reg [NUM_BITS - 1 : 0] registros [NUM_REGS - 1 : 0];
reg [NUM_BITS-1 : 0] reg_a;
reg [NUM_BITS-1 : 0] reg_b;
reg [NUM_BITS-1 : 0] reg_debug;
integer i;

always @ (posedge i_clk)
begin
    if (i_reset) 
        for (i = 0 ; i < NUM_REGS ; i = i + 1)
            registros[i] <= 0;    
    else if (i_write_enable)
        if(i_write_direc !=0)
            registros[i_write_direc] <= i_data;
end

always @ (negedge i_clk)
begin
    reg_a <= registros[i_read_direc_A];
    reg_b <= registros[i_read_direc_B];
    reg_debug <= registros[i_read_direc_debug];
end

assign o_data_A = reg_a;
assign o_data_B = reg_b;
assign o_data_debug = reg_debug;

endmodule