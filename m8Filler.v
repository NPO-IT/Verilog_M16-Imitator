module m8Filler(
	input reset,
	input clk,
	input bufGetWord,
	input [9:0]bufRdPointer,
	output reg [11:0]dataWord
);

reg once3, once2, once1;
reg [7:0]dat1012, dat6012;
reg [9:0]slow128;
reg [4:0]grpCnt;

always@(negedge reset or posedge clk)begin
	if (~reset) begin
		dataWord <= 0;
		dat1012 <= 0;
		dat6012 <= 0;
		once1 <= 0;
		once2 <= 0;
		once3 <= 0;
		slow128 <= 0;
		grpCnt <= 0;
	end else begin
		
			if(bufGetWord) begin

				case((bufRdPointer))
					0:
					begin // up count a10-b12
						dataWord <= {1'b0, dat1012[7:0],3'b001};
						//if ((bufRdPointer == 0) || (bufRdPointer == 512)) begin
							if(once1==0)begin
								dat1012 <= dat1012 + 1'b1;
								once1<=1;
							end
						//end
					end
/*					5,21,37,53,69,85,101,117,133,149,165,181,197,213,229,245,261,277,293,309,325,341,357,373,389,405,421,437,453,469,485,501,517,533,549,565,581,597,613,629,645,661,677,693,709,725,741,757,773,789,805,821,837,853,869,885,901,917,933,949,965,981,997,1013:
					begin	// down count a60-b12
						dataWord <= {1'b0, dat6012[7:0],3'b001};
						if(once2==0)begin
							dat6012 <= dat6012 - 1'b1;
							once2=1;
						end
					end
					1,17,33,49,65,81,97,113,129,145,161,177,193,209,225,241,257,273,289,305,321,337,353,369,385,401,417,433,449,465,481,497,513,529,545,561,577,593,609,625,641,657,673,689,705,721,737,753,769,785,801,817,833,849,865,881,897,913,929,945,961,977,993,1009:
					begin
						dataWord <= {1'b0, 8'd11, 3'b0};
						once1=0;
					end
					2,18,34,50,66,82,98,114,130,146,162,178,194,210,226,242,258,274,290,306,322,338,354,370,386,402,418,434,450,466,482,498,514,530,546,562,578,594,610,626,642,658,674,690,706,722,738,754,770,786,802,818,834,850,866,882,898,914,930,946,962,978,994,1010:
					begin
						dataWord <= {1'b0, 8'd22, 3'b0};
					end
					3,19,35,51,67,83,99,115,131,147,163,179,195,211,227,243,259,275,291,307,323,339,355,371,387,403,419,435,451,467,483,499,515,531,547,563,579,595,611,627,643,659,675,691,707,723,739,755,771,787,803,819,835,851,867,883,899,915,931,947,963,979,995,1011:
					begin
						dataWord <= {1'b0, 8'd33, 3'b0};
					end
					4,20,36,52,68,84,100,116,132,148,164,180,196,212,228,244,260,276,292,308,324,340,356,372,388,404,420,436,452,468,484,500,516,532,548,564,580,596,612,628,644,660,676,692,708,724,740,756,772,788,804,820,836,852,868,884,900,916,932,948,964,980,996,1012:
					begin
						dataWord <= {1'b0, 8'd44, 3'b0};
					end
					6,22,38,54,70,86,102,118,134,150,166,182,198,214,230,246,262,278,294,310,326,342,358,374,390,406,422,438,454,470,486,502,518,534,550,566,582,598,614,630,646,662,678,694,710,726,742,758,774,790,806,822,838,854,870,886,902,918,934,950,966,982,998,1014:
					begin
						dataWord <= {1'b0, 8'd66, 3'b0};
						once2=0;
					end
					7,23,39,55,71,87,103,119,135,151,167,183,199,215,231,247,263,279,295,311,327,343,359,375,391,407,423,439,455,471,487,503,519,535,551,567,583,599,615,631,647,663,679,695,711,727,743,759,775,791,807,823,839,855,871,887,903,919,935,951,967,983,999,1015:
					begin
						dataWord <= {1'b0, 8'd77, 3'b001};////////////////////
					end
					8,24,40,56,72,88,104,120,136,152,168,184,200,216,232,248,264,280,296,312,328,344,360,376,392,408,424,440,456,472,488,504,520,536,552,568,584,600,616,632,648,664,680,696,712,728,744,760,776,792,808,824,840,856,872,888,904,920,936,952,968,984,1000,1016:
					begin
						dataWord <= {1'b0, 8'd88, 3'b0};
					end
					//9,25,41,57,73,89,105,121,137,153,169,185,201,217,233,249,265,281,297,313,329,345,361,377,393,409,425,441,457,473,489,505,521,537,553,569,585,601,617,633,649,665,681,697,713,729,745,761,777,793,809,825,841,857,873,889,905,921,937,953,969,985,1001,1017:
					297:
					begin
						if (once3 == 0)begin		// on this stage = 128hz
							//slow128 <= slow128 + 1'b1;
							once3 <= 1;
							grpCnt <= grpCnt + 1'b1;
							if (grpCnt == 0)				// on this stage = 4hz
								slow128 <= slow128 + 1'b1;
						end
						dataWord <= {1'b0, slow128, 1'b0};
					end
					10,26,42,58,74,90,106,122,138,154,170,186,202,218,234,250,266,282,298,314,330,346,362,378,394,410,426,442,458,474,490,506,522,538,554,570,586,602,618,634,650,666,682,698,714,730,746,762,778,794,810,826,842,858,874,890,906,922,938,954,970,986,1002,1018:
					begin
						dataWord <= {1'b0, 8'd101, 3'b0};
						once3 <= 0;
					end
					11,27,43,59,75,91,107,123,139,155,171,187,203,219,235,251,267,283,299,315,331,347,363,379,395,411,427,443,459,475,491,507,523,539,555,571,587,603,619,635,651,667,683,699,715,731,747,763,779,795,811,827,843,859,875,891,907,923,939,955,971,987,1003,1019:
					begin
						dataWord <= {1'b0, 8'd111, 3'b0};
					end
					12,28,44,60,76,92,108,124,140,156,172,188,204,220,236,252,268,284,300,316,332,348,364,380,396,412,428,444,460,476,492,508,524,540,556,572,588,604,620,636,652,668,684,700,716,732,748,764,780,796,812,828,844,860,876,892,908,924,940,956,972,988,1004,1020:
					begin
						dataWord <= {1'b0, 8'd121, 3'b0};
					end
					13,29,45,61,77,93,109,125,141,157,173,189,205,221,237,253,269,285,301,317,333,349,365,381,397,413,429,445,461,477,493,509,525,541,557,573,589,605,621,637,653,669,685,701,717,733,749,765,781,797,813,829,845,861,877,893,909,925,941,957,973,989,1005,1021:
					begin
						dataWord <= {1'b0, 8'd131, 3'b0};
					end
					14,30,46,62,78,94,110,126,142,158,174,190,206,222,238,254,270,286,302,318,334,350,366,382,398,414,430,446,462,478,494,510,526,542,558,574,590,606,622,638,654,670,686,702,718,734,750,766,782,798,814,830,846,862,878,894,910,926,942,958,974,990,1006,1022:
					begin
						dataWord <= {1'b0, 8'd141, 3'b0};
					end
					15,31,47,63,79,95,111,127,143,159,175,191,207,223,239,255,271,287,303,319,335,351,367,383,399,415,431,447,463,479,495,511,527,543,559,575,591,607,623,639,655,671,687,703,719,735,751,767,783,799,815,831,847,863,879,895,911,927,943,959,975,991,1007,1023:
					begin
						dataWord <= {1'b0, 8'd151, 3'b0};/////////////////
					end
					*/
					default: begin
						dataWord <= {1'b0, 8'd0, 3'b010};
						once1<=0;
					end
				endcase
			end

	end
end
endmodule
