function Dialogos(){
    text = [];
	var knock_odd = irandom(4);
    
	if(knock_odd == 3){
	    audio_play_sound(sfx_knock_door, 10, false);
		if(!global.KnockedDoorMom){
			text[0] = _T("mom_knock_first");
			text[1] = _T("mom_no_answer");
			global.KnockedDoorMom = true;
		}else{
			text[0] = _T("mom_knock_again");
			text[1] = _T("mom_you_know");
		}
	} else {	
		text[0] = _T("mom_silence");
	}

    var _len = array_length(text);
    for(var i = 0; i < _len; i++){
        speaker_sprite[i] = noone;
        txtb_snd[i] = sfx_text;
        txtb_color[i] = c_white;
    }
}
