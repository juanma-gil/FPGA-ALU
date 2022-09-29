`timescale 1ns / 1ps

module alu#(
        parameter BUS_OP_SIZE = 6,
        parameter BUS_SIZE = 8,
        parameter BUS_BIT_ENABLE = 3
    )(
        input [BUS_SIZE - 1 : 0] i_data_a, i_data_b,
        input [BUS_OP_SIZE - 1 : 0] i_operation,
        output [BUS_SIZE - 1 : 0] o_out,
        output o_carry_bit,
        output o_zero_bit
    );
    localparam OP_ADD = 6'b100000;
    localparam OP_SUB = 6'b100010;
    localparam OP_AND = 6'b100100;
    localparam OP_OR = 6'b100101;
    localparam OP_XOR = 6'b100110;
    localparam OP_SRA = 6'b000011;
    localparam OP_SRL = 6'b000010;
    localparam OP_NOR = 6'b100111;

    reg[BUS_SIZE : 0] result; //tiene un bit extra para el carry
    assign o_out = result; //7:0
    assign o_carry_bit = result[BUS_SIZE];
    assign o_zero_bit = ~|o_out;
    
    always @(*)  
    begin        
        case(i_operation)
            OP_ADD: // Addition
                result = {1'b0, i_data_a} + {1'b0, i_data_b}; 
            OP_SUB: // Subtraction
                result = i_data_a - i_data_b ;
            OP_AND: //  Logical and 
                result = i_data_a & i_data_b;
            OP_OR: //  Logical or
                result = i_data_a | i_data_b;
            OP_XOR: //  Logical xor 
                result = i_data_a ^ i_data_b;
            OP_SRA: // SRA 
                result = {i_data_a[0], i_data_a[BUS_SIZE - 1], i_data_a[BUS_SIZE - 1 : 1]};
            OP_SRL: // SRL
                result = {i_data_a[0], i_data_a >> 1};
            OP_NOR: // Logical nor
                result = ~(i_data_a | i_data_b);
            default: result = i_data_a + i_data_b ; 
        endcase
    end
endmodule
