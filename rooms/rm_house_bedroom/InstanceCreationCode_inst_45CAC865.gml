function Dialogos(){
    text = [];
    decisions = array_create(10, undefined); 
    decision_result = array_create(10, undefined);
    decision_script = array_create(10, undefined);
    speaker_sprite = [];
    txtb_snd = [];
    txtb_color = [];

    var _pregunta_idx = 1;

    if(global.Bed_times_slept == 2){
        text[0] = _T("bed_known_1");
        text[1] = _T("bed_known_2");
        _pregunta_idx = 1;
    } else if(global.Bed_times_slept > 2){
        text[0] = _T("bed_wasting_1");
        text[1] = _T("bed_wasting_2");
        _pregunta_idx = 1;
    } else {
        text[0] = _T("bed_intro_1");
        text[1] = _T("bed_intro_2");
        text[2] = _T("bed_intro_3");
        _pregunta_idx = 2;
    }
	
    var _pag_si = 8;
    var _pag_no = 9;

    text[_pag_si] = _T("bed_result_yes");
    text[_pag_no] = _T("bed_result_no");

    decisions[_pregunta_idx] = {
        left:  _T("bed_yes"),
        right: _T("bed_no")
    };
    decision_result[_pregunta_idx] = {
        left: _pag_si,
        right: _pag_no
    };
    decision_script[_pregunta_idx] = {
        left: function() { instance_create_depth(0, 0, -10000, oBed); }
    };
    
    for(var i=0; i < 10; i++){
        speaker_sprite[i] = noone;
        txtb_snd[i] = sfx_text;
        txtb_color[i] = c_white;
    }
}
