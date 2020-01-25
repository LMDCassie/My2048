`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:15:06 01/06/2020 
// Design Name: 
// Module Name:    Event 
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
module Event(
   input wire [3:0] btn,
	input wire [63:0] slots,
	input wire clk,
	output wire [63:0] Board_out,
	output wire full,
	output wire over,
	output wire success
    );
	//reg temp[63:0];
	integer i, j;
	reg [3:0] temp;
	reg [63:0] board;
	reg flag;
	//reg tmp[3:0];// this register is for temporary use of adder4b
	//reg [63:0] slots;

   CheckBoard m0(.clk(clk), .slots(slots), .over(over), .full(full), .success(success));//棋盘未满并且数字未达到2048,输出ifFinish
	//posedge btn[0] or posedge btn[1] or posedge btn[2] or posedge btn[3]
always @(posedge btn[0] or posedge btn[1] or posedge btn[2] or posedge btn[3])
begin
		// Update board
		if(btn[0])
		begin
				board = slots;
			// Rightward 	
				// First, move all the nonzero blocks in direction, which takes at most twice.//把所有的非0都往右边移,不考虑合并
				//if(~over) 
				//begin
				
					for (j = 0; j < 3; j = j+1)
					begin
						for (i = 60; i >= 0; i = i-4)
						begin
								if (i % 16 != 0)
								begin
									if (board[i+3-:4] == 4'b0000)	// If this cell is empty
									begin
										//fill slots[i-1:i-4] into slots[i+3:i]
										board[i+3-:4] = board[i-1-:4];
										
										//Empty slots[i-1:i-4]
										board[i-1-:4] = 4'b0000;
									end
								end
						end
					end

					// Then merge blocks with the identical values.开始合并,从右往左遍历
					
					for(i = 60; i >= 0; i = i-4)
					begin
						if (i % 16 != 0)
						begin
							if (board[i+3-:4] == board[i-1-:4] && board[i+3-:4] != 4'b0000)
							begin
								//slots[i+3:i] + 1
								board[i+3-:4] = board[i+3-:4] + 4'b0001;
								//AddSub4b a0(.A(tmp),.B(4'b0001),.Ctrl(1'b1),.S(slots[i+3:i]));
							
								//Empty slots[i-1:i-4]
								board[i-1-:4] = 4'b0000;
							
							end
						end
					end
					
					for (j = 0; j < 3; j = j+1)
					begin
						for (i = 60; i >= 0; i = i-4)
						begin
								if (i % 16 != 0)
								begin
									if (board[i+3-:4] == 4'b0000)	// If this cell is empty
									begin
										//fill slots[i-1:i-4] into slots[i+3:i]
										board[i+3-:4] = board[i-1-:4];
										
										//Empty slots[i-1:i-4]
										board[i-1-:4] = 4'b0000;
									end
								end
						end
					end
					

			flag = 1;
			for (i = 0; i <= 60; i = i+4)
			begin
				if (board[i+3-:4] == 0 && flag)
				begin
					board[i+3-:4] = 4'b0001;
					flag = 0;
				end
			end
			end
			
			
			
		else if(btn[1])
		begin
				board = slots;
					for (j = 0; j < 3; j = j+1)
					begin
						for (i = 0; i <= 60; i = i+4)
						begin
								if ((i+4) % 16 != 0)
								begin
									if (board[i+3-:4] == 4'b0000)	// If this cell is empty
									begin
										//fill slots[i-1:i-4] into slots[i+3:i]
										board[i+3-:4] = board[i+7-:4];
								
										//Empty slots[i-1:i-4]
										board[i+7-:4] = 4'b0000;
									end
								end
						end
					end
					// Then merge blocks with the identical values.
					for(i = 0; i <= 60; i = i+4)
					begin
						if ((i+4) % 16 != 0)
						begin
							if (board[i+3-:4] == board[i+7-:4] && board[i+3-:4] != 4'b0000)
							begin
								//slots[i+3:i] + 1
								board[i+3-:4] = board[i+3-:4] + 4'b0001;
								//AddSub4b a0(.A(tmp),.B(4'b0001),.Ctrl(1'b1),.S(slots[i+3:i]));
							
								//Empty slots[i-1:i-4]
								board[i+7-:4] = 4'b0000;
							
							end
						end
						
					end
					
					for (j = 0; j < 3; j = j+1)
					begin
						for (i = 0; i <= 60; i = i+4)
						begin
								if ((i+4) % 16 != 0)
								begin
									if (board[i+3-:4] == 4'b0000)	// If this cell is empty
									begin
										//fill slots[i-1:i-4] into slots[i+3:i]
										board[i+3-:4] = board[i+7-:4];
										
										//Empty slots[i-1:i-4]
										board[i+7-:4] = 4'b0000;
									end
								end
						end
					end
				//end
				flag = 1;
			for (i = 0; i <= 60; i = i+4)
			begin
				if (board[i+3-:4] == 0 && flag)
				begin
					board[i+3-:4] = 4'b0001;
					flag = 0;
				end
			end
			end


		else if(btn[2])
		begin
				board = slots;
			//	Upward 	
				// First, move all the nonzero blocks in direction, which takes at most twice.//先把所有的非0都往右边移,不考虑合并,最多要移2次
				//if(~over) 
				//begin
					for (j = 0; j < 3; j = j+1)
					begin
						for (i = 0; i <= 60; i = i+4)
						begin
								if (i <= 44)
								begin
									if (board[i+3-:4] == 4'b0000)	// If this cell is empty
									begin
										//fill slots[i-1:i-4] into slots[i+3:i]
										board[i+3-:4] = board[i+19-:4];
										
										//Empty slots[i-1:i-4]
										board[i+19-:4] = 4'b0000;
									end
								end
						end
					end
					// Then merge blocks with the identical values.然后开始合并,从最右边开始往左遍历,从左往右遍历会有问题
					for(i = 0; i <= 60; i = i+4)
					begin
						if (i <= 44)
						begin
							if (board[i+3-:4] == board[i+19-:4] && board[i+3-:4] != 4'b0000)
							begin
								//slots[i+3:i] + 1
								board[i+3-:4] = board[i+3-:4] + 4'b0001;
								//AddSub4b a0(.A(tmp),.B(4'b0001),.Ctrl(1'b1),.S(slots[i+3:i]));
							
								//Empty slots[i-1:i-4]
								board[i+19-:4] = 4'b0000;
							
							end
						end
					end
					
					for (j = 0; j < 3; j = j+1)
					begin
						for (i = 0; i <= 60; i = i+4)
						begin
								if ((i+4) % 16 != 0)
								begin
									if (board[i+3-:4] == 4'b0000)	// If this cell is empty
									begin
										//fill slots[i-1:i-4] into slots[i+3:i]
										board[i+3-:4] = board[i+7-:4];
										
										//Empty slots[i-1:i-4]
										board[i+7-:4] = 4'b0000;
									end
								end
						end
					end
				//end
				flag = 1;
			for (i = 0; i <= 60; i = i+4)
			begin
				if (board[i+3-:4] == 0 && flag)
				begin
					board[i+3-:4] = 4'b0001;
					flag = 0;
				end
			end
			end
			
			
		else if(btn[3])
		begin
				board = slots;
			//	Downward 	
				// First, move all the nonzero blocks in direction, which takes at most twice.//先把所有的非0都往右边移,不考虑合并,最多要移2次
				//if(~over) 
				//begin
					for (j = 0; j < 3; j = j+1)
					begin
						for (i = 60; i >= 0; i = i-4)
						begin
								if (i >= 16)
								begin
									if (board[i+3-:4] == 4'b0000)	// If this cell is empty
									begin
										//fill slots[i-1:i-4] into slots[i+3:i]
										board[i+3-:4] = board[i-13-:4];
										
										//Empty slots[i-1:i-4]
										board[i-13-:4] = 4'b0000;
									end
								end
						end
					end
					// Then merge blocks with the identical values.然后开始合并,从最右边开始往左遍历,从左往右遍历会有问题
					for(i = 60; i >= 0; i = i-4)
					begin
						if (i >= 16)
						begin
							if (board[i+3-:4] == board[i-13-:4] && board[i+3-:4] != 4'b0000)
							begin
								//slots[i+3:i] + 1
								board[i+3-:4] = board[i+3-:4] + 4'b0001;
								//AddSub4b a0(.A(tmp),.B(4'b0001),.Ctrl(1'b1),.S(slots[i+3:i]));
							
								//Empty slots[i-1:i-4]
								board[i-13-:4] = 4'b0000;
							
							end
						end
					end
					
					for (j = 0; j < 3; j = j+1)
					begin
						for (i = 0; i <= 60; i = i+4)
						begin
								if ((i+4) % 16 != 0)
								begin
									if (board[i+3-:4] == 4'b0000)	// If this cell is empty
									begin
										//fill slots[i-1:i-4] into slots[i+3:i]
										board[i+3-:4] = board[i+7-:4];
										
										//Empty slots[i-1:i-4]
										board[i+7-:4] = 4'b0000;
									end
								end
						end
					end
					flag = 1;
			for (i = 0; i <= 60; i = i+4)
			begin
				if (board[i+3-:4] == 0 && flag)
				begin
					board[i+3-:4] = 4'b0001;
					flag = 0;
				end
			end
				//end
			end
			
			
end

assign Board_out = board;

endmodule

