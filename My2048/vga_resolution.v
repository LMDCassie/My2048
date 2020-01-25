`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:53 01/06/2020 
// Design Name: 
// Module Name:    vga_resolution 
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
module vga_resolution(
		input wire clk,   
		output reg Hsync,  //horizonal sync signal
		output reg Vsync,  //vertical sync signal
		output reg[9:0] hc,  //horizonal sync count
		output reg[9:0] vc,   //vertical sync count 
		output reg vidon   // visible signal
    );

	// 640 * 480 VGA data 
	parameter h_pixel = 800; // pixels of each line
	parameter h_total = 521; // lines of each frame
	parameter hbp = 144;   // horizonal back porch
	parameter hfp = 784;  // horizonal front porch
	parameter vbp = 31;   // vertical back porch
	parameter vfp = 511; // vertical front porch
	reg vs_enable;
	
	always @(posedge clk)
	begin
		if (hc == h_pixel - 1)
		begin
			hc <= 0;
			vs_enable <= 1;
		end
		else
		begin
			hc <= hc + 1;
			vs_enable <= 0;
		end
	end
	
	always @(posedge clk)
	begin
		if (vs_enable == 1)
		begin
			if (vc == h_total - 1)
			begin
				vc <= 0;
			end
			else
				vc <= vc + 1;
		end
	end
	
	always @(*)
	begin
		if (hc < 96)
			Hsync = 0;
		else
			Hsync = 1;
	end
	
	always @(*)
	begin
		if (vc < 2)
			Vsync = 0;
		else
			Vsync = 1;
	end
	
	always @(*)
	begin
		if ((hc > hbp) && (hc < hfp) && (vc > vbp) && (vc < vfp))
		begin
			vidon = 1;
		end
		else
			vidon = 0;
	end
endmodule

