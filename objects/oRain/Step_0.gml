if (global.Is_Indoors) {
    audio_sound_gain(sfx_rain, 0.05, 500); 
    part_system_automatic_draw(rain_instance, false);
} else {
    audio_sound_gain(sfx_rain, 0.2, 500); 
    part_system_automatic_draw(rain_instance, true);
}

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);
var _cam_w = camera_get_view_width(view_camera[0]);

part_system_position(rain_instance, _cam_x + (_cam_w / 2), _cam_y - 20);
