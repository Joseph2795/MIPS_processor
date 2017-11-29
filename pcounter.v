`timescale 1ns / 1ps

module pcounter(
    input wire clk,
    input wire [4:0] dir_j,
    input wire [4:0] dir_b,
    input wire [1:0] pc_sig,
    output reg [4:0] pc
    );
    initial
    begin
    pc = 5'hff;
    end
    
    always@(negedge clk)
        begin
        case (pc_sig)
            default:
                pc <= pc+1;
            2'b01:
                pc <= dir_j;
            2'b10:
                pc <= dir_b;    
        endcase 
        end
    
//    always@(negedge clk)
//        begin
//            pc <= pc_sig;    
//        end
    
endmodule
