function Items(){
    global.Items = {
        Flower : {
            name: "item_flower_name", 
            can_use: 0,
            effect: function(){
                var inst = instance_create_layer(0,0,"Dialogue", oTextBox);
                inst.is_item_dialog = true;
                inst.text[0] = _T("item_flower_desc"); 
                inst.speaker_sprite[0] = noone;
                inst.txtb_snd[0] = sfx_text;
                inst.txtb_color[0] = c_white;
            }
        },
        Candle: {
            name: "item_candle_name", 
            can_use : 0,
            effect: function(){
                var inst = instance_create_layer(0,0,"Dialogue", oTextBox);
                inst.is_item_dialog = true;
                inst.text[0] = _T("item_candle_desc");
                inst.speaker_sprite[0] = noone;
                inst.txtb_snd[0] = sfx_text;
                inst.txtb_color[0] = c_white;
            }
        },
        Mailman_Pin:{
            name: "item_mailman_pin_name",
            can_use : 0,
            effect: function(){
                var inst = instance_create_layer(0,0,"Dialogue",oTextBox);
                inst.is_item_dialog = true;
                with(inst){
                    text[0] = _T("item_mailman_pin_desc_1");
                    text[1] = _T("item_mailman_pin_desc_2"); 
                    text[2] = _T("item_mailman_pin_desc_3"); 
                    text[3] = _T("item_mailman_pin_desc_4"); 
                    for(var i = 0; i < array_length(text); i++){
                        speaker_sprite[i] = noone;
                        txtb_snd[i] = sfx_text;
                        txtb_color[i] = c_white;
                    }
                }
            }
        },
        Egg:{
            name: "item_egg_name",
            can_use : 0,
            effect: function(){
                var inst = instance_create_layer(0,0,"Dialogue",oTextBox);
                inst.is_item_dialog = true;
                with(inst){
                    text[0] = _T("item_egg_desc_1");
                    text[1] = _T("item_egg_desc_2");
                    text[2] = _T("item_egg_desc_3");
                    for(var i = 0; i < array_length(text); i++){
                        speaker_sprite[i] = noone;
                        txtb_snd[i] = sfx_text;
                        txtb_color[i] = c_white;
                    }
                }
            }
        },
        Water_Bottle:{
            name: "item_water_bottle_name",
            can_use : 2,
            effect: function(){
                var inst = instance_create_layer(0,0,"Dialogue",oTextBox);
                inst.is_item_dialog = true;
                with(inst){
                    text[0] = _T("item_water_bottle_desc_1");
                    text[1] = _T("item_water_bottle_desc_2");
                    for(var i = 0; i < array_length(text); i++){
                        speaker_sprite[i] = noone;
                        txtb_snd[i] = sfx_text;
                        txtb_color[i] = c_white;
                    }
                }
            },
            effect_can_use : function(){
                var inst = instance_create_layer(0,0,"Dialogue",oTextBox);
                inst.is_item_dialog = true;
                with(inst){
                    text[0] = _T("item_water_use_1");
                    text[1] = _T("item_water_use_2");
                    for(var i = 0; i < array_length(text); i++){
                        speaker_sprite[i] = noone;
                        txtb_snd[i] = sfx_text;
                        txtb_color[i] = c_white;
                    }
                }
            }    
        },
        Soda_Can:{
            name: "item_soda_can_name",
            can_use : 2,
            effect: function(){
                var inst = instance_create_layer(0,0,"Dialogue",oTextBox);
                inst.is_item_dialog = true;
                with(inst){
                    text[0] = _T("item_soda_can_desc_1");
                    text[1] = _T("item_soda_can_desc_2");
                    for(var i = 0; i < array_length(text); i++){
                        speaker_sprite[i] = noone;
                        txtb_snd[i] = sfx_text;
                        txtb_color[i] = c_white;
                    }
                }
            },
            effect_can_use : function(){
                var inst = instance_create_layer(0,0,"Dialogue",oTextBox);
                inst.is_item_dialog = true;
                with(inst){
                    text[0] = _T("item_soda_use_1");
                    text[1] = _T("item_soda_use_2");
                    for(var i = 0; i < array_length(text); i++){
                        speaker_sprite[i] = noone;
                        txtb_snd[i] = sfx_text;
                        txtb_color[i] = c_white;
                    }
                }
            }    
        },
		
		Chips:{
			name: "item_chips_name",
			can_use: 2,
			effect: function(){
				var inst = instance_create_layer(0,0,"Dialogue",oTextBox);
				inst.is_item_dialog = true;
				with(inst){
                    text[0] = _T("item_chips_desc_1");
                    text[1] = _T("item_chips_desc_2");
                    for(var i = 0; i < array_length(text); i++){
                        speaker_sprite[i] = noone;
                        txtb_snd[i] = sfx_text;
                        txtb_color[i] = c_white;
                    }					
				}
			},
			effect_can_use: function(){
				var inst = instance_create_layer(0,0,"Dialogue",oTextBox);
				inst.is_item_dialog = true;
				with(inst){
                    text[0] = _T("item_chips_use_1");
                    text[1] = _T("item_chips_use_2");
                    for(var i = 0; i < array_length(text); i++){
                        speaker_sprite[i] = noone;
                        txtb_snd[i] = sfx_text;
                        txtb_color[i] = c_white;
                    }					
				}
			}
		},
		
		Duck_Feed:{
			name: "item_duck_feed_name",
			can_use : 0,
			effect: function(){
				var inst = instance_create_layer(0,0,"Dialogue",oTextBox);
				inst.is_item_dialog = true;
				with(inst){
				     text[0] = _T("item_duck_feed_desc_1");
				     text[1] = _T("item_duck_feed_desc_2");
					 text[2] = _T("item_duck_feed_desc_3");
				     for(var i = 0; i < array_length(text); i++){
				          speaker_sprite[i] = noone;
				          txtb_snd[i] = sfx_text;
				          txtb_color[i] = c_white;
				     }					
				}				
			}
		},
    };
}