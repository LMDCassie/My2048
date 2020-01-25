`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:16:07 01/06/2020 
// Design Name: 
// Module Name:    CheckBoard 
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
module CheckBoard(
   input wire [63:0] slots,
	input wire clk,
	output wire over,
	output wire full,
	output wire success
    );
	reg [15:0] blocks;
	reg [63:0] slots_reg;
	reg over_reg;
	reg full_reg;
	reg success_reg;
	integer i, j, k, flag;
   //判断游戏棋盘是否已满
	//如果满了	
	//判断每个位置的下方和右侧没有相同的数
	
// Judge whether the game is over 
		
		always@(*)begin
		   slots_reg <= slots;
	   end
		
		always@(clk) begin
		   over_reg = 1'b0;
		   full_reg = 1'b0;
		   success_reg = 1'b0;
			for (k = 0; k <= 60; k = k + 4) begin
				blocks[k/4] = slots_reg[k] | slots_reg[k+1] | slots_reg[k+2] | slots_reg[k+3];
				if(slots_reg[k] & slots_reg[k+1] & ~slots_reg[k+2] & slots_reg[k+3]) success_reg = 1'b1;
			end
			full_reg = &blocks;
		   
			
			flag = 1;
			if(full) begin 
			   for(i = 0; i <= 48; i = i+16) begin
				   for(j = i; j <= i+8; j = j+4) begin
				      if(slots_reg[j+3 -: 4] == slots_reg[j+7 -: 4]) flag = 0;
					end
				end
				for(i = 0; i <= 32; i = i+16) begin
				   for(j = i; j <= i+12; j = j+4) begin
				      if(slots_reg[j+3 -: 4] == slots_reg[j+19 -: 4]) flag = 0;
					end
				end
				
				if(flag)  over_reg = 1'b1;
				else  over_reg = 1'b0;
			end
      end
		assign over = over_reg; 
		assign full = full_reg;
      assign success = success_reg;
endmodule

