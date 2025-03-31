`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2025 08:37:25 AM
// Design Name: 
// Module Name: pdm_microphone_tb
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
`timescale 1ns / 1ps

module pdm_microphone_tb(

    );
    
    reg         clk = 0;
    reg         rst = 0;

    wire [7:0] mic_data = 0;
    wire        mic_data_valid = 0;


    wire        m_clk =0;
    reg         m_data  ;
    wire        m_lrsel ;

always begin
   clk = ~clk;
   #5;
end

initial begin
   rst = 1'b0;
   #100;
   rst = 1'b1;
   m_data = 1'b1;
end

pdm_microphone dut(.clk(clk),.rst(rst),.mic_data(mic_data),
                   .mic_data_valid(mic_data_valid),
                   .m_clk(m_clk),.M_DATA(m_data),.M_LRSEL(m_lrsel));
endmodule
