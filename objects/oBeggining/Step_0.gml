if (intro_state == 1) {
    if (seconds == 0 && minutes == 0 && hours > 0) {
        hours -= 1;
        minutes = 59;
        seconds = 59;
    } 
    else if (seconds == 0 && minutes > 0) {
        minutes -= 1;
        seconds = 59;
    }
}

if (intro_state == 3) {
    fade_alpha += 0.02; 
    if (fade_alpha >= 1) {
        fade_alpha = 1;
        room_goto(rm_house_bedroom);
        New_Game();
        
        var player = instance_create_layer(global.PlayerX, global.PlayerY, "Player", oPlayer);
        player.sprite_index = sprPlayerLeft;
        player.image_angle = 270;
        
        global.CanMove = false;
        global.CanInventory = false;
        
        intro_state = 4;
    }
}

if (intro_state == 4) {
    fade_alpha -= 0.02;
    if (fade_alpha <= 0) {
        fade_alpha = 0;
        alarm[5] = game_get_speed(gamespeed_fps) * 3; 
        intro_state = 5;
    }
}

while (array_length(global.WEATHER) < 12){

    array_push(global.WEATHER, choose(
        "normal",
        "soleado",
        "nublado",
        "tormentoso",
        "lluvia",
        "nevada",
        "vientoso"
    ));
} 
