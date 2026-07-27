image_speed = 0;
image_xscale = 1.4;
image_yscale = 1.4;
image_alpha = 0;
if (!variable_global_exists("Wind")) {
    global.Wind = 0.1; 
}
viento_duracion = 60;

angulo_copa = 0;

sys_hojas_aire = part_system_create();
part_system_depth(sys_hojas_aire, -9999); 

sys_hojas_suelo = part_system_create();
part_system_depth(sys_hojas_suelo, -y + 2); 

part_hoja_cae = part_type_create();
part_type_sprite(part_hoja_cae, sprLeaf, false, false, false);
part_type_speed(part_hoja_cae, 0.5, 0.5, 0, 0);          
part_type_orientation(part_hoja_cae, 0, 360, 1, 2, false); 
part_type_gravity(part_hoja_cae, 0, 270);                

part_hoja_suelo = part_type_create();
part_type_sprite(part_hoja_suelo, sprLeaf, false, false, false);
part_type_speed(part_hoja_suelo, 0, 0, 0, 0);            
part_type_orientation(part_hoja_suelo, 0, 360, 0, 0, false); 
part_type_life(part_hoja_suelo, 240, 240); 
part_type_alpha3(part_hoja_suelo, 1, 1, 0); 

hojas_en_espera = ds_list_create();
