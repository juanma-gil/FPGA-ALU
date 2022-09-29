`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2022 00:55:44
// Design Name: 
// Module Name: latch
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


module latch#(
        parameter BUS_OP_SIZE = 6,
        parameter BUS_SIZE = 8,
        parameter BUS_BIT_ENABLE = 3
    )(
        input i_clk,
        input [BUS_BIT_ENABLE - 1 : 0] i_en,
        input [BUS_SIZE - 1 : 0] i_switch,
        output [BUS_SIZE - 1 : 0] o_data_a, 
        output [BUS_SIZE - 1 : 0] o_data_b, 
        output [BUS_OP_SIZE - 1 : 0] o_data_operation
    );
    reg [BUS_SIZE - 1 : 0] data_a; 
    reg [BUS_SIZE - 1 : 0] data_b;
    reg [BUS_OP_SIZE - 1 : 0] data_operation;
    always @(posedge i_clk)  
    begin    
        data_a = i_en[0] == 1 ? i_switch : data_a;
        data_b = i_en[1] == 1 ? i_switch : data_b;
        data_operation = i_en[2] == 1 ? i_switch : data_operation;
    end
    
    assign o_data_a = data_a;
    assign o_data_b = data_b;
    assign o_data_operation = data_operation;

endmodule
