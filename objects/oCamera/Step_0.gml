if (!instance_exists(oPlayer)) exit;

var _cam_w = camera_get_view_width(view_camera[0]);
var _cam_h = camera_get_view_height(view_camera[0]);

var _target_x = oPlayer.x - (_cam_w / 2);
var _target_y = oPlayer.y - (_cam_h / 2);

_target_x = clamp(_target_x, 0, room_width - _cam_w);
_target_y = clamp(_target_y, 0, room_height - _cam_h);

camera_set_view_pos(view_camera[0], floor(_target_x), floor(_target_y));
