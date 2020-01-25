`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:05:29 01/06/2020 
// Design Name: 
// Module Name:    Top_2048 
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

module Top_2048(
			input wire clk,   // clock 
			input wire [4:0] btn,  // 5 buttons reset, up, down, left, right
			output wire Hsync, // horizonal sync signal
			output wire Vsync, // vertical sync signal
			output wire [3:0] vgaRed, 
			output wire [3:0] vgaGreen,
			output wire [3:0] vgaBlue
    );

	wire clk25;  // 25MHz clock
	wire [7:0] data;  // RGB data of every pixel
	wire win;   // high if win
	wire lose; // high if lose
	wire [63:0] board; // game board
	wire visible; // high if in visible area of VGA monitor
	wire [9:0] hc; // horizonal sync count
	wire [9:0] vc; // vertical sync count
	wire [15:0] addrNumber; // address of numbers
	wire [15:0] addrTitle; // address of titles
	wire info_number; // 1 bit information output of number
	wire info_title; // 1 bit information output  of number
	wire info_win; // 1 bit information output of win_title
	wire info_end; // 1 bit information output of end_title


	/* Porduce 25MHz clock */
	clk25MHz m0(.clk(clk), .clk25(clk25));

	/* Confine the resolution to 640 * 480 */
	vga_resolution m1(.clk(clk25), .Hsync(Hsync), .Vsync(Vsync), .hc(hc), .vc(vc), .vidon(visible));

	/* Display on VGA monitor */
	vga_display m2(.clk(clk25), .vidon(visible), .data(data), .vgaRed(vgaRed), .vgaGreen(vgaGreen), .vgaBlue(vgaBlue));

	/* Design the interface */
	interface m3(.clk(clk25), .vidon(visible), .hc(hc), .vc(vc), .win(win), .isEnd(lose), .map(board),
	.data(data), .addrNumber(addrNumber), .addrTitle(addrTitle), 
	.info_number(info_number), .info_title(info_title), .info_win(info_win), .info_end(info_end));

	/* ROMs designed by ourselves to save 1bit images */
	/* Numbers ROM */
	number m4(.addra(addrNumber), .clka(clk25), .douta(info_number));
	/* Titles ROM */
	title m5(.addra(addrTitle), .clka(clk25), .douta(info_title)); // default title
	end_title m6(.clka(clk25), .addra(addrTitle), .douta(info_end)); // win title
	win_title m7(.clka(clk25), .addra(addrTitle), .douta(info_win)); // lose title

	/* Game logic module */
	game_2048 m9( .clk(clk), .btn(btn[4:1]), .start(btn[0]), .Board_out(board), .ifEnd(lose), .success(win));
	
endmodule
