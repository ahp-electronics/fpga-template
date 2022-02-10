CHIP=LCMXO3LF
SIZE=6900C
FOOTPRINT=CABGA256
TECH=MachXO3LF
BOARD=lcmxo3l
PROG_TARGETS=bypass,erase,program
PROG_FREQ=1000000
PROGRAMMER=FT2232
INCLUDES=-Isources/ -Itools/ispfpga/verilog/data/`echo "$(CHIP)" | tr '[:upper:]' '[:lower:]'`/

%:
	./flash.sh build $@_$(PROG_TARGETS)_$(TECH),$(CHIP)-$(SIZE)-$(FOOTPRINT)_$(BOARD)_$(PROGRAMMER)_$(PROG_FREQ)

%_program:
	./flash.sh program $@_$(PROG_TARGETS)_$(TECH),$(CHIP)-$(SIZE)-$(FOOTPRINT)_$(BOARD)_$(PROGRAMMER)_$(PROG_FREQ)
