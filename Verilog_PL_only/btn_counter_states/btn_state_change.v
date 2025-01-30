`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 01/30/2025 11:46:10 AM
//// Design Name: 
//// Module Name: btn_state_change
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


module btn_state_change(
    input CLK_IN,
    input CPU_RESETN,
    input BTNC,
    output wire [3:0] leds
    );
   
reg [2:0] btn_ff = 3'b0; 
reg counter_en ;
reg [7:0] counter_ff = 8'b0;
reg btn_sig = 0;
reg [3:0] led_ff = 4'b0;

reg [3:0] btn_cntr = 4'b0;
always @(posedge CLK_IN) begin
      btn_sig <= 0;
      btn_ff <= btn_ff << 1 | BTNC;
      if(btn_ff[2:1] == 2'b01) begin
         counter_en <= 1;
         counter_ff <= 8'b0;
       end
      else if (~btn_ff[1]) begin
         counter_en<= 0;
         counter_ff <= 8'b0;
      end
      if(counter_en) begin
         counter_ff <= counter_ff + 7'b1;
         if(&counter_ff) begin
            btn_sig <= 1;
            counter_en <= 0;
            counter_ff <= 8'b0;
         end
         
      end
end

//Seq logic for next and curr state
localparam IDLE=4'd0,LED1=4'd1,LED2=4'd2,LED3=4'd3;
reg [2:0] curr_state=IDLE,next_state;
always @(posedge CLK_IN) begin
    if(CPU_RESETN == 1) begin
       curr_state <= IDLE;
    end
    else begin
       curr_state <= next_state;
    end
end



/*always @(posedge CLK_IN) begin
   if(CPU_RESETN == 1) begin
     btn_cntr <= 4'b0;
   end
   else begin
     if(btn_cntr == 4'd5) begin
         btn_cntr <= 4'd0;    
     end
     else begin
         btn_cntr <= btn_cntr + btn_sig;
     end
   end
end*/


/*always @(*) begin
    
    case(curr_state)
    IDLE:begin
        led_ff = 4'b0000;
        if(btn_sig == 1)
          next_state = LED1;
        else 
          next_state = IDLE;
    end
    LED1:begin
        led_ff = 4'b0001;
        if(btn_sig == 1)
          next_state = LED2;
        else
          next_state = LED1;
    end
    LED2:begin
        led_ff = 4'b0010;
        if(btn_sig == 1)
          next_state = LED3;
        else 
          next_state = LED2;
    end
    LED3:begin
        led_ff = 4'b0100;
        if(btn_sig == 1)
          next_state = IDLE;
        else
          next_state = LED3;
    end
    default:begin
         next_state = IDLE;
         led_ff= 4'b0000;
    end
    endcase

end*/
always @(posedge CLK_IN) begin
    
    case(curr_state)
    IDLE:begin
        led_ff <= 4'b0000;
        if(btn_sig == 1)
          next_state <= LED1;
    end
    LED1:begin
        led_ff <= 4'b0001;
        if(btn_sig == 1)
          next_state <= LED2;
    end
    LED2:begin
        led_ff <= 4'b0010;
        if(btn_sig == 1)
          next_state <= LED3;
    end
    LED3:begin
        led_ff <= 4'b0100;
        if(btn_sig == 1)
          next_state <= IDLE;
    end
    default:begin
         next_state <= IDLE;
         led_ff <= 4'b0000;
    end
    endcase

end


assign leds = led_ff;

endmodule
