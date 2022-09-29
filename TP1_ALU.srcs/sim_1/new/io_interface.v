`timescale 1ns / 1ps

module io_interface(
        input i_clk,
        input [BUS_SIZE - 1 : 0] i_switch,
        input [BUS_BIT_ENABLE - 1 : 0] i_en
    );
    
    localparam BUS_OP_SIZE = 6;
    localparam BUS_SIZE = 8;
    localparam BUS_BIT_ENABLE = 3;
    
    reg [BUS_SIZE - 1 : 0] data_a;
    reg [BUS_SIZE - 1 : 0] data_b;
    reg [BUS_SIZE - 1 : 0] data_operation;
    
    always @(posedge i_clk)
    begin
        data_a = i_en[0] == 1 ? i_switch : data_a;
        data_b = i_en[1] == 1 ? i_switch : data_b;
        data_operation = i_en[2] == 1 ? i_switch : data_operation;

        alu(data_a, data_b, data_operation);
    end
endmodule
