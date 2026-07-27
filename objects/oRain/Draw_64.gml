draw_set_alpha(0.2);
draw_set_colour(#4a5566);
draw_rectangle(0,0,display_get_gui_width(),display_get_gui_height(),false);
draw_set_alpha(1);
draw_set_colour(c_white);

if (flash_alpha > 0) {
    draw_set_color(c_white);
    draw_set_alpha(flash_alpha);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    
    flash_alpha -= 0.05; 
    
    draw_set_alpha(1);
    draw_set_color(c_white);
}
