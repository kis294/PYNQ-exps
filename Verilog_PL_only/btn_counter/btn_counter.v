module cb
  (
   input wire                      CLK_IN,
   input wire                      BTNC,
   input wire                      CPU_RESETN,
   output wire [3:0]               leds
   );

  // Capture the rising edge of button press
  reg                               last_button = 0;
  reg                               button  = 0;
  reg button_down;
  reg   [3:0] leds_flop;

      reg [2:0] button_sync;
      reg       counter_en;
      reg [7:0] counter;
      always @(posedge CLK_IN) begin
      
      //To prevent metastability from async human domain to internal clk domain
        button_down <= 0;
        button_sync <= button_sync << 1 | BTNC;
        if (button_sync[2:1] == 2'b01) counter_en <= 1;
        else if (~button_sync[1])      counter_en <= 0;


      //To provide debouncing
        if (counter_en) begin
          counter <= counter + 1'b1;
          if (&counter) begin
            counter_en <= 0;
            counter    <= 0;
            button_down <= 1;
          end
        end
      end
      
      always @(posedge CLK_IN) begin
         if(CPU_RESETN == 1'b1) begin
           leds_flop <= 4'b0;
         end
         else begin 
            if (button_down == 1'b1)
               leds_flop <= leds_flop + button_down;
         end
      end
      
      assign leds = leds_flop;
      
//assign leds = {1'b1,1'b1,1'b1,1'b1};
endmodule
