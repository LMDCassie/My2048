`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:09 01/06/2020 
// Design Name: 
// Module Name:    clk25MHz 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clk25MHz(
			input clk,
			output clk25
    );
	 reg [1:0] count;
	 
	 always @(posedge clk)
	 begin
			count <= count + 1;
	 end

	assign clk25 = count[1];
endmodule

