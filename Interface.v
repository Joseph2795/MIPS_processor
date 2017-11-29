`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2017 10:58:27 AM
// Design Name: 
// Module Name: Interface
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


module Interface(
    clk,
    op_C,
    PC
);

input clk;
output op_C;
output PC; 

reg [5:0] arra;
reg [4:0] PC_reg = 0;
wire [4:0] PC;
wire [1:0] PC_sig;
wire [31:0] ALU_res;
wire [31:0] imm_signext;
wire [31:0] imm_zeroext;
wire zero;
wire [31:0] data;

reg [31:0] reg_ifid;
reg [1:0] control_pc;
reg [143:0] reg_idex;
reg [79:0] reg_exmem;
reg [79:0] reg_memwb;
wire [31:0] MEM_instrucciones_out;
wire [31:0] MEM_instrucciones_out_2;
wire [31:0] op_A;
wire [31:0] op_B;
wire [31:0] op_C;
reg [31:0] ALU_op_B;
wire [31:0] MEM_dataout;
reg [31:0] dato_memreg;
reg [5:0] control_out;
reg [1:0] control_jump;
reg [2:0] control_ALU;
wire [4:0] reg_rs;
wire [4:0] reg_rt;
wire [4:0] reg_rd;
wire [31:0] mem_o_reg;
wire [2:0] control_ALUw;
wire [31:0] ALU_oper;
wire [31:0] oper_a;
wire we;
wire [4:0] dir_j;
wire [4:0] dir_b;
wire [1:0] control_pcw;
wire we_ram;
wire rd_ram;
wire [3:0] address_mem;

assign reg_rs = reg_ifid[25:21];
assign reg_rt = reg_ifid[20:16];
assign reg_rd = reg_memwb[79:75];
assign mem_o_reg = dato_memreg;
assign control_ALUw = reg_idex[138:136];
assign ALU_oper = ALU_op_B;
assign oper_a = reg_idex[63:32];
assign we = reg_memwb[68];
assign dir_b = imm_zeroext[4:0];
assign dir_j = reg_ifid[4:0];
assign we_ram = reg_exmem[66];
assign rd_ram = reg_exmem[67];
assign address_mem = reg_exmem[35:32];
assign data = reg_exmem[31:0];
assign control_pcw = control_pc;

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
reg_ifid[20:16] = rte
reg_ifid[15:0] = immediate

Tipo J

reg_ifid[31:26] = opcode
reg_ifid[25:0] = address

*/

//bus de control
/*

control_out[5] = selector de dato de wb (69)
control_out[4] = escritura en mem de registros (68)
control_out[3] = lectura de mem de datos (67)
control_out[2] = escritura de mem de datos (66)
control_out[1] = selector de mux b (65)
control_out[0] = selector de mux b (64)

*/

/*
Casos de control de mux en B
00 = op_b (registro)
01 = extendido en cero
10 = extendido en signo
*/

always @*
begin
   if (reg_ifid[31:26] == 0) begin
       case (reg_ifid[5:0])
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
       case (reg_ifid[31:26])
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
           control_ALU <= 3'b111;
       end
       6'b000101: begin 
           control_ALU <= 3'b111;
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
    if (reg_ifid[31:26] == 4) begin //beq
        control_jump <= 2'b00;
    end 
    else if (reg_ifid[31:26] == 5) begin //bne
        control_jump <= 2'b01;
    end
    else if (reg_ifid[31:26] == 8) begin //j
        control_jump <= 2'b10;    
    end
    else begin
        control_jump <= 2'b11;//
    end    
end

always @*
begin
    if (reg_ifid[31:26] == 0) begin //beq
        arra <= reg_ifid[15:11];
    end 
    else begin
        arra <= reg_ifid[20:16]; 
    
    end   
end

always @*
begin
   if (reg_ifid[31:26] == 0) begin
       if (reg_ifid[5:0] == 0) begin
           control_out <= 6'b100000; 
       end
       else begin
           control_out <= 6'b110000; 
       end
   end
   else begin
       case (reg_ifid[31:26])
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

always @(negedge clk) begin
    reg_ifid <= MEM_instrucciones_out;
    reg_idex <= {arra,control_ALU,control_jump,control_out,imm_zeroext,imm_signext,op_A,op_B};
    reg_exmem <= {reg_idex[143:128],ALU_res,reg_idex[31:0]};
    reg_memwb <= {reg_exmem[79:64],reg_exmem[63:32],MEM_dataout};
end

always @* begin

if (control_jump == 2'b10) begin 
    control_pc <= 2'b01; end
else begin 
    if (reg_idex[135:134] == 2'b00 && (reg_idex[31:0] == reg_idex[63:32])) begin
        control_pc <= 2'b10; end  
    else if (reg_idex[135:134] == 2'b01 && (reg_idex[31:0] != reg_idex[63:32])) begin
        control_pc <= 2'b10; end
    else begin 
        control_pc <= 2'b11; end
    end   
end


always @* begin
case (reg_idex[129:128])
2'b00: begin 
    ALU_op_B <= reg_idex[31:0];
end
2'b01: begin
    ALU_op_B <= reg_idex[127:96]; 
end
2'b10: begin 
    ALU_op_B <= reg_idex[95:64];
end
default: ALU_op_B <= reg_idex[31:0]; 
endcase

end

always @* begin
case (reg_memwb[69])
1'b0: begin 
    dato_memreg <= reg_memwb[31:0]; 
end
1'b1: begin
    dato_memreg <= reg_memwb[63:32]; 
end
default: dato_memreg <= reg_memwb[63:32]; 
endcase

end

reg_mem memoria_regs (.clk(clk), .we(we), .address_rs(reg_rs), .address_rt(reg_rt), .address_rd(reg_rd), .data_outA(op_A), .data_outB(op_B), .data(mem_o_reg), .data_outC(op_C));

sign_extension ext_signo (.a(reg_ifid[15:0]), .a_ext(imm_signext));

zero_extension ext_zero (.a(reg_ifid[15:0]), .a_ext(imm_zeroext));

ALU ALu (.clk(clk),.a(oper_a),.b(ALU_oper),.ALU_op(control_ALUw),.ALU_res(ALU_res),.zero(zero));

Ram_datos ram (.clk(clk), .we(we_ram), .rd(rd_ram), .address_mem(address_mem), .data(data), .data_out(MEM_dataout)); 

mem_inst memoria_inst(.dir(PC),.dir(PC+1),.ins(MEM_instrucciones_out),.ins2(MEM_instrucciones_out_2));

pcounter p_counter(.clk(clk),.dir_j(dir_j),.dir_b(dir_b),.pc_sig(control_pcw),.pc(PC));

endmodule
