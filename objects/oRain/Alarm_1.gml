if (layer_exists("Puddles")) {

    if (!global.Is_Indoors && instance_number(oPuddle) < 15) {
        var _cam_x = camera_get_view_x(view_camera[0]);
        var _cam_y = camera_get_view_y(view_camera[0]);
        var _cam_w = camera_get_view_width(view_camera[0]);
        var _cam_h = camera_get_view_height(view_camera[0]);

        var _success = false;
        var _attempts = 0;

        while (!_success && _attempts < 20) {
            var _px = _cam_x + random(_cam_w);
            var _py = _cam_y + random(_cam_h);

            var _inst = instance_create_layer(_px, _py, "Puddles", oPuddle);
            
            with (_inst) {
                if (place_meeting(x, y, oWall) || place_meeting(x, y, oPuddle)) {
                    instance_destroy();
                } else {
                    _success = true;
                }
            }
            _attempts++;
        }
    }
}

alarm[1] = game_get_speed(gamespeed_fps) * 5;
