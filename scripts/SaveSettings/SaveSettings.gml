function SaveSettings(){
    var _settings_data = {
        mastervolume : global.Master_Volume,
        sfxvolume : global.SFX_Volume,
        language : global.Language,
        simplifyvfx : global.SimplifyVFX,
        dynamicborders: global.BordersEnabled,
        downkey : global.DownKey,
        upkey :  global.UpKey,
        leftkey :  global.LeftKey,
        rightkey : global.RightKey,
        confirmkey : global.ConfirmKey,
        cancelkey :  global.CancelKey,
        menukey :  global.MenuKey
    };

    var _json_string = json_stringify(_settings_data);
    
    var _temp_filename = "setting_temp.json";
    var _final_filename = "setting.json";
    
    var _file = file_text_open_write(_temp_filename);
    file_text_write_string(_file, _json_string);
    file_text_close(_file);
    
    if (file_exists(_final_filename)) file_delete(_final_filename);
    file_rename(_temp_filename, _final_filename);
    
}