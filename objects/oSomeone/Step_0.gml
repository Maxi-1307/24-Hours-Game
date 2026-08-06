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
			text[0] = "<unskippable>* Oh, lamento mi intrusión,#pero no pude no notar...";
			text[1] = "<unskippable>* Como tu cara se retorcio,#como si lucharas...";
			text[2] = "<unskippable>* Lucharas con algo dificil#de explicar.";
			text[3] = "<unskippable>* Justo después de acercarte#a esa lapida.";
			text[4] = "<unskippable>* Yo se lo que es las cosas#que no puedes explicar...";
		
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
			text[0] = "<unskippable>* Oh,<wait=30>no era para#que te pongas asi...";
			text[1] = "<unskippable>* Si te hace sentir mejor...";
			text[2] = "<unskippable>* Acercate, deja que#te cuente algo.";
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
			text[0] = "<unskippable>* Te acercas lentamente#hasta a él.";
			text[1] = "<unskippable>* Él se acerca a tu oreja y...";
			text[2] = "<unskippable>* Comienza a susurrarte algo..."
			text[3] = "<unskippable>* Algo parecido a una historia...";
			text[4] = "<unskippable>* O quizas un consejo...";
			text[5] = "<unskippable>* Lo que importa es que oiste#cada palabra con atención.";
		
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
			text[0] = "<unskippable>* Retrocedes un poco.";
			text[1] = "<unskippable>* Ves como el hombre se#despide de ti moviendo#su mano.";
			text[2] = "<unskippable>* Antes de darse la vuelta...";
			text[3] = "<unskippable>* Y caminar lentamente#entre los árboles."
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
		image_alpha = 0;
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
				case 1: text[0] = "* Bueno aqui habia ALGUIEN.";
				break;
				case 2: text[0] = "* Bueno aqui habia alguien.";
				break;
				default: text[0] = "* ...";
				break;
				
			}
			if(other.interact == other.random_odd){
				text[0] = "* No es bueno insistir en#aquellas cosas que#simplemente ya pasaron";
				instance_destroy(oSomeone);
			}
		}
		interact++;
	}
}	