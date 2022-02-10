# These functions can be used in the tcl scripts of the synthesis and simulation
# Copyright (c), 2008-2009, Lattice Semiconductor Corporation, All Rights Reserved

package provide simulation_generation 1.0.0

namespace eval ::bali::simulation {
	variable para
	set Para(VHDLSUFFIX) {.vhd .vhdl .hdl .vho}
	set Para(VERISUFFIX) {.v .ver .veri .tf .vo}
}

# -----------------------------------------------------------------------
# generate cmd file and run active-HDL tool
# -----------------------------------------------------------------------
# the pesudo code is changed as the following by CR52408. justin wu Feb.23, 2011.
# setenv SIM_WORKING_FOLDER .
# if {![file exists <current project>]} {
#	design create rtl_sim <project>
#   design open <project>
#   cd <project path>
#   <set include path>
# }	else {
#   design open <project>
#   cd <project path>
# }
# <clear clear library>
# <set simulation libs>
# <set macros>
# <remove all existing files>
# <add current all files>
# <del all libraries components>
# <compile all files>
# #the end#

proc ::bali::simulation::ActiveHDL_Run {} {
	variable Para	
	
	set filename $Para(PROJECTPATH)/$Para(PROJECT)/$Para(PROJECT)
	set adofile $Para(PROJECTPATH)/$Para(PROJECT)/$Para(PROJECT).ado
	if [catch {open "$adofile" w} DoFile ] {
		return -1
	}
	puts $DoFile "setenv SIM_WORKING_FOLDER ."
	puts $DoFile "set newDesign 0"
	puts $DoFile "if \{!\[file exists \"$filename.adf\"\]\} \{ "
	puts $DoFile "	design create $Para(PROJECT) \"$Para(PROJECTPATH)\""
	puts $DoFile "  set newDesign 1"
	puts $DoFile "\}"
	puts $DoFile "design open \"$Para(PROJECTPATH)/$Para(PROJECT)\""
	puts $DoFile "cd \"$Para(PROJECTPATH)\""
	
	#set include path
	puts $DoFile "designverincludedir -clear"
	set var ""
	foreach inc $Para(GLBINCLIST) {
		append var "\"$inc\" "
	}
	if {[string length $var] > 0} {
		puts $DoFile "designverincludedir $var"
	}
		
	#clear library
	puts $DoFile "designverlibrarysim -PL -clear"
	puts $DoFile "designverlibrarysim -L -clear"
	
	#set simulation libs
	foreach i $Para(SIMLIBLIST) {
		if {[string equal -nocase $i "pmi_work"]} {
			puts $DoFile "designverlibrarysim -PL $i"
		} else {
			puts $DoFile "designverlibrarysim $i"
		}
	}
	#set macros
	puts $DoFile "designverdefinemacro -clear"
	foreach i $Para(MACROLIST) {
		puts $DoFile "designverdefinemacro +define+$i"
	}
	
	#add files
	puts $DoFile "if \{\$newDesign == 0\} \{ "
	puts $DoFile "  removefile -Y -D *"
	puts $DoFile "\}"
	
	foreach i $Para(FILELIST) {
		puts $DoFile "addfile \"$i\""
	}
	
	#add sdf file
	if {[string length $Para(SDFPATH)] > 0} {
		puts $DoFile "addfile -sdf \"$Para(SDFPATH)\""
	}
		
	# delete all lib

	set libs ""
	foreach work $Para(WORKLIBLIST) {
		if { ![string equal -nocase $work ""]}	{
			if { [lsearch $libs $work] == -1 } {
				puts $DoFile "vlib \"$Para(PROJECTPATH)/$Para(PROJECT)/$work\""
				lappend libs $work
			}
		}
	}
	if { [lsearch $libs "work"] == -1 } {
		puts $DoFile "	vlib \"$Para(PROJECTPATH)/$Para(PROJECT)/work\""
	}

	puts $DoFile "set worklib work"
	puts $DoFile "adel -all"

	foreach i $Para(FILELIST) compiler $Para(COMPLIST) inc $Para(INCLIST) work $Para(WORKLIBLIST) {
		#set compiler
		set k [string last . $i]
		set compStr ""
		set comp ""
		if {$k != -1} {
			set len [string length $i]
			set suf [string range $i [expr $k] [expr $len-1]]
			
			if { [string equal -nocase $compiler "verilog"] } {
				set comp "vlog"
			} elseif { [string equal -nocase $compiler "vhdl"] } {
				set comp "vcom"
			} else {
				if { [lsearch $Para(VERISUFFIX) $suf] != -1 } {
					set comp "vlog"
				} elseif { [lsearch $Para(VHDLSUFFIX) $suf] != -1 } {
					set comp "vcom"
				}
			}
			if { [string equal -nocase $comp "vcom"] } {
				set compStr "vcom -dbg"
			} elseif { [string equal -nocase $comp "vlog"] } {
				set compStr "vlog -dbg"
				if { ![string equal -nocase $inc "none"] } {
					foreach eachinc $inc	{
						append compStr " +incdir+"
						append compStr "\"$eachinc\""
					}
#					foreach inc $Para(GLBINCLIST) {
#						append compStr " +incdir+"
#						append var "\{$inc\}"
#					}
				}
			}			
		}

		#add source files and compile them
		if { [string length $compStr] } {
			if { ![string equal -nocase $work ""]} {
				puts $DoFile "$compStr -work $work \"$i\""
			}	else	{
				puts $DoFile "$compStr \"$i\""
			}
		}	
	}
	
	
	#set top module
	if {[string length $Para(SIMULATIONTOPMODULE)] > 0} {
	
		if { [string equal -nocase $Para(LANGUAGE) "verilog"] } {
			puts $DoFile "module $Para(SIMULATIONTOPMODULE)"
		} elseif { [string equal -nocase $Para(LANGUAGE) "vhdl"] } {
			puts $DoFile "entity $Para(SIMULATIONTOPMODULE)"
		} 
	
	}


	#load sdf
    set sdfArgumentsForWaveform ""
	if {[string length $Para(SDFPATH)] > 0 && [string length $Para(SIMULATIONINSTANCE)] > 0 } {
        set instanceWithTestBech "/$Para(SIMULATIONTOPMODULE)$Para(SIMULATIONINSTANCE)"
        append sdfArgumentsForWaveform "-sdfmax $instanceWithTestBech=\"$Para(SDFPATH)\""
        puts $DoFile "designsdffile \"$Para(SDFPATH)\" $instanceWithTestBech -sdfmax -load yes" 
        
        puts $DoFile "designsimaddoptions +transport_path_delays +transport_int_delays"
	}
	

    #get simulation libs
    set simulationLibs ""
    foreach i $Para(SIMLIBLIST) {
        if {[string equal -nocase $i "pmi_work"]} {
            append simulationLibs " -PL $i"
        } else {
            append simulationLibs " -L $i"
        }
    }
    #get hdl parameters;
    set hdlParameters ""
    foreach i $Para(HDLPARAMETERS) {
        append hdlParameters " -G$i"       
    }
    
    #initialize simulation
    if {[string length $Para(SDFPATH)] > 0 && [string length $Para(SIMULATIONINSTANCE)] > 0 } {
        puts $DoFile "vsim $hdlParameters +access +r $Para(SIMULATIONTOPMODULE) $sdfArgumentsForWaveform $simulationLibs  +transport_path_delays +transport_int_delays"
    } else {
        puts $DoFile "vsim $hdlParameters +access +r $Para(SIMULATIONTOPMODULE) $sdfArgumentsForWaveform $simulationLibs"
    }
        
    #add top-level signals to waveform display    
    if { $Para(ADDTOPLEVELSIGNALSTOWAVEFORM) == "1" } {
        
        puts $DoFile "add wave *"
    }
    
    #run simulation
    if { $Para(RUNSIMULATION) == "1" } {
        puts $DoFile "run 1000ns"
    }
        
	close $DoFile

	return 0
}

