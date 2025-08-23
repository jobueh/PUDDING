v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -60 -170 -40 -170 {lab=thermo}
N 180 -170 240 -170 {lab=a3}
N 320 -170 410 -170 {lab=a4}
N 40 -170 100 -170 {lab=a2}
N -100 -170 -60 -170 {lab=thermo}
N 660 -270 740 -270 {lab=ON}
N 660 -40 740 -40 {lab=ON_N}
N -470 150 -420 150 {lab=VSS}
N -470 120 -420 120 {lab=VDD}
N -60 -130 410 -130 {lab=thermo}
N -60 -170 -60 -130 {lab=thermo}
N 540 -250 560 -250 {lab=#net1}
N 540 -150 540 -60 {lab=#net1}
N 540 -60 550 -60 {lab=#net1}
N 530 -150 540 -150 {lab=#net1}
N 540 -250 540 -150 {lab=#net1}
N -100 -290 560 -290 {lab=thermo}
N -100 -290 -100 -170 {lab=thermo}
N -140 -170 -100 -170 {lab=thermo}
N -30 -20 550 -20 {lab=#net2}
N -140 -20 -110 -20 {lab=thermo}
N -140 -170 -140 -20 {lab=thermo}
N -410 -170 -140 -170 {lab=thermo}
C {sg13g2_stdcells/sg13g2_dlygate4sd1_1.sym} 0 -170 0 0 {name=x3 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_dlygate4sd2_1.sym} 140 -170 0 0 {name=x5 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_dlygate4sd3_1.sym} 280 -170 0 0 {name=x7 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {iopin.sym} -470 150 2 0 {name=p1 lab=VSS}
C {ipin.sym} -410 -170 0 0 {name=p3 lab=thermo}
C {opin.sym} 740 -270 0 0 {name=p4 lab=ON}
C {opin.sym} 740 -40 0 0 {name=p5 lab=ON_N}
C {iopin.sym} -470 120 2 0 {name=p2 lab=VDD}
C {lab_wire.sym} -420 150 0 0 {name=p8 sig_type=std_logic lab=VSS}
C {lab_wire.sym} -420 120 0 0 {name=p9 sig_type=std_logic lab=VDD}
C {devices/code_shown.sym} -550 280 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {lab_wire.sym} 80 -170 0 0 {name=p11 sig_type=std_logic lab=a2}
C {lab_wire.sym} 220 -170 0 0 {name=p13 sig_type=std_logic lab=a3}
C {lab_wire.sym} 360 -170 0 0 {name=p15 sig_type=std_logic lab=a4}
C {sg13g2_stdcells/sg13g2_xor2_1.sym} 470 -150 0 0 {name=x1 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_or2_2.sym} 620 -270 0 0 {name=x2 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_or2_2.sym} 610 -40 0 0 {name=x4 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_inv_2.sym} -70 -20 0 0 {name=x6 VDD=VDD VSS=VSS prefix=sg13g2_ }
