v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 660 -400 660 -380 {lab=GND}
N 740 -400 820 -400 {lab=GND}
N 1460 -1000 1460 -880 {lab=VDD}
N 820 -1000 820 -880 {lab=VDD}
N 900 -840 900 -740 {lab=Vpbias}
N 880 -840 900 -840 {lab=Vpbias}
N 820 -740 900 -740 {lab=Vpbias}
N 820 -760 820 -740 {lab=Vpbias}
N 1460 -760 1460 -580 {lab=Vout}
N 1460 -520 1460 -400 {lab=GND}
N 820 -520 820 -480 {lab=#net1}
N 820 -420 820 -400 {lab=GND}
N 740 -420 740 -400 {lab=GND}
N 740 -500 740 -480 {lab=logI}
N 900 -840 1400 -840 {lab=Vpbias}
N 820 -740 820 -690 {lab=Vpbias}
N 820 -600 820 -580 {lab=Vpcbias}
N 820 -600 920 -600 {lab=Vpcbias}
N 820 -630 820 -600 {lab=Vpcbias}
N 920 -660 920 -600 {lab=Vpcbias}
N 860 -660 920 -660 {lab=Vpcbias}
N 740 -1000 820 -1000 {lab=VDD}
N 740 -1000 740 -660 {lab=VDD}
N 740 -660 820 -660 {lab=VDD}
N 920 -800 920 -660 {lab=Vpcbias}
N 880 -800 920 -800 {lab=Vpcbias}
N 1280 -1000 1460 -1000 {lab=VDD}
N 1380 -800 1400 -800 {lab=Vpcasc}
N 1280 -640 1280 -600 {lab=Vpcbias}
N 920 -600 1280 -600 {lab=Vpcbias}
N 1280 -1000 1280 -760 {lab=VDD}
N 1340 -700 1380 -700 {lab=Vpcasc}
N 1380 -800 1380 -700 {lab=Vpcasc}
N 1120 -1000 1280 -1000 {lab=VDD}
N 660 -400 740 -400 {lab=GND}
N 660 -520 660 -400 {lab=GND}
N 660 -1000 660 -580 {lab=VDD}
N 660 -1000 740 -1000 {lab=VDD}
N 1120 -400 1460 -400 {lab=GND}
N 1180 -720 1220 -720 {lab=off_n}
N 1180 -680 1220 -680 {lab=on_n}
N 1120 -640 1120 -400 {lab=GND}
N 1020 -400 1120 -400 {lab=GND}
N 1120 -1000 1120 -760 {lab=VDD}
N 820 -1000 1120 -1000 {lab=VDD}
N 1020 -520 1020 -400 {lab=GND}
N 820 -400 1020 -400 {lab=GND}
N 1020 -700 1020 -580 {lab=switch}
N 1020 -700 1060 -700 {lab=switch}
C {title.sym} 160 0 0 0 {name=l1 author="Christoph Maier"}
C {vsource.sym} 1460 -550 0 0 {name=Vout value=\{vdd-vout\} savecurrent=true}
C {gnd.sym} 660 -380 0 0 {name=l2 lab=GND}
C {devices/code_shown.sym} 40 -550 0 0 {name=NGSPICE only_toplevel=true 
value="
.include test_switchedsources_tran.save
.param temp=27
.options gmin=1e-15 abstol=1p method=gear
.options savecurrents
.param logI=-7
.param vdd=1.6
.param vout=0.6
.param tclock=100n
.param thigh=50n
.param trise=10p
.param tfall=10p
.control
save all 
op
write test_switchedsources_tran.raw
set appendwrite
*dc Vout 0 1.6 10m VlogI -8 -6 0.5
tran 1n 1u
write test_switchedsources_tran.raw
plot 2*(vout#branch-vprobe#branch)/(vprobe#branch+vout#branch)
plot vdd vpbias vpcbias switch on_n off_n vpcasc vout xref.drain xsrc.drain
plot vprobe#branch vout#branch
plot switch on_n off_n Vpcasc
.endc
"}
C {simulator_commands_shown.sym} 40 -690 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value=".include sg13g2_stdcell.spice
.lib cornerMOSlv.lib mos_tt"
      }
C {launcher.sym} 160 -820 0 0 {name=h3
descr=SimulateNGSPICE
tclcommand="
# Setup the default simulation commands if not already set up
# for example by already launched simulations.
set_sim_defaults
puts $sim(spice,1,cmd) 

# Change the Xyce command. In the spice category there are currently
# 5 commands (0, 1, 2, 3, 4). Command 3 is the Xyce batch
# you can get the number by querying $sim(spice,n)
set sim(spice,1,cmd) \{ngspice  \\"$N\\" -a\}

# change the simulator to be used (Xyce)
set sim(spice,default) 0

# Create FET and BIP .save file
exec mkdir -p $netlist_dir
write_data [save_params] $netlist_dir/[file rootname [file tail [xschem get current_name]]].save

# run netlist and simulation
xschem netlist
simulate
"}
C {devices/launcher.sym} 160 -790 0 0 {name=h1
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {devices/launcher.sym} 160 -760 0 0 {name=h2
descr="Load waves" 
tclcommand="
xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw dc
xschem setprop rect 2 0 fullxzoom
"
}
C {vsource.sym} 820 -450 0 1 {name=Vprobe value=0 savecurrent=true}
C {isource_arith.sym} 820 -550 0 0 {name=G1 CUR=10**V(logI)}
C {vsource.sym} 740 -450 0 1 {name=VlogI value=\{logI\} savecurrent=true}
C {lab_pin.sym} 740 -500 0 0 {name=p6 lab=logI}
C {pcascsrc.sym} 820 -820 0 1 {name=xref}
C {pcascsrc.sym} 1460 -820 0 0 {name=xsrc}
C {vsource.sym} 660 -550 0 1 {name=VDDA value=\{vdd\} savecurrent=true}
C {lab_wire.sym} 960 -840 0 0 {name=p2 lab=Vpbias}
C {sg13g2_pr/sg13_lv_pmos.sym} 840 -660 0 1 {name=Mcbias
l=0.15u
w=6u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_wire.sym} 890 -600 0 0 {name=p3 lab=Vpcbias}
C {lab_wire.sym} 880 -1000 0 0 {name=p1 lab=VDD}
C {lab_wire.sym} 1460 -750 3 0 {name=p4 lab=Vout}
C {cascodeswitch_pmos.sym} 1280 -700 0 0 {name=xsw}
C {lab_wire.sym} 1380 -800 0 0 {name=p5 lab=Vpcasc}
C {switch_logic.sym} 1120 -700 0 0 {name=xlogic}
C {lab_wire.sym} 1200 -720 0 0 {name=p7 sig_type=std_logic lab=off_n}
C {lab_wire.sym} 1200 -680 0 0 {name=p8 sig_type=std_logic lab=on_n}
C {vsource.sym} 1020 -550 0 0 {name=VSW value="dc 0 ac 0 pulse(0, \{vdd\}, \{tclock/4\}, \{trise\}, \{tfall\}, \{thigh\}, \{tclock\})" savecurrent=true}
C {lab_wire.sym} 1020 -700 0 0 {name=p9 sig_type=std_logic lab=switch}
