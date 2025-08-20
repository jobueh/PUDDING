v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -100 -170 -70 -170 {lab=#net1}
N 40 -170 70 -170 {lab=#net2}
N 150 -170 180 -170 {lab=#net3}
N 260 -170 290 -170 {lab=#net4}
N 390 -170 410 -170 {lab=#net5}
N 40 -170 40 -140 {lab=#net2}
N 10 -170 40 -170 {lab=#net2}
N -100 160 -70 160 {lab=#net6}
N 40 160 70 160 {lab=#net7}
N 150 160 180 160 {lab=#net8}
N 260 160 290 160 {lab=#net9}
N 390 160 410 160 {lab=#net10}
N 40 160 40 190 {lab=#net7}
N 10 160 40 160 {lab=#net7}
N 390 -170 390 -80 {lab=#net5}
N 370 -170 390 -170 {lab=#net5}
N 390 70 390 160 {lab=#net10}
N 370 160 390 160 {lab=#net10}
N -250 -50 390 70 {lab=#net10}
N -250 40 390 -80 {lab=#net5}
N -250 40 -250 140 {lab=#net5}
N -250 140 -220 140 {lab=#net5}
N -250 -150 -250 -50 {lab=#net10}
N -250 -150 -220 -150 {lab=#net10}
N -330 -190 -220 -190 {lab=thermo}
N -330 -190 -330 -50 {lab=thermo}
N -410 -190 -330 -190 {lab=thermo}
N -330 180 -220 180 {lab=#net11}
N -330 30 -330 180 {lab=#net11}
N 490 -170 570 -170 {lab=ON}
N 490 160 570 160 {lab=ON_N}
N -470 150 -420 150 {lab=VSS}
N -470 120 -420 120 {lab=VDD}
C {capa.sym} 40 -110 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {sg13g2_stdcells/sg13g2_inv_1.sym} -30 -170 0 0 {name=x1 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_nor2_1.sym} -160 -170 0 0 {name=x2 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_inv_1.sym} 110 -170 0 0 {name=x3 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_inv_1.sym} 220 -170 0 0 {name=x4 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_inv_1.sym} 330 -170 0 0 {name=x5 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_inv_1.sym} 450 -170 0 0 {name=x6 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {iopin.sym} -470 150 2 0 {name=p1 lab=VSS}
C {capa.sym} 40 220 0 0 {name=C2
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {sg13g2_stdcells/sg13g2_inv_1.sym} -30 160 0 0 {name=x7 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_nor2_1.sym} -160 160 0 0 {name=x8 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_inv_1.sym} 110 160 0 0 {name=x9 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_inv_1.sym} 220 160 0 0 {name=x10 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_inv_1.sym} 330 160 0 0 {name=x11 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_inv_1.sym} 450 160 0 0 {name=x12 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_inv_1.sym} -330 -10 1 0 {name=x13 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {ipin.sym} -410 -190 0 0 {name=p3 lab=thermo}
C {opin.sym} 570 -170 0 0 {name=p4 lab=ON}
C {opin.sym} 570 160 0 0 {name=p5 lab=ON_N}
C {iopin.sym} -470 120 2 0 {name=p2 lab=VDD}
C {title.sym} -390 350 0 0 {name=l1 author="Luis Ardila"}
C {lab_wire.sym} 40 250 3 0 {name=p6 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 40 -80 3 0 {name=p7 sig_type=std_logic lab=VSS}
C {lab_wire.sym} -420 150 0 0 {name=p8 sig_type=std_logic lab=VSS}
C {lab_wire.sym} -420 120 0 0 {name=p9 sig_type=std_logic lab=VDD}
C {devices/code_shown.sym} -550 280 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
