function Dialogos(){
	text[0] = _T("radio_kitchen_1");
	text[1] = _T("radio_kitchen_2");
	text[2] = _T("radio_kitchen_3");
	text[3] = _T("radio_kitchen_4");
	
	var _len = array_length(text);
    
    for (var i = 0; i < _len; i++) {
        speaker_sprite[i] = noone;
        txtb_snd[i]       = sfx_text;
        txtb_color[i]     = c_white;
    }
	
}

