global.Musical_Score = 0;
global.Musical_Missed = 0;
global.Musical_Can_Play = false;

estado_juego = "intro";
fase_intro = "esperando_pantalla"; 

color_marco = c_white;
marco_timer = 0;
flash_rojo_alfa = 0;

tecla_x_timer = 0;

letras = ["R", "O", "C", "K","!!"]; 
num_letras = array_length(letras);

for (var i = 0; i < num_letras; i++) {
    letra_y[i] = -60;
    letra_target_y[i] = -60;
}

timer_intro = 0;


texto_conteo = "";

lineas_offset_y = 0;
lineas_velocidad = 0.7;

if (global.Musical_Dificultad == "normal") {
    margen_asistencia = 24;
} else {
    margen_asistencia = 10; 
}

audio_stream = noone;  
nota_actual_index = 0; 


mapa_notas = cargar_partitura_musical(global.Musica_Seleccionada, global.Musical_Dificultad);
num_total_notas = array_length(mapa_notas);

siguiente_hito_publico = 200;

sub_fase_final = "esperando_fin"; 
timer_final = 0;
puntaje_final_real = 0;
puntaje_dinamico_visual = 0;

texto_veredicto = "";
color_veredicto = c_white;
parpadeo_timer = 0;
veredicto_visible = true;

letras_finish = ["F", "I", "N", "I", "S", "H"];
num_letras_finish = array_length(letras_finish);
for (var i = 0; i < num_letras_finish; i++) {
    finish_y[i] = -60;
    finish_target_y[i] = -60;
}

tabla_posiciones = [
    ["SUSIE",  500, false],
    ["BERDLY", 3000, false],
    ["RALSEI", 1500, false],
    ["LANCER",  760, false],
    ["YOU",      0, true]
];
num_competidores = array_length(tabla_posiciones);

if (!variable_global_exists("Musical_HighScore_Guardado")) {
    global.Musical_HighScore_Guardado = 200; 
}


modo_grabacion = true;
carril_simulado = 0;