function Dialogos(){
    decisions = [];
    decision_result = [];
    decision_script = [];
    text = [];
    
    if (global.StoreNumberStory == 0) {
        text[0] = _T("flyer_first_1");
        text[1] = _T("flyer_first_2");
        text[2] = _T("flyer_first_3");
        text[3] = _T("flyer_first_4");
        text[4] = _T("flyer_picked_1");
        text[5] = _T("flyer_picked_2");
        text[6] = _T("flyer_leave_1");
        text[7] = _T("flyer_leave_2");
        
        decisions[3] = {
            left: _T("flyer_option_ohyeah"),
            right: _T("flyer_option_nah")
        };
        decision_result[3] = {
            left: 4,
            right: 6
        };
        
        decision_script[3] = {
            left: function(){
                global.StoreNumberStory = 1;
                phone_add_contact("Store");
            }
        };
        
    } else {
        text[0] = _T("flyer_later_1");
        text[1] = _T("flyer_later_2");
        text[2] = _T("flyer_later_3");
        text[3] = _T("flyer_later_4");
    }
    
    for(var i= 0;i<array_length(text);i++){
        txtb_snd[i] = sfx_text;
        speaker_sprite[i] = noone;
        txtb_color[i] = c_white;
    }
}