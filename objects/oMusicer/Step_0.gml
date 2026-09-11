if (!weather_loaded) {
    if (variable_global_exists("CURRENT_WEATHER")) {
        weather_loaded = true;
        show_debug_message("CLIMA cargado: " + string(global.CURRENT_WEATHER));
    }
}

if (!hour_loaded) {
    if (instance_exists(oTimeAtmosphere)) {
        hour_loaded = true;
        show_debug_message("HORA cargada: " + string(oTimeAtmosphere.period));
    }
}

if (!weather_loaded || !hour_loaded) {
    if (!system_ready) {
        show_debug_message("sperando clima y hora...");
    }
    return;
}

if (!system_ready) {
    system_ready = true;
    show_debug_message("Sistema listo - Clima y Hora cargados");
    BuildPool();
    music_state = "idle";
    idle_timer = GetBiasedIdleTime() * 60;
    return;
}

var _weather = global.CURRENT_WEATHER;
var _period = oTimeAtmosphere.period;

if (_weather != last_weather || _period != last_period) {
    last_weather = _weather;
    last_period = _period;
    BuildPool();
    music_state = "idle";
    idle_timer = GetBiasedIdleTime() * 60;
    if (audio_id != noone) {
        audio_stop_sound(audio_id);
        audio_id = noone;
    }
}

ManageAudio();