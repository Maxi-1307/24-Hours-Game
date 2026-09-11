function PlayerWalk(_path_array, _callback) {
    show_debug_message("PlayerWalk llamado. Waypoints: " + string(array_length(_path_array)) + " | Callback: " + string(_callback));

    with (oPlayer) {
        move_callback = _callback;
        global.CanMove = false;

        waypoint_list = _path_array;
        waypoint_index = 0;
        state = PLAYER_STATE.AUTO_MOVE;
    }
}

function PlayerWalkTo(_tx, _ty, _callback, _spd = 1, _final_x = undefined, _final_y = undefined) {
    var _path = path_add();
    var _success = mp_grid_path(global.pf_grid, _path, x, y, _tx, _ty, true);

    if (_success) {
        show_debug_message("Path encontrado con " + string(path_get_number(_path)) + " puntos.");

        var _wp_list = [];
        var _n = path_get_number(_path);

        for (var i = 1; i < _n; i++) { // i=1 salta el punto de partida
            array_push(_wp_list, {
                x: path_get_point_x(_path, i),
                y: path_get_point_y(_path, i),
                spd: _spd,
                is_lerp: false
            });
        }

        if (_final_x != undefined && _final_y != undefined) {
            array_push(_wp_list, {
                x: _final_x,
                y: _final_y,
                spd: 0.2,
                is_lerp: true
            });
        }

        path_delete(_path);
        PlayerWalk(_wp_list, _callback);
    } else {
        show_debug_message("No se encontró camino hacia el destino.");
        path_delete(_path);
    }
}