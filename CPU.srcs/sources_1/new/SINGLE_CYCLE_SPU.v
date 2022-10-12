`timescale 1ns / 1ps

module SINGLE_CYCLE_CPU(input clk, clk_bcd, rst, [1:0] ledSel, [3:0] ssdSel, output [6:0] LED_out, [7:0] Anode, reg [15:0] led);
wire [31:0] data_out;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;
wire [31:0] WriteData; //from mux
wire [31:0] ReadData1, ReadData2, ReadData;
wire [31:0] gen_out, ALUResult;
wire [3:0] ALU_Sel;
wire [31:0] MUX_ALU;
wire z;
reg [7:0] PC;
wire [7:0] Sum;
wire [31:0] ShiftLeftOut;
wire [31:0] Add4, MUX_ADD;
reg [12:0] SSD;



InstMem IM (PC[7:2], data_out);
Control_Unit CU (data_out [6:2], Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);
registerFile #(32) RF (clk, rst , RegWrite, data_out [19:15], data_out [24:20], data_out [11:7], WriteData, ReadData1, ReadData2);
ImmGen IG (data_out, gen_out);
ALU_ControlUnit ACU (data_out[30], ALUOp, data_out [14:12], ALU_Sel);
N_bit_ALU #(32) NALU (ReadData1, MUX_ALU, ALU_Sel, z, ALUResult);
DataMem DM (clk, MemRead,MemWrite, ALUResult[7:2], ReadData2, ReadData);
n_bit_ShiftLeft #(32) SL (gen_out, ShiftLeftOut);
BCD bcd (clk_bcd, SSD,LED_out, Anode);

assign WriteData = (MemtoReg)? ReadData: ALUResult;
assign MUX_ALU = (ALUSrc)? gen_out : ReadData2;
assign Sum = PC + ShiftLeftOut;
assign Add4 = 4 + PC;
assign MUX_ADD = (Branch & z)?Sum:Add4;

always@(posedge clk or posedge rst) 
begin
if (rst) PC = 0;
else PC = MUX_ADD;
end

always@(*)
begin
case (ledSel)

2'b00: led = data_out[15:0];
2'b01: led = data_out[31:16];
2'b10: led = {8'b00000000, ALUOp, ALU_Sel, z, (Branch & z)};
default: led = 0;

endcase
end

always@(*)
begin
case (ssdSel)

4'b0000: SSD = PC;
4'b0001: SSD = Add4;
4'b0010: SSD = Sum;
4'b0011: SSD = MUX_ADD;
4'b0100: SSD = ReadData1;
4'b0101: SSD = ReadData2;
4'b0110: SSD = WriteData;
4'B0111: SSD = gen_out;
4'b1000: SSD = ShiftLeftOut;
4'b1001: SSD = MUX_ALU;
4'b1010: SSD = ALUResult;
4'b1011: SSD = ReadData;
default: SSD = 0;

endcase
end



endmodule