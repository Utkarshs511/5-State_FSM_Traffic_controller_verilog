`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2025 22:01:24
// Design Name: 
// Module Name: traffic_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_tb();

	// Inputs
	reg clk;
	reg reset;
	reg pedestrian_button;
	reg emergency_button;

	// Outputs
	wire pedestrian_light;
	wire emergency_light;
	wire [2:0] traffic;

	// Instantiate the Unit Under Test (UUT)
	traffic dut (
		.clk(clk), 
		.reset(reset), 
		.pedestrian_button(pedestrian_button), 
		.emergency_button(emergency_button), 
		.pedestrian_light(pedestrian_light), 
		.emergency_light(emergency_light), 
		.traffic(traffic)
	);
	always begin
        #5 clk = ~clk;  // 100 MHz clock
    end

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		pedestrian_button = 0;
		emergency_button = 0;

		// Wait 10 ns for global reset to finish
		#10 reset=0;
        
		// Add stimulus here
		// Wait for RED light time
        #3500;

        // Test pedestrian button press
        pedestrian_button = 1;
        #10 pedestrian_button = 0;

        // Wait for pedestrian crossing time
        #7500;

        // Test emergency button press
        emergency_button = 1;
        #10 emergency_button = 0;

        // Wait for emergency mode to complete
        #700;
		  // Test regular transition back to normal cycle
        #1000;

        // End of test
        $stop;
    end

    // Display state changes
    initial begin
        $monitor("Time = %0d, Traffic = %b, Pedestrian Light = %b, Emergency Light = %b, Pedestrian Button = %b, Emergency Button = %b", 
                  $time, traffic, pedestrian_light, emergency_light, pedestrian_button, emergency_button);
    end
      

endmodule
