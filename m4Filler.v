module m4Filler(
	input reset,
	input clk,
	input bufGetWord,
	input [8:0]bufRdPointer,
	input [4:0]cntGrp,
	output reg [11:0]dataWord
);

reg once2, once1, once3;
reg [9:0]cnt1, cnt2;
reg [7:0]cnt3;
always@(negedge reset or posedge clk)begin
	if (~reset) begin
		dataWord <= 0;
		cnt1 <= 0;
		cnt2 <= 0;
		cnt3 <= 0;
		once1 <= 0;
		once2 <= 0;
		once3 <= 0;
		dataWord <= 0;
	end else begin
		
			if(bufGetWord) begin

				case((bufRdPointer))
					0:
					begin
						dataWord <= {1'b0, cnt1[9:0],1'b1};
						if(once1==0)begin
							cnt1 <= cnt1 + 1'b1;
							if(cnt1 == 500) cnt1 <= 0;
							once1<=1;
						end
					end
					149:
					begin
						dataWord <= {1'b0, cnt2[9:0], 1'b0};
						if (once3 == 0) begin
							once3 <= 1;
							if (cntGrp == 0)				// on this stage = 4hz
								cnt2 <= cnt2 + 1'b1;
						end
					end
					2,18,34,50,66,82,98,114,130,146,162,178,194,210,226,242,258,274,290,306,322,338,354,370,386,402,418,434,450,466,482,498:
					begin
						dataWord <= {1'b0, cnt3[7:0],3'b1};
						if(once2==0) begin
							cnt3 <= cnt3 + 1'b1;
							once2=1;
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
