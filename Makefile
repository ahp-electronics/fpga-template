CHIP=LCMXO3LF-6900C
TECH=MachXO3LF
BOARD=lcmxo3l
FREQ=1000000
TARGETS=bypass,erase,program
INCLUDES=-Isources/ -Itools/ispfpga/verilog/data/$(CHIP)/

%:
	./flash.sh build $@_$(TARGETS)_$(FREQ)_$(TECH),$(CHIP)_$(BOARD)

%_program:
	./flash.sh program $@_$(TARGETS)_$(FREQ)_$(TECH),$(CHIP)_$(BOARD)
