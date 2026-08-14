if ((
(global.game_minutes >= 258 && global.game_minutes <= 259.2)
||
global.game_minutes >= 162 && global.game_minutes <= 163.2)
)
{
	if (global.bus.room_index >= array_length(global.bus_route))
	{
	    exit;
	}

	var _room = global.bus_route[global.bus.room_index][0];

	if ((!global.bus.started || _room == room) && !instance_exists(oBus))
	{
	    var _room_data = global.bus_route[global.bus.room_index];

	    var _bus_room = _room_data[0];


	    if (_bus_room != room)
	    {
	        exit;
	    }


	    var _segments = _room_data[1];

	    var _spawner = noone;

	    var _spawner_count = instance_number(oCarSpawner);


	    for (var i = 0; i < _spawner_count; i++)
	    {
	        var _check_spawner =
	            instance_find(oCarSpawner, i);


	        if (abs(angle_difference(
	            _check_spawner.image_angle,
	            _segments[0][1]
	        )) < 0.01)
	        {
	            _spawner = _check_spawner;
	            break;
	        }
	    }


	    if (_spawner == noone)
	    {
	        exit;
	    }

	    var _new_bus = instance_create_layer(
	        _spawner.x,
	        _spawner.y,
	        "Traffic",
	        oBus
	    );


	    _new_bus.speed = _new_bus.max_speed;

	    if (room == rm_town_street_2_down_1)
	    {
			if (global.bus.segment_index == 0)
			{
				_new_bus.direction = -90;
				_new_bus.image_angle = -90;
			}
			else if (global.bus.segment_index == 1)
			{
				_new_bus.direction = 0;
				_new_bus.image_angle = 0;
			}
	    }
	    else if (room == rm_town_street_3_down)
	    {
	        if (global.bus.segment_index == 0)
	        {
	            _new_bus.direction = 0;
	            _new_bus.image_angle = 0;
	        }
	        else if (global.bus.segment_index == 1)
	        {
	            _new_bus.direction = 90;
	            _new_bus.image_angle = 90;
	        }
	    }
	    else if (room == rm_town_street_3)
	    {
	        if (global.bus.segment_index == 0)
	        {
	            _new_bus.direction = 90;
	            _new_bus.image_angle = 90;
	        }
	        else if (global.bus.segment_index == 1)
	        {
	            _new_bus.direction = -90;
	            _new_bus.image_angle = -90;
	        }
	    }
	    else if (room == rm_town_street_2)
	    {
	        if (global.bus.segment_index == 0)
	        {
	            _new_bus.direction = 180;
	            _new_bus.image_angle = 180;
	        }
	        else if (global.bus.segment_index == 1)
	        {
	            _new_bus.direction = 90;
	            _new_bus.image_angle = 90;
	        }
	    }

	    global.bus.started = true;
	}
}