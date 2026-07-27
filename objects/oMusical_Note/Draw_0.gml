if (x <= 0) exit; 
var _pista_top = 26;
var _pista_bot = 167;

if (duracion_sostenido > 0 && altura_cola > 0) {
    draw_set_alpha(nota_fallada ? 0.4 : 0.7); 
    
    var _top_rect = clamp(y - altura_cola, _pista_top, _pista_bot);
    var _bot_rect = clamp(y, _pista_top, _pista_bot);
    
    if (_bot_rect > _pista_top) {
        var _color_brillante = color_cola;
        
        var _color_oscuro = merge_colour(_color_brillante, c_black, 0.65); 
        
        draw_rectangle_colour(x - 3, _top_rect, x + 3, _bot_rect, _color_oscuro, _color_oscuro, _color_brillante, _color_brillante, false);
    }
    draw_set_alpha(1.0);
}

if (y >= _pista_top && y <= _pista_bot) {
    if (nota_fallada) {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_dkgray, 0.5);
    } else {
        draw_self();
    }
}
