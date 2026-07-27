function LoadGame(){
    if (!file_exists("save_data.json")) {
        show_debug_message("No hay archivo de guardado (save_data.json).");
        return;
    }
    
    Items();
	
    
    var _file = file_text_open_read("save_data.json");
    var _json_string = file_text_read_string(_file);
    file_text_close(_file);

    try {
        var _data = json_parse(_json_string);
        
        global.game_minutes = _data.time;
        global.PlayerX = _data.player_x;
        global.PlayerY = _data.player_y;
        global.Money = _data.money;
        global.HasShowered = _data.has_showered;
        global.KnockedDoorMom = _data.knocked_door_mom;
        global.Bed_times_slept = _data.bed_times_slept;
        global.Is_Indoors = _data.is_indoors;
        global.Platformer_Final_Score = _data.platformer_final_score;
		global.StoreNumberStory = _data.store_number_story
		global.DuckStory = _data.duck_story;
        
        if (variable_struct_exists(_data, "musical_highscore_saved")) {
            global.Musical_HighScore_SAVED = _data.musical_highscore_saved;
        } else {
            global.Musical_HighScore_SAVED = {};
        }
        
        var _temp_inv = _data.inventory;
        var _inventario_reconstruido = [];
        
        for (var i = 0; i < array_length(_temp_inv); i++) {
            var _itemName = "";
            if (variable_struct_exists(_temp_inv[i], "item_id")) {
                _itemName = _temp_inv[i].item_id;
            } 
            else if (variable_struct_exists(_temp_inv[i], "name")) {
                _itemName = _temp_inv[i].name;
            }
            
            if (_itemName != "") {
                var _ranura_limpia = {
                    item_id: _itemName
                };
                array_push(_inventario_reconstruido, _ranura_limpia);
            }
        }
        
        global.Inventory = _inventario_reconstruido;
        
        global.time_speed = 0.003;
        global.time_paused = false;
        global.InventoryLength = 8;
        global.Loaded_Game = true;
		
		PhoneContacts();
		phone_add_contact("Home");
		if(global.StoreNumberStory > 0){
			phone_add_contact("Store");
		}

        room_goto(_data.current_room);
        
        if(!instance_exists(oTimeAtmosphere)) instance_create_layer(0,0,"Atmosphere",oTimeAtmosphere);
        if(!instance_exists(oTime)) instance_create_layer(0,0,"Time",oTime);
        if(!instance_exists(oPlayer)) instance_create_layer(global.PlayerX, global.PlayerY, "Player", oPlayer);
        if(!instance_exists(oShadow_Light)) instance_create_depth(320,0,-9999,oShadow_Light);
        if(!instance_exists(oWeather)) instance_create_layer(0,0,"Atmosphere",oWeather);
		
		
        show_debug_message("Cargo el save data");
    } catch (_error) {
        show_debug_message("Error al leer el archivo save_data.json: " + string(_error));
    }
}