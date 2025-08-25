current_design heichips25_pudding

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports clk] -name clk -period 10

set_false_path -from [get_pins thermo_out\[*\]] -to [get_pins on_out\[*\]]
set_false_path -from [get_pins thermo_out\[*\]] -to [get_pins on__n_out\[*\]]