if(save_check_odd == 0 && (!instance_exists(oTree))){
	var tree = instance_create_layer(160,120,"Objects",oTree);
	tree.image_index = 2;
	tree.image_xscale = 1.4;
	tree.image_yscale = 1.4;
	tree_create = 1;
	alarm[0] = game_get_speed(gamespeed_fps) * 4;
}
if(save_check_odd == 1 && !instance_exists(oPlayerActing)){
	var player = instance_create_layer(160,120,"Objects",oPlayerActing);
	var dog = instance_create_layer(330,120,"Objects",oDogActing);
	
}
if(save_check_odd == 1 && instance_exists(oTextBox)){
	with(oTextBox){
		if(page == 3){
			oPlayerActing.image_index = 5;
		}
	}
}

if (save_check_odd == 2) {
	
	pc_frame += 5 / game_get_speed(gamespeed_fps);

    if (pc_frame >= sprite_get_number(sprPc_Fire)) {
        pc_frame = 0;
    }
}
