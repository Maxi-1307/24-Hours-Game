velocidad_patrulla = 0.8;
velocidad_persecucion = 2.0;
direccion = 1;

vel_horizontal = 0;
vel_vertical = 0;

estado = "patrulla";
rango_vision = 160;
altura_inicial_y = y;

efecto_flotar_tiempo = 0;
velocidad_onda = 0.05;
amplitud_onda = 0.3;

alarm[0] = game_get_speed(gamespeed_fps) * irandom_range(2, 4);


image_xscale = 2;
image_yscale = 2;
