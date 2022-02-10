#!/bin/bash

environment() {
	export project="fpga_firmware"
	export implementation="$(echo $1 | cut -d '_' -f 1)"
	export target="$(echo $1 | cut -d '_' -f 2)"
	export targets="$(echo $1 | cut -d '_' -f 3 | tr -s ',' ' ')"
	export programming_part="$(echo $1 | cut -d '_' -f 4)"
	export technology="$(echo $programming_part | cut -d ',' -f 1)"
	export chip="$(echo $programming_part | cut -d ',' -f 2)"
	export part="$(echo $chip | cut -d '-' -f 1)"
	export size="$(echo $chip | cut -d '-' -f 2)"
	export footprint="$(echo $chip | cut -d '-' -f 3)"
	export flash="$(echo $1 | cut -d '_' -f 5)"
	export flash_chip="$(grep $flash flashdb.txt | cut -d ';' -f 2)"
	export flash_vendor="$(grep $flash flashdb.txt | cut -d ';' -f 1)"
	export flash_jtagid="$(grep $flash flashdb.txt | cut -d ';' -f 3)"
	export board="$(echo $1 | cut -d '_' -f 6)"
	export programmer="$(echo $1 | cut -d '_' -f 7)"
	export frequency="$(echo $1 | cut -d '_' -f 8)"
	export TOOLSDIR=${PWD}/tools/
	export FOUNDRY=${TOOLSDIR}/ispfpga
	export TCL_LIBRARY=${TOOLSDIR}/tcltk/lib/tcl8.5
	export LM_LICENSE_FILE=${TOOLSDIR}/license/license.dat
	export ISPDIR=${FOUNDRY}/bin/lin64/
	export LD_LIBRARY_PATH=${TOOLSDIR}/bin/lin64/:${TOOLSDIR}/ispfpga/bin/lin64/
	export PATH=${PATH}:${TOOLSDIR}/bin/lin64/:${TOOLSDIR}/ispfpga/bin/lin64/
	echo "Project: ${project}"
	echo "Implementation: ${implementation}"
	echo "Target: ${target}"
	echo "Programming Targets: ${targets}"
	echo "Programmer: ${programmer} @${frequency}"
	echo "Chip: ${technology} ${part}-${size} ${footprint}"
}

svf() {
	svf="${PWD}/output/${implementation}/${1}.svf"
	tmpfile="${PWD}/output/${implementation}/${1}.xcf"
	binsize=$( wc -c build/${implementation}/${project}_${implementation}.bit | cut -d ' ' -f 1 )
	endaddr=0x000F0000
	echo $project ${implementation} $1
	sed -e "s:PART:${part}:g" "${PWD}/boards/flash_${1}.xcf" | \
	sed -e "s:LUTSIZE:${size}:g" | \
	sed -e "s:FLASH:${flash_chip}:g" | \
	sed -e "s:VENDOR:${flash_vendor}:g" | \
	sed -e "s:JTAGID:${flash_jtagid}:g" | \
	sed -e "s:TECHNOLOGY:${technology}:g" | \
	sed -e "s:IMPLEMENTATION:${implementation}:g" | \
	sed -e "s:PWD:${PWD}:g" | \
	sed -e "s:PROJECT:${project}:g" | \
	sed -e "s:END-ADDR:${endaddr}:g" | \
	sed -e "s:BINSIZE:${binsize}:g" \
	> "${tmpfile}"
	rm -f "${svf}"
	ddtcmd -oft -svfchain -revd -of "${svf}" -if "${tmpfile}"
}

program() {
	_svf="${PWD}/output/${implementation}/flash.svf"
	program_jtag -i"${_svf}" -d"${programmer}" -f${frequency} || true
}

