current_design non_overlap

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA

set_false_path -from [get_pins thermo] -to [get_pins ON]
set_false_path -from [get_pins thermo] -to [get_pins ON_N]