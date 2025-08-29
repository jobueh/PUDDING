# make_dac_pads.py
try:
    from klayout import db as pya
except:
    import pya

# Create layout
layout = pya.Layout()
layout.dbu = 0.001  # 1 nm units
top = layout.create_cell("SWITCHED_PMOS_CASCODE")

# Parameters
n = 300

# Layers
l_m2     = layout.layer(pya.LayerInfo(10, 0))
l_m2text = layout.layer(pya.LayerInfo(10, 2))

# Draw shapes
top.shapes(l_m2).insert(    pya.Box( -420, -4910,  -130, -4620))
top.shapes(l_m2).insert(    pya.Box(  130, -4910,   420, -4620))
top.shapes(l_m2).insert(    pya.Text("ON", -275, -4765))
top.shapes(l_m2).insert(    pya.Text("ONB", 275, -4765))

# Save GDS
layout.write("dac_pads.gds")
print("Wrote dac_pads.gds")

