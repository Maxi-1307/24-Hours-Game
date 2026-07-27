timer = 0;
fase = 0;

global.Platformer_Can_Move = false;
global.CanInventory = false;

if (instance_exists(oPlayer)) {
    oPlatformer_Kid.x = 2918;
    oPlatformer_Kid.y = 20;
    oPlatformer_Kid.image_index = 0;
    oPlatformer_Kid.image_angle = 0;
    oPlatformer_Kid.image_xscale = 2;
    oPlatformer_Kid.vel_horizontal = 0;
    oPlatformer_Kid.vel_vertical = 0;
}

mostrar_pantalla_negra = false;
mostrar_ranking = false;
festejo_activo = false;
festejo_timer = 0;
instance_destroy(oPlatformer_Controller);
new_record = false;


if(global.Platformer_Global_Score > global.Platformer_Final_Score){
	new_record = true;
	global.Platformer_Final_Score = global.Platformer_Global_Score; 
}
puntaje_final = global.Platformer_Global_Score;

lista_ranking = [
    { nombre: "Max13",  puntos: 6460 },
    { nombre: "Kristian", puntos: 300 },
    { nombre: "YOU",   puntos: puntaje_final },
	{ nombre: "Susan", puntos: 4000}
];

var _funcion_ordenar = function(_elemento_a, _elemento_b) {
    return _elemento_b.puntos - _elemento_a.puntos;
};

array_sort(lista_ranking, _funcion_ordenar);

es_top_uno = (lista_ranking[0].nombre == "YOU"); 

mostrar_titulo = false;
mostrar_tabla = false;
mostrar_evaluacion = false;

puntaje_animado = 0;

