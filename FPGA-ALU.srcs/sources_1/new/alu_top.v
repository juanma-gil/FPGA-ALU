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


module alu_top#(
        parameter BUS_OP_SIZE = 6,
        parameter BUS_SIZE = 8,
        parameter BUS_BIT_ENABLE = 2
    )(
        input i_clk,
        input reset,
        input [BUS_BIT_ENABLE - 1 : 0] i_en,
        input [BUS_SIZE - 1 : 0] i_switch,
        output [BUS_SIZE - 1 : 0] o_led,
        output o_carry_bit,
        output o_zero_bit
    );

    wire [BUS_SIZE*3 - 1 : 0] data1;
    wire [BUS_SIZE - 1 : 0] data_a;  
    wire [BUS_SIZE - 1 : 0] data_b;
    wire [BUS_SIZE - 1 : 0] data_c;
    
    demux#(
        .BITS_ENABLES(2),
        .BUS_SIZE(8)
    ) demux1(
        .i_en(i_en),
        .i_data(i_switch),
        .o_data(data1) 
    );
    
    latch #(.BUS_DATA(BUS_SIZE)) enable_values1(
        .i_clock(i_clk),
        .i_enable(~|i_en),
        .reset(reset),       
        .i_data(data1[BUS_SIZE - 1 : 0]),
        .o_data(data_a)       
    );
    latch #(.BUS_DATA(BUS_SIZE)) enable_values2(
        .i_clock(i_clk),
        .i_enable(i_en[0]),
        .reset(reset),       
        .i_data(data1[BUS_SIZE*2 - 1 : BUS_SIZE]),
        .o_data(data_b)       
    );
    latch #(.BUS_DATA(BUS_SIZE)) enable_values3(
        .i_clock(i_clk),
        .i_enable(i_en[1]),
        .reset(reset),       
        .i_data(data1[BUS_SIZE*3 - 1 : BUS_SIZE*2]),
        .o_data(data_c)       
    );
    
    alu imp_alu(
        .i_data_a(data_a),
        .i_data_b(data_b),
        .i_operation(data_c),
        .o_out(o_led),
        .o_carry_bit(o_carry_bit),
        .o_zero_bit(o_zero_bit)
        );
        
endmodule
