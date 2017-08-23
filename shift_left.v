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


module shift_left(a, a_out);

input a;
output a_out;

wire [31:0] a;
reg [31:0] a_out;

always @* begin
    a_out <= {a[31:2], 2'b0};
end

endmodule