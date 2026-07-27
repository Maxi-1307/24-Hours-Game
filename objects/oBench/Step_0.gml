if (global.CanMove && (!instance_exists(oTextBox)) && oPlayer.sprite_index != sprPlayerSitting && (!instance_exists(oInventory))) {
    if (point_distance(x, y, oPlayer.x, oPlayer.y) < 25) {
        if (keyboard_check_pressed(global.ConfirmKey)) { 
            
            var _tb = instance_create_layer(0, 0, "Dialogue", oTextBox);
            with(_tb) {
                interact_id = other.id; 
                
                text[0] = _T("bench_desc");
                text[1] = _T("bench_ask");
                
                decisions[1] = { 
                    left: _T("bench_yes"), 
                    right: _T("bench_no") 
                };
                
                decision_result[1] = { left: 2, right: 3 };
                
                text[2] = _T("bench_rest");
                text[3] = _T("bench_leave");
                
			    for(var i = 0; i < 10; i++){
			        speaker_sprite[i] = noone;
			        txtb_snd[i] = sfx_text;
			        txtb_color[i] = c_white;
				}	
                
                decision_script[1] = {
                    left: function() {
                        global.CanMove = false;
						global.CanInventory = false;
                        oPlayer.x = other.interact_id.x; 
                        oPlayer.y = other.interact_id.y - 17;
                        oPlayer.sprite_index = sprPlayerSitting;
                    }
                };
            }
        }
    }
}

if (oPlayer.sprite_index == sprPlayerSitting && oPlayer.x == x && oPlayer.y == y - 17) {
	oPlayer.depth = depth - 1;
    var _get_up = keyboard_check(global.UpKey) || keyboard_check(global.DownKey) || 
                  keyboard_check(global.LeftKey) || keyboard_check(global.RightKey);
    
    if (_get_up) {
		if(instance_exists(oTextBox)){
			instance_destroy(oTextBox);
		}
        global.CanMove = true;
        oPlayer.sprite_index = sprPlayerDown; 
        oPlayer.y += 27; 
		global.CanInventory = true;
    }
}
