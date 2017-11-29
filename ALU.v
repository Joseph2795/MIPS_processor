`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TEC 
// Student: Joseph Blanco
// 
// Create Date: 08/23/2017 09:46:51 AM
// Design Name: 
// Module Name: ALU
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


module ALU(clk,a,b,ALU_op,ALU_res,zero);

input clk;
input a;
input b;
input ALU_op;
output ALU_res;
output zero;

wire [31:0] a;
wire [31:0] b;
wire [2:0] ALU_op;
reg  [31:0] ALU_res;
reg zero;

always @* begin
case (ALU_op)
3'b000: begin
    ALU_res <= a + b;
    zero <= 0; 
end
3'b001: begin
    ALU_res <= a - b;
    zero <= 0;
end
3'b010: begin
    ALU_res <= a | b;
    zero <= 0;   
end
3'b011: begin
    ALU_res <= a & b; 
    zero <= 0; 
end
3'b101: begin
    ALU_res <= ~(a | b);
    zero <= 0;   
end
3'b110: begin
    ALU_res <= ~a;
    zero <= 0;   
end
3'b111: begin
    ALU_res <= ALU_res;
    zero <= zero;       
end
endcase
end

endmodule
