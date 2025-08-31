// File: dac2u128out4in.v
// SystemVerilog: 128 unit source DAC module digital placeholder
// Yosys hints: blackbox + keep_hierarchy.
(* blackbox *)
module dac2u128out4in (
    input [127:0] ON,
    input [127:0] ONB,
    input [3:0] EN,
    input [3:0] ENB,
    inout [1:0] VpcascP,
    inout [1:0] VbiasP,
    output Iout
);

// List all unused inputs to prevent warnings
wire _unused = &{VbiasP[1:0],VpcascP[1:0],Iout};


endmodule
