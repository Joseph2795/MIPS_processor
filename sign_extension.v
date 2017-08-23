`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TEC
// Student: Joseph Blanco
// 
// Create Date: 08/23/2017 10:27:21 AM
// Design Name: 
// Module Name: sign_extension
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


module sign_extension(a, a_ext);

input a;
output a_ext;

wire [15:0] a;
reg [31:0] b;

always @* begin
if (a[15] <= 1)
    b <= {16'b1,a};
else
    b <= {16'b0,a};
end

endmodule
