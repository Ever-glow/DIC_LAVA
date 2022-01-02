`timescale 1ps/1ps
`include "ALUInst.v"


//Arthematic Logic Unit
module alu (Inst, A, BusWires, DelayedResult);

	input [3:0] Inst;
	input [7:0] A, BusWires;

	wire [3:0] Inst;
	wire [7:0] A, BusWires;

	output [15:0] DelayedResult;

	reg [15:0] Result;
	reg Zout, Sout, Cout;
			
	assign #700 DelayedResult = Result;
	
	always @(Inst  or A or BusWires or Result)
	begin
		Result = 15'b0;
    	case (Inst)  // synopsis  parallel_case
		`AluMultiply:	Result = (A * BusWires);
		`AluShl: 		Result = {A[6:0], 1'b0};				
		`AluShr: 		Result = {1'b0, A[7:1]};
		`AluRol: 		Result = {A[6:0], A[7]};
		`AluRor: 		Result = {A[0], A[7:1]};
		`AluAdd:		Result = A + BusWires;
		`AluSub:		Result = A - BusWires ;
		`AluAnd: 		Result = A & BusWires; 
		`AluNand:		Result = ~(A & BusWires); 
		`AluOr:  		Result = A | BusWires;
		`AluNor: 		Result = ~(A | BusWires);
		`AluNot:		Result = ~(A);
		default: 		Result = 15'b0;
	endcase	
end
	
endmodule