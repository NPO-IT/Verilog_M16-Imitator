module m16imit(
	input clk100,										// 100'663'296 Hz
	output Orb_serial,
	output Orb_M8,
	output Orb_M4,
	output Orb_M2,
	output Orb_M1	
);
wire aclr, clk, clk4, clk2, clk1;
globalReset aClear (.clk(clk100), .rst(aclr));
divReg clkDivider(.reset(aclr), .iClkIN(clk100), .Outdiv8(clk));
divReg clkDiv4(.reset(aclr), .iClkIN(clk100), .Outdiv16(clk4));
divReg clkDiv2(.reset(aclr), .iClkIN(clk4), .Outdiv2(clk2), .Outdiv4(clk1));

wire [11:0]wordM16, wordM8, wordM4, wordM2, wordM1;
wire [10:0]rdAddrM16;
wire [9:0]rdArrdM8;
wire [8:0]rdArrdM4;
wire [7:0]rdArrdM2;
wire [6:0]rdArrdM1;
wire getWordM16, getWordM8, getWordM4, getWordM2, getWordM1;
wire grpOddity;
wire [4:0]numGrp16;

assign Orb_M1 = ~Orb_M8;
//assign Orb_M8 = clk2;
assign Orb_M16 = Orb_M8;
//assign Orb_M8 = Orb_M2;
//assign Orb_M4 = Orb_M2;
//assign Orb_M2 = ~Orb_serial;
//assign Orb_M1 = ~Orb_M2;

//m16 frameFormer_16( .reset(aclr), .iClkOrb(clk), .iWord(wordM16), .oAddr(rdAddrM16), .numGrp(numGrp16), .oRdEn(getWordM16), .oOrbit(Orb_serial) );
//m16Filler fill16( .reset(aclr), .clk(clk100), .bufGetWord(getWordM16), .bufRdPointer(rdAddrM16), .numGrp(numGrp16), .dataWord(wordM16) );

M8 frameFormer_8(	.reset(aclr), .clk(clk), .iData(wordM8), .oRdEn(getWordM8), .oAddr(rdArrdM8), .oSerial(Orb_M8) );
m8Filler fill8( .reset(aclr), .clk(clk100), .bufGetWord(getWordM8), .bufRdPointer(rdArrdM8), .dataWord(wordM8) );

//M4 frameFormer_4( .reset(aclr), .clk(clk4), .iData(wordM4), .oRdEn(getWordM4), .oAddr(rdArrdM4), .oSerial(Orb_M4) );
//m4Filler fill4( .reset(aclr), .clk(clk100), .bufGetWord(getWordM4), .bufRdPointer(rdArrdM4), .dataWord(wordM4) );

//M2 frameFormer_2( .reset(aclr), .grpOddity(grpOddity), .clk(clk2), .iData(wordM2), .oRdEn(getWordM2), .oAddr(rdArrdM2), .oSerial(Orb_M2) );
//m2Filler fill2( .reset(aclr), .clk(clk100), .grpOddity(grpOddity), .bufGetWord(getWordM2), .bufRdPointer(rdArrdM2), .dataWord(wordM2) );

//M1 frameFormer_1( .reset(aclr), .clk(clk1), .iData(wordM1), .oRdEn(getWordM1), .oAddr(rdArrdM1), .oSerial(Orb_M1) );
//m1Filler fill1( .reset(aclr), .clk(clk100), .bufGetWord(getWordM1), .bufRdPointer(rdArrdM1), .dataWord(wordM1) );


endmodule
