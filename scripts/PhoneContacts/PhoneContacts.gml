

function PhoneContacts() {
    global.PhoneContacts = {
        Home: {
            name: "Home",
            effect: function() {
                var inst = instance_create_layer(0, 0, "Dialogue", oTextBox);                
                with (inst) {
					text = [];
                    var _current_room_name = string_lower(room_get_name(room));
                    if (string_pos("house", _current_room_name) == 0){
                        text[0] = "* (Click)...";
                        text[1] = "* You tried call <yellow>HOME<white>...";
                        text[2] = "* But there was no one#to answer.";
                        text[3] = "* (Click)...";
                    }else{
                        text[0] = "* (Click)...";
                        text[1] = "* You tried call <yellow>HOME<white>...";
                        text[2] = "* Even when you know it's#<yellow>YOU<white>...";
                    }
                    
                    for (var i = 0; i < array_length(text); i++) {
                        speaker_sprite[i] = noone;
                        txtb_snd[i] = sfx_text;
                        txtb_color[i] = c_white;
                    }
                }
            }
        },

        Store: {
            name: "Store",
            effect: function() {
                var inst = instance_create_layer(0, 0, "Dialogue", oTextBox);
                with (inst) {
					
					if(room == rm_town_store) {
						if(instance_exists(oStore_EmployeeGirl) && !instance_exists(oShop_EmployeeBoy)){
							text[0] = "* (Click)..."
			                text[1] = "* Hellow!!";
			                text[2] = "* Oh, you got the store's#number!";
							text[3] = "* That's akward...";
							text[4] = "* But nice too,jajaja";
							text[5] = "* Don't forget to do some#shop<wait=30>-ing";
			                text[6] = "* (Click)...";
						}else if(instance_exists(oShop_EmployeeBoy) && !instance_exists(oStore_EmployeeGirl)){
							text[0] = "* (Click)..."
			                text[1] = "* Hell-";
			                text[2] = "<unskippable>*<wait=60> .<wait=60>.<wait=60>.";
							text[3] = "* You know I'm looking#at you, right...?";
			                text[4] = "* (Click)...";							
						}else{
							text[0] = "* (Click)";
							text[1] = "* 24/7 Store it's a:";
							text[2] = "* Normal and boring day...";
							text[3] = "* Noo... that's not#the line!";
							text[4] = "* For what? Like if you#can't see him standing#there!";
							text[5] = "* Yeah I know but it's fun.";
							text[6] = "* ...";
							text[7] = "* (Click)...";
						}
		            }				
					switch (global.current_turn)
					{
						//Chica
						case 0:
		                    if (room != rm_town_store) {
		                        text[0] = "* (Click)..."
		                        text[1] = "* Hello, 24/7 Store!";
		                        text[2] = "* Can we help you?";
		                        text[3] = "* ....";	
		                        text[4] = "* (Click)..."
		                    }
		                    for (var i = 0; i < array_length(text); i++) {
		                        speaker_sprite[i] = noone;
		                        txtb_snd[i] = sfx_text;
		                        txtb_color[i] = c_white;
		                    }
							break;
						
						//Chico
						case 1:
							if (room != rm_town_store) {
		                        text[0] = "* (Click)..."
		                        text[1] = "* Hello, 24/7 Store!";
		                        text[2] = "* Can we help you?";
		                        text[3] = "* ....";	
		                        text[4] = "* (Click)..."
		                    }
		                    for (var i = 0; i < array_length(text); i++) {
		                        speaker_sprite[i] = noone;
		                        txtb_snd[i] = sfx_text;
		                        txtb_color[i] = c_white;
		                    }
							break;
						
						//Ambos
						case 2:
							if (room != rm_town_store) {
		                        text[0] = "* (Click)..."
		                        text[1] = "* Hello, 24/7 Store!";
		                        text[2] = "* Can we help you?";
		                        text[3] = "* ....";	
		                        text[4] = "* (Click)..."
		                    }
		                    for (var i = 0; i < array_length(text); i++) {
		                        speaker_sprite[i] = noone;
		                        txtb_snd[i] = sfx_text;
		                        txtb_color[i] = c_white;
		                    }
							break;
					}
                }
            }
        },

    };
    
    global.PhoneContactsList = [];
}

function phone_add_contact(contact_id) {
    if (variable_struct_exists(global.PhoneContacts, contact_id)) {
        var exists = false;
        for (var i = 0; i < array_length(global.PhoneContactsList); i++) {
            if (global.PhoneContactsList[i] == contact_id) {
                exists = true;
                break;
            }
        }
        if (!exists) {
            array_push(global.PhoneContactsList, contact_id);
        }
    }
}