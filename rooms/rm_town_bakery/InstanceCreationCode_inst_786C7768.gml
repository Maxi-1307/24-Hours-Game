function Dialogos(){
    text = [];
    decisions = array_create(10, undefined); 
    decision_result = array_create(10, undefined);
    decision_script = array_create(10, undefined);
    speaker_sprite = [];
    txtb_snd = [];
    txtb_color = [];
	
    text = _T("bell_desc");
	text = _T("bell_ask");
	text = _T("bell_cancel");
	
    decisions = {
        left:  _T("bell_btn_yes"),
        right: _T("bell_btn_no")
    };
	decision_result = {
        right: 2
    };
    
    decision_script = {
        left: function() {
            audio_play_sound(sfx_enter_bakery,1,false);
			instance_destroy(oTextBox);
			global.CanInventory = true;
			global.CanMove = true;
        }
    };
    
    for(var i=0; i<6; i++){
        speaker_sprite[i] = noone;
        txtb_snd[i] = sfx_text;
        txtb_color[i] = c_white;
    }
}
