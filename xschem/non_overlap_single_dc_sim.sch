v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -600 0 -600 40 {lab=VDD}
N -600 100 -600 120 {lab=GND}
N -490 100 -490 120 {lab=GND}
N 0 70 0 90 {lab=GND}
N -490 0 -490 40 {lab=VIN}
N 0 -110 0 -70 {lab=VDD}
N -190 0 -150 0 {lab=VIN}
N 150 -20 190 -20 {lab=ON}
N 150 20 190 20 {lab=ON_N}
C {non_overlap.sym} 0 0 0 0 {name=xdut}
C {devices/code_shown.sym} -650 200 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.include sg13g2_stdcell.spice
.lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -650 -330 0 0 {name=NGSPICE only_toplevel=true 
value="
*.include non_overlap_single_dc_sim.save
.param temp=27
.control
save all 
tran 50p 20n
write non_overlap_single_dc_sim.raw
.endc
"}
C {vsource.sym} -600 70 0 0 {name=VDD value=1.5 savecurrent=false}
C {vsource.sym} -490 70 0 0 {name=VIN value="dc 0 ac 0 pulse(0, 1.2, 0, 100p, 100p, 2n, 4n)" savecurrent=false}
C {lab_pin.sym} -600 0 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {gnd.sym} -600 120 0 0 {name=l1 lab=GND}
C {gnd.sym} -490 120 0 0 {name=l2 lab=GND}
C {gnd.sym} 0 90 0 0 {name=l3 lab=GND}
C {lab_pin.sym} -490 0 0 0 {name=p2 sig_type=std_logic lab=VIN}
C {lab_pin.sym} 0 -110 0 0 {name=p3 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -190 0 0 0 {name=p4 sig_type=std_logic lab=VIN}
C {lab_pin.sym} 190 -20 2 0 {name=p5 sig_type=std_logic lab=ON}
C {lab_pin.sym} 190 20 2 0 {name=p6 sig_type=std_logic lab=ON_N}
C {title.sym} -500 280 0 0 {name=l4 author="Luis Ardila"}
