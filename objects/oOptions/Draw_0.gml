if (quit_visible) {
    var _cam_x = camera_get_view_x(view_camera[0]);
    var _cam_y = camera_get_view_y(view_camera[0]);
    var _cam_w = camera_get_view_width(view_camera[0]);
    
    draw_set_alpha(quit_alpha);
    draw_set_font(MainFont);
    
    var dots_text = "QUITTING";
    for (var i = 0; i < quit_dots; i++) {
        dots_text += ".";
    }

    var _escala = (_cam_w / 320) * 0.7;
    
    var _base_color   = c_white;
    var _bottom_color = c_ltgray;
    
    var _outline_color = (_base_color == c_white) ? c_dkgray : merge_colour(_base_color, c_black, 0.65);
    
    var _text_x = _cam_x + 10;
    var _text_y = _cam_y + 5;
    var _dist   = 1;

    draw_text_transformed_colour(_text_x - _dist, _text_y,         dots_text, _escala, _escala, 0, _outline_color, _outline_color, _outline_color, _outline_color, quit_alpha);
    draw_text_transformed_colour(_text_x + _dist, _text_y,         dots_text, _escala, _escala, 0, _outline_color, _outline_color, _outline_color, _outline_color, quit_alpha);
    draw_text_transformed_colour(_text_x,         _text_y - _dist, dots_text, _escala, _escala, 0, _outline_color, _outline_color, _outline_color, _outline_color, quit_alpha);
    draw_text_transformed_colour(_text_x,         _text_y + _dist, dots_text, _escala, _escala, 0, _outline_color, _outline_color, _outline_color, _outline_color, quit_alpha);
    draw_text_transformed_colour(_text_x - _dist, _text_y - _dist, dots_text, _escala, _escala, 0, _outline_color, _outline_color, _outline_color, _outline_color, quit_alpha);
    draw_text_transformed_colour(_text_x + _dist, _text_y - _dist, dots_text, _escala, _escala, 0, _outline_color, _outline_color, _outline_color, _outline_color, quit_alpha);
    draw_text_transformed_colour(_text_x - _dist, _text_y + _dist, dots_text, _escala, _escala, 0, _outline_color, _outline_color, _outline_color, _outline_color, quit_alpha);
    draw_text_transformed_colour(_text_x + _dist, _text_y + _dist, dots_text, _escala, _escala, 0, _outline_color, _outline_color, _outline_color, _outline_color, quit_alpha);

    draw_text_transformed_colour(_text_x, _text_y, dots_text,  _escala, _escala, 0,_base_color, _base_color,  _bottom_color, _bottom_color, quit_alpha);
    
    draw_set_alpha(1);
}
