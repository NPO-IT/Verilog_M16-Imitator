module m2Filler(
	input reset,
	input clk,
	input bufGetWord,
	input [7:0]bufRdPointer,
	input grpOddity,
	output reg [11:0]dataWord
);

reg once2, once1, once3, once4, once5, once6;
reg [9:0] datCnt1; 
reg [9:0] datCnt2;
reg [9:0] datCnt3;
reg [9:0] datCnt4;
reg [7:0] datCnt5;
reg [9:0] datCnt6;

reg switchGroup;
always@(negedge reset or posedge clk)begin
	if (~reset) begin
		dataWord <= 0;
		datCnt1 <= 0;
		datCnt2 <= 0;
		datCnt3 <= 0;
		datCnt4 <= 0;
		datCnt5 <= 0;
		datCnt6 <= 0;
		once1 <= 0;
		once2 <= 0;
		once3 <= 0;
		once4 <= 0;
		once5 <= 0;
		once6 <= 0;
		dataWord <= 0;
	end else begin
		
			if(bufGetWord) begin

				case((bufRdPointer))
					80:
					begin	// down count a20-b12
						if(once1==0)begin
							if(grpOddity) begin								// нечётные группы
								dataWord <= {1'b0, datCnt1[9:0],1'b0};
								datCnt1 <= datCnt1 + 1'b1;
							end
							once1<=1;
						end
					end
					248:
					begin	// down count a20-b12
						if(once2==0)begin
							if(grpOddity) begin								// нечётные группы
								dataWord <= {1'b0, datCnt2[9:0],1'b0};
								datCnt2 <= datCnt2 + 1'b1;
							end
							once2<=1;
						end
					end
					200:
					begin	// down count a20-b12
						if(once3==0)begin
							if(grpOddity) begin								// нечётные группы
								dataWord <= {1'b0, datCnt3[9:0],1'b0};
								datCnt3 <= datCnt3 + 1'b1;
							end
							once3<=1;
						end
					end
					26,90,154,218:
					begin
						if(once4 == 0)begin
							dataWord <= {1'b0, datCnt4[9:0], 1'b0};
							datCnt4 <= datCnt4 + 1'b1;
							once4 <= 1;
						end
					end
					0:
					begin
						if(once5 == 0)begin
							dataWord <= {1'b0, datCnt6[9:0], 1'b0};
							datCnt6 <= datCnt6 + 1'b1;
							once5 <= 1;
						end
					end
					1,5,9,13,17,21,25,29,33,37,41,45,49,53,57,61,65,69,73,77,81,85,89,93,97,101,105,109,113,117,121,125,129,133,137,141,145,149,153,157,161,165,169,173,177,181,185,189,193,197,201,205,209,213,217,221,225,229,233,237,241,245,249,253:
					begin
						if(once6 == 0)begin
							dataWord <= {1'b0, datCnt5[7:0], 3'b0};
							datCnt5 <= datCnt5 + 1'b1;
							once6 <= 1;
						end
					end
					default: 
					begin
						dataWord <= {1'b0, 8'd0, 3'b010};
						once1 <= 0;
						once2 <= 0;
						once3 <= 0;
						once4 <= 0;
						once5 <= 0;
						once6 <= 0;
					end

				endcase
			end

	end
end
endmodule
