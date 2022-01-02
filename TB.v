`timescale 1ps/1ps

module tb;

reg clk;
reg rst;

always 
  #500 clk = ~clk;

initial begin
  clk = 1;
  rst = 1;
  #2500 rst = 0;
  #1000 rst = 1;
end

lava cpu(clk, rst);

endmodule;