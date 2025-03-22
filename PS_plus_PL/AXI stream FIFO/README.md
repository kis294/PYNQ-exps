# About
AXI-stream FIFO example
This is a simple FIFO which counts up to 8.
    [Architecture](arch.png)

## Issues-faced
While reading from the DMA, only connected to
HP0 as set the bus width as 32,this leads to 
only even bytes as read.
The actual width should be set to 64 bus width.

## Instructions to use
1)Copy the files to bitstream folder.

2)Run the ipynb file on PYNQ.