synthesize() {
rm -rf build/${implementation}
mkdir -p build/${implementation}
if [ -e ${PWD}/output/${implementation}.v ]; then
 cp ${PWD}/boards/${implementation}.v ${PWD}/output/
fi
	echo "set_option -technology ${technology}
set_option -part ${part}_${size}
set_option -package BG256C
set_option -speed_grade -6
set_option -symbolic_fsm_compiler true
set_option -resource_sharing true
set_option -vlog_std sysv
set_option -frequency 10
set_option -maxfan 4096
set_option -auto_constrain_io 0
set_option -disable_io_insertion false
set_option -retiming true; set_option -pipe true
set_option -force_gsr auto
set_option -compiler_compatible 0
set_option -dup false
set_option -frequency 1
set_option -default_enum_encoding default
set_option -write_verilog true
set_option -write_apr_constraint 1
set_option -fix_gated_and_generated_clocks 1
set_option -update_models_cp 1
set_option -resolve_multiple_driver 1
set_option -include_path {${PWD}}
` for file in source/*.v; do
echo \"add_file -verilog {${PWD}/${file}}\"
done
`
`echo \"add_file -verilog {${PWD}/output/${implementation}.v}\"`
`echo \"add_file -verilog {${PWD}/boards/${board}.v}\"`
set_option -top_module top_module
project -result_file {${PWD}/build/${implementation}/${project}_${implementation}.edi}
project -log_file {${project}_${implementation}.srf}
project -run
" > build/${implementation}/${project}_${implementation}_synplify.tcl
	pushd build/${implementation}
	synpwrap -msg -prj "${project}_${implementation}_synplify.tcl" -log "${project}_${implementation}.srf"
	popd
}

translate() {
	pushd build/${implementation}
	edif2ngd  -l ${technology} -d ${part}-${size} -path build/${implementation} -path ./ ${project}_${implementation}.edi ${project}_${implementation}.ngo
	ngdbuild  -a ${technology} -d ${part}-${size} -p ${TOOLSDIR}/ispfpga/sa5p00/data -p build/impl ${project}_${implementation}.ngo ${project}_${implementation}.ngd
	popd
}

mapper() {
	pushd build/${implementation}
	map -a ${technology} -p ${part}-${size} -t ${footprint} -s 6 -oc Commercial -ioreg b ${project}_${implementation}.ngd -o ${project}_${implementation}_map.ncd -pr ${project}_${implementation}.prf -mp ${project}_${implementation}.mrp -lpf ${project}_${implementation}_synplify.lpf -lpf ../../boards/${board}.lpf -retime -tdm -split_node -td_pack
	popd
}

route() {
	pushd build/${implementation}
	mpartrce -distrce -log ${project}_${implementation}_route.log -o ${project}_${implementation}_route_report.txt -pr ${project}_${implementation}.prf -p "${project}_${implementation}.p2t" -tf "${project}_${implementation}.pt" "${project}_${implementation}_map.ncd" "${project}_${implementation}.ncd"
	popd
}

generate() {
	pushd build/${implementation}
	bitgen -w ${project}_${implementation}.ncd ${project}_${implementation}.prf
	popd
        mkdir -p "${PWD}/output/${implementation}"
	_svf="${PWD}/output/${implementation}/flash.svf"
	rm -f "${_svf}"
	echo "" > "${_svf}"
	for t in $targets; do
		svf $t
		cat "${PWD}/output/${implementation}/${t}.svf" >> "${_svf}"
	done
	sed -i "s/SDR 16 TDI(00A0)//g" "${_svf}"
        sed -i "s/		TDO(00FF)//g" "${_svf}"
        sed -i "s/		MASK(C100) ;//g" "${_svf}"
	sed -i "s/\(FREQUENCY\).*$/\1\t$(($frequency/1000000)).00e+06 HZ ;/g" "${_svf}"
}

build() {
	synthesize;
	translate;
	mapper;
	route;
	generate;
}

mkdir -p "$HOME/.config/LatticeSemi/"

environment $@
echo "Initializing target ${target}..."
if sleep 5; then
	mkdir -p output/
	[ -e ${PWD}/boards/${implementation}.v ] && cp -f ${PWD}/boards/${implementation}.v ${PWD}/output/
	[ -e ${PWD}/output/${implementation}.v ] || prepare
	rm -rf output/flash.svf
$target
fi
