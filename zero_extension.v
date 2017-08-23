`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TEC
// Student: Joseph Blanco
// 
// Create Date: 08/23/2017 10:27:21 AM
// Design Name: 
// Module Name: zero_extension
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


module zero_extension(a, a_ext);

input a;
output a_ext;

wire [15:0] a;
reg [31:0] a_ext;

always @* begin
    a_ext <= {16'b0,a};
end

endmodule

