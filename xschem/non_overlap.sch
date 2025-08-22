v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -100 -170 -40 -170 {lab=a1}
N 180 -170 240 -170 {lab=a3}
N 320 -170 390 -170 {lab=a4}
N 390 -170 410 -170 {lab=a4}
N 40 -170 100 -170 {lab=a2}
N 180 160 240 160 {lab=b3}
N 320 160 390 160 {lab=b4}
N 390 160 410 160 {lab=b4}
N 40 160 100 160 {lab=b2}
N 390 -170 390 -80 {lab=a4}
N 390 70 390 160 {lab=b4}
N -250 -50 390 70 {lab=b4}
N -250 40 390 -80 {lab=a4}
N -250 40 -250 140 {lab=a4}
N -250 140 -220 140 {lab=a4}
N -250 -150 -250 -50 {lab=b4}
N -250 -150 -220 -150 {lab=b4}
N -330 -190 -220 -190 {lab=thermo}
N -330 -190 -330 -50 {lab=thermo}
N -410 -190 -330 -190 {lab=thermo}
N -330 180 -220 180 {lab=thermon}
N -330 30 -330 180 {lab=thermon}
N 490 -170 570 -170 {lab=ON}
N 490 160 570 160 {lab=ON_N}
N -470 150 -420 150 {lab=VSS}
N -470 120 -420 120 {lab=VDD}
N -100 160 -40 160 {lab=b1}
C {sg13g2_stdcells/sg13g2_inv_1.sym} -330 -10 1 0 {name=x0 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_nor2_1.sym} -160 -170 0 0 {name=x1 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_nor2_1.sym} -160 160 0 0 {name=x2 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_dlygate4sd1_1.sym} 0 -170 0 0 {name=x3 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_dlygate4sd1_1.sym} 0 160 0 0 {name=x4 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_dlygate4sd2_1.sym} 140 -170 0 0 {name=x5 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_dlygate4sd2_1.sym} 140 160 0 0 {name=x6 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_dlygate4sd3_1.sym} 280 -170 0 0 {name=x7 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_dlygate4sd3_1.sym} 280 160 0 0 {name=x8 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_inv_1.sym} 450 -170 0 0 {name=x9 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_inv_1.sym} 450 160 0 0 {name=x10 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {iopin.sym} -470 150 2 0 {name=p1 lab=VSS}
C {ipin.sym} -410 -190 0 0 {name=p3 lab=thermo}
C {opin.sym} 570 -170 0 0 {name=p4 lab=ON}
C {opin.sym} 570 160 0 0 {name=p5 lab=ON_N}
C {iopin.sym} -470 120 2 0 {name=p2 lab=VDD}
C {title.sym} -390 350 0 0 {name=l1 author="Original: Luis Ardila; Palimpsest: Christoph Maier"}
C {lab_wire.sym} -420 150 0 0 {name=p8 sig_type=std_logic lab=VSS}
C {lab_wire.sym} -420 120 0 0 {name=p9 sig_type=std_logic lab=VDD}
C {devices/code_shown.sym} -550 280 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {lab_wire.sym} -260 180 0 0 {name=p6 sig_type=std_logic lab=thermon}
C {lab_wire.sym} -60 -170 0 0 {name=p7 sig_type=std_logic lab=a1}
C {lab_wire.sym} -60 160 0 0 {name=p10 sig_type=std_logic lab=b1}
C {lab_wire.sym} 80 -170 0 0 {name=p11 sig_type=std_logic lab=a2}
C {lab_wire.sym} 80 160 0 0 {name=p12 sig_type=std_logic lab=b2}
C {lab_wire.sym} 220 -170 0 0 {name=p13 sig_type=std_logic lab=a3}
C {lab_wire.sym} 220 160 0 0 {name=p14 sig_type=std_logic lab=b3}
C {lab_wire.sym} 360 -170 0 0 {name=p15 sig_type=std_logic lab=a4}
C {lab_wire.sym} 360 160 0 0 {name=p16 sig_type=std_logic lab=b4}
