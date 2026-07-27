function Dialogos(){
    text = [];
    decisions = array_create(10, undefined); 
    decision_result = array_create(10, undefined);
    decision_script = array_create(10, undefined);
    speaker_sprite = [];
    txtb_snd = [];
    txtb_color = [];
	
    text[0] = _T("shower_intro");
	text[1] = _T("shower_ask_1");
	text[2] = _T("shower_action_1");
    text[3] = _T("shower_no");
    text[4] = _T("shower_later");
    text[5] = _T("shower_dots");
    
	if(global.HasShowered > 0){
		text[1] = _T("shower_ask_2");
        
        var _frase_base = _T("shower_action_2");
		text[2] = string_replace(_frase_base, "{0}", string(global.HasShowered));
	}
    
    decisions[1] = {
        up:    _T("btn_yes_up"),
        down:  _T("btn_no_down"),
        left:  _T("btn_later_left"),
        right: _T("btn_dots_right")
    };
    decision_result[1] = {
        up: 2,
        down: 3,
        left: 4,
        right: 5
    };
	
    decision_script[1] = {
        up: function() {
            instance_create_depth(0, 0, -10000, oShower);
        }
    };
    
    for(var i=0; i<6; i++){
        speaker_sprite[i] = noone;
        txtb_snd[i] = sfx_text;
        txtb_color[i] = c_white;
    }
}
