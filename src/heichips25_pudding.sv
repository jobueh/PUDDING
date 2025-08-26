// SPDX-FileCopyrightText: © 2025 Luis Ardila, Jonas Buehler, Christoph Maier
// SPDX-License-Identifier: Apache-2.0

// Adapted from the Tiny Tapeout template

`default_nettype none

module heichips25_pudding(
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, uio_in[7:0]};
	
    logic [7:0] count;
    logic dir_up = 1;
    wire shift_en;
    assign shift_en = uio_in[0];
    
    wire thermo_switch;
    assign thermo_switch = uio_in[1];
    
	reg [255:0] thermo;
	reg [255:0] thermo_shift;
	reg [255:0] thermo_out;
	
	wire [255:0] ON;
	wire [255:0] ON_N;
	

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            count <= '0;
        end else begin
            if (ui_in[0]) begin
                if (dir_up) begin 
                	count <= count + 1;
                	if (count == 254) begin
                		dir_up <= 0;
                	end
                end else begin
                	count <= count - 1;
                	if (count == 1) begin
                		dir_up <= 1;
                	end
                end                
            end
        end
    end
    
	thermometer_encoder #(
		.IN_WIDTH (8),
		.OUT_WIDTH (256))
	te_inst(
		.din (count),
		.thermo (thermo)
	);
	
	// shift register takes 8 bits at a time
	always_ff @(posedge clk) begin
        if (!rst_n) begin
            thermo_shift <= '0;
        end else if (shift_en) begin
        	thermo_shift <= {thermo_shift[255-8:0], ui_in}; 
        end
    end
    
    // switch to choose between standard thermo encoder (thermo_switch = 0) or shift register (thermo_switch = 1)
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            thermo_out <= '0;
        end else if (thermo_switch) begin
        	thermo_out <= thermo_shift;
        end else begin
        	thermo_out <= thermo;
        end
    end
    
	non_overlap non_overlap_x32_0 (
		.thermo(thermo_out[31:0]),
		.ON(ON[31:0]),
		.ON_N(ON_N[31:0])
	);
	
	non_overlap non_overlap_x32_1 (
		.thermo(thermo_out[63:32]),
		.ON(ON[63:32]),
		.ON_N(ON_N[63:32])
	);
	
	non_overlap non_overlap_x32_2 (
		.thermo(thermo_out[95:64]),
		.ON(ON[95:64]),
		.ON_N(ON_N[95:64])
	);
	
	non_overlap non_overlap_x32_3 (
		.thermo(thermo_out[127:96]),
		.ON(ON[127:96]),
		.ON_N(ON_N[127:96])
	);
	
	non_overlap non_overlap_x32_4 (
		.thermo(thermo_out[159:128]),
		.ON(ON[159:128]),
		.ON_N(ON_N[159:128])
	);
	
	non_overlap non_overlap_x32_5 (
		.thermo(thermo_out[191:160]),
		.ON(ON[191:160]),
		.ON_N(ON_N[191:160])
	);
	
	non_overlap non_overlap_x32_6 (
		.thermo(thermo_out[223:192]),
		.ON(ON[223:192]),
		.ON_N(ON_N[223:192])
	);
	
	non_overlap non_overlap_x32_7 (
		.thermo(thermo_out[255:224]),
		.ON(ON[255:224]),
		.ON_N(ON_N[255:224])
	);
    
    assign uo_out  = {thermo_out[255],thermo_out[223],thermo_out[191],thermo_out[159],
    				thermo_out[127],thermo_out[95],thermo_out[63],thermo_out[31]};
    assign uio_out = {ON[254],ON[222],ON[190],ON[158],ON[126],ON[94],ON[62],ON[30]};
    assign uio_oe  = {ON_N[253],ON_N[221],ON_N[189],ON_N[157],ON_N[125],ON_N[93],ON_N[61],ON_N[29]};

endmodule
