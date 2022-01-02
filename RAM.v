module ram(a, d, we, clk);
  input  [15:0] d;
  input  [2:0] a;
  input        clk, we;
  reg    [15:0] mem [15:0];

  always @(posedge clk) begin
     if(we) begin 
      mem[a] <= d;
      $display("mem[%d] <== %b", a, d);
   end
  end

endmodule
