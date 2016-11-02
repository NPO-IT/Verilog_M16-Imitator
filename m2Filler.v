module m2Filler(
	input reset,
	input clk,
	input bufGetWord,
	input [7:0]bufRdPointer,
	input [4:0]grpOddity,
	output reg [11:0]dataWord
);

reg once2, once1, once3;
reg [9:0] dat1012; 
reg [9:0] dat6012;
reg [9:0] dat50101012;
reg switchGroup;
always@(negedge reset or posedge clk)begin
	if (~reset) begin
		dataWord <= 0;
		dat1012 <= 0;
		dat6012 <= 0;
		dat50101012 <= 0;
		once1 <= 0;
		once2 <= 0;
		once3 <= 0;
		dataWord <= 0;
	end else begin
		
			if(bufGetWord) begin

				case((bufRdPointer))
					64:
					begin // up count a10-b12
						dataWord <= {1'b0, dat1012[9:0], 1'b0};
						//if ((bufRdPointer == 0) || (bufRdPointer == 128)) begin
							if(once1==0)begin
								dat1012 <= dat1012 + 1'b1;
								once1<=1;
							end
						//end
					end
					8:
					begin	// down count a20-b12
						if(once2==0)begin
							if(grpOddity[0]) begin								// нечётные группы
								dataWord <= {1'b0, dat6012[9:0],1'b0};
								dat6012 <= dat6012 - 1'b1;
							end
							once2<=1;
						end
					end
					0, 128:
					begin
						if(once3 == 0)begin
							dataWord <= {1'b0, 10'd110, 1'b0};
							once3 <= 1;
						end
					end
					default: 
					begin
						dataWord <= {1'b0, 8'd0, 3'b010};
						once1 <= 0;
						once2 <= 0;
						once3 <= 0;
					end
/*					5: 			//a50-b10-c10-d12
					begin
						if(once3 == 0)begin
							dataWord <= {1'b0, dat50101012[9:0],1'b0};
							dat50101012 <= dat50101012 + 1'b1;
							once3 <= 1;
						end
					end
*/
				endcase
			end

	end
end
endmodule
