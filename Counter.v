module Counter
(
	input clk,
	input switch,
	input reset,
	output wire [11:0]data,
	output reg [10:0]address,
	output reg wren,
	output reg test
);

`define WAIT 0
`define TX 1

reg tmp;
reg [10:0] count;
reg state;
reg [4:0]serial;
reg [3:0]cycle;

assign data[11:0] = {1'b0, count[9:0], 1'b0};

always@(posedge clk)
begin
if (reset) begin
serial <= 0;
cycle <= 0;
state <= 0;
count <= 0;
end else
begin
case (state)
	`WAIT: begin
		if (switch != tmp) state <= `TX; 
		test <= 1;
		tmp <= switch;
	end
	`TX: begin
		test <= 0;
		serial <= serial + 1'b1;
		case (serial)
			1,2,3: wren <= 1;
			4: wren <= 0;
			5: count <= count + 1'b1;
			6: cycle <= cycle + 1'b1;
			7: address <= address + 256;
			8: if (address > 2000) address <= 0;
			9: if (count == 1023) count <= 0;
			10: begin
				if (cycle == 8) begin
					state <= `WAIT;
					
					cycle <= 0;
				end
				serial <= 0;
			end
		endcase
	end
endcase
end
end
endmodule
