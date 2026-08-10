var _ancho_deteccion = 25;
var _largo_vista = 40;
var _inicio_morro = 22;

var _x1, _y1, _x2, _y2;

if (direction == 0 || direction == 180) {
    _x1 = x + lengthdir_x(_inicio_morro, direction);
    _x2 = x + lengthdir_x(_inicio_morro + _largo_vista, direction);
    _y1 = y - _ancho_deteccion;
    _y2 = y + _ancho_deteccion;
} else {
    _x1 = x - _ancho_deteccion;
    _x2 = x + _ancho_deteccion;
    _y1 = y + lengthdir_y(_inicio_morro, direction);
    _y2 = y + lengthdir_y(_inicio_morro + _largo_vista, direction);
}

var _obs_front = collision_rectangle(
    _x1 + 5,
    _y1 + 5,
    _x2 + 5,
    _y2 + 5,
    [oPlayer, oCar, oBus],
    false,
    true
);

// Detectar parada delante
var _bus_stop_ahead = collision_rectangle(
    _x1 + 10,
    _y1 + 10,
    _x2 + 10,
    _y2 + 10,
    oBusStop,
    false,
    true
);

var _on_zebra = instance_place(x, y, oZebraWay);
var _on_turn = instance_place(x, y, oTurnCarMarkWay);

var _on_stop_way = instance_place(x, y, oBusStop);
var _other_car_in_intersection = noone;
var _car_ahead_intersection = noone;

if (_on_stop_way != noone) {

    var _distancia_busqueda = 130;
    var _mejor_distancia = _distancia_busqueda;
    _car_ahead_intersection = noone;

    with (oCar) {

        if (id != other.id) {

            var _dist = point_distance(other.x, other.y, x, y);

            var _dir = point_direction(other.x, other.y, x, y);

            var _diferencia = angle_difference(other.direction, _dir);

            if (abs(_diferencia) < 45) {

                if (_dist < _mejor_distancia) {
                    _mejor_distancia = _dist;
                    other._car_ahead_intersection = id;
                }
            }
        }
    }
}

var _player_in_safe_zone = false;

if (instance_exists(oPlayer)) {
    if (place_meeting(oPlayer.x, oPlayer.y, oZebraWay)) {
        _player_in_safe_zone = true;
    }
}

if (bus_stopped)
{
    bus_stop_timer += 0.1;

    _should_stop = true;

    if (bus_stop_timer >= 20)
    {
        _should_stop = false;
        bus_stopped = false;
        bus_stop_timer = 0;

        bus_stop_cooldown = true;
    }
}


if (_bus_stop_ahead == noone)
{
    bus_stop_cooldown = false;
}


if (_bus_stop_ahead != noone
&& !bus_stopped
&& !bus_stop_cooldown)
{
    bus_stopped = true;
    _should_stop = true;
}

if (_obs_front != noone) {

    _should_stop = true;

    if (distance_to_object(_obs_front) < 55) {
        _emergency_stop = true;
    }

    if (_obs_front.object_index == oPlayer
    && !honked
    && !_player_in_safe_zone) {

        if (irandom(10) > 7) {
            audio_play_sound(sfx_Car_Horn, 10, false);
        }

        honked = true;
    }
}

var _zebra_ahead = collision_rectangle(
    _x1,
    _y1,
    _x2,
    _y2,
    oZebraWay,
    false,
    true
);

if (_zebra_ahead != noone && _player_in_safe_zone) {
    _should_stop = true;
}

if (_other_car_in_intersection != noone) {

    if (_car_ahead_intersection == id) {

        if (direction == 0) {

            if (Get_Distance(x, x - 62)
            < Get_Distance(
                _car_ahead_intersection.y,
                _car_ahead_intersection.y - 62
            )) {
                _should_stop = false;
            }
            else {
                _should_stop = true;
            }
        }

        if (direction == 90) {

            if (Get_Distance(y, y - 62)
            < Get_Distance(
                _car_ahead_intersection.x,
                _car_ahead_intersection.x - 62
            )) {
                _should_stop = false;
            }
            else {
                _should_stop = true;
            }
        }
    }
    else {

        if (direction == 0) {

            if (Get_Distance(x, x - 62)
            < Get_Distance(
                _car_ahead_intersection.y,
                _car_ahead_intersection.y - 62
            )) {
                _should_stop = false;
            }
            else {
                _should_stop = true;
            }
        }

        if (direction == 90) {

            if (Get_Distance(y, y - 62)
            < Get_Distance(
                _car_ahead_intersection.x,
                _car_ahead_intersection.x - 62
            )) {
                _should_stop = false;
            }
            else {
                _should_stop = true;
            }
        }
    }

    if (point_distance(
        x,
        y,
        _other_car_in_intersection.x,
        _other_car_in_intersection.y
    ) < 75) {

        _emergency_stop = true;
    }
}

if (_emergency_stop) {

    speed = 0;

}
else if (_should_stop) {

    speed = lerp(speed, 0, 0.5);

}
else {

    speed = lerp(speed, max_speed, 0.05);

    if (speed > 0.5) {
        honked = false;
    }
}

if (_on_turn != noone) {

    if (last_marker != _on_turn
    && direction == _on_turn.direccion_afectada) {

        if (random(1) < _on_turn.probabilidad_giro) {

            direction = _on_turn.new_dir;
            image_angle = direction;

            x = lerp(x, _on_turn.x, 0.5);
            y = lerp(y, _on_turn.y, 0.5);
        }

        last_marker = _on_turn;
    }

}
else {

    last_marker = noone;
}

if (x < -300
|| x > room_width + 300
|| y < -300
|| y > room_height + 300) {

    instance_destroy();
}