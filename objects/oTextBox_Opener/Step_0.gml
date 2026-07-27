Update_Dialogos();

if instance_exists(oPlayer) && !instance_exists(oInventory){
    if (place_meeting(x,y,oPlayer) && can_interact && (!instance_exists(oTextBox)) && (global.CanMove) && (!instance_exists(oInventory)) && (keyboard_check_pressed(global.ConfirmKey))){
        var inst = instance_create_layer(0,0,"Dialogue", oTextBox);
        inst.creator = id; 
        
        Dialogos();
        inst.text = text;
        inst.speaker_sprite = speaker_sprite;
        inst.txtb_snd = txtb_snd;
        inst.txtb_color = txtb_color;
        inst.decisions = decisions;
        inst.decision_result = decision_result;
        inst.decision_script = decision_script;
    }
}
