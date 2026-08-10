if (!place_meeting(x, y, oCar) && !place_meeting(x, y, oBus) && point_distance(x, y, oPlayer.x, oPlayer.y) > 100)
{
	var r = irandom_range(0, 1);
	
	if (r == 0)
	{
	    var _car = instance_create_layer(x, y, "Traffic", oCar);

	    _car.direction = image_angle;
	    _car.image_angle = image_angle;
	}
	else
	if (r == 1 && (
    (global.game_minutes >= 258 && global.game_minutes <= 259.2)
    ||
    (global.game_minutes >= 162 && global.game_minutes <= 163.2)
	))
	{
	    var cb = false;
	    var xx = 0;
	    var max_dist = room_width;

	    while (!cb && xx < max_dist)
	    {
	        if (place_meeting(x + xx, y, oBusStop))
	        {
	            cb = true;
	        }
	        else
	        {
	            xx += 1;
	        }
			if (xx >= max_dist) {r = 0;}
	    }

	    if (cb)
	    {
	        var _bus = instance_create_layer(x, y, "Traffic", oBus);

	        _bus.direction = image_angle;
	        _bus.image_angle = image_angle;
	    }
	}
}

alarm[0] = game_get_speed(gamespeed_fps) * random_range(3, 9);