function draw_textbox_final_lines(_x, _y, _data, _lines, _count, _line_sep, _sx, _sy){
    var drawn = 0;

    for (var l = 0; l < array_length(_lines); l++) {
        var line = _lines[l];
        var draw_x = _x + 1;  
        var draw_y = (_y + l * _line_sep * _sy) + 1;

        for (var i = 0; i < array_length(line); i++) {
            if (drawn >= _count) break;
            
            var index = line[i];
            var char = _data.chars[index];
            var col  = _data.colors[index];
            var sh = _data.shakes[index];
            
            var off_x = 0;
            var off_y = 0;
            
            if (sh) {
                off_x = random_range(-1, 1);
                off_y = random_range(-1, 1);
            }
            
            if (char != "") {
                var _shadow_color = (col == c_white) ? c_dkgray : merge_colour(col, c_black, 0.65);
                
                draw_text_transformed_colour(
                    draw_x + off_x, draw_y + off_y,
                    char,
                    _sx, _sy, 0,
                    _shadow_color, _shadow_color,
                    _shadow_color, _shadow_color,
                    1
                );
                draw_x += string_width(char) * _sx;
            }
            drawn++;
        }
    }
    
    drawn = 0;
    
    for (var l = 0; l < array_length(_lines); l++) {
        var line = _lines[l];
        var draw_x = _x;
        var draw_y = _y + l * _line_sep * _sy;

        for (var i = 0; i < array_length(line); i++) {
            if (drawn >= _count) return;

            var index = line[i];
            
            var char = _data.chars[index];
            var col  = _data.colors[index];
            var sh   = _data.shakes[index];

            var off_x = 0;
            var off_y = 0;

            if (sh) {
                off_x = random_range(-1, 1);
                off_y = random_range(-1, 1);
            }

            if (char != "") {
                var _bottom_color = merge_colour(col, c_black, 0.35);
                
                draw_text_transformed_colour(
                    draw_x + off_x, draw_y + off_y,
                    char,
                    _sx, _sy, 0,
                    col, col,                     
                    _bottom_color, _bottom_color, 
                    1
                );

                draw_x += string_width(char) * _sx;
            }

            drawn++;
        }
    }

    draw_set_color(c_white);
    draw_set_alpha(1);
}
