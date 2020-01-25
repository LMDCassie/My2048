`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:08:01 01/06/2020 
// Design Name: 
// Module Name:    interface 
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
module interface(
			input wire clk,
			input wire [9:0] hc,
			input wire [9:0] vc,
			input wire vidon,
			input wire win,
			input wire isEnd,
			input wire [63:0] map,
			input wire info_number,
			input wire info_title,
			input wire info_win,
			input wire info_end,
			output reg [7:0] data,
			output wire [15:0] addrNumber,
			output wire [15:0] addrTitle
    );

	/* VGA data that are same as in VGA_resolution module*/
	parameter h_pixel = 800;
	parameter h_total = 521;
	parameter hbp = 144;
	parameter hfp = 784;
	parameter vbp = 31;
	parameter vfp = 511;

	wire [9:0] xpix;
	wire [9:0] ypix;
	wire [9:0] x;
	wire [9:0] y;

	/* Calculate the position of pixel */
	assign xpix = hc - hbp; 
	assign ypix = vc - vbp;

	/* Calculate the address and the scale of titles and numbers */
	assign x = ((xpix>238)+(xpix>316)+(xpix>394)); 
	assign y = ((ypix>198)+(ypix>276)+(ypix>354));
	assign addrNumber = (map[(((y << 2) + x) * 4 + 3)-:4] - 1) * 4900 + (xpix - 168 - (x * 78)) + ((ypix - 128 - (y * 78)) * 70);
	assign addrTitle = xpix - 160 + (ypix << 8) + (ypix << 6);

	/* Assign RGB data to different images */
	always @(posedge clk)
	begin
		if (vidon == 0)
		begin
			data <= 0;
		end
		else
		if (xpix > 160 && xpix < 480 && ypix < 120 && win == 1)   //win, change title
		begin
			//data <= info_win;
			if(info_win == 0)
			begin
			  data <= 8'b11111111;
			end
			else
			begin
			  data <= 8'b01101000;
			end
		end
		else
		if (xpix > 160 && xpix < 480 && ypix < 120 && isEnd == 1)  //end, change title
		begin
			//data <= info_end;
			if (info_end == 0) begin
			  data <= 8'b11111111;
			end else begin
			  data <= 8'b01101000;
			end
		end
		else
		if (xpix > 160 && xpix < 480 && ypix > 120 && ypix < 440) //in game
		begin
			if (xpix <= 168 || (xpix > 238 && xpix <= 246) || (xpix > 316 && xpix <= 324) || (xpix > 394 && xpix <= 402) || xpix > 472
			||  ypix <= 128 || (ypix > 198 && ypix <= 206) || (ypix > 276 && ypix <= 284) || (ypix > 354 && ypix <= 362) || ypix > 432)
			begin
				data <= 8'b101_101_10;
			end
			else
			begin
				case (map[(((y << 2) + x) * 4 + 3)-:4])
					0:
					begin
						data <= 8'b11011010;
					end
					1:
					begin
						if (info_number == 0)
						begin
							data <= 8'b11111011;
						end
						else
						begin
							data <= 8'b01101000;
						end
					end
					2:
					begin
						if (info_number == 0)
						begin
							data <= 8'b11111010;
						end
						else
						begin
							data <= 8'b01101000;
						end
					end
					3:
					begin
						if (info_number == 0)
						begin
							data <= 8'b11110110;
						end
						else
						begin
							data <= 8'b11111111;
						end
					end
					4:
					begin
						if (info_number == 0)
						begin
							data <= 8'b11101101;
						end
						else
						begin
							data <= 8'b11111111;
						end
					end
					5:
					begin
						if (info_number == 0)
						begin
							data <= 8'b11101001;
						end
						else
						begin
							data <= 8'b11111111;
						end
					end
					6:
					begin
						if (info_number == 0)
						begin
							data <= 8'b11100000;
						end
						else
						begin
							data <= 8'b11111111;
						end
					end
					7:
					begin
						if (info_number == 0)
						begin
							data <= 8'b11011100;
						end
						else
						begin
							data <= 8'b11111111;
						end
					end
					8:
					begin
						if (info_number == 0)
						begin
							data <= 8'b11011101;
						end
						else
						begin
							data <= 8'b11111111;
						end
					end
					9:
					begin
						if (info_number == 0)
						begin
							data <= 8'b11011110;
						end
						else
						begin
							data <= 8'b11111111;
						end
					end
					10:
					begin
						if (info_number == 0)
						begin
							data <= 8'b11011111;
						end
						else
						begin
							data <= 8'b11111111;
						end
					end
					11:
					begin
						if (info_number == 0)
						begin
							data <= 8'b00001011;
						end
						else
						begin
							data <= 8'b11111111;
						end
					end
				endcase
			end
		end
		else
		if (xpix > 160 && xpix < 480 && ypix < 120)  //normal title
		begin
			if (info_title == 0)
			begin
				data <= 8'b11111111;
			end
			else
			begin
				data <= 8'b01101000;
			end
		end
		else
		begin
			data <= 8'b11111111;
		end
	end


endmodule
