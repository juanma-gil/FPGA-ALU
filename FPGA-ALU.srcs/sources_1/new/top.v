`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.09.2022 17:27:42
// Design Name: 
// Module Name: black_box
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


module top#(
        parameter BUS_OP_SIZE = 6,
        parameter BUS_SIZE = 8,
        parameter BUS_BIT_ENABLE = 3
    )(
        input i_clk,
        input [BUS_BIT_ENABLE - 1 : 0] i_en,
        input [BUS_SIZE - 1 : 0] i_switch,
        output [BUS_SIZE - 1 : 0] o_led,
        output o_carry_bit,
        output o_zero_bit
    );

    wire [BUS_SIZE - 1 : 0] data_a; 
    wire [BUS_SIZE - 1 : 0] data_b; 
    wire [BUS_OP_SIZE - 1 : 0] data_operation; 
    
    latch enable_values(
        .i_clk(i_clk),
        .i_en(i_en),
        .i_switch(i_switch),
        .o_data_a(data_a),
        .o_data_b(data_b),
        .o_data_operation(data_operation)
    );
    
    
    alu imp_alu(
        .i_data_a(data_a),
        .i_data_b(data_b),
        .i_operation(data_operation),
        .o_out(o_led),
        .o_carry_bit(o_carry_bit),
        .o_zero_bit(o_zero_bit)
        );
        
endmodule