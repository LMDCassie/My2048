`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:29 01/06/2020 
// Design Name: 
// Module Name:    vga_display 
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
module vga_display(
			input wire clk, 
			input wire vidon,
			input wire [7:0] data,   
			output reg [2:0] vgaRed,
			output reg [2:0] vgaGreen,
			output reg [2:0] vgaBlue
    );
 
	/* When visible, RGB will be data at the moment */
	always @(posedge clk)
	begin
		if (vidon == 1)
		begin
			vgaRed <= {data[7:5],1'b0};
			vgaGreen <= {data[4:2],1'b0};
			vgaBlue <= {data[1:0],1'b0};
		end
		else
		begin
			vgaRed <= 0;
			vgaGreen <= 0;
			vgaBlue <= 0;
		end
	end

endmodule
