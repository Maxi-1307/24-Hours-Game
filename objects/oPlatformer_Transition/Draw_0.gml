var _cam_x = camera_get_view_x(view_camera);
var _cam_y = camera_get_view_y(view_camera);

draw_set_color(c_black);

for (var col = 0; col < columnas; col++) {
    for (var fil = 0; fil < filas; fil++) {
        
        var posicion_x = _cam_x + (col * tamano_cuadro) + (tamano_cuadro / 2);
        var posicion_y = _cam_y + (fil * tamano_cuadro) + (tamano_cuadro / 2);
        
        var tamano_actual = tamano_cuadro * clamp(progreso, 0, 1);
        
        var angulo_actual = progreso * 180; 
        
        draw_sprite_ext(
            sprTransitiona, 
            0, 
            posicion_x, 
            posicion_y, 
            tamano_actual / sprite_get_width(sprTransitiona), 
            tamano_actual / sprite_get_height(sprTransitiona), 
            angulo_actual, 
            c_black, 
            1
        );
    }
}

draw_set_color(c_white);
