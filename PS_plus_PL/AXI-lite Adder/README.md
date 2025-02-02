## About
Did an experiment to interface AXI-lite interface in Vivado to my custom Adder IP.
You need to create a Zynq(PS) design , modify and package your adder ip.

## Steps to create the design
Vivado can help you generate a template for AXI-lite which you can then edit to add
your custom IP.
You can follow this tutorial.
https://www.hackster.io/whitney-knitter/axi4-lite-interface-wrapper-for-custom-rtl-in-vivado-2021-2-8a7009

Once generated validate your design, create HDL wrapper for your bd. Then you need to
1) Synthesize
2) Implement
3) Generate bitstream
    
Make sure to do one step at a time as my laptop had limited resources.

## How to create an overlay
I followed this tutorial, to generate an overlay
https://www.hackster.io/news/pynq-edition-creating-custom-overlays-8543f45eccb1
https://pynq.readthedocs.io/en/latest/overlay_design_methodology/overlay_design.html#overlay-design

One step missing in it is the need to copy your .hwh also from Vivado project.
So basically,
   Copy your .hwh, .bit and .tcl files. All these files should have the same name .
   I named each of them my_adder.xxx .

## Running in Jupyter
You can check the base address of your custom IP in Vivado Address map. This address can be memory-mapped and 
you can read and write the offsets directly in Python.

One good thing about the Pynq approach is that there is no need to 
create an XSA or even open Vitis for that matter.



