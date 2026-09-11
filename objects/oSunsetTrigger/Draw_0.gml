if (instance_exists(oPlayer) && place_meeting(x, y, oPlayer)) {
    
    var _yellow_color = c_yellow;
    var _shadow_color = $330E0B;
    var _offset_y = 1;

    var _sw = bbox_right - bbox_left;
    var _sh = bbox_bottom - bbox_top;

    if (_sw <= 0 || _sh <= 0) exit;

    if (!surface_exists(surf_effect)) {
        surf_effect = surface_create(_sw, _sh);
    }

    surface_set_target(surf_effect);
    draw_clear_alpha(c_black, 0);

    with (oPlayer) {
        var _px = x - other.bbox_left;
        var _py = y - other.bbox_top;

        gpu_set_fog(true, _yellow_color, 0, 1);
        draw_sprite_ext(sprite_index, image_index, _px, _py - _offset_y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
        gpu_set_fog(false, c_white, 0, 0);
    }

    gpu_set_blendmode(bm_subtract);
    draw_set_color(c_white);
    draw_rectangle(-100, -100, _sw + 100, -1, false);
    draw_rectangle(-100, _sh, _sw + 100, _sh + 100, false);
    draw_rectangle(-100, -100, -1, _sh + 100, false);
    draw_rectangle(_sw, -100, _sw + 100, _sh + 100, false);

    gpu_set_blendmode(bm_normal);
    surface_reset_target();

    draw_surface(surf_effect, bbox_left, bbox_top);

    with (oPlayer) {
        draw_self();
    }

    surface_set_target(surf_effect);
    draw_clear_alpha(c_black, 0);

    with (oPlayer) {
        var _px = x - other.bbox_left;
        var _py = y - other.bbox_top;

        gpu_set_fog(true, _shadow_color, 0, 1);
        draw_sprite_ext(sprite_index, image_index, _px, _py, image_xscale, image_yscale, image_angle, c_white, 0.7); 
        gpu_set_fog(false, c_white, 0, 0);
    }

    gpu_set_blendmode(bm_subtract);
    draw_set_color(c_white);
    draw_rectangle(-100, -100, _sw + 100, -1, false);
    draw_rectangle(-100, _sh, _sw + 100, _sh + 100, false);
    draw_rectangle(-100, -100, -1, _sh + 100, false);
    draw_rectangle(_sw, -100, _sw + 100, _sh + 100, false);

    gpu_set_blendmode(bm_normal);
    surface_reset_target();

    draw_surface(surf_effect, bbox_left, bbox_top);
}