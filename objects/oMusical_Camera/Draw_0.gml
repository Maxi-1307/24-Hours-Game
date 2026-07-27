depth = -9999;
var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);
var _cam_w = camera_get_view_width(view_camera[0]);
var _cam_h = camera_get_view_height(view_camera[0]);

var _ancho_real = ancho_cortina; 

if (flash_general_alfa > 0) {
    draw_set_color(c_white);
    draw_set_alpha(flash_general_alfa);
    draw_rectangle(_cam_x, _cam_y, _cam_x + _cam_w, _cam_y + _cam_h, false);
    draw_set_alpha(1.0);
}

if (_ancho_real > 0) {
    draw_set_color(c_black);
    draw_rectangle(_cam_x, _cam_y, _cam_x + _ancho_real, _cam_y + _cam_h, false);
    
    draw_rectangle(_cam_x + _cam_w - _ancho_real, _cam_y, _cam_x + _cam_w, _cam_y + _cam_h, false);
}
