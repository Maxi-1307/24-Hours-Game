draw_set_color(c_white);
draw_text(0, 0, global.CURRENT_WEATHER);
draw_text(0, 20, oTimeAtmosphere.period);
if (keyboard_check_pressed(ord("R"))) {global.CURRENT_WEATHER = "soleado";}