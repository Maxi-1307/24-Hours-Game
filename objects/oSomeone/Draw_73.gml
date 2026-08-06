if (fade_alfa > 0) {
    var camera_x = camera_get_view_x(view_camera[0]);
    var camera_y = camera_get_view_y(view_camera[0]);
    
    draw_set_alpha(fade_alfa);
    draw_set_color(c_black);
    
    draw_rectangle(camera_x, camera_y, camera_x + 320, camera_y + 240, false);
    
    draw_set_alpha(1); 
}
