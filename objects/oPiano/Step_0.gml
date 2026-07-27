if (cooldown_interact > 0) {
    cooldown_interact--;
}

if(!instance_exists(oInventory) && place_meeting(x,y,oPlayer) && keyboard_check_pressed(global.ConfirmKey) && !instance_exists(oTextBox) && !using_piano && cooldown_interact <= 0)
{
    var textbox = instance_create_layer(0,0,"Dialogue",oTextBox);

    with(textbox)
    {
        text[0] = "* Aparenta ser un piano#público.";
        text[1] = "* Parece que hace mucho q no#es algo usado.";
        text[2] = "* ¿Usarlo?";
        text[3] = "* Decides no usarlo.";

        decisions[2] = { left : "Si", right: "No" };
        decision_result[2] = { right: 3 };

        decision_script[2] = {
            left: function(){
 instance_destroy(oTextBox);
                
                var ruta_al_piano = [];
                
                if (oPlayer.y < 210)
                {
                    array_push(ruta_al_piano, { x: 285, y: oPlayer.y, spd: 1.5, is_lerp: false });
                    
                    array_push(ruta_al_piano, { x: 285, y: 238, spd: 1.5, is_lerp: false });
                    
                    array_push(ruta_al_piano, { x: 245, y: 238, spd: 0.1, is_lerp: true });
                }
                else 
                {
                    array_push(ruta_al_piano, { x: 245, y: 238, spd: 1, is_lerp: false });
                }

                PlayerWalk(ruta_al_piano, function() {
					audio_pause_all();
                    oPlayer.state = PLAYER_STATE.INTERACTING;
                    oPlayer.sprite_index = sprPlayerPianoPlaying;
                    oPlayer.image_index = 0; 
                    oPlayer.image_speed = 0;
                    
                    oPiano.using_piano = true;
                    global.CanInventory = false;
                    global.CanMove = false;
                });
		}
			}
        for(var i = 0; i < array_length(text); i++) {
            txtb_color[i] = c_white;
            txtb_snd[i] = sfx_text;
            speaker_sprite[i] = noone;
        }
	}
}
if(using_piano)
{
    var up    = keyboard_check(vk_up);
    var down  = keyboard_check(vk_down);
    var left  = keyboard_check(vk_left);
    var right = keyboard_check(vk_right);

    if(right && down) current_note = 1;
    else if(left && down) current_note = 3;
    else if(left && up) current_note = 5;
    else if(right && up) current_note = 7;
    else if(right) current_note = 0;
    else if(down) current_note = 2;
    else if(left) current_note = 4;
    else if(up) current_note = 6;

    if(keyboard_check_pressed(global.CancelKey)) sharp_mode = !sharp_mode;
    if(keyboard_check_pressed(global.MenuKey)) current_octave = (current_octave == 4) ? 5 : 4;

    if(keyboard_check(global.CancelKey))
    {
        hold_exit++;

        if(hold_exit >= game_get_speed(gamespeed_fps) * 3)
        {
            using_piano = false;
            hold_exit = 0;

            global.CanMove = true;
            global.CanInventory = true;
            
            oPlayer.state = PLAYER_STATE.NORMAL; 
			audio_resume_all();
            
            oPlayer.sprite_index = sprPlayerUp; 
            oPlayer.image_index = 0;
            oPlayer.image_speed = 0;

            oPlayer.y += 20; 
            
            cooldown_interact = 30; 
        }
    }
    else
    {
        hold_exit = 0;
    }


    if(keyboard_check_pressed(global.ConfirmKey)){
        var note_index;
		
        oPlayer.image_speed = 0; 
		
        if(current_octave == 4){
            oPlayer.image_index = 1;
        }else{
            oPlayer.image_index = 2;
        }
        
        piano_anim_timer = 6;
		
        switch(current_note){
            case 0: note_index = 0;  break;
            case 1: note_index = 2;  break;
            case 2: note_index = 4;  break;
            case 3: note_index = 5;  break;
            case 4: note_index = 7;  break;
            case 5: note_index = 9;  break;
            case 6: note_index = 11; break;
            case 7: note_index = 12; break;
        }

        if(sharp_mode && current_note != 2 && current_note != 6) note_index++;
        if(current_octave == 5) note_index += 12;

        if(current_sound != -1) audio_stop_sound(current_sound);
        current_sound = audio_play_sound(piano_notes[note_index], 0, false);
		
        var played_name = note_names[note_index];
        array_push(played_notes, played_name);
		
        var txt = "";
        for(var i = 0; i < array_length(played_notes); i++) {
            txt += played_notes[i];
            if(i < array_length(played_notes) - 1) txt += " ";
        }

        if(array_length(played_notes) > 32) array_delete(played_notes,0,1);

        for(var m = 0; m < array_length(melodies); m++) {
            var melody = melodies[m].notes;
            var len = array_length(melody);
            if(array_length(played_notes) >= len) {
                var correct = true;
                for(var i = 0; i < len; i++) {
                    var played = played_notes[array_length(played_notes) - len + i];
                    if(played != melody[i]) { correct = false; break; }
                }
                if(correct) {
                    show_debug_message("Melodia : " + melodies[m].name);
                    played_notes = [];
                }
            }
        }

        piano_flash = current_note;
        piano_flash_timer = 6;
    }

    if(piano_flash_timer > 0) {
        piano_flash_timer--;
        if(piano_flash_timer <= 0) piano_flash = -1;
    }
	

    if(piano_anim_timer > 0)
    {
        piano_anim_timer--;

        if(piano_anim_timer <= 0)
        {
            oPlayer.image_speed = 0;
            oPlayer.image_index = 0;
        }
    }
	


	
}

var _cam = view_camera[0]; 

if (instance_exists(oPlayer))
{
    var _cam_x = camera_get_view_x(_cam); 
    var _cam_y = camera_get_view_y(_cam); 
    var _cam_h = camera_get_view_height(_cam);

    var _target_offset = (using_piano) ? 60 : 0; 

    piano_cam_offset = lerp(piano_cam_offset, _target_offset, 0.1);

    var _new_cam_y = clamp(_cam_y - piano_cam_offset, 0, room_height - _cam_h);

    camera_set_view_pos(_cam, _cam_x, floor(_new_cam_y));
}
else
{
    piano_cam_offset = 0;
}

