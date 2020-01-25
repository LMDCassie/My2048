`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:52 01/06/2020 
// Design Name: 
// Module Name:    game_2048 
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
module game_2048(
   input wire clk,
	//input wire [63:0] slots,
	input wire [3:0] btn,//operation control
	input wire start,
	output wire [63:0] Board_out,
	output wire ifEnd,
	output wire success
    );
	
	reg [63:0] temp;
	wire full;
	integer flag = 1;
	integer r_flag = 1;
	reg move = 0;
   //wire [63:0] slots;
	wire [63:0] TmpBoard;
	wire [63:0] InitialBoard;
	wire [63:0] PresentBoard;
	wire [63:0] Board;
   
	StartGame d0(.start(start), .Board(InitialBoard));
	Event d1(.clk(clk), .btn(btn), .slots(PresentBoard), .Board_out(Board), .full(full), .over(ifEnd), .success(success));

	always@(posedge btn[3] or posedge btn[2] or posedge btn[1] or posedge btn[0] or posedge start)begin
		if (start)
		begin
			if(flag) flag <= 0;
			else flag <= 1;
			move <= 0;
		end
		else if (btn[3])
			move <= 1;
		else if (btn[2])
			move <= 1;
		else if (btn[1])
			move <= 1;
		else if (btn[0])
			move <= 1;
	end
	always@(posedge clk) begin
		if(r_flag != flag) begin
		   temp <= InitialBoard;
			if(r_flag) r_flag <= 0;
		   else r_flag <= 1;
		end
	   else if(move) temp <= Board;
	end
	assign PresentBoard = temp;
	assign Board_out = temp;
	
endmodule
