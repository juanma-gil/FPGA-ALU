//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2022 01:50:53 PM
// Design Name: 
// Module Name: alu
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
`timescale 1ns / 1ps
`define BUS_SIZE 8 
`define BUS_OP_SIZE 6
module alu(
        input [`BUS_SIZE - 1 : 0] in_a, in_b,
        input [`BUS_OP_SIZE - 1 : 0] in_op,
        output [`BUS_SIZE - 1 : 0] out_led,
        output out_carry,
        output out_zero
    );
    reg[`BUS_SIZE : 0] result; //tiene un bit extra para el carry
    assign out_led = result; //7:0
    assign out_carry = result[`BUS_SIZE];
    assign out_zero = ~|out_led;
    
    always @(*)      
    begin
        case(in_op)
            `BUS_OP_SIZE'b100000: // Addition
                result = {1'b0, in_a} + {1'b0, in_b}; 
            `BUS_OP_SIZE'b100010: // Subtraction
                result = in_a - in_b ;
            `BUS_OP_SIZE'b100100: //  Logical and 
                result = in_a & in_b;
            `BUS_OP_SIZE'b100101: //  Logical or
                result = in_a | in_b;
            `BUS_OP_SIZE'b100110: //  Logical xor 
                result = in_a ^ in_b;
            `BUS_OP_SIZE'b000011: // SRA 
                result = {in_a[0], in_a[`BUS_SIZE - 1], in_a[`BUS_SIZE - 1 : 1]};
            `BUS_OP_SIZE'b000010: // SRL
                result = {in_a[0], in_a >> 1};
            `BUS_OP_SIZE'b100111: // Logical nor
                result = ~(in_a | in_b);
            default: result = in_a + in_b ; 
        endcase
    end
endmodule


module tb_alu;
    //Inputs
    reg[`BUS_SIZE - 1 :0] in_a, in_b;
    reg[`BUS_OP_SIZE - 1 : 0] in_op;

    //Outputs
    wire[`BUS_SIZE - 1 : 0] out_led;
    wire out_carry;

    // Verilog code for ALU
    alu test_unit(
            in_a, in_b,  // ALU N-bit Inputs                 
            in_op,// ALU Operation
            out_led, // ALU 8-bit Output
            out_carry, // Carry Out Flag,
            out_zero // Zero Out Flag
        );
    initial begin
    // hold reset state for 100 ns.
        in_a = `BUS_SIZE'h8B; // 139 representado en hexa de N bits
        in_b = `BUS_SIZE'h02; // 2 representado en hexa de N bits
        in_op = `BUS_OP_SIZE'h0; // operación 0 representada en un hexa de M bits
        
        in_op = `BUS_OP_SIZE'b100000; // Addition
        #10;
        in_op = `BUS_OP_SIZE'b100010; // Subtraction
        #10;
        in_op = `BUS_OP_SIZE'b100100; //  Logical and 
        #10;
        in_op = `BUS_OP_SIZE'b100101; //  Logical or
        #10;
        in_op = `BUS_OP_SIZE'b100110; //  Logical xor 
        #10;
        in_op = `BUS_OP_SIZE'b000011; // SRA 
        #10;
        in_op = `BUS_OP_SIZE'b000010; // SRL
        #10;
        in_op = `BUS_OP_SIZE'b100111; // Logical nor
        #10;
        
        $finish;
    end
endmodule
