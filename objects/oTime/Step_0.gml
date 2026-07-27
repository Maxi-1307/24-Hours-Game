if (!global.time_paused) {
    global.game_minutes += global.time_speed;
}

var total = floor(global.game_minutes);

var hours = (total div 60) mod 24;
var minutes = total mod 60;

var h = string_format(hours, 2, 0);
var m = string_format(minutes, 2, 0);

//show_debug_message( h + ":" + m);