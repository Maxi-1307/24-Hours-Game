function Dialogos(){
	text[0] = _T("picnic_group_1");
	text[1] = _T("picnic_group_2");

    var _len = array_length(text);
    
    for (var i = 0; i < _len; i++) {
        speaker_sprite[i] = noone;
        txtb_snd[i]       = sfx_text;
        txtb_color[i]     = c_white;
    }
}
