global.ambience_clima = {
    normal: [],
    soleado: [],
    nublado: [dreiton],
    tormentoso: [],
    lluvia: [dreiton],
    nevada: [],
    vientoso: []
};

global.ambience_hora = {
    dawn: [],
    morning: [],
    day: [],
    afternoon: [sndHome, sndBakery_Shop, sndSilence],
    afternoon_fade: [],
    sunset: [],
    early_night: [],
    night: [sndSilence]
};

current_pool = [];
current_pool_index = 0;
audio_id = noone;
volume = 1;
last_volume = volume;
is_paused = false;
last_weather = "";
last_period = "";
fade_target_volume = 1;
fade_speed = 0.02;
is_fading = false;
song_ended = false;

music_state = "idle";
idle_timer = 0;
idle_time_min = 30;
idle_time_max = 240;
fade_in_speed = 0.02;
fade_out_speed = 0.02;
weather_loaded = false;
hour_loaded = false;
system_ready = false;


function GetBiasedIdleTime() {
    var _min = idle_time_min;
    var _max = idle_time_max;
    var _range = _max - _min;

    var _random = power(random(1), 0.6);
    
    var _result = _min + (_range * _random);
    
    _result = clamp(floor(_result), _min, _max);
    
    return _result;
}

function BuildPool() {
    var _weather = global.CURRENT_WEATHER;
    var _period = oTimeAtmosphere.period;
    
    current_pool = [];
    
    var _clima_list = global.ambience_clima[$ _weather];
    var _hora_list = global.ambience_hora[$ _period];
    
    for (var i = 0; i < array_length(_clima_list); i++) {
        array_push(current_pool, _clima_list[i]);
    }
    
    for (var i = 0; i < array_length(_hora_list); i++) {
        array_push(current_pool, _hora_list[i]);
    }
    
    if (array_length(current_pool) > 0) {
        current_pool = shuffle_array(current_pool);
        current_pool_index = 0;
        ShowDebugInfo();
    } else {
        if (audio_id != noone) {
            audio_stop_sound(audio_id);
            audio_id = noone;
        }
        show_debug_message("No hay canciones disponibles para el clima y hora actual");
    }
}

function shuffle_array(_array) {
    var _shuffled = [];
    array_copy(_shuffled, 0, _array, 0, array_length(_array));
    
    for (var i = array_length(_shuffled) - 1; i > 0; i--) {
        var j = irandom(i);
        var temp = _shuffled[i];
        _shuffled[i] = _shuffled[j];
        _shuffled[j] = temp;
    }
    return _shuffled;
}

function PlayCurrentSong() {
    if (array_length(current_pool) == 0) {
        return;
    }
    
    if (current_pool_index >= array_length(current_pool)) {
        current_pool_index = 0;
        current_pool = shuffle_array(current_pool);
    }
    
    var _song = current_pool[current_pool_index];
    
    if (_song != noone) {
        if (audio_id != noone) {
            audio_stop_sound(audio_id);
            audio_id = noone;
        }
        audio_id = audio_play_sound(_song, 10, false, 0);
        is_paused = false;
        song_ended = false;
        music_state = "fade_in";
        is_fading = true;
        fade_target_volume = volume;
        fade_speed = fade_in_speed;
        show_debug_message("Iniciando fade in: " + string(_song));
        ShowDebugInfo();
    }
}

function ManageAudio() {
    if (array_length(current_pool) == 0 || !system_ready) {
        return;
    }
    
    var _volume = global.Is_Indoors ? 0.5 : 1;
    volume = _volume;
    
    switch (music_state) {
        case "idle":
            if (audio_id != noone && audio_is_playing(audio_id)) {
                audio_stop_sound(audio_id);
                audio_id = noone;
            }
            idle_timer--;
            if (idle_timer <= 0) {
                PlayCurrentSong();
            }
            break;
            
        case "fade_in":
            if (!is_fading && audio_id != noone) {
                music_state = "playing";
                show_debug_message("Reproduciendo: " + string(current_pool[current_pool_index]));
            }
            break;
            
        case "playing":
            if (audio_id != noone && !audio_is_playing(audio_id) && !is_paused) {
                song_ended = true;
                music_state = "fade_out";
                is_fading = true;
                fade_target_volume = 0;
                fade_speed = fade_out_speed;
                show_debug_message("Canción terminó, fade out");
            }
            break;
            
        case "fade_out":
            if (!is_fading) {
                if (audio_id != noone) {
                    audio_stop_sound(audio_id);
                    audio_id = noone;
                }
                current_pool_index++;
                music_state = "idle";
                idle_timer = GetBiasedIdleTime() * 60;
                show_debug_message("Silencio por " + string(idle_timer/60) + " segundos");
            }
            break;
    }
    
    if (is_fading && audio_id != noone) {
        var _current_gain = audio_sound_get_gain(audio_id);
        var _new_gain = approach(_current_gain, fade_target_volume, fade_speed);
        audio_sound_gain(audio_id, _new_gain, 0);
        
        if (abs(_new_gain - fade_target_volume) < 0.001) {
            is_fading = false;
        }
    }
}

