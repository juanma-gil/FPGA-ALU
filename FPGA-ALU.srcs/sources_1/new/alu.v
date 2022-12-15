`timescale 1ns / 1ps

module alu#(
        parameter TAM_FUNC = 6,
        parameter TAM_DATA = 32
    )(
        input [TAM_DATA - 1 : 0] i_data_a, i_data_b,
        input [TAM_FUNC - 1 : 0] i_func,
        output [TAM_DATA - 1 : 0] o_out,
        output o_zero_bit
    );
    localparam SLL      =   6'b000000;  // Left  Shift i_data_b shamt  
    localparam SRL      =   6'b000010;  // Right Shift i_data_b shamt (insertando ceros) L de logic
    localparam SRA      =   6'b000011;  // Right Shift i_data_b shamt (Aritmetico, conservando el sig)
    localparam SLLV     =   6'b000100;  // Left  Shift i_data_b << i_data_a
    localparam SRLV     =   6'b000110;  // Right Shift i_data_b >> i_data_a (insertando ceros) L de logic
    localparam SRAV     =   6'b000111;  // Right Shift i_data_b >> i_data_a (conservando signo)
    localparam ADD      =   6'b110001;
    localparam ADDU     =   6'b100001;  // Add unsigned
    localparam SUBU     =   6'b100011;  // rs - rt (signed obvio)
    localparam AND      =   6'b100100;
    localparam OR       =   6'b100101;
    localparam XOR      =   6'b100110;
    localparam NOR      =   6'b100111;
    localparam SLT      =   6'b101010;
    localparam SHIFTLUI =   6'b101011;
    
    reg[TAM_DATA : 0] reg_result; //tiene un bit extra para el carry
    assign o_out = reg_result; //7:0
    assign o_zero_bit = ~|o_out;
    
always @(*)
    case (i_func)
        /* Shift */
        SLL  : reg_result    = i_data_b  <<  i_data_a;
        SRL  : reg_result    = i_data_b  >>  i_data_a;
        SRA  : reg_result    = $signed(i_data_b) >>>  i_data_a;
        SLLV : reg_result    = i_data_b  <<  i_data_a;
        SRLV : reg_result    = i_data_b  >>  i_data_a;
        SRAV : reg_result    = $signed(i_data_b) >>>  i_data_a;
        SHIFTLUI: reg_result = {i_data_b[15:0],{16{1'b0}}} ;
        /* aritmetica basica */
        ADD  : reg_result    = $signed (i_data_a) + $signed (i_data_b);
        ADDU : reg_result    = i_data_a + i_data_b;
        SUBU : reg_result    = $signed (i_data_a) - $signed (i_data_b);
        /* Logic  */
        AND  : reg_result    =  i_data_a & i_data_b;
        OR   : reg_result    =  i_data_a | i_data_b;
        XOR  : reg_result    =  i_data_a ^ i_data_b;
        NOR  : reg_result    = ~(i_data_a | i_data_b);
        /**/
        SLT  : reg_result    = ($signed (i_data_a) < $signed (i_data_b)) ? 'd1 : 'd0;
        
        default: reg_result   = {TAM_DATA{1'b1}};
    endcase
endmodule