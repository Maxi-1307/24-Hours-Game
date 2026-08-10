max_speed = random_range(1.5, 2.5);
speed = max_speed;
honked = false;
image_speed = 0;
last_marker = noone;
visible = true;


image_blend = choose(c_white, c_gray, #3d5afe, #f44336, #ffeb3b, #4caf50);

bus_stop_timer = 0;
bus_stopped = false;

_should_stop = false;
_emergency_stop = false;
bus_stop_cooldown = false;
