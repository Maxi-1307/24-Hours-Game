if (transicion_fase == "abriendo") {
    ancho_cortina = lerp(ancho_cortina, 0, 0.08);
    if (ancho_cortina <= 0.5) {
        ancho_cortina = 0;
        transicion_fase = "jugando";
        
        if (instance_exists(oMusical_Controller)) {
            oMusical_Controller.fase_intro = "kris_aparece";
            oMusical_Controller.timer_intro = 0;
        }
    }
}

if (transicion_fase == "cerrando") {
    ancho_cortina = lerp(ancho_cortina, cam_width / 2, 0.1);
    if (abs(ancho_cortina - (cam_width / 2)) <= 0.5) {
        ancho_cortina = cam_width / 2;
        transicion_fase = "completamente_cerrado";
        
        if (instance_exists(oMusical_Controller)) {
            oMusical_Controller.alarm[0] = 1; 
        }
    }
}

cam_zoom = lerp(cam_zoom, cam_zoom_target, cam_zoom_speed);

if (flash_general_alfa > 0) {
    flash_general_alfa -= flash_general_decay;
}

if (is_holding_note) {
    cam_x_target = random_range(-1.5, 1.5);
    cam_y_target = random_range(-1.5, 1.5);
} else {
    cam_x_target = lerp(cam_x_target, 0, 0.15);
    cam_y_target = lerp(cam_y_target, 0, 0.15);
    cam_angle_target = lerp(cam_angle_target, 0, 0.15);
}

cam_x_current = lerp(cam_x_current, cam_x_target, 0.2);
cam_y_current = lerp(cam_y_current, cam_y_target, 0.2);
cam_angle_current = lerp(cam_angle_current, cam_angle_target, 0.2);


var _cam = view_camera[0];

var _new_w = cam_width * cam_zoom;
var _new_h = cam_height * cam_zoom;

camera_set_view_size(_cam, _new_w, _new_h);

var _final_x = ((cam_width - _new_w) / 2) + cam_x_current;
var _final_y = ((cam_height - _new_h) / 2) + cam_y_current;

camera_set_view_pos(_cam, _final_x, _final_y);
camera_set_view_angle(_cam, cam_angle_current);