`timescale 1ns / 1ps

module alu#(
        parameter BUS_OP_SIZE = 6,
        parameter BUS_SIZE = 8,
        parameter BUS_BIT_ENABLE = 3,
        parameter OP_ADD = 6'b100000,
        parameter OP_SUB = 6'b100010,
        parameter OP_AND = 6'b100100,
        parameter OP_OR = 6'b100101,
        parameter OP_XOR = 6'b100110,
        parameter OP_SRA = 6'b000011,
        parameter OP_SRL = 6'b000010,
        parameter OP_NOR = 6'b100111
    )(
        input clk,
        input [BUS_BIT_ENABLE - 1 : 0] in_en,
        input [BUS_SIZE - 1 : 0] in_a, in_b,
        input [BUS_OP_SIZE - 1 : 0] in_op,
        output [BUS_SIZE - 1 : 0] out_led,
        output out_carry,
        output out_zero
    );
    reg [BUS_SIZE - 1 : 0] data_a; 
    reg [BUS_SIZE - 1 : 0] data_b; 
    reg [BUS_OP_SIZE - 1 : 0] data_op; 

    reg[BUS_SIZE : 0] result; //tiene un bit extra para el carry
    assign out_led = result; //7:0
    assign out_carry = result[BUS_SIZE];
    assign out_zero = ~|out_led;
    
    always @(posedge clk)  
    begin
        data_a = in_en[0] == 1 ? in_a : data_a;
        data_b = in_en[1] == 1 ? in_b : data_b;
        data_op = in_en[2] == 1 ? in_op : data_op;
            
        case(data_op)
            OP_ADD: // Addition
                result = {1'b0, data_a} + {1'b0, data_b}; 
            OP_SUB: // Subtraction
                result = data_a - data_b ;
            OP_AND: //  Logical and 
                result = data_a & data_b;
            OP_OR: //  Logical or
                result = data_a | data_b;
            OP_XOR: //  Logical xor 
                result = data_a ^ data_b;
            OP_SRA: // SRA 
                result = {data_a[0], data_a[BUS_SIZE - 1], data_a[BUS_SIZE - 1 : 1]};
            OP_SRL: // SRL
                result = {data_a[0], data_a >> 1};
            OP_NOR: // Logical nor
                result = ~(data_a | data_b);
            default: result = data_a + data_b ; 
        endcase
    end
endmodule

module tb_alu;
    localparam BUS_OP_SIZE = 6;
    localparam BUS_SIZE = 8;   
    localparam BUS_BIT_ENABLE = 3;
    localparam OP_ADD = 6'b100000;    
    localparam OP_SUB = 6'b100010;    
    localparam OP_AND = 6'b100100;    
    localparam OP_OR = 6'b100101;    
    localparam OP_XOR = 6'b100110;    
    localparam OP_SRA = 6'b000011;    
    localparam OP_SRL = 6'b000010;    
    localparam OP_NOR = 6'b100111;
    localparam IN_CLK = 1'b0;
    localparam IN_EN = 3'b000;
    localparam IN_A = 8'hFF; // 255 representado en hexa de N bits    
    localparam IN_B = 8'h02; // 2 representado en hexa de N bits    
    localparam IN_OP = 6'h0; // operaci�n 0 representada en un hexa de M bits

    //Inputs
    reg clk;
    reg[BUS_BIT_ENABLE -1 : 0] in_en;
    reg[BUS_SIZE - 1 :0] in_a, in_b;
    reg[BUS_OP_SIZE - 1 : 0] in_op;
    
    //Outputs
    wire[BUS_SIZE - 1 : 0] out_led;
    wire out_carry;

    // Verilog code for ALU
    alu test_unit(
            clk,
            in_en,
            in_a, in_b,  // ALU N-bit Inputs                 
            in_op,// ALU Operation
            out_led, // ALU 8-bit Output
            out_carry, // Carry Out Flag,
            out_zero // Zero Out Flag
        );
    initial begin
        clk = IN_CLK;
        in_en = IN_EN;
        in_a = IN_A; // 139 representado en hexa de N bits
        in_b = IN_B; // 2 representado en hexa de N bits
        in_op = IN_OP; // operaci�n 0 representada en un hexa de M bits
        #5
        in_en[0] = 1;
        #5
        in_en[0] = 0;
        in_en[1] = 1;
        #5
        in_en[1] = 0;
        in_en[2] = 1;
        #5
        in_en[2] = 0;

        in_op = OP_ADD; // Addition
        in_en[2] = 1;
        #2
        in_en[2] = 0;
        #10;
        in_op = OP_SUB; // Subtraction
        in_en[2] = 1;
        #2
        in_en[2] = 0;
        #10;
        in_op = OP_AND; //  Logical and 
        in_en[2] = 1;
        #2
        in_en[2] = 0;
        #10;
        in_op = OP_OR; //  Logical or
        in_en[2] = 1;
        #2
        in_en[2] = 0;
        #10;
        in_op = OP_XOR; //  Logical xor 
        in_en[2] = 1;
        #2
        in_en[2] = 0;
        #10;
        in_op = OP_SRA; // SRA 
        in_en[2] = 1;
        #2
        in_en[2] = 0;
        #10;
        in_op = OP_SRL; // SRL
        in_en[2] = 1;
        #2
        in_en[2] = 0;
        #10;
        in_op = OP_NOR; // Logical nor
        in_en[2] = 1;
        #2
        in_en[2] = 0;
        #10
        $finish;
    end
    
    always begin
        #1
        clk = ~clk;
    end
endmodule
