global.CanMove = false;
global.CanInventory = false;

switch(state) {
    
    case 1:
        if (!audio_is_playing(sonido_id)) {
            state = 2;
            timer = 0;
        }
    break;

    case 2:
        timer++;
        if (timer >= wait_time) {
			oPlayer.sprite_index = sprPlayerDown;
            state = 3;
        }
    break;

    case 3:
        alpha -= 0.02;
        if (alpha <= 0) {
			if(instance_exists(oTextBox)){
				instance_destroy(oTextBox);
			}
			audio_resume_all();
			
			var textbox = instance_create_layer(0, 0, "Dialogue", oTextBox);
			
			textbox.text[0] = _T("shower_finished"); 
			
			textbox.txtb_snd[0] = sfx_text;
			textbox.txtb_color[0] = c_white;
			textbox.speaker_sprite[0] = noone;
			
            instance_destroy();
        }
    break;
}
