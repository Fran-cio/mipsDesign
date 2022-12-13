`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.12.2022 18:42:11
// Design Name: 
// Module Name: mux_tb
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


module mux_tb;
    reg[3*2**3 - 1 :0] i_data;
    reg[3 - 1 :0] i_en;
    
    //Outputs
    wire[3 - 1 : 0] o_led;

   mux#(
        .BITS_ENABLES(3),
        .BUS_SIZE(3)
    ) mux1(
        .i_en(i_en),
        .i_data(i_data),
        .o_data(o_led)
    );

    initial begin
        i_en = 0;
        #1
        i_data[5:0] = {3'd2,3'd1};
        i_data[8:6] = 8'd3;
        i_data[11:9] = 8'd4;
        i_data[14:12] = 8'd5;
        i_data[17:15] = 8'd6;
        i_data[20:18] = 8'd7;
        i_data[23:21] = 8'd2;

        #1
        i_en = 1;
        #1
        i_en = 2;
        #1
        i_en = 3;     
        #1     
        i_en = 4;
        #1
        i_en = 5;
        #1
        i_en = 6;     
        #1
        i_en = 7;
        #1
        i_en = 8;
        #1

        $finish;
    end
endmodule