function approach(_val, _target, _speed) {
    if (_val < _target) {
        return min(_val + _speed, _target);
    } else {
        return max(_val - _speed, _target);
    }
}

function ShowDebugInfo() {
    if (!system_ready) return;
    
    var _weather = global.CURRENT_WEATHER;
    var _period = oTimeAtmosphere.period;
    
    var _clima_list = global.ambience_clima[$ _weather];
    var _hora_list = global.ambience_hora[$ _period];
    
    show_debug_message("CLIMA ACTUAL: " + string(_weather));
    show_debug_message("Canciones: " + string(_clima_list));
    show_debug_message("HRA ACTUAL: " + string(_period));
    show_debug_message("Canciones: " + string(_hora_list));
    show_debug_message("POOL TOTAL (" + string(array_length(current_pool)) + " canciones):");
    show_debug_message("   " + string(current_pool));
    if (array_length(current_pool) > 0 && current_pool_index < array_length(current_pool)) {
        show_debug_message("ANCIÓN ACTUAL [" + string(current_pool_index + 1) + "/" + string(array_length(current_pool)) + "]: " + string(current_pool[current_pool_index]));
    } else {
        show_debug_message("CANCIÓN ACTUAL: [NINGUNA]");
    }
    show_debug_message("ESTADO: " + string(music_state));
    show_debug_message("ID DE AUDIO: " + string(audio_id));
    show_debug_message("VOLUMEN: " + string(volume));
    show_debug_message("PAUSADO: " + string(is_paused));
    show_debug_message("IDLE TIMER: " + string(idle_timer) + " frames (" + string(idle_timer/60) + "s)");
}



function PauseMusic() {
    if (audio_id != noone && audio_is_playing(audio_id)) {
        audio_pause_sound(audio_id);
        is_paused = true;
        show_debug_message("Música pausada");
    }
}

function ResumeMusic() {
    if (audio_id != noone && is_paused) {
        audio_resume_sound(audio_id);
        is_paused = false;
        show_debug_message("Música reanudada");
    }
}

function StopMusic() {
    if (audio_id != noone) {
        audio_stop_sound(audio_id);
        audio_id = noone;
        is_paused = false;
        song_ended = false;
        music_state = "idle";
        idle_timer = GetBiasedIdleTime() * 60;
        show_debug_message(" Música detenida");
    }
}

function NextTrack() {
    if (array_length(current_pool) > 0) {
        current_pool_index++;
        if (current_pool_index >= array_length(current_pool)) {
            current_pool_index = 0;
            current_pool = shuffle_array(current_pool);
        }
        if (audio_id != noone) {
            audio_stop_sound(audio_id);
            audio_id = noone;
        }
        music_state = "idle";
        idle_timer = 10;
    }
}

function PreviousTrack() {
    if (array_length(current_pool) > 0) {
        current_pool_index--;
        if (current_pool_index < 0) {
            current_pool_index = array_length(current_pool) - 1;
        }
        if (audio_id != noone) {
            audio_stop_sound(audio_id);
            audio_id = noone;
        }
        music_state = "idle";
        idle_timer = 10;
    }
}

function SetVolume(_new_volume) {
    volume = clamp(_new_volume, 0, 1);
    if (audio_id != noone && music_state == "playing") {
        audio_sound_gain(audio_id, volume, 0);
        last_volume = volume;
    }
    show_debug_message("Volumen cambiado a: " + string(volume));
}

function SetIdleTimes(_min_seconds, _max_seconds) {
    idle_time_min = _min_seconds;
    idle_time_max = _max_seconds;
    show_debug_message("Tiempo de silencio: " + string(_min_seconds) + "s - " + string(_max_seconds) + "s");
}

function SetBias(_bias_value) {
    global.idle_bias = clamp(_bias_value, 0.1, 0.9);
    show_debug_message("sesgo de silencio: " + string(global.idle_bias));
}

function SetFadeSpeed(_in_speed, _out_speed) {
    if (_in_speed != undefined) fade_in_speed = _in_speed;
    if (_out_speed != undefined) fade_out_speed = _out_speed;
    show_debug_message("Fade in: " + string(fade_in_speed) + " | Fade out: " + string(fade_out_speed));
}

function RefreshPool() {
    BuildPool();
    music_state = "idle";
    idle_timer = GetBiasedIdleTime() * 60;
    if (audio_id != noone) {
        audio_stop_sound(audio_id);
        audio_id = noone;
    }
}

function ForcePlayNow() {
    music_state = "idle";
    idle_timer = 5;
}

function GetCurrentTrack() {
    if (array_length(current_pool) > 0 && current_pool_index < array_length(current_pool)) {
        return current_pool[current_pool_index];
    }
    return noone;
}

function GetCurrentPool() {
    return current_pool;
}

function GetPoolSize() {
    return array_length(current_pool);
}

function IsMusicPlaying() {
    return audio_id != noone && audio_is_playing(audio_id);
}

function GetMusicState() {
    return music_state;
}
