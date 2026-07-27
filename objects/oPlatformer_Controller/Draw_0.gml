draw_set_color(c_white);
depth = -9999;
var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

if (state == "playing") {
	
	var index = 0;
	for(var i = 0; i < global.Platformer_Lives; i++){
		if(i == 3){
			index = 1;
		}
		draw_sprite_ext(sprPlatfomer_hearts, index, _cam_x + 15 + (i * 20), _cam_y + 10, 1, 1, 0, c_white, 1);
	}

	var _estrella_x = _cam_x + 230;
	var _text_stars_x = _cam_x + 246;
	var _score_x = _cam_x + 225;
	
	draw_sprite_ext(sprPlatformer_Stars, star_index, _estrella_x, _cam_y + 10, 1, 1, 0, c_white, 1);
	
	var level_stars = string_replace_all(string_format(global.Platformer_Level_Stars, 2, 0), " ", "0");
	draw_text_transformed(_text_stars_x, _cam_y, string(level_stars) + "/" + string(global.Platformer_Global_Stars), 0.75, 0.75, 0);
	
	draw_text_transformed_colour(_score_x, _cam_y + 22, "Score:" + string(global.Platformer_Global_Score), 0.6, 0.6, 0, c_navy, c_navy, c_navy, c_navy, 1);
	draw_text_transformed(_score_x + 1, _cam_y + 22, "Score:" + string(global.Platformer_Global_Score), 0.6, 0.6, 0);

	var total = max(0, floor(global.Platformer_Level_Time));
	var minutes = (total div 60) mod 24;
	var seconds = total mod 60;
	
	var minutes_show = string_replace_all(string_format(minutes, 2, 0), " ", "0");
	var seconds_show = string_replace_all(string_format(seconds, 2, 0), " ", "0");

	draw_text_transformed(_cam_x + 140, _cam_y + 6, string(minutes_show) + ":" + string(seconds_show), 0.75, 0.75, 0);
}else if (state == "menu") {
	
	draw_rectangle_colour(_cam_x, _cam_y, _cam_x + 340, _cam_y + 240, c_black, c_black, c_black, c_black, false);
	
	if (fase_introduccion == 1) {
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		var _centro_x = _cam_x + 200;
		var _centro_y = _cam_y + 120;
		
		draw_text_transformed(_centro_x - 35, _centro_y - 25, "LEVEL " + string(global.Platformer_Level), 1.2, 1.2, 0);
		
		draw_sprite_ext(sprPlatfomer_hearts, 0, _centro_x - 70, _centro_y + 10, 1, 1, 0, c_white, 1);
		draw_text_transformed(_centro_x - 25, _centro_y + 10, "x " + string(global.Platformer_Lives), 1.2, 1.2, 0);
		
		draw_text_transformed(_centro_x - 35, _centro_y + 35, "Score:" + string(global.Platformer_Global_Score), 1.2, 1.2, 0);
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}else if (state == "game_over") {
	
	draw_rectangle_colour(_cam_x, _cam_y, _cam_x + 340, _cam_y + 240, c_black, c_black, c_black, c_black, false);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_set_color(c_red);
	draw_text_transformed(_cam_x + 160, _cam_y + 120, "GAME OVER", 1.5, 1.5, 0);
	
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
