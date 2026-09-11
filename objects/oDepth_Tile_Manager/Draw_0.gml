if (variable_global_exists("Is_Indoors")) {
    var _is_indoors = global.Is_Indoors;

    if ((image_alpha > 0 && visible) && !_is_indoors && instance_exists(oShadow_Light)) {
        var _lista = oShadow_Light.sombras;
        var _total = array_length(_lista);
        
        for (var i = 0; i < _total; i++) {
            var _smd = _lista[i];
            
            if (_smd.id_origen == id && _smd.spriteIndex >= 0) {
                
                if (instance_exists(oCantShadow)) {
                    
                    var _vx = camera_get_view_x(view_camera[0]);
                    var _vy = camera_get_view_y(view_camera[0]);
                    var _vw = camera_get_view_width(view_camera[0]);
                    var _vh = camera_get_view_height(view_camera[0]);

                    var _surf = surface_create(_vw, _vh);
                    
                    if (surface_exists(_surf)) {
                        surface_set_target(_surf);
                        draw_clear_alpha(c_black, 0);

                        var _matrix_antigua = matrix_get(matrix_world);
                        var _matrix_shadow = matrix_build(_smd.posX - _vx, _smd.posY - _vy, 0, 0, 0, 0, _smd.escalaX, _smd.escalaY, 1);
                        _matrix_shadow[4] = _smd.skewX; 
                        
                        matrix_set(matrix_world, _matrix_shadow);
                        draw_sprite_ext(_smd.spriteIndex, _smd.imageIndex, 0, 0, 1, 1, 0, c_black, 0.75);
                        matrix_set(matrix_world, _matrix_antigua);

                        gpu_set_blendmode_ext(bm_zero, bm_zero);
                        
                        with (oCantShadow) {
                            if (sprite_index >= 0) {
                                draw_sprite_ext(sprite_index, image_index, x - _vx, y - _vy, image_xscale, image_yscale, image_angle, c_white, 1);
                            } else {
                                draw_set_color(c_white);
                                draw_rectangle(bbox_left - _vx, bbox_top - _vy, bbox_right - _vx, bbox_bottom - _vy, false);
                            }
                        }
                        
                        gpu_set_blendmode(bm_normal);

                        surface_reset_target();

                        draw_surface(_surf, _vx, _vy);
                        surface_free(_surf);
                    }
                } else {
                    var _matrix_antigua = matrix_get(matrix_world);
                    var _matrix_shadow = matrix_build(_smd.posX, _smd.posY, 0, 0, 0, 0, _smd.escalaX, _smd.escalaY, 1);
                    _matrix_shadow[4] = _smd.skewX; 
                    
                    matrix_set(matrix_world, _matrix_shadow);
                    draw_sprite_ext(_smd.spriteIndex, _smd.imageIndex, 0, 0, 1, 1, 0, c_black, 0.55);
                    matrix_set(matrix_world, _matrix_antigua);
                }
            }
        }
    }

    if (sprite_index >= 0) {
        draw_self();
    }
}