module m16Filler(
	input reset,
	input clk,
	input bufGetWord,
	input [10:0]bufRdPointer,
	input [4:0]cntGrp,
	output reg [11:0]dataWord
);

reg once1, once2, once3, once4, once5;
reg [7:0]cnt8up1;
reg [9:0]cnt10up1, cnt10dn1, cnt10up2, cnt8dn1;
always@(negedge reset or posedge clk)begin
	if (~reset) begin
		dataWord <= 0;
		cnt8up1 <= 0;
		cnt8dn1 <= 0;
		cnt10up1 <= 0;
		cnt10up2 <= 0;
		cnt10dn1 <= 0;
		once1 <= 0;
		once2 <= 0;
		once3 <= 0;
		once4 <= 0;
		once5 <= 0;
		dataWord <= 0;
	end else begin
		
			if(bufGetWord) begin

				case((bufRdPointer))
					0:
					begin
						dataWord <= {1'b0, cnt10up1[9:0],1'b0};
						if(once1 == 0)begin
							cnt10up1 <= cnt10up1 + 1'b1;
							once1 <= 1;
						end
					end
					594:
					begin
						if (once5 == 0) begin
							if (cntGrp == 0) begin
								cnt10up2 <= cnt10up2 + 1'b1;
								dataWord <= {1'b0, cnt10up2[9:0], 1'b0};
								once5 <= 1;
							end else begin
								dataWord <= {1'b0, 8'd0, 3'b010};
							end

						end
					end
					4,68,132,196,260,324,388,452,516,580,644,708,772,836,900,964,1028,1092,1156,1220,1284,1348,1412,1476,1540,1604,1668,1732,1796,1860,1924,1988:
					begin
						dataWord <= {1'b0, cnt8up1[7:0],1'b0};
						if(once4 == 0)begin
							cnt8up1 <= cnt8up1 + 1'b1;
							once4 <= 1;
						end
					end
					default: begin
						once1 <= 0;
						once2 <= 0;
						once3 <= 0;
						once4 <= 0;
						once5 <= 0;
						dataWord <= {1'b0, 8'd0, 3'b010};
					end
				endcase
			end

	end
end
endmodule
