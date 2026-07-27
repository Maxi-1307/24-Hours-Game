var total = floor(global.game_minutes);
var hours   = (total div 60) mod 24;
var minutes = total mod 60;
var time = hours + (minutes / 60);


if (time >= 6.5 && time < 7.5){
    period = "dawn";
    target_color = make_color_rgb(130, 90, 160); 
    var t = (time - 6.5) / 1.0; 
    target_alpha = lerp(0.35, 0.18, t); 
}else if (time >= 7.5 && time < 10){
    period = "morning";
    target_color = make_color_rgb(130, 90, 160);
    target_alpha = 0.18; 
}else if (time >= 10 && time < 13){
    period = "day";
    target_color = c_black;
    target_alpha = 0;
}else if (time >= 13 && time < 17.0){
    period = "afternoon";
    target_color = make_color_rgb(255, 210, 140);
    target_alpha = 0.20;
}else if (time >= 17.0 && time < 19.5){

    period = "afternoon_fade";
    var t = (time - 17.0) / 2.5;
    target_color = merge_color(make_color_rgb(255, 210, 140), make_color_rgb(230, 120, 40), t);
    target_alpha = 0.20;
}else if (time >= 19.5 && time < 20.5){
    period = "sunset";
    var t = (time - 19.5) / 1.0; 
    target_color = merge_color(make_color_rgb(230, 120, 40), make_color_rgb(20, 15, 45), t); 
    target_alpha = lerp(0.20, 0.50, t); 
}else if (time >= 20.5 && time < 22){
    period = "early_night";
    var t = (time - 20.5) / 1.5;
    target_color = merge_color(make_color_rgb(20, 15, 45), make_color_rgb(0, 0, 0), t);
    target_alpha = lerp(0.50, 0.70, t);
}else{
    period = "night";
    target_color = make_color_rgb(0, 0, 0);
    target_alpha = 0.70;
}

if (period == "night" || period == "early_night" || period == "sunset") {
    if (!audio_is_playing(sfx_crickets)) {
        audio_play_sound(sfx_crickets, 1, true); 
    }
} else {
    if (audio_is_playing(sfx_crickets)) {
        audio_stop_sound(sfx_crickets); 
    }
}

if (global.Is_Indoors){
    target_alpha = lerp(target_alpha, 0.2, 0.85);
}

if (global.Loaded_Game){
    current_alpha = target_alpha;
    current_color = target_color;
    global.Loaded_Game = false;
}

current_alpha = lerp(current_alpha, target_alpha, 0.008);
current_color = merge_color(current_color, target_color, 0.008);
