// =========================================================================
// VARIABLES LOCALES INICIALIZADAS PARA ESTA INSTANCIA EN LA ROOM
// =========================================================================
duck_cinematic_played = false;
duck_cinematic_timer = 0;
sequence_id = -1;  
interacted_duck = 0;
used_call = false;
used_stand = false;
cinematica = false; 

// =========================================================================
// FUNCIÓN Update_Dialogos() - EJECUTADA EN EL STEP UNIVERSAL
function Update_Dialogos(){
    var _es_mi_caja = (instance_exists(oTextBox) && variable_instance_exists(oTextBox, "creator") && oTextBox.creator == id);
	text = [];
	speaker_sprite = [];
	txtb_color = [];
	txtb_snd = [];
    if(global.DuckStory <= 1){
        if(interacted_duck == 2 && global.DuckStory == 0){
            global.DuckStory++;
        }
    
        text[0] = "* It's a cute <brown>duck<white>!!";
        text[1] = "* How adorable!";
    
        text[2] = "* You start calling the <brown>duck<white>!";
        text[3] = "* But it ignored you!";

        if(_es_mi_caja){
            if(oTextBox.page == 2){
                if(instance_exists(oDuck)){
                    oDuck.can_swim = false;
                    oDuck.image_index = 1;
                    if(instance_exists(oPlayer)){
                        if(oPlayer.x > oDuck.x){
                            oDuck.image_xscale = -abs(oDuck.image_xscale);
                        } else {
                            oDuck.image_xscale = abs(oDuck.image_xscale);
                        }
                    }
                }
                if(!used_call){
                    used_call = true;
                    interacted_duck++; 
                }
            }
            if(oTextBox.page == 3){
                if(instance_exists(oDuck)){
                    oDuck.image_speed = 0;
                    oDuck.image_index = 2;
                }
            }
            if(oTextBox.page == 4){
                if(!used_stand){
                    used_stand = true;
                    interacted_duck++;
                }
            }
        } else {
            if(!instance_exists(oTextBox) && instance_exists(oDuck)){
                oDuck.can_swim = true;
                oDuck.image_index = 0;
                if(oDuck.facing == -1){
                    oDuck.image_xscale = 1;
                } else {
                    oDuck.image_xscale = -1;
                }
            }
        }
    
        text[4] = "* You stay still.";
        text[5] = "* The <brown>duck<white> didn't care...";
        text[6] = "* What? Were you expecting#it to work?"
    
        decisions[1] = {
            left: "Call",
            right: "Stand"
        };
    
        decision_result[1] = {
            left: 2,
            right: 4
        };
    
        decision_script[1] = {};
        
    } else if (global.DuckStory == 2 || global.DuckStory == 3) { 
        text[0] = "* Welp, there it swims#'<brown>Mr.Butterscotch<white>'.";
        text[1] = "* You slowly bring out the:# " + _T("item_duck_feed_name") + "!";
        text[2] = "* When suddenly...";
        
        if(_es_mi_caja){            
            if(oTextBox.page == 2){
                if(!cinematica && !duck_cinematic_played) {
                    cinematica = true; 
                }
            }
        }
        
        if(cinematica && !_es_mi_caja){
            if(!duck_cinematic_played){
                if(instance_exists(oDuck)){
                    oDuck.visible = false;
                    oDuck.can_swim = false;
                }
                if(instance_exists(oPlayer)){
                    oPlayer.image_alpha = 0;
                    oPlayer.state = PLAYER_STATE.INTERACTING;
                }
                
                var _seq_layer = layer_create(100, "Temp_Sequence");
                sequence_id = layer_sequence_create(_seq_layer, 439, 382, "sDuck");
                
                duck_cinematic_played = true;
                duck_cinematic_timer = 0;
            }
        }
        
        if(duck_cinematic_played){
            duck_cinematic_timer++;
            
            if(duck_cinematic_timer > game_get_speed(gamespeed_fps) * 10){ 
                if(sequence_id != -1){
                    layer_sequence_destroy(sequence_id);
                    sequence_id = -1;
                    
                    var _layer_to_delete = layer_get_id("Temp_Sequence");
                    if (layer_exists(_layer_to_delete)) {
                        layer_destroy(_layer_to_delete);
                    }
                }
                
                RemoveItem("Duck_Feed"); 
                global.DuckStory = 4;
                
                if(instance_exists(oDuck)){
                    oDuck.visible = true;
                    oDuck.can_swim = true;
                    oDuck.image_index = 0;
                }
                
                if(instance_exists(oPlayer)){
                    oPlayer.image_alpha = 1;
                    oPlayer.state = PLAYER_STATE.NORMAL;
                    oPlayer.sprite_index = sprPlayerRight;
                    oPlayer.image_speed = 0;
                    oPlayer.image_index = 0;
                    oPlayer.x = 430;
                    oPlayer.y = 382;
                }
                
                duck_cinematic_played = false;
                duck_cinematic_timer = 0;
                cinematica = false; 
            }
        }
    } else {
        text[0] = "* Quack<sfx=sfx_Car_Horn>";
    }
    
    for(var i = 0; i < array_length(text); i++){
        speaker_sprite[i] = noone;
        txtb_snd[i] = sfx_text;
        txtb_color[i] = c_white;
    }
}
