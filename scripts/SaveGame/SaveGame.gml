function SaveGame(){
    var _inventario_para_guardar = [];
    for (var i = 0; i < array_length(global.Inventory); i++) {
        var _ranura = {
            item_id: global.Inventory[i].item_id
        };
        array_push(_inventario_para_guardar, _ranura);
    }

    var _save_data = {
        time: global.game_minutes,
        player_x: global.PlayerX,
        player_y: global.PlayerY,
        money: global.Money,
        current_room: room,
        inventory: _inventario_para_guardar, 

        //Global Variables
        has_showered: global.HasShowered,
        knocked_door_mom: global.KnockedDoorMom,
        bed_times_slept: global.Bed_times_slept,
        is_indoors: global.Is_Indoors,

        platformer_final_score : global.Platformer_Final_Score,
        musical_highscore_saved: global.Musical_HighScore_SAVED,
        weather: global.WEATHER,
		
		store_number_story: global.StoreNumberStory,
		duck_story: global.DuckStory
    };

    var _json_string = json_stringify(_save_data);

    var _temp_filename = "save_data_temp.json";
    var _final_filename = "save_data.json";

    var _file = file_text_open_write(_temp_filename);
    file_text_write_string(_file, _json_string);
    file_text_close(_file);

    if (file_exists(_final_filename)) file_delete(_final_filename);
    file_rename(_temp_filename, _final_filename);
}