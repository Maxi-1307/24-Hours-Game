var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);
var _cam_w = camera_get_view_width(view_camera[0]);
var _cam_h = camera_get_view_height(view_camera[0]);

/*/debug
draw_text(_cam_x, _cam_y, string(global.WEATHER));
draw_text(_cam_x, _cam_y + string_height("g"), string(global.CURRENT_WEATHER));
draw_text(_cam_x, _cam_y + string_height("g") * 2, string(global.game_minutes));
*/
if(!global.Is_Indoors){
	if(global.CURRENT_WEATHER == "lluvia" || global.CURRENT_WEATHER == "tormentoso"){
	        draw_set_alpha(0.2);
	        draw_set_colour(#4a5566);
	        draw_rectangle(_cam_x, _cam_y, _cam_x + _cam_w, _cam_y + _cam_h, false);
	        draw_set_alpha(1);
	        draw_set_colour(c_white);

	        if (flash_alpha > 0) {
	            draw_set_color(c_white);
	            draw_set_alpha(flash_alpha);
	            draw_rectangle(_cam_x, _cam_y, _cam_x + _cam_w, _cam_y + _cam_h, false);

	            flash_alpha -= 0.05; 

	            draw_set_alpha(1);
	            draw_set_color(c_white);
	        }
	}
}