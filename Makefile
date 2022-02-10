CHIP=LCMXO3LF
SIZE=6900C
TECH=MachXO3LF
BOARD=lcmxo3l
PROG_FREQ=1000000
PROGRAMMER=FT2232
TARGETS=bypass,erase,program
INCLUDES=-Isources/ -Itools/ispfpga/verilog/data/`echo "$(CHIP)" | tr '[:upper:]' '[:lower:]'`/

%:
	./flash.sh build $@_$(TARGETS)_$(TECH),$(CHIP)-$(SIZE)_$(BOARD)_$(PROGRAMMER)_$(PROG_FREQ)

%_program:
	./flash.sh program $@_$(TARGETS)_$(TECH),$(CHIP)-$(SIZE)_$(BOARD)_$(PROGRAMMER)_$(PROG_FREQ)
