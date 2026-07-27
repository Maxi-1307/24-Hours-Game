function Dialogos(){
	text[0] = _T("sink_desc_1");
	text[1] = _T("sink_desc_2");
	text[2] = _T("sink_desc_3");
    var _len = array_length(text);
    
    for (var i = 0; i < _len; i++) {
        speaker_sprite[i] = noone;
        txtb_snd[i]       = sfx_text;
        txtb_color[i]     = c_white;
    }	
}



