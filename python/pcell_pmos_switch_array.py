# KLayout 0.30.2‑compatible PCell: PMOSSwitchArray
# -------------------------------------------------------------
# Parametric array of switchable PMOS transistors, side‑by‑side.
# Bottom diffusion (drain) has CO→M1 contacts; top diffusion is
# left clean for abutment (so stacking two instances vertically
# shorts the sources by OD abutment).
#
# NOTE for IHP SG13G2: map the placeholder LayerInfo tuples to
# your exact PDK layer numbers/datatypes and tune rules.
#
# This version avoids Box.from_dpoint/from_dbox and DTrans usage
# so it runs on KLayout 0.30.2.
# -------------------------------------------------------------

import pya

class PMOSSwitchArray(pya.PCellDeclarationHelper):
    def __init__(self):
        super(PMOSSwitchArray, self).__init__()

        # ---------- Parameters ----------
        self.param("n", self.TypeInt, "Number of devices", default=2)
        self.param("w", self.TypeDouble, "Gate width (um)", default=0.3)
        self.param("l", self.TypeDouble, "Gate length (um)", default=0.4)
        self.param("sd_ext", self.TypeDouble, "S/D OD extension (um)", default=0.10)
        self.param("bot_gap", self.TypeDouble, "Bottom OD gap for drain isolation (um)", default=0.20)

        self.param("cont_size", self.TypeDouble, "Contact size (um)", default=0.14)
        self.param("cont_pitch", self.TypeDouble, "Contact pitch (um)", default=0.24)
        self.param("cont_enc_od", self.TypeDouble, "OD enclosure of contact (um)", default=0.03)
        self.param("cont_enc_m1", self.TypeDouble, "M1 enclosure of contact (um)", default=0.03)

        self.param("po_ovl_od", self.TypeDouble, "Poly over OD (um)", default=0.05)
        self.param("po_space", self.TypeDouble, "Poly to poly spacing (um)", default=0.28)

        self.param("m1_lbl_prefix", self.TypeString, "M1 drain label prefix", default="D")
        self.param("add_gate_strap", self.TypeBoolean, "Add shared gate strap (M1)", default=False)
        self.param("add_nwell_tap", self.TypeBoolean, "Add N-well tap at left", default=False)

        # ---------- Layers (map to SG13G2) ----------
        self.param("ly_od", self.TypeLayer, "Diffusion (OD)", default=pya.LayerInfo(1, 0))
        self.param("ly_pimp", self.TypeLayer, "P+ implant", default=pya.LayerInfo(14, 0))
        self.param("ly_nwell", self.TypeLayer, "N-Well", default=pya.LayerInfo(31, 0))
        self.param("ly_po", self.TypeLayer, "Poly (Gate)", default=pya.LayerInfo(5, 0))
        self.param("ly_co", self.TypeLayer, "Contact (CO)", default=pya.LayerInfo(6, 0))
        self.param("ly_m1", self.TypeLayer, "Metal1 (M1)", default=pya.LayerInfo(8, 0))
        self.param("ly_lbl", self.TypeLayer, "Text Labels", default=pya.LayerInfo(63, 0))
        self.param("ly_ntap", self.TypeLayer, "N-well tap diffusion", default=pya.LayerInfo(1, 0))
        self.param("ly_pr", self.TypeLayer, "Placement boundary", default=pya.LayerInfo(63, 0))

    def display_text_impl(self):
        return f"PMOSSwitchArray_n{self.n}_W{self.w}_L{self.l}"

    # ---- Helpers (integer DBU geometry only; 0.30.2 safe) ----
    def _ibox(self, x0, y0, x1, y1, to_dbu):
        return pya.Box(to_dbu(x0), to_dbu(y0), to_dbu(x1), to_dbu(y1))

    def _ico(self, xc, yc, size, to_dbu):
        s = size * 0.5
        return self._ibox(xc - s, yc - s, xc + s, yc + s, to_dbu)

    def _insert_text(self, shapes, layer, txt, x, y, to_dbu):
        # Use integer Trans in DBU for 0.30.2 compatibility
        t = pya.Trans(to_dbu(x), to_dbu(y))
        shapes(layer).insert(pya.Text(txt, t))

    def produce_impl(self):
        dbu = self.layout.dbu
        to_dbu = lambda x: int(round(x / dbu))

        # Layers
        ly_od = self.layout.layer(self.ly_od)
        ly_pimp = self.layout.layer(self.ly_pimp)
        ly_nwell = self.layout.layer(self.ly_nwell)
        ly_po = self.layout.layer(self.ly_po)
        ly_co = self.layout.layer(self.ly_co)
        ly_m1 = self.layout.layer(self.ly_m1)
        ly_lbl = self.layout.layer(self.ly_lbl)
        ly_ntap = self.layout.layer(self.ly_ntap)
        ly_pr = self.layout.layer(self.ly_pr)

        shapes = self.cell.shapes

        # Derived dimensions
        gate_pitch = self.l + 2*self.sd_ext + self.po_space
        array_width = self.n * gate_pitch - self.po_space

        # Vertical coordinates (y=0 at bottom drain contact centerline)
        bottom_y = 0.0
        drain_co_y = bottom_y + self.cont_enc_od + self.cont_size/2.0
        od_bottom = bottom_y
        od_height = self.w + 2*self.sd_ext + self.bot_gap
        od_top = od_bottom + od_height
        gate_y0 = od_bottom + self.sd_ext
        gate_y1 = gate_y0 + self.w

        # --- Build OD and PIMP as Regions, then add notches, then dump ---
        od_reg = pya.Region(self._ibox(0.0, od_bottom, array_width, od_top, to_dbu))
        pim_reg = pya.Region(self._ibox(0.0, od_bottom, array_width, od_top, to_dbu))

        # Gates + bottom notches
        x0 = 0.0
        gate_boxes = []
        for i in range(self.n):
            g_x0 = x0 + self.sd_ext
            g_x1 = g_x0 + self.l
            gate_boxes.append(self._ibox(g_x0, gate_y0 - self.po_ovl_od, g_x1, gate_y1 + self.po_ovl_od, to_dbu))

            if i < self.n - 1:
                notch_x0 = x0 + gate_pitch - self.po_space/2.0
                notch_x1 = notch_x0 + self.po_space
                notch_box = self._ibox(notch_x0, od_bottom, notch_x1, od_bottom + self.bot_gap, to_dbu)
                od_reg -= pya.Region(notch_box)
                pim_reg -= pya.Region(notch_box)

            x0 += gate_pitch

        # Insert OD and PIMP
        shapes(ly_od).insert(od_reg)
        shapes(ly_pimp).insert(pim_reg)

        # Insert poly gates
        for bx in gate_boxes:
            shapes(ly_po).insert(bx)

        # Bottom drain contacts + M1 bars + labels
        x0 = 0.0
        for i in range(self.n):
            od_left = x0
            od_right = x0 + (self.l + 2*self.sd_ext)
            usable_w = (od_right - od_left) - 2*self.cont_enc_od
            n_cuts = max(1, int((usable_w + (self.cont_pitch - self.cont_size)) // self.cont_pitch))
            total_cuts_w = n_cuts * self.cont_pitch - (self.cont_pitch - self.cont_size)
            start_x = od_left + self.cont_enc_od + 0.5*(usable_w - total_cuts_w) + self.cont_size/2.0

            # Contacts
            for k in range(n_cuts):
                cx = start_x + k*self.cont_pitch
                shapes(ly_co).insert(self._ico(cx, drain_co_y, self.cont_size, to_dbu))

            # M1 landing
            m1_y0 = drain_co_y - (self.cont_size/2.0 + self.cont_enc_m1)
            m1_y1 = drain_co_y + (self.cont_size/2.0 + self.cont_enc_m1)
            m1_x0 = start_x - self.cont_size/2.0 - self.cont_enc_m1
            m1_x1 = start_x + (n_cuts - 1)*self.cont_pitch + self.cont_size/2.0 + self.cont_enc_m1
            shapes(ly_m1).insert(self._ibox(m1_x0, m1_y0, m1_x1, m1_y1, to_dbu))

            # Label (on label layer)
            self._insert_text(shapes, ly_lbl, f"{self.m1_lbl_prefix}{i}", (m1_x0 + m1_x1)/2.0, m1_y1 + 0.05, to_dbu)

            x0 += gate_pitch

        # Optional shared gate strap in M1 on the left (placeholder)
        if self.add_gate_strap:
            gstrap_x0 = - self.po_space - 0.1
            gstrap_x1 = - self.po_space + 0.1
            shapes(ly_m1).insert(self._ibox(gstrap_x0, gate_y0 - 0.1, gstrap_x1, gate_y1 + 0.1, to_dbu))
            # (PO↔M1 vias are PDK‑specific; left as a placeholder.)

        # N-Well and optional tap
        shapes(ly_nwell).insert(self._ibox(-0.5, od_bottom - 0.5, array_width + 0.5, od_top + 0.5, to_dbu))
        if self.add_nwell_tap:
            tap_w = 0.6
            tap_h = 0.6
            tx0 = -0.9
            ty0 = gate_y0
            shapes(ly_ntap).insert(self._ibox(tx0, ty0, tx0 + tap_w, ty0 + tap_h, to_dbu))
            # 2x2 COs in tap
            cx0 = tx0 + self.cont_enc_od + self.cont_size/2.0
            cy0 = ty0 + self.cont_enc_od + self.cont_size/2.0
            for ix in range(2):
                for iy in range(2):
                    shapes(ly_co).insert(self._ico(cx0 + ix*self.cont_pitch, cy0 + iy*self.cont_pitch, self.cont_size, to_dbu))
            # M1 over tap
            shapes(ly_m1).insert(self._ibox(tx0 - self.cont_enc_m1, ty0 - self.cont_enc_m1, tx0 + tap_w + self.cont_enc_m1, ty0 + tap_h + self.cont_enc_m1, to_dbu))

        # Placement boundary
        shapes(ly_pr).insert(self._ibox(-1.2, od_bottom - 0.8, array_width + 0.8, od_top + 0.8, to_dbu))

# Register as a library so it appears in the PCell list
class PMOSSwitchArrayLib(pya.Library):
    def __init__(self):
        super(PMOSSwitchArrayLib, self).__init__()
        self.description = "Templates for IHP SG13G2 (user-mapped layers)"
        self.layout().register_pcell("PMOSSwitchArray", PMOSSwitchArray())
        self.register("PMOSSwitchArrayLib")

# Instantiate library on load
def load_libraries():
    PMOSSwitchArrayLib()

load_libraries()
