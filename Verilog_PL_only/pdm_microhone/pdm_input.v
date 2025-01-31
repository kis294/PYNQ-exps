`timescale 1ns/10ps
module pdm_input
  #
  (
   parameter          CLK_FREQ    = 125,    // Mhz
   parameter          SAMPLE_RATE = 2400000 // Hz
   )
  (
   input wire         CLK_IN, // 100Mhz

   // Microphone interface
   output reg       M_CLK,
   //output reg       m_clk_en,
   input wire         M_DATA

   // Amplitude outputs
   //reg [6:0] amplitude,
   //reg       amplitude_valid
   );
 // Marks an internal wire for debug in Vivado hardware manager 
  (* MARK_DEBUG = "TRUE" *) reg [6:0] amplitude ;
  (* MARK_DEBUG = "TRUE" *) reg       amplitude_valid;
  localparam CLK_COUNT = ((CLK_FREQ*1000000)/(SAMPLE_RATE*2));
  reg m_clk_en = 0;
  reg [7:0]                   counter1;
  reg [7:0]                   counter2;
  (* MARK_DEBUG = "TRUE" *) reg  ila_sampling;
  reg [7:0]                   sample_counter1;
  reg [7:0]                   sample_counter2;
  reg [15:0]                  ila_counter;
  reg [$clog2(CLK_COUNT)-1:0]      clk_counter;

  initial begin
    sample_counter1 = 0;
    sample_counter2 = 0;
    counter1        = 0;
    counter2        = 0;
   
    M_CLK          = 0;
    clk_counter    = 0;
    ila_sampling   = 0;
  end

  always @(posedge CLK_IN) begin
    amplitude_valid <= 0;
    m_clk_en        <= 0;

    if (clk_counter == CLK_COUNT - 1) begin
      clk_counter <= 0;
      M_CLK       <= ~M_CLK;
      m_clk_en    <= ~M_CLK;
    end else begin
      clk_counter <= clk_counter + 1;
      if (clk_counter == CLK_COUNT - 2) m_clk_en    <= ~M_CLK;
    end

    if (m_clk_en) begin
      counter1        <= counter1 + 1'b1;
      counter2        <= counter2 + 1'b1;
      if (counter1 == 199) begin
        counter1        <= 0;
        amplitude         <= sample_counter1;
        amplitude_valid   <= 1;
        sample_counter1 <= 0;
      end else if (counter1 < 128) begin
        sample_counter1 <= sample_counter1 + M_DATA;
      end
      if (counter2 == 227) begin
        counter2        <= 0;
        amplitude         <= sample_counter2 + M_DATA;
        amplitude_valid   <= 1;
        sample_counter2 <= 0;
      end else if (counter1 > 100) begin
        sample_counter1 <= sample_counter1 + M_DATA;
      end
    end
  end // always @ (posedge clk)

  always @(posedge CLK_IN) begin
     
     if(ila_counter == 16'b1111_1111_1111_1111 ) begin
         ila_counter <= 0;
         ila_sampling <= 0;
     end
     else begin
         if(amplitude_valid) begin
          ila_counter <= ila_counter + amplitude_valid;
          ila_sampling <= 1;
         end
     end
  end
endmodule // pdm_input