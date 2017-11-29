`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yo
// 
// Create Date: 09/20/2017 04:05:21 PM
// Design Name: 
// Module Name: reg_mem
// Project Name: MIPS_processor
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
`timescale 1ns / 1ps
module reg_mem (
clk, // Clock Input
we,
address_rs     , // Address Input
address_rt     , // Address Input
address_rd     , // Address Input
data_outA   ,
data_outB   ,
data,
data_outC
); 

parameter DATA_WIDTH = 32 ;
parameter ADDR_WIDTH = 5 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

//--------------Input Ports----------------------- 

input [ADDR_WIDTH-1:0] address_rs     ;
input [ADDR_WIDTH-1:0] address_rt     ;
input [ADDR_WIDTH-1:0] address_rd     ;

reg [DATA_WIDTH-1:0] address_rsr;
reg [DATA_WIDTH-1:0] address_rtr     ;
reg [DATA_WIDTH-1:0] address_test     ;

//--------------Inout Ports----------------------- 
output data_outA       ;
output data_outB       ;
output data_outC ;
input clk;
input we;
input data ;

//--------------Internal variables---------------- 
wire [DATA_WIDTH-1:0] data_outA ;
wire [DATA_WIDTH-1:0] data_outB ;
wire [DATA_WIDTH-1:0] data_outC ;


wire [DATA_WIDTH-1:0] data ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];


initial begin
    mem[0] <= 0;
    mem[1] <= 1;
    mem[2] <= 2;
    mem[3] <= 3;
    mem[4] <= 4;
    mem[5] <= 5;
    mem[6] <= 6;
    mem[7] <= 33;
    mem[8] <= 8;
    mem[9] <= 9;
    mem[10] <= 10;
    mem[11] <= 11;
    mem[12] <= 12;
    mem[13] <= 13;
    mem[14] <= 14;
    mem[15] <= 15;
    mem[16] <= 16;
    mem[17] <= 17;
    mem[18] <= 18;
    mem[19] <= 19;
    mem[20] <= 20;
//    mem[21] <= 21;
//    mem[22] <= 22;
//    mem[23] <= 23;
//    mem[24] <= 24;
//    mem[25] <= 25;
//    mem[26] <= 26;
//    mem[27] <= 27;
//    mem[28] <= 28;
//    mem[29] <= 29;
//    mem[30] <= 30;
//    mem[31] <= 31;    
end

//--------------Code Starts Here------------------ 

// Tri-State Buffer control 
// output : When we = 0, oe = 1, cs = 1

// Memory Write Block 
// Write+ Operation : When we = 1, cs = 1
always @(posedge clk)
begin
    address_rsr <= mem[address_rs];
    address_rtr <= mem[address_rt];
end

always @(negedge clk)
begin
    if (we) begin
        mem[address_rd] <= data;
    end
end

assign data_outA = address_rsr      ;
assign data_outB = address_rtr     ;
assign data_outC = mem[20];

endmodule

