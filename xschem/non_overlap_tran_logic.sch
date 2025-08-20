v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 570 -270 1370 130 {flags=graph
y1=0
y2=1.8
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-1.3405248e-08
x2=6.594752e-09
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0

dataset=-1
unitx=1
logx=0
logy=0
color="6 8 7"
node="thermo
ON
ON_N"}
N 410 -50 410 130 {
lab=GND}
N -270 40 -270 50 {
lab=GND}
N 410 -290 410 -110 {
lab=#net1}
N 80 -10 80 10 {lab=GND}
N 230 -100 270 -100 {lab=ON}
N 230 -60 270 -60 {lab=ON_N}
N 80 -290 80 -150 {lab=#net1}
N 80 -290 410 -290 {lab=#net1}
N -270 -80 -70 -80 {lab=thermo}
N -270 -80 -270 -20 {lab=thermo}
C {devices/code_shown.sym} -290 190 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_ff
"}
C {devices/code_shown.sym} -330 -530 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=127
.control
save all 
tran 50p 20n
meas tran tdelay TRIG v(thermo) VAl=0.9 FALl=1 TARG v(ON) VAl=0.9 RISE=1
write non_overlap_tran_logic.raw
.endc
"}
C {devices/vsource.sym} 410 -80 0 0 {name=Vdd value=1.2}
C {devices/gnd.sym} 410 130 0 0 {name=l3 lab=GND}
C {devices/title.sym} -130 260 0 0 {name=l5 author="Luis Ardila"}
C {devices/launcher.sym} -270 -610 0 0 {name=h5
descr="load waves Ctrl + left click" 
tclcommand="xschem raw_read $netlist_dir/tran_logic_nand.raw tran"
}
C {devices/gnd.sym} -270 50 0 0 {name=l7 lab=GND}
C {devices/vsource.sym} -270 10 0 0 {name=Vthermo value="dc 0 ac 0 pulse(0, 1.2, 0, 100p, 100p, 2n, 4n ) "}
C {devices/lab_pin.sym} -270 -80 0 0 {name=p3 sig_type=std_logic lab=thermo}
C {non_overlap.sym} 80 -80 0 0 {name=x1}
C {gnd.sym} 80 10 0 0 {name=l8 lab=GND}
C {lab_pin.sym} 270 -100 2 0 {name=p6 sig_type=std_logic lab=ON}
C {lab_pin.sym} 270 -60 2 0 {name=p7 sig_type=std_logic lab=ON_N}
