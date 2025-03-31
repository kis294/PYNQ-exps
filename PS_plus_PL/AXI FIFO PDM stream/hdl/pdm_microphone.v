`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 13.11.2021 14:32:12
// Design Name:
// Module Name: pdm_microphone
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


module pdm_microphone
  #(
    parameter INPUT_FREQ = 100000000,
    parameter PDM_FREQ = 2400000

    )
   (
    input         clk,
    input         rst,

    output [7:0] mic_data,
    output       mic_data_valid,

    output        M_CLK,
    input         M_DATA,
    output        M_LRSEL
   
    );

   reg [2:0]      m_data_q;
   reg            m_clk_rising;

   // triple register data into clk domain
   always@(posedge clk) begin
      if (rst) begin
         m_data_q       <= 0;

      end
      else begin
         m_data_q[0]   <= M_DATA;
         m_data_q[2:1] <= m_data_q[1:0];

      end
   end

   // clock gen
   pdm_clk_gen
     #(
       .INPUT_FREQ(INPUT_FREQ),
       .OUTPUT_FREQ(PDM_FREQ)

       )
   pdm_clk_gen_i
     (
      .clk(clk),
      .rst(rst),

      .M_CLK(M_CLK),
      .m_clk_rising(m_clk_rising)

      );


   assign M_LRSEL = 0;
   assign mic_data = {7'b0,m_data_q[2]};
   assign mic_data_valid = m_clk_rising;

endmodule