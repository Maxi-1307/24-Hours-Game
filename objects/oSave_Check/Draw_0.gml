if(flag_for_menu && !instance_exists(oTextBox)){
	    draw_sprite_tiled(sprFade,image_index,0,0);
}
if(save_check_odd == 2){
	draw_sprite_ext(sprPlayerUp,0,118,152,1.5,1.5,0,c_white,1);
	draw_sprite_ext(sprPc_Fire,pc_frame,160,120,1,1,0,c_white,1);
}