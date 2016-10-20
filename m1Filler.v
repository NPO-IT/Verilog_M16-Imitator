module m1Filler(
	input reset,
	input clk,
	input bufGetWord,
	input [6:0]bufRdPointer,
	output reg [11:0]dataWord
);

reg once2, once1;
reg [7:0]dat1012, dat6012;
always@(negedge reset or posedge clk)begin
	if (~reset) begin
		dataWord <= 0;
		dat1012 <= 0;
		dat6012 <= 0;
		once1 <= 0;
		once2 <= 0;
		dataWord <= 0;
	end else begin
			if(bufGetWord) begin
				case(bufRdPointer)
					0,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60,64,68,72,76,80,84,88,92,96,100,104,108,112,116,120,124:
					begin // up count a10-b12-с12
						dataWord <= {1'b0, dat1012[7:0],3'b0};
						if ((bufRdPointer == 0) || (bufRdPointer == 64)) begin
							if(once1==0)begin
								dat1012 <= dat1012 + 1'b1;
								once1=1;
							end
						end
					end
					1,5,9,13,17,21,25,29,33,37,41,45,49,53,57,61,65,69,73,77,81,85,89,93,97,101,105,109,113,117,121,125:
					begin	// down count a20-b12-с12
						dataWord <= {1'b0, dat6012[7:0],3'b0};
						if(once2==0)begin
							dat6012 <= dat6012 - 1'b1;
							once2=1;
						end
					end
					2,6,10,14,18,22,26,30,34,38,42,46,50,54,58,62,66,70,74,78,82,86,90,94,98,102,106,110,114,118,122,126:
					begin
						dataWord <= {1'b0, 8'd111, 3'b0};
						once1=0;
						once2=0;
					end
					3,7,11,15,19,23,27,31,35,39,43,47,51,55,59,63,67,71,75,79,83,87,91,95,99,103,107,111,115,119,123,127:
					begin
						dataWord <= {1'b0, 8'd222, 3'b0};
					end
					default: dataWord <= {1'b0, 8'd0, 3'b010};
				endcase
			end

	end
end
endmodule
