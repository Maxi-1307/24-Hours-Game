if ((
(global.game_minutes >= 258 && global.game_minutes <= 259.2)
||
global.game_minutes >= 162 && global.game_minutes <= 163.2)
)
{
	if (global.bus.room_index >= array_length(global.bus_route))
	{
	    global.bus.room_index = 0;
	    global.bus.segment_index = 0;
	    global.bus.segment_time = 0;
	    exit;
	}
	var _room_data = global.bus_route[global.bus.room_index];

	var _segments = _room_data[1];

	if (global.bus.segment_indsex >= array_length(_segments))
	{
	    global.bus.segment_index = 0;
	}

	var _segment = _segments[global.bus.segment_index];

	var _delay = _segment[0];

	global.bus.segment_time += 0.01;

	if (global.bus.segment_time >= _delay)
	{
	    global.bus.segment_time -= _delay;

	    global.bus.segment_index++;
		if (_room_data[0] == room)
		{
			exit;
		}


	    if (global.bus.segment_index >= array_length(_segments))
	    {
	        global.bus.segment_index = 0;

	        global.bus.room_index++;


	        if (global.bus.room_index >= array_length(global.bus_route))
	        {
	            global.bus.room_index = 0;
	        }
	    }
	}
}