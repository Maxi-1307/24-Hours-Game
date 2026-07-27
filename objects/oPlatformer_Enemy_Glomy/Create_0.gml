velocidad_patrulla = 1;  
velocidad_embestida = 3.5; 
direccion = 1;

vel_horizontal = 0;
vel_vertical = 0;
gravedad = 0.4;


estado = "patrulla";

rango_vision = 120;
image_speed = 0;
if(room == rm_Platformer_lvl_weird){
	image_speed = 1;
	image_index = 1;
	image_speed = 0;
}
image_xscale = 2;
image_yscale = 2;
