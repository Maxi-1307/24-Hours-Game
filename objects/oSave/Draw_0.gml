var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);
var _cam_w = camera_get_view_width(view_camera[0]);
var _cam_h = camera_get_view_height(view_camera[0]);

var _draw_x = _cam_x + _cam_w - 30;
var _draw_y = _cam_y + _cam_h - 30;

draw_sprite_ext(sprSave, 0, _draw_x, _draw_y, 2 ,2, 0, c_white, alpha);
