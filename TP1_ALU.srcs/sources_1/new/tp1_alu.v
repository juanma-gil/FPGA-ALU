`timescale 1ns / 1ps

module alu#(
        parameter BUS_OP_SIZE = 6,
        
        parameter BUS_SIZE = 8,
        
        parameter OP_ADD = 6'b100000,
        
        parameter OP_SUB = 6'b100010,
        
        parameter OP_AND = 6'b100100,
        
        parameter OP_OR = 6'b100101,
        
        parameter OP_XOR = 6'b100110,
        
        parameter OP_SRA = 6'b000011,
        
        parameter OP_SRL = 6'b000010,
        
        parameter OP_NOR = 6'b100111
    )(
        input [BUS_SIZE - 1 : 0] in_a, in_b,
        input [BUS_OP_SIZE - 1 : 0] in_op,
        output [BUS_SIZE - 1 : 0] out_led,
        output out_carry,
        output out_zero
    );
  
    reg[BUS_SIZE : 0] result; //tiene un bit extra para el carry
    assign out_led = result; //7:0
    assign out_carry = result[BUS_SIZE];
    assign out_zero = ~|out_led;
    
    always @(*)      
    begin
        case(in_op)
            OP_ADD: // Addition
                result = {1'b0, in_a} + {1'b0, in_b}; 
            OP_SUB: // Subtraction
                result = in_a - in_b ;
            OP_AND: //  Logical and 
                result = in_a & in_b;
            OP_OR: //  Logical or
                result = in_a | in_b;
            OP_XOR: //  Logical xor 
                result = in_a ^ in_b;
            OP_SRA: // SRA 
                result = {in_a[0], in_a[BUS_SIZE - 1], in_a[BUS_SIZE - 1 : 1]};
            OP_SRL: // SRL
                result = {in_a[0], in_a >> 1};
            OP_NOR: // Logical nor
                result = ~(in_a | in_b);
            default: result = in_a + in_b ; 
        endcase
    end
endmodule

module tb_alu;
    localparam BUS_OP_SIZE = 6;
    
    localparam BUS_SIZE = 8;
    
    localparam OP_ADD = 6'b100000;
    
    localparam OP_SUB = 6'b100010;
    
    localparam OP_AND = 6'b100100;
    
    localparam OP_OR = 6'b100101;
    
    localparam OP_XOR = 6'b100110;
    
    localparam OP_SRA = 6'b000011;
    
    localparam OP_SRL = 6'b000010;
    
    localparam OP_NOR = 6'b100111;
    
    localparam IN_A = 8'hFF; // 255 representado en hexa de N bits
    
    localparam IN_B = 8'h02; // 2 representado en hexa de N bits
    
    localparam IN_OP = 6'h0; // operaci�n 0 representada en un hexa de M bits
    
    //Inputs
    reg[BUS_SIZE - 1 :0] in_a, in_b;
    reg[BUS_OP_SIZE - 1 : 0] in_op;

    //Outputs
    wire[BUS_SIZE - 1 : 0] out_led;
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
        in_a = IN_A; // 139 representado en hexa de N bits
        in_b = IN_B; // 2 representado en hexa de N bits
        in_op = IN_OP; // operaci�n 0 representada en un hexa de M bits
        
        in_op = OP_ADD; // Addition
        #10;
        in_op = OP_SUB; // Subtraction
        #10;
        in_op = OP_AND; //  Logical and 
        #10;
        in_op = OP_OR; //  Logical or
        #10;
        in_op = OP_XOR; //  Logical xor 
        #10;
        in_op = OP_SRA; // SRA 
        #10;
        in_op = OP_SRL; // SRL
        #10;
        in_op = OP_NOR; // Logical nor
        #10;
        
        $finish;
    end
endmodule
