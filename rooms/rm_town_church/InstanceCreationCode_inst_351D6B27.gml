prayed = false;

fade_state = false;
unfade_state = false;
can_keep_state = false;

fade_frame = 0;
fade_speed = 0.2;

function Dialogos(){
	
	text[0] = "* It's a piece of furniture.";
	if(!prayed){
	    text[1] = "* You can notice some candles#inside.";
	    text[2] = "* Some are lit, others not so#much anymore.";
	    text[3] = "* You think you can see some#names written on them,#and one empty one.";
    
	    text[4] = "* You take the empty candle,#and slowly,but slowly...";
	    text[5] = "* Start whispering some comfy#words to someone.";
	    text[6] = "* Hoping that they heard#them.";
	    text[7] = "* ...";
	    text[8] = "* You leave the candle in#its place once more.";
	    text[9] = "* And opened your eyes.";
    
	    text[10] = "* He closed his eyes...";
	    text[11] = "* His hands are holding the#candle.";
	    text[12] = "* But,they're your words...";
	    text[13] = "* Close your eyes.#Feel free to try saying them.";
	    text[14] = "* . . .";
	    text[15] = "* . . .";
	    text[16] = "* . . .";
	    text[17] = "* You leave the candle in#its place once more.";
	    text[18] = "* And opened your eyes.";
    
	    text[19] = "* You close your eyes...";
	    text[20] = "* And began to say some#words to yourself.";
	    text[21] = "* Some of them are BIG,others#are SMALL.";
	    text[22] = "* Some others are COMFORTABLE#,and others are EMPTY.";
	    text[23] = "* But... at the end,they're#just WORDS... right?";
    
	    text[24] = "* You decided not to touch#anything.";
	
		decisions[3] = {
			left: "Pray",
			right: "Pray\nfor\nYOU",
			up: "Pray for you",
			down: "..."
	
		};
		decision_result[3] = {
			left: 4,
			right: 10,
			up: 19,
			down: 24
		};
		
		
		decision_script[3] = {
			right: function(){
					with(oMusicer){
						PauseMusic();
						audio_pause_all();
						audio_play_sound(snd12am,1,true);
					}
			}
		};
	}
	for(var i = 0; i < array_length(text); i++){
		txtb_color[i] = c_white;
		txtb_snd[i] = sfx_text;
		speaker_sprite[i] = noone;
	}
}

function Update_Dialogos(){

    var textbox = noone;

    with(oTextBox){
        if(creator == other.id){
            textbox = id;
        }
    }
	

    if(textbox != noone){

        if((textbox.page == 4 || textbox.page == 10 || textbox.page == 19)
        && !fade_state && !can_keep_state){
            fade_state = true;
        }

        if((textbox.page == 9 || textbox.page == 18 || textbox.page == 23)
        && !unfade_state && can_keep_state){
            unfade_state = true;
			audio_stop_sound(snd12am);
			audio_resume_all();
			with (oMusicer){
				ResumeMusic();
			}
        }
    }

    // Fade hacia negro
    if(fade_state){
        fade_frame += fade_speed;

        if(fade_frame >= sprite_get_number(sprFade) - 1){
            fade_frame = sprite_get_number(sprFade) - 1;
            fade_state = false;
            can_keep_state = true;
        }
    }

    // Fade de regreso
    if(unfade_state){
        fade_frame -= fade_speed;

        if(fade_frame <= 0){
            fade_frame = 0;
            unfade_state = false;
            can_keep_state = false;
        }
    }
}
	
function Draw_Dialogos(){
    if(fade_state || unfade_state || can_keep_state){
        draw_sprite_tiled(sprFade, fade_frame, 0, 0);
    }
}