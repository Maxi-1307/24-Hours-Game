function Bus_Save(_bus, _target_room, _exit_side)
{
    global.buses[0] = {
        c_room: _target_room,
        c_x: _bus.x,
        c_y: _bus.y,
        c_speed: _bus.speed,
        c_direction: _bus.direction,
        c_blend: _bus.image_blend,
        c_exit_side: _exit_side,
        c_last_game_minutes: global.game_minutes
    };

    instance_destroy(_bus);
}