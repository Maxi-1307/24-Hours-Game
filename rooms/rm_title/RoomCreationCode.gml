if (!variable_global_exists("Master_Volume")) {
    cargar_idioma("en");
    global.Master_Volume = 70;
    global.SFX_Volume = 100;
    global.Language = 1;    
    global.SimplifyVFX = 0; 
    global.BordersEnabled = 0;
    global.DownKey    = vk_down;
    global.UpKey      = vk_up;
    global.LeftKey    = vk_left;
    global.RightKey   = vk_right;
    global.ConfirmKey = ord("Z");
    global.CancelKey  = ord("X");
    global.MenuKey    = ord("C");
   
    audio_group_load(audiogroupVolumeSFX);
    audio_group_load(audiogroupVolume);
}

// === CARGAR SÓLO CONFIGURACIONES ===
if (file_exists("setting.json")) {
    var _file = file_text_open_read("setting.json");
    var _json_string = file_text_read_string(_file);
    file_text_close(_file);

    try {
        var _data = json_parse(_json_string);
        
        if (variable_struct_exists(_data, "mastervolume")) {
            global.Master_Volume = _data.mastervolume;
            global.SFX_Volume    = _data.sfxvolume;
            global.Language      = _data.language;
            global.SimplifyVFX   = _data.simplifyvfx;
            global.BordersEnabled = _data.dynamicborders;
            global.DownKey       = _data.downkey;
            global.UpKey         = _data.upkey;
            global.LeftKey       = _data.leftkey;
            global.RightKey      = _data.rightkey;
            global.ConfirmKey    = _data.confirmkey;    
            global.CancelKey     = _data.cancelkey;
            global.MenuKey       = _data.menukey;
            
            if (global.Language == 0) {
                cargar_idioma("es");
            } else if (global.Language == 1) {
                cargar_idioma("en");
            }
            show_debug_message("Configuración y controles cargados con éxito desde setting.json!");
        }
    } catch (_error) {
        show_debug_message("Error al leer el archivo setting.json: " + string(_error.message));
    }
}
if (oBorder_Screen.borde_sprite != noone) {
    oBorder_Screen.borde_anterior = oBorder_Screen.borde_sprite;
    oBorder_Screen.borde_sprite = noone;
    oBorder_Screen.borde_alpha = 0.0; // Empieza invisible y hace fade in encima del anterior
}