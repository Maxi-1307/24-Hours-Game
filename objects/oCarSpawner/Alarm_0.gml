if (!place_meeting(x, y, oCar) && !place_meeting(x+30,y+30,oPlayer)) && !place_meeting(x-30,y-30,oPlayer) {
    var _car = instance_create_layer(x, y, "Traffic", oCar);
    _car.direction = image_angle;
    _car.image_angle = image_angle;
}

alarm[0] = game_get_speed(gamespeed_fps) * random_range(3, 9);
