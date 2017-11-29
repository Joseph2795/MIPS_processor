`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2017 05:42:25 PM
// Design Name: 
// Module Name: Control_ALU
// Project Name: 
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


module Control_ALU(
    inst,
    control_out
    );
    
input inst;
output control_out;

wire [31:0] inst;
reg [2:0] control_out;

//distribución de instrucción
/*

Tipo R

reg_ifid[31:26] = opcode
reg_ifid[25:21] = rs
reg_ifid[20:16] = rt
reg_ifid[15:11] = rd
reg_ifid[10:6] = shamt
reg_ifid[5:0] = funct

Tipo I

reg_ifid[31:26] = opcode
reg_ifid[25:21] = rs
reg_ifid[20:16] = rt
reg_ifid[15:0] = immediate

Tipo J

reg_ifid[31:26] = opcode
reg_ifid[25:0] = address

*/

always @*
begin
   if (inst[31:26] == 0) begin
       case (inst[5:0])
       6'b000000: begin 
           control_out <= 3'b000;
       end
       6'b000001: begin 
           control_out <= 3'b010;
       end
       6'b000010: begin 
           control_out <= 3'b011;
       end
       6'b000011: begin 
           control_out <= 3'b000;
       end
       6'b000100: begin 
           control_out <= 3'b001;
       end
       6'b000101: begin 
           control_out <= 3'b101;
       end
       6'b000110: begin 
           control_out <= 3'b110;
       end
       6'b000111: begin 
           control_out <= 3'b111;
       end
       default: control_out <= 3'b000; 
       endcase
   end
   else begin
       case (inst[31:26])
       6'b000001: begin 
           control_out <= 3'b010;
       end
       6'b000010: begin 
           control_out <= 3'b011;
       end
       6'b000011: begin 
           control_out <= 3'b000;
       end
       6'b000100: begin 
           control_out <= 3'b100;
       end
       6'b000101: begin 
           control_out <= 3'b101;
       end
       6'b000110: begin 
           control_out <= 3'b000;
       end
       6'b000111: begin 
           control_out <= 3'b000;
       end
       6'b001000: begin 
           control_out <= 3'b000;
       end
       default: control_out <= 3'b000; 
       endcase
   end
       
end
    
endmodule
