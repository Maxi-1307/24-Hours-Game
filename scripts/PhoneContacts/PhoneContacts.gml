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
		                text[0] = "* (Click)..."
		                text[1] = "* Hell-";
		                text[2] = "* You know we can see#you calling us...";
						text[3] = "* Try your prank in#another place!";
		                text[4] = "* (Click)..."
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