# Example code
Here is provided the assembler code converted in hexadecimal and formatted ready to load into MIPS Instruction Memory.
For more information about how to do that, please read [this][mips].

The software is in `Firmware.asm` file.

### Code
```hexadecimal
x"20",x"10",x"00",x"00",
x"20",x"11",x"00",x"00",
x"8c",x"08",x"ff",x"16",
x"11",x"00",x"00",x"01",
x"08",x"00",x"00",x"02",
x"8c",x"10",x"ff",x"15",
x"ac",x"10",x"ff",x"15",
x"21",x"08",x"00",x"30",
x"02",x"08",x"80",x"22",
x"8c",x"08",x"ff",x"16",
x"11",x"00",x"00",x"01",
x"08",x"00",x"00",x"09",
x"8c",x"11",x"ff",x"15",
x"ac",x"11",x"ff",x"15",
x"21",x"08",x"00",x"30",
x"02",x"28",x"88",x"22",
x"20",x"08",x"00",x"00",
x"20",x"09",x"00",x"09",
x"00",x"10",x"50",x"20",
x"11",x"09",x"00",x"03",
x"21",x"08",x"00",x"01",
x"02",x"0a",x"80",x"20",
x"08",x"00",x"00",x"13",
x"02",x"11",x"80",x"20",
x"8c",x"08",x"ff",x"16",
x"11",x"00",x"00",x"01",
x"08",x"00",x"00",x"18",
x"8c",x"0f",x"ff",x"15",
x"20",x"08",x"00",x"2a",
x"11",x"e8",x"00",x"05",
x"20",x"08",x"00",x"2b",
x"11",x"e8",x"00",x"03",
x"20",x"08",x"00",x"2d",
x"11",x"e8",x"00",x"01",
x"08",x"00",x"00",x"18",
x"ac",x"0f",x"ff",x"15",
x"8c",x"08",x"ff",x"16",
x"11",x"00",x"00",x"01",
x"08",x"00",x"00",x"24",
x"8c",x"11",x"ff",x"15",
x"ac",x"11",x"ff",x"15",
x"21",x"08",x"00",x"30",
x"02",x"28",x"88",x"22",
x"8c",x"08",x"ff",x"16",
x"11",x"00",x"00",x"01",
x"08",x"00",x"00",x"2b",
x"8c",x"12",x"ff",x"15",
x"ac",x"12",x"ff",x"15",
x"21",x"08",x"00",x"30",
x"02",x"48",x"90",x"22",
x"20",x"08",x"00",x"00",
x"20",x"09",x"00",x"09",
x"00",x"11",x"50",x"20",
x"11",x"09",x"00",x"03",
x"21",x"08",x"00",x"01",
x"01",x"51",x"88",x"20",
x"08",x"00",x"00",x"35",
x"02",x"32",x"88",x"20",
x"20",x"08",x"00",x"2a",
x"11",x"e8",x"00",x"04",
x"20",x"08",x"00",x"2b",
x"11",x"e8",x"00",x"09",
x"20",x"08",x"00",x"2d",
x"11",x"e8",x"00",x"09",
x"20",x"08",x"00",x"00",
x"20",x"12",x"00",x"00",
x"11",x"11",x"00",x"03",
x"21",x"08",x"00",x"01",
x"02",x"50",x"90",x"20",
x"08",x"00",x"00",x"42",
x"08",x"00",x"00",x"4b",
x"02",x"11",x"90",x"20",
x"08",x"00",x"00",x"4b",
x"02",x"11",x"90",x"22",
x"08",x"00",x"00",x"4b",
x"8c",x"08",x"ff",x"16",
x"11",x"00",x"00",x"01",
x"08",x"00",x"00",x"4b",
x"8c",x"08",x"ff",x"15",
x"20",x"10",x"00",x"01",
x"20",x"08",x"03",x"e8",
x"20",x"09",x"00",x"64",
x"20",x"0a",x"00",x"0a",
x"20",x"0c",x"00",x"00",
x"20",x"0d",x"00",x"00",
x"20",x"0e",x"00",x"00",
x"20",x"0f",x"00",x"00",
x"02",x"48",x"a0",x"2a",
x"12",x"14",x"00",x"03",
x"21",x"8c",x"00",x"01",
x"02",x"48",x"90",x"22",
x"08",x"00",x"00",x"57",
x"02",x"49",x"a0",x"2a",
x"12",x"90",x"00",x"03",
x"21",x"ad",x"00",x"01",
x"02",x"49",x"90",x"22",
x"08",x"00",x"00",x"5c",
x"02",x"4a",x"a0",x"2a",
x"12",x"90",x"00",x"03",
x"21",x"ce",x"00",x"01",
x"02",x"4a",x"90",x"22",
x"08",x"00",x"00",x"61",
x"00",x"12",x"78",x"20",
x"20",x"0b",x"ff",x"3d",
x"ac",x"0b",x"ff",x"15",
x"21",x"8c",x"00",x"30",
x"21",x"ad",x"00",x"30",
x"21",x"ce",x"00",x"30",
x"21",x"ef",x"00",x"30",
x"ac",x"0c",x"ff",x"15",
x"ac",x"0d",x"ff",x"15",
x"ac",x"0e",x"ff",x"15",
x"ac",x"0f",x"ff",x"15",
x"20",x"09",x"ff",x"0d",
x"ac",x"09",x"ff",x"15",
x"20",x"0a",x"ff",x"0a",
x"ac",x"0a",x"ff",x"15",
x"08",x"00",x"00",x"02",
```


### Whats this code do?
The system is capable to receive two chars (first operand) followed by the operator (add, subtraction or multiplication), and another two chars (representing the second operand).

Pressing the `Enter` key, the system must return (across the UART interface to the PC) the following ASCII codes:
  - Equal ASCII symbol (`=` or `0x3d` in hex)
  - Result of arithmetic operation (four digits)
  - Carriage return (`0x0d` in hex)
  - New line feed (`0x0a` in hex)

And the system will wait for new inputs.

### Where I put this code?
The code goes in `Instruction_Memory.vhd` file.

### What is the maximum number of instructions that this processor can handle?
This information is on [MIPS] repository


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
