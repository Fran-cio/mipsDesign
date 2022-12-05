`timescale 1ns/100ps

module register_file
#(
    parameter NUM_BITS = 32,
    parameter NUM_REGS  = 32,
    parameter TAM_DIREC = $clog2(NUM_REGS)
 )
 (
    input  wire                      i_clk,
    input  wire                      i_rst,
    input  wire                      i_write_enable,
    input  wire [ NUM_BITS-1 : 0]     i_data,
    input  wire [TAM_DIREC-1 : 0]     i_write_direc,
    input  wire [TAM_DIREC-1 : 0]     i_read_direc_A,
    input  wire [TAM_DIREC-1 : 0]     i_read_direc_B,

    input  wire [TAM_DIREC-1 : 0]     i_read_direc_debug,
    output wire [NUM_BITS - 1 : 0]    o_registro_debug,

    output wire [NUM_BITS-1 : 0]     o_registro_A,
    output wire [NUM_BITS-1 : 0]     o_registro_B
 );


reg [NUM_BITS - 1 : 0] registros [NUM_REGS - 1 : 0];
reg [NUM_BITS-1 : 0] data_a;
reg [NUM_BITS-1 : 0] data_b;
reg [NUM_BITS-1 : 0] data_debug;
integer i;

always @ (posedge i_clk)
begin
    if (i_rst) 
        for (i = 0 ; i < NUM_REGS ; i = i + 1)
            registros[i] <= 0;    
    else if (i_write_enable)
        registros[i_write_direc] <= i_data;
end

always @ (negedge i_clk)
begin
    data_a <= registros[i_read_direc_A];
    data_b <= registros[i_read_direc_B];
    data_debug <= registros[i_read_direc_debug];
end

assign o_registro_A = data_a;
assign o_registro_B = data_b;
assign o_registro_debug = data_debug;

endmodule