v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 360 -500 360 -460 {lab=#net1}
N 360 -500 650 -500 {lab=#net1}
N 360 -530 360 -500 {lab=#net1}
N 650 -500 650 -230 {lab=#net1}
N 270 -560 270 -500 {lab=ON}
N 270 -560 320 -560 {lab=ON}
N 270 -430 320 -430 {lab=ON}
N 270 -470 270 -430 {lab=ON}
N 270 -470 560 -470 {lab=ON}
N 270 -500 270 -470 {lab=ON}
N 560 -470 560 -350 {lab=ON}
N 760 -310 910 -310 {lab=Pcascode_sw}
N 760 -310 760 -190 {lab=Pcascode_sw}
N 590 -310 760 -310 {lab=Pcascode_sw}
N 170 -190 620 -190 {lab=Pcascode}
N 170 -310 530 -310 {lab=VDD}
N 160 -500 270 -500 {lab=ON}
N 360 -350 360 -130 {lab=ESDGND}
N 360 -430 430 -430 {lab=ESDGND}
N 430 -430 430 -350 {lab=ESDGND}
N 360 -350 430 -350 {lab=ESDGND}
N 360 -400 360 -350 {lab=ESDGND}
N 650 -190 650 -110 {lab=VDD}
N 560 -310 560 -110 {lab=VDD}
N 360 -560 440 -560 {lab=VDD}
N 360 -620 360 -590 {lab=VDD}
N 440 -620 440 -560 {lab=VDD}
N 360 -620 440 -620 {lab=VDD}
N 360 -640 360 -620 {lab=VDD}
N 680 -190 760 -190 {lab=Pcascode_sw}
C {sg13g2_pr/sg13_lv_pmos.sym} 560 -330 1 0 {name=M1
l=0.13u
w=0.5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 340 -560 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 650 -210 1 0 {name=M3
l=0.13u
w=0.5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 340 -430 0 0 {name=M4
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {ipin.sym} 160 -500 0 0 {name=p1 lab=ON}
C {ipin.sym} 170 -190 0 0 {name=p2 lab=Pcascode}
C {ipin.sym} 360 -130 3 0 {name=p4 lab=ESDGND}
C {ipin.sym} 360 -640 1 0 {name=p5 lab=VDD}
C {opin.sym} 910 -310 0 0 {name=p6 lab=Pcascode_sw}
C {lab_wire.sym} 170 -310 0 0 {name=p3 sig_type=analog lab=VDD}
C {lab_wire.sym} 560 -110 3 0 {name=p7 sig_type=analog lab=VDD}
C {lab_wire.sym} 650 -110 3 0 {name=p8 sig_type=analog lab=VDD}
