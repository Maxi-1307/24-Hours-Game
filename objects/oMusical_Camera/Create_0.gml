cam_width = 320;
cam_height = 240;

cam_x_target = 0;
cam_y_target = 0;
cam_angle_target = 0;

cam_x_current = 0;
cam_y_current = 0;
cam_angle_current = 0;


is_holding_note = false;

ancho_cortina = cam_width / 2; 
transicion_fase = "esperando"; // "esperando", "abriendo", "jugando", "cerrando"

alarm[0] = game_get_speed(gamespeed_fps) * 1.0;

cam_zoom = 1.0;
cam_zoom_target = 1.0;
cam_zoom_speed = 0.15;

flash_general_alfa = 0;
flash_general_decay = 0.05;