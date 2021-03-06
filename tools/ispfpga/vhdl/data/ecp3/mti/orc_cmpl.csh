#!/bin/csh -f
cp modelsim.unx modelsim.ini
#
# Compile the MTI ECP3 library
#
# Uncomment to include pre-compiled JTAGE model
#rm -rf work
#unzip -d . ../../../blackbox/jtage-mti_6.3f.zip
#vlog -refresh -work ./jtage_work
#mv jtage_work work
#
vlib ./work
echo Compiling the ECP3 Component File...
vcom -explicit -work ./work ../src/ECP3COMP.vhd
echo Compiling the ECP3 Sequential Cells...
vcom -explicit -work ./work ../src/ECP3_SEQ.vhd
echo Compiling the ECP3 I/Os...
vcom -explicit -work ./work ../src/ECP3_IO.vhd
echo Compiling the ECP3 Combinational Cells...
vcom -explicit -work ./work ../src/ECP3_CMB.vhd
echo Compiling the ECP3 Counters...
vcom -explicit -work ./work ../src/ECP3_CNT.vhd
echo Compiling the ECP3 Memory Elements...
vcom -explicit -work ./work ../src/ECP3_MEM.vhd
echo Compiling the ECP3 Miscillaneous cells...
vcom -explicit -work ./work ../src/ECP3_MISC.vhd
echo Compiling the ECP3 LUTs...
vcom -explicit -work ./work ../src/ECP3_LUT.vhd
echo Compiling the ECP3 MULTs cells...
vcom -explicit -work ./work ../src/ECP3_MULT.vhd
echo Compiling the ECP3 Backanno cells...
vcom -explicit -work ./work ../src/ECP3_SL.vhd

