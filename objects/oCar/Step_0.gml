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

var _obs_front = collision_rectangle(_x1, _y1, _x2, _y2, [oPlayer, oCar], false, true);
var _on_zebra  = instance_place(x, y, oZebraWay);
var _on_turn   = instance_place(x, y, oTurnCarMarkWay);

var _on_stop_way = instance_place(x, y, oStopWay);
var _other_car_in_intersection = noone;

if (_on_stop_way != noone) {

    var _frente_x = x + lengthdir_x(50, direction);
    var _frente_y = y + lengthdir_y(50, direction);

    var _largo_sensor_lateral = 130; 
    
    var _izq_x = _frente_x + lengthdir_x(_largo_sensor_lateral, direction + 90);
    var _izq_y = _frente_y + lengthdir_y(_largo_sensor_lateral, direction + 90);
    var _sensor_izq = collision_line(_frente_x, _frente_y, _izq_x, _izq_y, oCar, false, true);
    
    var _der_x = _frente_x + lengthdir_x(_largo_sensor_lateral, direction - 90);
    var _der_y = _frente_y + lengthdir_y(_largo_sensor_lateral, direction - 90);
    var _sensor_der = collision_line(_frente_x, _frente_y, _der_x, _der_y, oCar, false, true);
    
    if (_sensor_izq != noone) _other_car_in_intersection = _sensor_izq;
    else if (_sensor_der != noone) _other_car_in_intersection = _sensor_der;
}

var _player_in_safe_zone = false;
if (instance_exists(oPlayer)) {
    if (place_meeting(oPlayer.x, oPlayer.y, oZebraWay)) _player_in_safe_zone = true;
}

var _should_stop = false;
var _emergency_stop = false;

if (_obs_front != noone) {
    _should_stop = true;
    if (distance_to_object(_obs_front) < 55) _emergency_stop = true;
    
    if (_obs_front.object_index == oPlayer && !honked && !_player_in_safe_zone) {
        if (irandom(10) > 7) audio_play_sound(sfx_Car_Horn, 10, false);
        honked = true;
    }
}

var _zebra_ahead = collision_rectangle(_x1, _y1, _x2, _y2, oZebraWay, false, true);
if (_zebra_ahead != noone && _player_in_safe_zone) _should_stop = true;

if (_other_car_in_intersection != noone) {
    _should_stop = true;
    
    if (point_distance(x, y, _other_car_in_intersection.x, _other_car_in_intersection.y) < 75) {
        _emergency_stop = true;
    }
}

if (_emergency_stop) {
    speed = 0; 
} else if (_should_stop) {
    speed = lerp(speed, 0, 0.5); 
} else {
    speed = lerp(speed, max_speed, 0.05); 
    if (speed > 0.5) honked = false; 
}

if (_on_turn != noone) {
    if (last_marker != _on_turn && direction == _on_turn.direccion_afectada) {
        if (random(1) < _on_turn.probabilidad_giro) {
            direction = _on_turn.new_dir;
            image_angle = direction;
            
            x = lerp(x, _on_turn.x, 0.5);
            y = lerp(y, _on_turn.y, 0.5);
        }
        last_marker = _on_turn; 
    }
} else {
    last_marker = noone; 
}

if (x < -300 || x > room_width + 300 || y < -300 || y > room_height + 300) {
    instance_destroy();
}
