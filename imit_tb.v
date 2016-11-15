`timescale 10 ps/10 ps

module imit_tb();

	// Wires and variables to connect to UUT (unit under test)
	reg clk, clr;
	reg [11:0]iOrbWrd = 1638;
	wire outSerial;
	wire val;
	
	reg clk5;
	reg clkOrbx16;
	reg clkOrb;
	reg [7:0]number[0:4];
	reg [2:0]i = 0;
	reg [2:0]j = 0;
	
	// Instantiate UUT
	m16imit imit_tb(.clk100(clkOrbx16), .Orb_serial(outSerial));

	// Clock definition
	initial begin						// clk 80MHz
		clk = 0;
		forever #625 clk = ~clk;
	end
	initial begin						// clk 5MHz
		clk5=0;
		forever #10000 clk5 = ~clk5;
	end
	
	initial begin						// clk Orb 
		clkOrb=0;
		forever #15900 clkOrb = ~clkOrb;
	end
	initial begin						// clk Orb x4
		clkOrbx16=0;
		forever #993 clkOrbx16 = ~clkOrbx16;		//#15900 = ~3145728 Hz
	end
	
	initial begin						// Main
		clr=0;
		repeat (30)@(posedge clk);
		clr=1;
		iOrbWrd = 1638;
		repeat (32768) @(posedge clkOrb)
			repeat (32768) @(posedge clkOrb);
		
		$stop;
	end
	
endmodule
