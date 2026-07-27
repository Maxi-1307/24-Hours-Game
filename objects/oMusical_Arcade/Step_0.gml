if (place_meeting(x, y, oPlayer) && keyboard_check_pressed(global.ConfirmKey) && (!instance_exists(oTextBox)) && !instance_exists(oPlatformer_Transition)&& (!instance_exists(oInventory))) {
    
	var txtb = instance_create_layer(0, 0, "Dialogue", oTextBox);
	
	with (txtb) {
		function Dialogos() {
		    text = [];
		    decisions = array_create(10, undefined); 
		    decision_result = array_create(10, undefined);
		    decision_script = array_create(10, undefined);
		    speaker_sprite = [];
		    txtb_snd = [];
		    txtb_color = [];
	
		    text[0] = _T("arcade_desc");
			text[1] = _T("arcade_cost");
			text[2] = _T("arcade_cancel");
    
		    decisions[1] = {
		        left:  _T("arcade_btn_use"),
		        right: _T("arcade_btn_skip")
		    };
			
			decision_result[1] = {
		        right: 2
		    };
			
		    decision_script[1] = {
		        left: function() {
					if(global.Money >= 15){
						instance_destroy(oTextBox); 
						var txtb1 = instance_create_layer(0, 0, "Dialogue", oTextBox);
						with(txtb1){
							text = [];
						    decisions = array_create(10, undefined); 
						    decision_result = array_create(10, undefined);
						    decision_script = array_create(10, undefined);
						    speaker_sprite = [];
						    txtb_snd = [];
						    txtb_color = [];
							
							text[0] = _T("arcade_musical_choice");
							text[1] = _T("arcade_musical_difficult");
							
							decisions[0] = {
								left: "TV WORLD",
								right: "CASTLE FUNK"
							};
							
							decision_result[0] = {
								left: 1,
								right: 1
							};
							decisions[1] = {
								left: "Normal",
								right: _T("arcade_musical_hard")
							};
							
							decision_script[0] = {
								left: function(){
									global.Musica_Seleccionada = snd_Test_TVWORLD;
								},
								right: function(){
									global.Musica_Seleccionada = snd_Castle_Funk;
								}
							};
							decision_script[1] = {
								left: function(){
									global.Musical_Dificultad = "normal";
									room_goto(rm_musical);
					
									global.Platformer_Can_Move = false; 
									global.Money -= 15;
									oPlayer.visible = false;
									global.CanMove = false;
									
									instance_destroy(oTextBox); 									
								},
								right: function(){
									global.Musical_Dificultad = "hard";
									room_goto(rm_musical);
					
									global.Platformer_Can_Move = false; 
									global.Money -= 15;
									oPlayer.visible = false;
									global.CanMove = false;
									
									instance_destroy(oTextBox); 
								}
							}
							for(var i = 0; i < array_length(text); i++) {
								speaker_sprite[i] = noone;
								txtb_snd[i] = sfx_text;
								txtb_color[i] = c_white;
							}
						}			
			        }else{
						instance_destroy(oTextBox); 
						var txtb2 = instance_create_layer(0, 0, "Dialogue", oTextBox);
						with(txtb2){
							function Dialogos(){
								text[0] = _T("arcade_no_money");
								speaker_sprite[0] = noone;
								txtb_snd[0] = sfx_text;
								txtb_color[0] = c_white;
							}
							Dialogos();
						}
					}
				}
		    };
    
		    for(var i = 0; i < 6; i++) {
		        speaker_sprite[i] = noone;
		        txtb_snd[i] = sfx_text;
		        txtb_color[i] = c_white;
		    }
		}
		
		Dialogos(); 
	}
}