#-----------------------------------------------------------------------
# generate script file and run ModelSim tool
#-----------------------------------------------------------------------
proc ::bali::simulation::ModelSim_Run {} {	
	variable Para	
	
	set filename $Para(PROJECTPATH)/$Para(PROJECT)/$Para(PROJECT)
	set mdofile $Para(PROJECTPATH)/$Para(PROJECT)/$Para(PROJECT).mdo
	if [catch {open "$mdofile" w} DoFile ] {
		return -1
	}
	puts $DoFile "if \{!\[file exists \"$filename.mpf\"\]\} \{ "
	puts $DoFile "	project new \"$Para(PROJECTPATH)/$Para(PROJECT)\" $Para(PROJECT)"
	
	foreach i $Para(FILELIST) {
		puts $DoFile "	project addfile \"$i\""
	}
	
	#delete all libs.
	set libs ""
	foreach work $Para(WORKLIBLIST) {
		if { ![string equal -nocase $work "none"]}	{
			#set default lib to "work" instead of empty string
			set mywork $work
			if { [string equal -nocase $work ""]} {
				set mywork "work"
			}
			if { [lsearch $libs $mywork] == -1 } {
				# create $work if not exist.
				puts $DoFile "	vlib  $mywork"			
				# del this lib in case to clean up existing libs.
				puts $DoFile "	vdel -lib $mywork -all "	
				# create this $work.				
				puts $DoFile "	vlib $mywork"				
				lappend libs $mywork
			}
		}
	}
    #refresh for pojo2
    if {[string length $Para(POJO2LIBREFRESH)] > 0 } {
        puts $DoFile "	$Para(POJO2LIBREFRESH)"
    }
    
	
#	puts $DoFile "	vdel -lib work -all"
#	puts $DoFile "    vlib work"
	foreach i $Para(FILELIST) compiler $Para(COMPLIST) inc $Para(INCLIST) work $Para(WORKLIBLIST) {
		#set compiler
		set j [string last > $i]
		set k [string last . $i]
		set compStr ""
		set comp ""
		if {$k != -1} {
			set len [string length $i]
			if {$j != -1} {
				set suf [string range $i [expr $k] [expr $j-1]]
			} else {
				set suf [string range $i [expr $k] [expr $len-1]]
			}
			
			if { [string equal -nocase $compiler "verilog"] } {
				set comp "vlog"
			} elseif { [string equal -nocase $compiler "vhdl"] } {
				set comp "vcom"
			} else {
				if { [lsearch $Para(VERISUFFIX) $suf] != -1 } {
					set comp "vlog"
				} elseif { [lsearch $Para(VHDLSUFFIX) $suf] != -1 } {
					set comp "vcom"
				}
                
			}
			if { [string equal -nocase $comp "vcom"] } {
				set compStr "	vcom"
			} elseif { [string equal -nocase $comp "vlog"] } {
				set compStr "	vlog"
				if { ![string equal -nocase $inc "none"] } {
#					append compStr " +incdir+"
#					append compStr "\"$inc\""
					foreach eachinc $inc	{
                        append compStr " \{+incdir+$eachinc\}"
					}
				}
				foreach ginc $Para(GLBINCLIST) {                   
                    if { [string first "\{+incdir+$ginc\}" $compStr] == -1 } {
                            append compStr " \{+incdir+$ginc\}"
                        }
				}
				if {[string length $Para(POJO2MODELSIMLIB)] > 0 } {
                    append compStr " $Para(POJO2MODELSIMLIB) "
                }
			}
		}
		
		#add source files and compile them
		if { ![string equal -nocase $work "none"] } {
			#set default lib to "work" instead of empty string
			set mywork $work
			if { [string equal -nocase $work ""]} {
				set mywork "work"
			}
			if { [string length $compStr] } {
				puts $DoFile "$compStr -work $mywork \"$i\""
			}
		}
	}
	
	puts $DoFile "\} else \{"
	puts $DoFile "	project open \"$Para(PROJECTPATH)/$Para(PROJECT)/$Para(PROJECT)\""
	puts $DoFile "\}"
	#modelsim stange things. run vsim will remember this command line 'do {<mdo file>}'. so run vsim first.
	puts $DoFile "vsim -version"
	close $DoFile
		
	return 0
}
