# Embedded System Calculator
VHDL implementation of an embedded system that is capable to communicate across a RS-232 serial interface with the PC

**This project uses the MIPS processor implemented [here][mips]**

This project has been tested on a [Digilent Basys 2][digilent] [FPGA]

If you are a FICH student, then [read this][fich]

### Changelog

  - Created img/ directory with block diagrams and photos

### Software

* [Xilinx ISE Project Navigator][Xilinx] - FPGA design solution to synthesis and simulation
* [MARS] - **M**IPS **A**ssembler and **R**untime **S**imulator

### Hardware
* [Digilent Basys 2][digilent] FPGA
* USB to RS-232 adapter

![Connections](https://github.com/cristian1604/EmbeddedMips/blob/master/img/fpga.jpg)

Connections:

The connectors can be edited on `UCF` file.

`A7 button -> Reset`
And between FPGA and USB adapter:

| FPGA Basys 2 | RS-232 adapter |
| ------ | ------ |
| B2 pin (*receiver*) | TX |
| A3 pin (*transmitter*) | RX |



### Block Diagram
![Block diagram](https://github.com/cristian1604/mips/blob/master/img/mips.png)

**As a component:**

![Block diagram](https://github.com/cristian1604/mips/blob/master/img/mips_rtl.png)

References:

  - **readdata**: Data in (32 bits)
  - **clk**: Clock signal
  - **reset**: Reset signal
  - **address**: Address to write data (on a FIFO buffer, external memory, UART).
  - **writedata**: Data to write (32 bits)
  - **memwrite**: Logic signal to write the data from *writedata* port

How I can load my own firmware?
----
This project uses the same processor implemented [here][mips], so the firmware must be placed on the `Instruction_Memory.vhd` file as well. The format is: Four hexadecimal tuples to describe one assembly instruction.

So, the instruction

`addi $s1, $0, 6` is 

`x"20",x"11",x"00",x"06",`.

I strongly recommend to use [MARS] software to export your code in hexadecimal format.

Remember: The Instruction Memory is an array with 512 elements. Each instruction is composed by four hexadecimal tuples. So the maximum number of instructions allowed is: `512/4 = 128 instructions`. You can modify this value according to the size of the FPGA memory.

### Example

The firmware is detailed and it's described [here][firmware].

The proposed firmware reads two numbers, one operand and another two numbers across the console of the PC.
The system solves on the FPGA the requested operation and send the result across the UART interface to the console back.

![Block diagram](https://github.com/cristian1604/EmbeddedMips/blob/master/img/example.jpeg)


### Input mode:
The system is capable to receive two chars (first operand) followed by the operator (sum, subtraction or multiplication), and another two chars (representing the second operand).

Pressing the `Enter` key, the system must return (across the UART interface to the PC) the following ASCII codes:
  - Equal ASCII symbol (`=` or `0x3d` in hex)
  - Result of arithmetic operation (four digits)
  - Carriage return (`0x0d` in hex)
  - New line feed (`0x0a` in hex)

And the system will wait for new inputs.


**NOTE!** If you use MARS software, watch out all the *jump* instructions. The software **always** export the line like
`x"08",x"10"` when the second tuple **MUST** be `x"00"`.
So, always replace in the text `x"08",x"10"` by `x"08",x"00"`.
Otherwise the jump on this MIPS implementation will don't work.


### Bibliography
  - *Digital Design and Computer Architecture* - David Money Harris & Sarah L. Harris (2007 Elsiever)
  - *Computer Organization and Design - David A. Patterson & John L. Hennessy* (2012 Morgan Kauffman)


About
----
Developed by Cristian Bottazzi  `cbottazzi @ ful.unl.edu.ar`

If you are a FICH student, then [read this][fich]

Computer Organization - Computer Engineering

Facultad de Ingeniería y Ciencias Hídricas - Universidad Nacional del Litoral


[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [digilent]: <https://reference.digilentinc.com/_media/basys2:basys2_rm.pdf>
   [fpga]: <https://en.wikipedia.org/wiki/Field-programmable_gate_array>
   [xilinx]: <https://www.xilinx.com/products/design-tools/ise-design-suite/ise-webpack.html>
   [mars]: <http://courses.missouristate.edu/kenvollmar/mars/>
   [fich]: <http://github.com/cristian1604/mips/blob/master/img/FICH_note.md>
   [mips]: <http://github.com/cristian1604/mips>
