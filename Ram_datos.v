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
module Ram_datos (
clk, // Clock Input
we, rd,
address_mem     , // Address Input
data,
data_out   
); 

parameter DATA_WIDTH = 32 ;
parameter ADDR_WIDTH = 4 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

//--------------Input Ports----------------------- 

input [ADDR_WIDTH-1:0] address_mem;

//--------------Inout Ports----------------------- 
input data     ;
output data_out      ;
input clk;
input we;
input rd;

//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0] data_out ;
reg [DATA_WIDTH-1:0] data_outB ;


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
    mem[10] <= 33;
    mem[11] <= 11;
    mem[12] <= 12;
    mem[13] <= 13;
    mem[14] <= 14;
    mem[15] <= 15;    
end


//--------------Code Starts Here------------------ 


always @*
begin
    if (!we && rd) begin
        data_out <= mem[address_mem];
        mem[address_mem] <= mem[address_mem]; end
    else if (!rd && we) begin
        mem[address_mem] <= data;
        data_out <= data_out; end
end

endmodule
