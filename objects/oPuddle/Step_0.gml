if (global.CURRENT_WEATHER == "lluvia" || global.CURRENT_WEATHER == "tormentoso" && !estado_desvanecer) {
    if (alpha_dinamico < 1.0) {
        alpha_dinamico += 0.02;
    }
} else {
    estado_desvanecer = true;
    if (alpha_dinamico > 0.0) {
        alpha_dinamico -= 0.02;
    } else {
        instance_destroy();
        exit;
    }
}

if (alpha_dinamico > 0.3 && place_meeting(x, y, oPlayer) && (oPlayer.xspd != 0 || oPlayer.yspd != 0)) {
    if (puddle_snd_timer <= 0) {
        audio_play_sound(sfx_puddle_step, 1, false, 0.4);
        puddle_snd_timer = 15;
    }
}

if (puddle_snd_timer > 0) {
    puddle_snd_timer--;
}

if (!instance_exists(oTextBox) && !instance_exists(oInventory) && alpha_dinamico > 0.5) {
    if (point_distance(x, y, oPlayer.x, oPlayer.y) < 20 && keyboard_check_pressed(global.ConfirmKey)) {
        var _tb = instance_create_layer(0, 0, "Dialogue", oTextBox);
        with(_tb) {
            var _etiqueta_al_azar = choose("puddle_phrase_1", "puddle_phrase_2", "puddle_phrase_3", "puddle_phrase_4");
            text[0] = _T(_etiqueta_al_azar);
        
            for(var i = 0; i < 6; i++){
                speaker_sprite[i] = noone;
                txtb_snd[i] = sfx_text;
                txtb_color[i] = c_white;
            }
        }
    }
}
