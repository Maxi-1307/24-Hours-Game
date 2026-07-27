// 1. Conseguir la posición de la cámara actual en el mundo
var _cam_x = camera_get_view_x(view_camera);
var _cam_y = camera_get_view_y(view_camera);

draw_set_color(c_black);

for (var col = 0; col < columnas; col++) {
    for (var fil = 0; fil < filas; fil++) {
        
        // 2. Sumamos _cam_x y _cam_y para que las posiciones relativas sigan a la pantalla
        var posicion_x = _cam_x + (col * tamano_cuadro) + (tamano_cuadro / 2);
        var posicion_y = _cam_y + (fil * tamano_cuadro) + (tamano_cuadro / 2);
        
        var tamano_actual = tamano_cuadro * clamp(progreso, 0, 1);
        
        var angulo_actual = progreso * 180; 
        
        // 3. Dibujamos el sprite en las nuevas coordenadas globales del mundo
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
