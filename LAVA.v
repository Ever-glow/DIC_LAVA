`timescale 1ps/1ps
`define S0	3'b000
`define S1	3'b001
`define S2	3'b010
`define S3	3'b011
`define S4	3'b100

module lava(clk, rst);

input clk, rst;

reg [3:0] inst; // The "Registers"
reg [7:0] a1, buswires1, a2, buswires2; // The "Registers"
reg [2:0] raddr; 
reg [2:0] waddr;
reg [2:0] state; // State registers for the controller

reg we, inc;  // This is just to use always block for combinational logic
reg [2:0] next_state; // This is just to use always block for combinational logic

wire [7:0] result;
wire [35:0] data;


// Instantiate ROM, ALU, RAM here: Instantiate
	rom rom0 (.z(data), .a(raddr));
	alu alu0 (.Inst(inst), .A(a), .BusWires(buswires), .DelayedResult(result));
	ram ram0 (.a(waddr), .d(result), .we(we), .clk(clk)); // Dual-Port RAM
// Describe the behavior of the "Registers": Sequential logic, always? 
	always @(posedge clk) begin
			inst <=	data[19:16];
			a1 <= data[15:8];
			buswires1 <= data[7:0];
			a2 <= data[35:28];
			buswires2 <= data[27:20];
	end
// Program Counter, WAddr Counter:  always
// Describe a sequential logic here
// Update raddr, waddr depending on rst, inc and we.
	always @(posedge clk) begin
		if(~rst) begin
			raddr <= 0;
		end
		else begin
			if(inc) begin
				raddr <= raddr + 1;
			end
		end
	end
		
	always @(posedge clk) begin	
		if(~rst) begin
			waddr <= 0;
		end
		else begin
			if(we) begin
				waddr <= waddr + 1;
			end
		end
	end
// Controller: FSM
// Describe a combinational logic here: always
	always @(posedge clk) begin
		if(state == 0) begin
			next_state = state + 1;
		end
		else if(state == 1) begin
			next_state = state + 1;
			inc = 1;
		end
		else if(state == 2) begin
			we = 1;
			if(raddr == 7) begin
				next_state = state + 1;
				inc = 0;
			end
			else		
				inc = 1;
		end
		else if(state == 3) begin
			next_state = state + 1;
			we = 1;
		end
		else if(state == 4) begin
			next_state = 0;
			we = 0;
		end
	end
// Controller
// Describe a sequential logic for the controller: always
	always @(posedge clk) begin
		if(~rst) 
			state <= 0;
		else
			state <= next_state;
	end

endmodule