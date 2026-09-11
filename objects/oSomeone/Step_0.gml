if (oPlayer.sprite_index == sprPlayerFaceBlurry) {
    if (oPlayer.image_index < 1) {
        oPlayer.image_speed = 0.5;
    }
    
    if (oPlayer.image_index >= 1) {
        oPlayer.image_speed = 0;
        oPlayer.image_index = 2;
    }
}

if(interact == 0){
	if(place_meeting(x,y,oPlayer) && keyboard_check_pressed(global.ConfirmKey) && !instance_exists(oTextBox) && oPlayer.sprite_index == sprPlayerDown && state == 0){
		var textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
		with(textbox){
			text[0] = _T("someone_speak_1");
			text[1] = _T("someone_speak_2");
			text[2] = _T("someone_speak_3");
			text[3] = _T("someone_speak_4");
			text[4] = _T("someone_speak_5");
		
			other.state = 1;
		
			for(var i = 0;i < array_length(text);i++){
				speaker_sprite[i] = noone;
				txtb_color[i] = c_white;
				txtb_snd[i] = sfx_text;
			}
		}
	}

	if(state == 1 && !instance_exists(oTextBox)){
		oPlayer.state = PLAYER_STATE.INTERACTING;
		oPlayer.sprite_index = sprPlayerFaceBlurry;
		global.CanMove = false;
		alarm[0] = game_get_speed(gamespeed_fps) * 2;
		state = 1.5;
	}

	if(state == 2 && !instance_exists(oTextBox)){
		var textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
		with(textbox){
			text[0] = _T("someone_speak_6");
			text[1] = _T("someone_speak_7");
			text[2] = _T("someone_speak_8");
			for(var i = 0;i < array_length(text);i++){
				speaker_sprite[i] = noone;
				txtb_color[i] = c_white;
				txtb_snd[i] = sfx_text;
			}
		}
		state = 3;
	}

	if(state == 3 && !instance_exists(oTextBox)){
		alarm[1] = game_get_speed(gamespeed_fps) * 2;
		state = 3.5;
	}

	if(state == 3.5){
	    if (fade_alfa < 1) {
	        fade_alfa += 0.01;
	    }
	}

	if(state == 4 && !instance_exists(oTextBox)){
		var textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
		with(textbox){
			text[0] = _T("someone_speak_9");
			text[1] = _T("someone_speak_10");
			text[2] = _T("someone_speak_11");
			text[3] = _T("someone_speak_12");
			text[4] = _T("someone_speak_13");
			text[5] = _T("someone_speak_14");
		
			for(var i = 0;i < array_length(text);i++){
				speaker_sprite[i] = noone;
				txtb_color[i] = c_white;
				txtb_snd[i] = sfx_text;
			}
		}
		state = 5;
	}

	if(state == 5){
		alarm[2] = game_get_speed(gamespeed_fps) * 2;
		state = 5.5;
	}
	if(state == 6 && !instance_exists(oTextBox)){
	    if (fade_alfa > 0) {
	        fade_alfa -= 0.01;
	    } else {
	        state = 7;
	    }
	}

	if(state == 7 && !instance_exists(oTextBox)){
		var textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
		with(textbox){
			text[0] = _T("someone_speak_15");
			text[1] = _T("someone_speak_16");
			text[2] = _T("someone_speak_17");
			text[3] = _T("someone_speak_18");
			for(var i = 0;i < array_length(text);i++){
				speaker_sprite[i] = noone;
				txtb_color[i] = c_white;
				txtb_snd[i] = sfx_text;
			}
		}
		state = 8;
	}
	if(state == 8 && !instance_exists(oTextBox)){
		alarm[3] = game_get_speed(gamespeed_fps) * 2;
		y +=5;
		state = 8.5;
		interact = 1;
		random_odd = irandom_range(3,6);
	}
}	
	
if(interact > 0){
	if(place_meeting(x,y,oPlayer) && !instance_exists(oTextBox) && keyboard_check_pressed(ord("Z"))){
		var textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
		with(textbox){
			switch(other.interact){
				case 1: text[0] = _T("someone_speak_19");
				break;
				case 2: text[0] = _T("someone_speak_20");
				break;
				default: text[0] = "* ...";
				break;
				
			}
			if(other.interact == other.random_odd){
				text[0] = _T("someone_speak_21");
				instance_destroy(oSomeone);
			}
		}
		interact++;
	}
}	