`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2022 12:30:39
// Design Name: 
// Module Name: demux
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


module demux#(
        parameter BITS_ENABLES = 2,
        parameter BUS_SIZE = 8
    )(
        input   [BITS_ENABLES - 1 : 0] i_en,
        input   [BUS_SIZE - 1 : 0] i_data,
        output  [BUS_SIZE*BITS_ENABLES**2 - 1 : 0] o_data 
    );
    
    reg [BUS_SIZE*BITS_ENABLES**2 - 1 : 0] data;
    
    always @(*)
        data[BUS_SIZE*i_en+:BUS_SIZE] = i_data;      
    
    assign o_data = data;

endmodule

