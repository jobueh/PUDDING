// File: non_overlap.sv
// SystemVerilog: non overlaping ON - ON_N logic for the current mirrors

module non_overlap #(
	parameter int IN_WIDTH = 32,
	parameter int NUMBER_OF_DELAYS = 1
) (
	input logic [IN_WIDTH-1:0] thermo,
	output logic [IN_WIDTH-1:0] ON,
	output logic [IN_WIDTH-1:0] ON_N
);
	
	// Combinatorial generation of non overlaping inverted logic
	for (genvar i = 0; i < IN_WIDTH; i++) begin : comb_logic
		(* keep *) wire delayed[NUMBER_OF_DELAYS-1:0];
		(* keep *) wire pulse_out_n;


		//first delay cell
		(* keep *) sg13g2_dlygate4sd1_1 delay1_I (.X(delayed[0]), .A(thermo[i]));

		//Generate delay cell-chain
		for (genvar n = 0; n < NUMBER_OF_DELAYS -1; n++) begin :delay_chain
			(* keep *) sg13g2_dlygate4sd1_1 delay1_I (.X(delayed[n+1]), .A(delayed[n]));
		end
	
		(* keep *) sg13g2_xnor2_1 xor_pulse_I (pulse_out_n,thermo[i], delayed[NUMBER_OF_DELAYS-1]);
		(* keep *) sg13g2_nand2_2 nand_on_I (ON[i],pulse_out_n, ~thermo[i]);
		(* keep *) sg13g2_nand2_2 nand_on_n_I (ON_N[i],pulse_out_n, thermo[i]);
	end
	
endmodule