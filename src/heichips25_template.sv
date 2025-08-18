// SPDX-FileCopyrightText: © 2025 XXX Authors
// SPDX-License-Identifier: Apache-2.0

// Adapted from the Tiny Tapeout template

`default_nettype none

module heichips25_template (
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
    
    non_overlap #(
		.IN_WIDTH (256))
	no_inst(
		.thermo(thermo_out),
		.ON(ON),
		.ON_N(ON_N)
	);
    
    assign uo_out  = thermo_out[7:0];
    assign uio_out = ON[7:0];
    assign uio_oe  = ON_N[7:0];

endmodule
