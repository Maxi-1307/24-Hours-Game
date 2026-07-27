switch(state){

    case PLAYER_STATE.AUTO_MOVE:
        if (array_length(waypoint_list) > 0){
            var _wp = waypoint_list[waypoint_index];
            var _wp_x = _wp.x;
            var _wp_y = _wp.y;
            
            var _spd  = variable_struct_exists(_wp, "spd") ? _wp.spd : walk_spd;
            var _use_lerp = variable_struct_exists(_wp, "is_lerp") ? _wp.is_lerp : false;

            var h = 0;
            var v = 0;

            if (_use_lerp){
                x = lerp(x, _wp_x, _spd);
                y = lerp(y, _wp_y, _spd);
                
                if (abs(_wp_x - x) > 1) h = sign(_wp_x - x);
                if (abs(_wp_y - y) > 1) v = sign(_wp_y - y);
            }else {
                if (abs(_wp_x - x) > _spd) h = sign(_wp_x - x);
                if (abs(_wp_y - y) > _spd) v = sign(_wp_y - y);

                x += h * _spd;
                y += v * _spd;
            }

            if (abs(h) > abs(v)){
                sprite_index = (h > 0) ? sprPlayerRight : sprPlayerLeft;
            }else if (abs(v) > 0) {
                sprite_index = (v > 0) ? sprPlayerDown : sprPlayerUp;
            }
            
            if (h != 0 || v != 0){
                image_speed = 1;
            }else{
                image_speed = 0;
                image_index = 0;
            }

            if (abs(_wp_x - x) <= 1 && abs(_wp_y - y) <= 1){
                x = _wp_x;
                y = _wp_y;
                
                waypoint_index++;

                if (waypoint_index >= array_length(waypoint_list))
                {
                    waypoint_list = [];
                    waypoint_index = 0;

                    state = PLAYER_STATE.NORMAL;
                    global.CanMove = true;

                    if(is_callable(move_callback))
                    {
                        move_callback();
                        move_callback = undefined;
                    }
                }
            }
        }
        break;

    case PLAYER_STATE.NORMAL:
        var h = keyboard_check(global.RightKey) - keyboard_check(global.LeftKey);
        var v = keyboard_check(global.DownKey) - keyboard_check(global.UpKey);

        if (keyboard_check_pressed(global.MenuKey) && global.CanInventory){
            if (!instance_exists(oInventory) && global.CanMove){
                instance_create_layer(0, 0, "Inventory", oInventory);
                global.CanMove = false;
                global.time_paused = true;
            }
            else
            {
                with (oInventory) instance_destroy();
                global.CanMove = true;
                global.time_paused = false;
            }
        }

        if (global.CanMove){
            var spd = (keyboard_check(vk_shift) || keyboard_check(global.CancelKey)) ? run_spd : walk_spd;
            xspd = h * spd;
            yspd = v * spd;

            var _collision_list = ds_list_create();

            var _num_h = instance_place_list(x + xspd, y, all, _collision_list, false);
            var _collision_detected_h = false;

            for (var i = 0; i < _num_h; i++) {
                var _inst = _collision_list[| i];
                if (instance_exists(_inst) && _inst.solid) {
                    _collision_detected_h = true;
                    break;
                }
            }
            ds_list_clear(_collision_list);

            if (!_collision_detected_h){
                x += xspd;
            }else{
                if (v == 0) {
                    var _slide_dist = 6; 
                    
                    var _free_up = true;
                    for (var i = 1; i <= _slide_dist; i++) {
                        var _num_check = instance_place_list(x + xspd, y - i, all, _collision_list, false);
                        for (var j = 0; j < _num_check; j++) {
                            if (_collision_list[| j].solid) { _free_up = false; break; }
                        }
                        ds_list_clear(_collision_list);
                        if (!_free_up) break;
                    }
                    
                    var _free_down = true;
                    for (var i = 1; i <= _slide_dist; i++) {
                        var _num_check = instance_place_list(x + xspd, y + i, all, _collision_list, false);
                        for (var j = 0; j < _num_check; j++) {
                            if (_collision_list[| j].solid) { _free_down = false; break; }
                        }
                        ds_list_clear(_collision_list);
                        if (!_free_down) break;
                    }

                    if (_free_up) y -= spd;
                    else if (_free_down) y += spd;
                }

                while (abs(xspd) > 0.1){
                    var _num_pixel = instance_place_list(x + sign(xspd), y, all, _collision_list, false);
                    var _pixel_solid = false;
                    for (var i = 0; i < _num_pixel; i++) {
                        if (_collision_list[| i].solid) { _pixel_solid = true; break; }
                    }
                    ds_list_clear(_collision_list);

                    if (!_pixel_solid){
                        x += sign(xspd);
                    }else{
                        break;
                    }
                    xspd -= sign(xspd) * 0.1;
                }
                xspd = 0;
            }
            
            var _num_v = instance_place_list(x, y + yspd, all, _collision_list, false);
            var _collision_detected_v = false;

            for (var i = 0; i < _num_v; i++) {
                var _inst = _collision_list[| i];
                if (instance_exists(_inst) && _inst.solid) {
                    _collision_detected_v = true;
                    break;
                }
            }
            ds_list_clear(_collision_list);

            if (!_collision_detected_v){
                y += yspd;
            }else{
                if (h == 0) {
                    var _slide_dist = 6; 
                    
                    var _free_left = true;
                    for (var i = 1; i <= _slide_dist; i++) {
                        var _num_check = instance_place_list(x - i, y + yspd, all, _collision_list, false);
                        for (var j = 0; j < _num_check; j++) {
                            if (_collision_list[| j].solid) { _free_left = false; break; }
                        }
                        ds_list_clear(_collision_list);
                        if (!_free_left) break;
                    }
                    
                    var _free_right = true;
                    for (var i = 1; i <= _slide_dist; i++) {
                        var _num_check = instance_place_list(x + i, y + yspd, all, _collision_list, false);
                        for (var j = 0; j < _num_check; j++) {
                            if (_collision_list[| j].solid) { _free_right = false; break; }
                        }
                        ds_list_clear(_collision_list);
                        if (!_free_right) break;
                    }

                    if (_free_left) x -= spd;
                    else if (_free_right) x += spd;
                }

                while (abs(yspd) > 0.1){
                    var _num_pixel = instance_place_list(x, y + sign(yspd), all, _collision_list, false);
                    var _pixel_solid = false;
                    for (var i = 0; i < _num_pixel; i++) {
                        if (_collision_list[| i].solid) { _pixel_solid = true; break; }
                    }
                    ds_list_clear(_collision_list);

                    if (!_pixel_solid){
                        y += sign(yspd);
                    }else{ 
                        break;
                    }
                    yspd -= sign(yspd) * 0.1;
                }
                yspd = 0;
            }

            ds_list_destroy(_collision_list);

            if (abs(xspd) > abs(yspd)){
                sprite_index = (xspd > 0) ? sprPlayerRight : sprPlayerLeft;
            }else if (abs(yspd) > 0) {
                sprite_index = (yspd > 0) ? sprPlayerDown : sprPlayerUp;
            }

            if ((h != 0 || v != 0) && (xspd != 0 || yspd != 0)){
                image_speed = 1;
            }else{
                image_speed = 0;
                image_index = 0;
            }

        }else{
            xspd = 0;
            yspd = 0;
            image_speed = 0;
            image_index = 0;
        }
        break;

    case PLAYER_STATE.INTERACTING:
        xspd = 0;
        yspd = 0;
        break;
}


