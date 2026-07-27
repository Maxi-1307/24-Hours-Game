if (state == "playing") {
    global.Platformer_Level_Time -= 1 / game_get_speed(gamespeed_fps);
    if (global.Platformer_Level_Time <= 0) {
        global.Platformer_Level_Time = 0;
        herir_jugador();
    }
}

if (level_weird) {
    if (!musica_iniciada) {
        audio_actual = audio_play_sound(sndCollage, 10, false);
        musica_iniciada = true;
    }
}