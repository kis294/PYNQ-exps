`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2025 04:50:31 PM
// Design Name: 
// Module Name: counter
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


module counter(
    input clk,
    input reset,
    output led
    );
    
reg [22:0] counter = 0;
reg led_sync= 0;
reg led_r = 0;
always @(posedge clk) begin 
    if(reset == 0) begin
        counter <= 22'b0;
        led_sync <= 0;
    end
    else begin
       if(counter == 25_000_00) begin
          led_sync <= 1;
          counter <= 22'b0;
       end
       else begin
          led_sync <= 0;
          counter <= counter + 21'b1;
       end
    end
end

always @(posedge led_sync) begin
     if(reset == 0) begin
        led_r <= 0;
     end
     else begin
        led_r <= ~led_r;
     end
end

assign led = led_r;
endmodule
