if(instance_exists(oPlayer)){
	if(oPlayer.visible){
		var cam = view_camera[0];

		var cam_x = camera_get_view_x(cam);
		var cam_y = camera_get_view_y(cam);

		var cam_w = camera_get_view_width(cam);
		var cam_h = camera_get_view_height(cam);

		draw_set_alpha(current_alpha);

		draw_set_color(current_color);

		draw_rectangle(cam_x,cam_y, cam_x + cam_w,cam_y + cam_h,false);

		draw_set_alpha(1);

		draw_set_color(c_white);
	}
}	