
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


module Control(
    inst,
    control_out,
    control_jump,
    control_ALU
    );
    
input inst;
output control_out;
output control_jump;
output control_ALU;

wire [31:0] inst;
reg [5:0] control_out;
reg [1:0] control_jump;
reg [2:0] control_ALU;

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

/*

control_out[5] = selector de dato de wb
control_out[4] = escritura en mem de registros
control_out[3] = lectura de mem de datos
control_out[2] = escritura de mem de datos
control_out[1] = selector de mux b
control_out[0] = selector de mux b

*/

/*
Casos de control de mux en B
00 = op_b (registro)
01 = extendido en cero
10 = extendido en signo

Casos de salida data
0 = mem
1 = alu

*/

always @*
begin
   if (inst[31:26] == 0) begin
       case (inst[5:0])
       6'b000000: begin 
           control_ALU <= 3'b000;
       end
       6'b000001: begin 
           control_ALU <= 3'b010;
       end
       6'b000010: begin 
           control_ALU <= 3'b011;
       end
       6'b000011: begin 
           control_ALU <= 3'b000;
       end
       6'b000100: begin 
           control_ALU <= 3'b001;
       end
       6'b000101: begin 
           control_ALU <= 3'b101;
       end
       6'b000110: begin 
           control_ALU <= 3'b110;
       end
       6'b000111: begin 
           control_ALU <= 3'b111;
       end
       default: control_ALU <= 3'b000; 
       endcase
   end
   else begin
       case (inst[31:26])
       6'b000001: begin 
           control_ALU <= 3'b010;
       end
       6'b000010: begin 
           control_ALU <= 3'b011;
       end
       6'b000011: begin 
           control_ALU <= 3'b000;
       end
       6'b000100: begin 
           control_ALU <= 3'b100;
       end
       6'b000101: begin 
           control_ALU <= 3'b101;
       end
       6'b000110: begin 
           control_ALU <= 3'b000;
       end
       6'b000111: begin 
           control_ALU <= 3'b000;
       end
       6'b001000: begin 
           control_ALU <= 3'b000;
       end
       default: control_ALU <= 3'b000; 
       endcase
   end
       
end

always @*
begin
    if (inst[31:26] == 4) begin //beq
        control_jump <= 2'b00;
    end 
    else if (inst[31:26] == 5) begin //bne
        control_jump <= 2'b01;
    end
    else if (inst[31:26] == 8) begin //j
        control_jump <= 2'b10;    
    end
    else begin
        control_jump <= 2'b11;//
    end    
end

always @*
begin
   if (inst[31:26] == 0) begin
       if (inst[5:0] == 0) begin
           control_out <= 6'b100000; 
       end
       else begin
           control_out <= 6'b110000; 
       end
   end
   else begin
       case (inst[31:26])
       6'b000001: begin 
           control_out <= 6'b110001;
       end
       6'b000010: begin 
           control_out <= 6'b110001;
       end
       6'b000011: begin 
           control_out <= 6'b110010;
       end
       6'b000100: begin 
           control_out <= 6'b100001;
       end
       6'b000101: begin 
           control_out <= 6'b100001;
       end
       6'b000110: begin 
           control_out <= 6'b011010;
       end
       6'b000111: begin 
           control_out <= 6'b000110;
       end
       6'b001000: begin 
           control_out <= 6'b100001;
       end
       default: control_out <= 6'b100000; 
       endcase
   end
       
end
    
endmodule

