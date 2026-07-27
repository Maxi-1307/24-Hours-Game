if(odd == 4){
	if(image_index == 0){
		image_index = 2;
	}else if(image_index == 1){
		image_index = 3;
	}
}

if(place_meeting(x,y,oPlayer) && (!instance_exists(oTextBox)) && (!instance_exists(oInventory)) && keyboard_check_pressed(global.ConfirmKey)){
   
   var txtbx = instance_create_layer(0,0,"Dialogue",oTextBox); 
    
    with(txtbx){
        switch(other.image_index){
           case 0: 
                text[0] = _T("sign_case0_1");
                text[1] = _T("sign_case0_2");

                for(var i=0; i<2; i++){
                    speaker_sprite[i] = noone;
                    txtb_snd[i] = sfx_text;
                    txtb_color[i] = c_white;
                }
            break;
			case 1: 
                text[0] = _T("sign_case1_1");
                text[1] = _T("sign_case1_2");

                for(var i=0; i<2; i++){
                    speaker_sprite[i] = noone;
                    txtb_snd[i] = sfx_text;
                    txtb_color[i] = c_white;
                }
            break;
			case 2:
				if(other.interact < 3){
					text[0] = _T("sign_smile_base");
	                text[1] = _T("sign_case2_repl");

	                for(var i=0; i<2; i++){
	                    speaker_sprite[i] = noone;
	                    txtb_snd[i] = sfx_text;
	                    txtb_color[i] = c_white;
	                }
					other.interact++;
				}else if(other.interact == 3){
					text[0] = _T("sign_smile_base");
	                text[1] = _T("sign_inutil");

	                for(var i=0; i<2; i++){
	                    speaker_sprite[i] = noone;
	                    txtb_snd[i] = sfx_text;
	                    txtb_color[i] = c_white;
	                }
					other.interact++;
				}else if(other.interact == 4){
					text[0] = _T("sign_smile_base");
	                text[1] = _T("sign_notime");

	                for(var i=0; i<2; i++){
	                    speaker_sprite[i] = noone;
	                    txtb_snd[i] = sfx_text;
	                    txtb_color[i] = c_white;
	                }
					other.odd = 0;
					other.image_index = 0;
				}
            break;
			case 3:
				if(other.interact < 3){
					text[0] = _T("sign_smile_base");
					text[1] = _T("sign_case3_smile");

	                for(var i=0; i<2; i++){
	                    speaker_sprite[i] = noone;
	                    txtb_snd[i] = sfx_text;
	                    txtb_color[i] = c_white;
	                }
					other.interact++;
				}else if(other.interact == 3){
					text[0] = _T("sign_smile_base");
	                text[1] = _T("sign_inutil");

	                for(var i=0; i<2; i++){
	                    speaker_sprite[i] = noone;
	                    txtb_snd[i] = sfx_text;
	                    txtb_color[i] = c_white;
	                }
					other.interact++;
				}else if(other.interact == 4){
					text[0] = _T("sign_smile_base");
	                text[1] = _T("sign_notime");

	                for(var i=0; i<2; i++){
	                    speaker_sprite[i] = noone;
	                    txtb_snd[i] = sfx_text;
	                    txtb_color[i] = c_white;
	                }
					other.odd = 0;
					other.image_index = 1;
				}
			break;
			case 4:
				text[0] = "* It's a big BUS STOP.";
				text[1] = "* Nothing STOP-Sign related.";
				 for(var i=0; i<2; i++){
                    speaker_sprite[i] = noone;
                    txtb_snd[i] = sfx_text;
                    txtb_color[i] = c_white;
                }
				break;
        }
    }
}
