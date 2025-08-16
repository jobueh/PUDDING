v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 680 -300 680 -280 {lab=GND}
N 540 -300 680 -300 {lab=GND}
N 920 -860 920 -740 {lab=VDDA}
N 780 -860 920 -860 {lab=VDDA}
N 620 -860 620 -740 {lab=VDDA}
N 700 -700 860 -700 {lab=Vpbias}
N 700 -700 700 -600 {lab=Vpbias}
N 680 -700 700 -700 {lab=Vpbias}
N 620 -600 700 -600 {lab=Vpbias}
N 620 -620 620 -600 {lab=Vpbias}
N 620 -600 620 -580 {lab=Vpbias}
N 780 -660 860 -660 {lab=Vpcbias}
N 920 -620 920 -580 {lab=Vout}
N 920 -520 920 -480 {lab=VDDA}
N 920 -480 1040 -480 {lab=VDDA}
N 1040 -860 1040 -480 {lab=VDDA}
N 920 -860 1040 -860 {lab=VDDA}
N 620 -520 620 -480 {lab=#net1}
N 620 -420 620 -400 {lab=VDDA}
N 680 -400 1040 -400 {lab=VDDA}
N 1040 -480 1040 -400 {lab=VDDA}
N 680 -400 680 -380 {lab=VDDA}
N 620 -400 680 -400 {lab=VDDA}
N 680 -320 680 -300 {lab=GND}
N 780 -860 780 -820 {lab=VDDA}
N 620 -860 780 -860 {lab=VDDA}
N 780 -760 780 -660 {lab=Vpcbias}
N 680 -660 780 -660 {lab=Vpcbias}
N 540 -320 540 -300 {lab=GND}
N 540 -400 540 -380 {lab=logI}
C {title.sym} 160 0 0 0 {name=l1 author="Christoph Maier"}
C {vsource.sym} 920 -550 0 0 {name=Vout value=-0.8 savecurrent=true}
C {gnd.sym} 680 -280 0 0 {name=l2 lab=GND}
C {devices/code_shown.sym} 40 -390 0 0 {name=NGSPICE only_toplevel=true 
value="
.include test_pcascsrc_DC.save
.param temp=27
.options savecurrents
.control
save all 
op
write test_pcascsrc_DC.raw
set appendwrite
dc VlogI -8 -5 10m
write test_pcascsrc_DC.raw
plot ylog vprobe#branch vout#branch
plot vdda vpbias vpcbias vout xref.drain xsrc.drain
plot @n.xref.xmsrc.nsg13_lv_pmos[gm]/vprobe#branch @n.xref.xmcasc.nsg13_lv_pmos[gm]/vprobe#branch @n.xsrc.xmsrc.nsg13_lv_pmos[gm]/vout#branch @n.xsrc.xmcasc.nsg13_lv_pmos[gm]/vout#branch
plot @n.xref.xmsrc.nsg13_lv_pmos[gm]/@n.xref.xmsrc.nsg13_lv_pmos[gds] @n.xref.xmcasc.nsg13_lv_pmos[gm]/@n.xref.xmcasc.nsg13_lv_pmos[gds] @n.xsrc.xmsrc.nsg13_lv_pmos[gm]/@n.xsrc.xmsrc.nsg13_lv_pmos[gds] @n.xsrc.xmcasc.nsg13_lv_pmos[gm]/@n.xsrc.xmcasc.nsg13_lv_pmos[gds]
.endc
"}
C {simulator_commands_shown.sym} 40 -690 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
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
C {pcascsrc.sym} 620 -680 0 1 {name=xref}
C {pcascsrc.sym} 920 -680 0 0 {name=xsrc}
C {vsource.sym} 680 -350 0 1 {name=VDDA value=1.8 savecurrent=true}
C {lab_pin.sym} 620 -820 0 0 {name=p1 lab=VDDA}
C {lab_pin.sym} 620 -600 0 0 {name=p2 lab=Vpbias}
C {vsource.sym} 780 -790 0 0 {name=Vpcasc value=1.8 savecurrent=true}
C {lab_pin.sym} 780 -740 0 0 {name=p3 lab=Vpcbias}
C {lab_pin.sym} 920 -600 0 0 {name=p4 lab=Vout}
