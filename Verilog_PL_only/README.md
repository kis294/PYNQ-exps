## ABOUT
This folder contains examples about my Verilog Journey.
The code is adapted from SV to Verilog because of difficulty in Vivado.

## btn_counter
It will count the number of button presses, BTN3 is for reset, 
BTN2 is for counting. It is an important lesson while learning 
**"metastability"** and **"debouncing"** . 

## btn counter states
It is an extension of btn_counter. It turns ON LED3 , LED2 , LED1 
one at a time based on state controlled by BTN2. Generally, the next state logic should be in combinatinal always block but somehow only LED2 was only turned now. TB didn't help as it was showing correct behaviour.
You need to add else block for every state which seems redundant
so prefer seq always block.