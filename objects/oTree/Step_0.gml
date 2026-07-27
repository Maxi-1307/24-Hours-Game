depth = -y;
viento_duracion--;

if (viento_duracion <= 0) {

    var direccion_viento = choose(-1, 1);
    var fuerza_base = random_range(0.1, 1.0);
    global.Wind = fuerza_base * direccion_viento;
    
    var frames_espera = 600 + ((1.0 - fuerza_base) / 0.9) * 1800;
    viento_duracion = frames_espera;
    
    soplando_tiempo = 180; 
}

var spawn_y_base = y - 35; 
switch(image_index) {
    case 0: spawn_y_base = y - 25; break; 
    case 1: spawn_y_base = y - 25; break; 
    case 2: spawn_y_base = y - 35; break; 
    default: spawn_y_base = y - 35; break;
}

if (variable_instance_exists(id, "soplando_tiempo") && soplando_tiempo > 0) {
    soplando_tiempo--;
    
    var factor_desvanecimiento = (soplando_tiempo / 180);
    angulo_copa = sin(current_time * 0.006) * (global.Wind * 10) * factor_desvanecimiento;
    
    if (random(100) < (abs(global.Wind) * 3)) { 
        var spawn_x = x + irandom_range(-35, 35); 
        var spawn_y = spawn_y_base; 
        
        part_type_subimage(part_hoja_cae, image_index);
        part_type_subimage(part_hoja_suelo, image_index);
        
        var variacion_extra = irandom_range(5, 15);
        var distancia_total = 75 + variacion_extra; 
        var frames_vida = distancia_total * 2; 
        
        part_type_life(part_hoja_cae, frames_vida, frames_vida);
        part_particles_create(sys_hojas_aire, spawn_x, spawn_y, part_hoja_cae, 1);
        
        var nueva_hoja = {
            hx: spawn_x,
            hy: spawn_y + distancia_total, 
            tiempo: frames_vida,
            fuerza_empuje: global.Wind
        };
        ds_list_add(hojas_en_espera, nueva_hoja);
    }
} else {
    angulo_copa = 0;
}

var fuerza_viento_hoja = global.Wind * 20; 
var oscilacion = sin(current_time * 0.005) * 10;
var dir_final = 270 + oscilacion + fuerza_viento_hoja;
part_type_direction(part_hoja_cae, dir_final - 4, dir_final + 4, 0, 0);

for (var i = ds_list_size(hojas_en_espera) - 1; i >= 0; i--) {
    var hoja = hojas_en_espera[| i];
    hoja.tiempo--;
    
    hoja.hx += hoja.fuerza_empuje * 0.4; 
    
    if (hoja.tiempo <= 0) {
        part_particles_create(sys_hojas_suelo, hoja.hx, hoja.hy, part_hoja_suelo, 1);
        ds_list_delete(hojas_en_espera, i);
    }
}
