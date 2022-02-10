# Verilog FPGA template repository

## Template repository for Lattice® FPGA projects

You should obtain a Lattice Diamond license to build projects with this template

see https://www.latticesemi.com/Support/Licensing for further informations

The directory tree contains the source/ directory where the modules should be added.

The top modules are into the boards/ directory, all pins should be inout into the top module.

### Building

To build a bitstream you should run make targeting the top module filename (without the .v extension)

```
make template
````

### Programming parts

To program a part you should install liburjtag-dev and install the program_jtag utility:

```
sudo apt install build-essential cmake liburjtag-dev
mkdir tools/source/build
pushd tools/source/build
cmake -DCMAKE_INSTALL_PREFIX=/usr ../
sudo make install
popd
```

Then program the part by running make:
```
make template_program
```

### Parts supported

There is a single part included into the template:

**MachXO3L**

The development board can be purchased online and found by googling LCMXO3LF-6900C-S-EVN

### Environment Variables

These environment variables can be set before calling make:

**CHIP** The FPGA chip

**SIZE** The FPGA  size variant

**FOOTPRINT** The FPGA footprint

**TECH** The FPGA Family

**BOARD** The board to program

**PROG_TARGETS** The programming targets

**PROG_FREQ** The programmer frequency

**PROGRAMMER** the programmer to use
