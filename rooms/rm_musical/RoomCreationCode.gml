if (global.SimplifyVFX) {
    if (layer_exists("Glow")) {
		layer_clear_fx("Glow");
    }
}

if (oBorder_Screen.borde_sprite != sprBorder_Screen_Musical) {
    oBorder_Screen.borde_anterior = oBorder_Screen.borde_sprite;
    oBorder_Screen.borde_sprite = sprBorder_Screen_Musical;
    oBorder_Screen.borde_alpha = 0.0;
}