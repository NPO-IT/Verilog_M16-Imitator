module m1Filler(
	input reset,
	input clk,
	input bufGetWord,
	input [6:0]bufRdPointer,
	input [4:0]cntGrp,
	output reg [11:0]dataWord
);

reg once2, once1, once3;
reg [9:0]dat1012, dat6012;
reg [7:0]datCnt3;
always@(negedge reset or posedge clk)begin
	if (~reset) begin
		dataWord <= 0;
		dat1012 <= 0;
		dat6012 <= 0;
		datCnt3 <= 0;
		once1 <= 0;
		once2 <= 0;
		once3 <= 0;
		dataWord <= 0;
	end else begin
			if(bufGetWord) begin
				case(bufRdPointer)
					2:
					begin
						dataWord <= {1'b0, dat1012[9:0],1'b0};
						if(once1==0)begin
							dat1012 <= dat1012 + 1'b1;
							once1=1;
						end
					end
					34:
					begin
						dataWord <= {1'b0, dat6012[9:0],1'b0};
						if(once2 == 0)begin
							if(cntGrp == 0) begin
								dat6012 <= dat6012 + 1'b1;
								once2<=1;
							end
						end
					end
					1,5,9,13,17,21,25,29,33,37,41,45,49,53,57,61,65,69,73,77,81,85,89,93,97,101,105,109,113,117,121,125:
					begin
						dataWord <= {1'b0, datCnt3[7:0],3'b0};
						if(once3==0)begin
							datCnt3 <= datCnt3 + 1'b1;
							once3<=1;
						end
					end
					default: begin
						dataWord <= {1'b0, 8'd0, 3'b010};
						once1 <= 0;
						once2 <= 0;
						once3 <= 0;
					end
				endcase
			end

	end
end
endmodule
