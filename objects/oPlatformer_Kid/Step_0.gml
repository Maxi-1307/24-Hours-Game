if(global.Platformer_Can_Move){
	var tecla_derecha, tecla_izquierda;
	if (dir_gravedad == 1) {
		tecla_derecha = keyboard_check(global.RightKey);
		tecla_izquierda = keyboard_check(global.LeftKey);
	} else {
		tecla_derecha = keyboard_check(global.LeftKey);
		tecla_izquierda = keyboard_check(global.RightKey);
	}
	
	var tecla_salto = keyboard_check_pressed(vk_space); 
	var tecla_accion = keyboard_check_pressed(global.ConfirmKey); 
	var tecla_drop = keyboard_check_pressed(global.CancelKey); 

	var direccion = tecla_derecha - tecla_izquierda;
	var _vel_final = velocidad_caminar + velocidad_bonus;

	if (cargando_objeto) {
	    _vel_final -= penalizacion_velocidad; 
	}

	vel_horizontal = direccion * _vel_final;

	if (vel_horizontal != 0) {
	    image_xscale = sign(vel_horizontal) * 2; 
	}

	var en_el_suelo = false;
	var _lista_suelos = ds_list_create();
	var _num_suelos = instance_place_list(x, y + dir_gravedad, oWall, _lista_suelos, false);

	for (var i = 0; i < _num_suelos; i++) {
	    var _inst = _lista_suelos[| i];
	    if (_inst != objeto_cargado_id) {
	        en_el_suelo = true; 
	        break;
	    }
	}
	ds_list_destroy(_lista_suelos);

	if (!en_el_suelo) {
	    vel_vertical += (gravedad * dir_gravedad); 
	} else {
	    vel_vertical = 0; 
	    if (tecla_salto) {
	        if (cargando_objeto) {
	            vel_vertical = (fuerza_salto * dir_gravedad) * 0.65; 
	        } else {
	            vel_vertical = (fuerza_salto * dir_gravedad); 
	        }
	    }
	}

	var _lista_muros_h = ds_list_create();
	var _num_muros_h = instance_place_list(x + vel_horizontal, y, oWall, _lista_muros_h, false);
	var _muro_horizontal_real = noone;

	for (var i = 0; i < _num_muros_h; i++) {
	    var _inst = _lista_muros_h[| i];
	    if (_inst != objeto_cargado_id) {
	        _muro_horizontal_real = _inst;
	        break;
	    }
	}
	ds_list_destroy(_lista_muros_h);

	if (_muro_horizontal_real != noone) {
	    while (true) {
	        var _check_lista = ds_list_create();
	        var _check_num = instance_place_list(x + sign(vel_horizontal), y, oWall, _check_lista, false);
	        var _colision_real = false;
	        for (var j = 0; j < _check_num; j++) {
	            if (_check_lista[| j] != objeto_cargado_id) { _colision_real = true; break; }
	        }
	        ds_list_destroy(_check_lista);
        
	        if (!_colision_real) {
	            x += sign(vel_horizontal);
	        } else {
	            break;
	        }
	    }
	    vel_horizontal = 0; 
	}
	x += vel_horizontal; 

	var _lista_muros_v = ds_list_create();
	var _num_muros_v = instance_place_list(x, y + vel_vertical, oWall, _lista_muros_v, false);
	var _muro_vertical_real = noone;

	for (var i = 0; i < _num_muros_v; i++) {
	    var _inst = _lista_muros_v[| i];
	    if (_inst != objeto_cargado_id) {
	        _muro_vertical_real = _inst;
	        break;
	    }
	}
	ds_list_destroy(_lista_muros_v);

	if (_muro_vertical_real != noone) {
	    while (true) {
	        var _check_lista = ds_list_create();
	        var _check_num = instance_place_list(x, y + sign(vel_vertical), oWall, _check_lista, false);
	        var _colision_real = false;
	        for (var j = 0; j < _check_num; j++) {
	            if (_check_lista[| j] != objeto_cargado_id) { _colision_real = true; break; }
	        }
	        ds_list_destroy(_check_lista);
        
	        if (!_colision_real) {
	            y += sign(vel_vertical);
	        } else {
	            break;
	        }
	    }
	    vel_vertical = 0; 
	}
	y += vel_vertical; 

	var _lado_mirada = sign(image_xscale);

	if (tecla_accion) {
    
	    if (!cargando_objeto && !cargando_globo) {
	        var _caja_cerca = instance_place(x + (_lado_mirada * 24), y, oPlatformer_Box);
	        if (_caja_cerca != noone && !_caja_cerca.siendo_cargada && !_caja_cerca.tiene_globo) {
	            cargando_objeto = true;
	            objeto_cargado_id = _caja_cerca;
	            _caja_cerca.siendo_cargada = true;
	        }
        
	        if (!cargando_objeto) {
	            var _globo_cerca = instance_place(x + (_lado_mirada * 24), y, oPlatformer_Balloon);
	            if (_globo_cerca != noone && !_globo_cerca.siendo_cargado && _globo_cerca.objeto_atado_id == noone) {
	                cargando_globo = true;
	                globo_cargado_id = _globo_cerca;
	                _globo_cerca.siendo_cargado = true;
	            }
	        }
	    }
	    else if (cargando_globo) {
	        var _caja_enfrente = instance_place(x + (_lado_mirada * 24), y, oPlatformer_Box);
	        if (_caja_enfrente != noone && !_caja_enfrente.tiene_globo && !_caja_enfrente.siendo_cargada) {
	            _caja_enfrente.tiene_globo = true;
	            _caja_enfrente.globo_id = globo_cargado_id;
	            _caja_enfrente.altura_ancla_y = _caja_enfrente.y; 
            
	            globo_cargado_id.objeto_atado_id = _caja_enfrente;
	            globo_cargado_id.siendo_cargado = false;
            
	            cargando_globo = false;
	            globo_cargado_id = noone;
	        }
	    }
	}

	if (keyboard_check(global.ConfirmKey) && cargando_globo && !place_meeting(x, y + dir_gravedad, oWall)) {
	    if (!esta_flotando_globo) {
	        esta_flotando_globo = true;
	        altura_ancla_flotar = y; 
	    }
    
	    var _altura_maxima = altura_ancla_flotar - (40 * dir_gravedad); 
    
	    if (dir_gravedad == 1) {
	        if (y > _altura_maxima) { vel_vertical = -2.5; } 
			else { y = _altura_maxima; vel_vertical = 0; }
	    } else {
	        if (y < _altura_maxima) { vel_vertical = 2.5; } 
			else { y = _altura_maxima; vel_vertical = 0; }
	    }
	} else if (!keyboard_check(global.ConfirmKey)) {
	    esta_flotando_globo = false; 
	}

	if (tecla_drop) {
	    if (cargando_objeto && instance_exists(objeto_cargado_id)) {
	        objeto_cargado_id.x = x + (_lado_mirada * 16);
	        objeto_cargado_id.y = y;
	        objeto_cargado_id.siendo_cargada = false;
	        cargando_objeto = false;
	        objeto_cargado_id = noone;
	    }
    
	    if (cargando_globo && instance_exists(globo_cargado_id)) {
	        globo_cargado_id.x = x + (_lado_mirada * 16);
	        globo_cargado_id.y = y - (16 * dir_gravedad);
	        globo_cargado_id.siendo_cargado = false;
	        cargando_globo = false;
	        globo_cargado_id = noone;
	        esta_flotando_globo = false;
	    }
    
	    if (!cargando_objeto && !cargando_globo) {
	        var _caja_enfrente = instance_place(x + (_lado_mirada * 24), y, oPlatformer_Box);
	        if (_caja_enfrente != noone && _caja_enfrente.tiene_globo) {
	            var _globo_recuperado = _caja_enfrente.globo_id;
	            if (instance_exists(_globo_recuperado)) {
	                _globo_recuperado.objeto_atado_id = noone;
	                cargando_globo = true;
	                globo_cargado_id = _globo_recuperado;
	                _globo_recuperado.siendo_cargado = true;
	            }
	            _caja_enfrente.tiene_globo = false;
	            _caja_enfrente.globo_id = noone;
	        }
	    }
	}

	if (cargando_objeto && instance_exists(objeto_cargado_id)) {
	    objeto_cargado_id.x = x + (_lado_mirada * 8); 
	    objeto_cargado_id.y = y; 
		objeto_cargado_id.image_yscale = dir_gravedad;
	}

	if (cargando_globo && instance_exists(globo_cargado_id)) {
	    globo_cargado_id.x = x + (_lado_mirada * 8); 
	    globo_cargado_id.y = y - (12 * dir_gravedad); 
	}
}
