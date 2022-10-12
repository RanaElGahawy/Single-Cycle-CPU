`timescale 1ns / 1ps


module SIM(    );
parameter CLK_P = 1500;
reg clk, clk_bcd, rst;
reg [1:0] ledSel;
reg [3:0] ssdSel;
wire[6:0] LED_out;
wire[7:0] Anode;
wire[15:0] led;

initial begin
    clk = 1'b0;
    forever begin
        #(CLK_P/2) clk = ~clk;
    end
end


SINGLE_CYCLE_CPU cpu(clk, clk_bcd, rst, ledSel, ssdSel, LED_out, Anode, led);

initial begin
    rst = 1'b1;#10;
    rst = 1'b0;
//    ledSel = 2'b00; ssdSel = 4'b0000; #100;
//    ledSel = 2'b01; ssdSel = 4'b0001; #100;
//    ledSel = 2'b10; ssdSel = 4'b0010; #100;
//    ssdSel = 4'b0011; #100;
//    ssdSel = 4'b0100; #100;
//    ssdSel = 4'b0101; #100;
//    ssdSel = 4'b0110; #100;
//    ssdSel = 4'b0111; #100;
//    ssdSel = 4'b1000; #100;
//    ssdSel = 4'b1001; #100
//    ssdSel = 4'b1010; #100;
//    ssdSel = 4'b1011; #100;
////    #CLK_P; #CLK_P; #CLK_P;
//    ledSel = 2'b00; ssdSel = 4'b0000; #100;
//    ledSel = 2'b01; ssdSel = 4'b0001; #100;
//    ledSel = 2'b10; ssdSel = 4'b0010; #100;
//    ssdSel = 4'b0011; #100;
//    ssdSel = 4'b0100; #100;
//    ssdSel = 4'b0101; #100;
//    ssdSel = 4'b0110; #100;
//    ssdSel = 4'b0111; #100;
//    ssdSel = 4'b1000; #100;
//    ssdSel = 4'b1001; #100
//    ssdSel = 4'b1010; #100;
//    ssdSel = 4'b1011; #100;

end

endmodule
