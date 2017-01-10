module m2Filler(
	input reset,
	input clk,
	input bufGetWord,
	input [7:0]bufRdPointer,
	input [4:0]cntGrp,
	output reg [11:0]dataWord
);

reg once2, once1, once3, once4, once5, once6;
reg [9:0] datCnt1; 
reg [9:0] datCnt2;
reg [7:0] datCnt3;
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
					1:
					begin
						dataWord <= {1'b0, datCnt1[9:0],1'b0};
						if(once1==0)begin
							datCnt1 <= datCnt1 + 1'b1;
							once1<=1;
						end
					end
					89:
					begin
						dataWord <= {1'b0, datCnt2[9:0],1'b0};
						if(once2 == 0)begin
							if(cntGrp == 0) begin
								datCnt2 <= datCnt2 + 1'b1;
								once2<=1;
							end
						end
					end
					0,8,16,24,32,40,48,56,64,72,80,88,96,104,112,120,128,136,144,152,160,168,176,184,192,200,208,216,224,232,240,248:
					begin
						dataWord <= {1'b0, datCnt3[7:0],3'b0};
						if(once3==0)begin
							datCnt3 <= datCnt3 + 1'b1;
							once3<=1;
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
