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
        parameter BUS_DATA = 8
    )(
        input                       i_clock,
        input                       i_reset,
        input                       i_enable,
      
        input   [BUS_DATA - 1 : 0]  i_data,
        output  [BUS_DATA - 1 : 0]  o_data     
    );
    
    reg [BUS_DATA - 1 : 0]  data_reg;     
    
    always @(posedge i_clock)
      if (i_reset)   
         data_reg <= 0;
      else
        if(i_enable)
            data_reg <= i_data;      
    
    assign o_data = data_reg;

endmodule
