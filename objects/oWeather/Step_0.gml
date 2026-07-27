if (keyboard_check_pressed(ord("F"))) {
    global.game_minutes += 396;
    aply = false;
}

if (global.game_minutes >= next_minute_event) {
    index = (index + 1) mod array_length(global.WEATHER);
    global.CURRENT_WEATHER = global.WEATHER[index];
    next_minute_event += 396;
    aply = false; 
}

if (global.Is_Indoors != last_indoors_state) {
    aply = false;
    last_indoors_state = global.Is_Indoors;
}

if (!aply) {
    audio_stop_sound(sfx_rain);
    alarm[1] = -1;
    alarm[2] = -1;
    flash_alpha = 0;
    
    if (rain_instance != undefined) {
        part_system_destroy(rain_instance);
        rain_instance = undefined;
    }

    if (global.Is_Indoors) {
        oTimeAtmosphere.addr = 0; oTimeAtmosphere.addg = 0; oTimeAtmosphere.addb = 0;
    }

    switch (global.CURRENT_WEATHER) {
        case "normal":
            if (!global.Is_Indoors) { oTimeAtmosphere.addr = 0; oTimeAtmosphere.addg = 0; oTimeAtmosphere.addb = 0; }
            break;

        case "soleado":
            if (!global.Is_Indoors) { oTimeAtmosphere.addr = 10; oTimeAtmosphere.addg = 5; oTimeAtmosphere.addb = 0; }
            break;

        case "nublado":
            if (!global.Is_Indoors) { oTimeAtmosphere.addr = -8; oTimeAtmosphere.addg = -8; oTimeAtmosphere.addb = -2; }
            break;

        case "vientoso":
            if (!global.Is_Indoors) {
                oTimeAtmosphere.addr = 4; oTimeAtmosphere.addg = 0; oTimeAtmosphere.addb = 0;
                var dir = choose(0, 1);
                if (dir == 1) audio_play_sound(sfxWind_Left, 10, false);
                else audio_play_sound(sfxWind_Right, 10, false);
            }
            break;

	case "lluvia":
            if (!global.Is_Indoors) {
                oTimeAtmosphere.addr = 0; oTimeAtmosphere.addg = 0; oTimeAtmosphere.addb = 0;
                rain_instance = part_system_create(psRain);
                var _snd = audio_play_sound(sfx_rain, 1, true);
                audio_sound_gain(_snd, 1.0, 0); 
                
                alarm[1] = game_get_speed(gamespeed_fps) * irandom_range(10, 12);
                alarm[2] = game_get_speed(gamespeed_fps) * 5;
            } else {
                var _snd = audio_play_sound(sfx_rain, 1, true);
                audio_sound_gain(_snd, 0.2, 0); 
            }
            break;

        case "tormentoso":
            if (!global.Is_Indoors) {
                oTimeAtmosphere.addr = 0; oTimeAtmosphere.addg = 0; oTimeAtmosphere.addb = 0;
                rain_instance = part_system_create(psRain);
                var _snd = audio_play_sound(sfx_rain, 1, true);
                audio_sound_gain(_snd, 1.0, 0);
                
                alarm[2] = game_get_speed(gamespeed_fps) * 5;
            } else {
                var _snd = audio_play_sound(sfx_rain, 1, true);
                audio_sound_gain(_snd, 0.2, 0);
            }
            alarm[1] = game_get_speed(gamespeed_fps) * irandom_range(5, 15);
            break;
            
        case "nevada":
            if (!global.Is_Indoors) {
                oTimeAtmosphere.addr = 0; oTimeAtmosphere.addg = 0; oTimeAtmosphere.addb = 0;
                rain_instance = part_system_create(psSnow);
            }
            break;
    }
    aply = true; 
}

if (rain_instance != undefined) {
    var _cam_x = camera_get_view_x(view_camera);
    var _cam_y = camera_get_view_y(view_camera);
    var _cam_w = camera_get_view_width(view_camera);
    part_system_position(rain_instance, _cam_x + (_cam_w / 2), _cam_y - 20);
}