if (global.bus.room_index >= array_length(global.bus_route))
{
    exit;
}

var _room = global.bus_route[global.bus.room_index][0];

if (_room == room)
{
	global.bus.room_index++;
}
instance_destroy();