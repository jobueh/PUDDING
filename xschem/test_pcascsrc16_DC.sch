v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 680 -300 680 -280 {lab=GND}
N 540 -300 680 -300 {lab=GND}
N 920 -1000 920 -880 {lab=VDDA}
N 620 -1000 620 -880 {lab=VDDA}
N 700 -840 700 -740 {lab=Vpbias}
N 680 -840 700 -840 {lab=Vpbias}
N 620 -740 700 -740 {lab=Vpbias}
N 620 -760 620 -740 {lab=Vpbias}
N 920 -760 920 -580 {lab=Vout}
N 920 -520 920 -400 {lab=VDDA}
N 1040 -1000 1040 -400 {lab=VDDA}
N 920 -1000 1040 -1000 {lab=VDDA}
N 620 -520 620 -480 {lab=#net1}
N 620 -420 620 -400 {lab=VDDA}
N 920 -400 1040 -400 {lab=VDDA}
N 680 -400 680 -380 {lab=VDDA}
N 620 -400 680 -400 {lab=VDDA}
N 680 -320 680 -300 {lab=GND}
N 620 -1000 920 -1000 {lab=VDDA}
N 540 -320 540 -300 {lab=GND}
N 540 -400 540 -380 {lab=logI}
N 720 -800 860 -800 {lab=Vpcbias}
N 700 -840 860 -840 {lab=Vpbias}
N 680 -400 920 -400 {lab=VDDA}
N 620 -740 620 -690 {lab=Vpbias}
N 620 -600 620 -580 {lab=Vpcbias}
N 620 -600 720 -600 {lab=Vpcbias}
N 620 -630 620 -600 {lab=Vpcbias}
N 720 -660 720 -600 {lab=Vpcbias}
N 660 -660 720 -660 {lab=Vpcbias}
N 600 -1000 620 -1000 {lab=VDDA}
N 540 -1000 540 -660 {lab=VDDA}
N 540 -660 620 -660 {lab=VDDA}
N 720 -800 720 -660 {lab=Vpcbias}
N 680 -800 720 -800 {lab=Vpcbias}
N 600 -920 600 -880 {lab=NWELL}
N 600 -1000 600 -980 {lab=VDDA}
N 540 -1000 600 -1000 {lab=VDDA}
C {title.sym} 160 0 0 0 {name=l1 author="Christoph Maier"}
C {vsource.sym} 920 -550 0 0 {name=Vout value=-0.6 savecurrent=true}
C {gnd.sym} 680 -280 0 0 {name=l2 lab=GND}
C {devices/code_shown.sym} 40 -390 0 0 {name=NGSPICE only_toplevel=true 
value="
.include test_pcascsrc16_DC.save
.param temp=27
.options savecurrents
.control
save all 
op
write test_pcascsrc16_DC.raw
set appendwrite
dc Vout 0 -1.8 -10m VlogI -8 -6 0.5
write test_pcascsrc16_DC.raw
plot 2*(vout#branch/8-vprobe#branch)/(vprobe#branch+vout#branch/8)
plot vdda vpbias vpcbias vout
.endc
"}
C {simulator_commands_shown.sym} 40 -690 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
"
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
C {vsource.sym} 620 -450 0 1 {name=Vprobe value=0 savecurrent=true}
C {isource_arith.sym} 620 -550 0 0 {name=G1 CUR=10**V(logI)}
C {vsource.sym} 540 -350 0 1 {name=VlogI value=-7 savecurrent=true}
C {lab_pin.sym} 540 -400 0 0 {name=p6 lab=logI}
C {pcascsrc.sym} 620 -820 0 1 {name=xref[1:0]}
C {pcascsrc16.sym} 920 -820 0 0 {name=xsrc}
C {vsource.sym} 680 -350 0 1 {name=VDDA value=1.8 savecurrent=true}
C {lab_pin.sym} 540 -1000 0 0 {name=p1 lab=VDDA}
C {lab_pin.sym} 620 -740 0 0 {name=p2 lab=Vpbias}
C {lab_pin.sym} 620 -600 0 0 {name=p3 lab=Vpcbias
value=0.4}
C {lab_pin.sym} 920 -720 0 0 {name=p4 lab=Vout}
C {sg13g2_pr/sg13_lv_pmos.sym} 640 -660 0 1 {name=Mcbias
l=0.15u
w=6u
ng=1
m=2
model=sg13_lv_pmos
spiceprefix=X
}
C {vsource.sym} 600 -950 0 1 {name=VNWELL value=0 savecurrent=true}
C {lab_pin.sym} 600 -900 0 0 {name=p5 lab=NWELL}
