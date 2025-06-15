`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2024 21:59:43
// Design Name: 
// Module Name: traffic
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


module traffic(
    input clk,                 // Clock signal
    input reset,               // Reset signal
    input pedestrian_button,   // Pedestrian request button
	 input emergency_button,
	 output reg pedestrian_light, // Pedestrian light output
	 output reg emergency_light,
    output reg [2:0] traffic   // Traffic light output: Red-Green-Yellow
);

    // Add a state to handle pedestrian crossing
    parameter RED = 3'b100;
    parameter YELLOW = 3'b010;
    parameter GREEN = 3'b001;
    parameter PED_CROSS = 3'b101;
    parameter EMG_GO = 3'b111;
    reg [2:0] state;
    reg pedestrian_request;
	 reg [15:0] counter;
	 parameter RED_TIME = 16'd100;
    parameter GREEN_TIME = 16'd80;
    parameter YELLOW_TIME = 16'd20;
	 parameter PED_TIME=16'd40;
	 parameter EMG_TIME=16'd60;
	 	 
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RED;
            counter <= 0;
            pedestrian_request <= 0;
        end 
		  else begin
				counter<=counter+1;
            if (pedestrian_button) begin
						pedestrian_request <= 1;
				end
				if(emergency_button) begin
						state<=EMG_GO;
						counter<=0;
						pedestrian_request <= 0;
				end
            case(state)
                RED: if (counter >= RED_TIME) begin
								if (pedestrian_request) begin
									state <= PED_CROSS;
									pedestrian_request <= 0;
								end 
								else begin
									state <= GREEN;
									
								end
                    counter <= 0;
                end
                GREEN:if (counter >= GREEN_TIME) begin
									state <= YELLOW;
									counter <= 0;	
									
							 end
							 else if(pedestrian_request) begin
									state <= PED_CROSS;
									pedestrian_request <= 0;
									counter <= 0;
								end 
									
                YELLOW: if (counter >= YELLOW_TIME) begin
                    state <= RED;
                    counter <= 0;
                end
                PED_CROSS: if (counter >= PED_TIME) begin
                    state <= RED;
                end
					 EMG_GO: if(counter>=EMG_TIME) begin
						  state<=RED;
					 end 
            endcase
        end
    end

    always @(state) begin
        case (state)
            RED: begin
                traffic = 3'b100;
                pedestrian_light = 0;
					 emergency_light=0;
            end
            GREEN: begin
                traffic = 3'b001;
                pedestrian_light = 0;
					 emergency_light=0;
            end
            YELLOW:begin
                traffic = 3'b010;
                pedestrian_light = 0;
					 emergency_light=0;
            end
            PED_CROSS: begin
                traffic = 3'b100;
                pedestrian_light = 1;
					 emergency_light=0;
            end
				EMG_GO: begin
					 traffic=3'b100;
					 pedestrian_light = 0;
					 emergency_light=1;
				end	 
            default: begin
                traffic = 3'b100;
                pedestrian_light = 0;
					 emergency_light=0;
            end
        endcase
    end
	
endmodule
