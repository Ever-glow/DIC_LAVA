`timescale 1ps/1ps

module rom(z, a);
  output [39:0] z;
  input  [2:0] a; 
  // declares a memory rom of 8 4-bit registers.
  //The indices are 0 to 7
reg    [39:0] rom[0:15]; 
wire   [39:0] z;
  // NOTE:  To infer combinational logic instead of a ROM, use
  // (* synthesis, logic_block *)
 
initial $readmemb("rom.data", rom); 

assign #700 z = rom[a];


endmodule