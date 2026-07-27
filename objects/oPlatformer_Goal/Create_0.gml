tocado = false;
fase_victoria = 0;

zoom_actual = 1;
zoom_objetivo = 0.5;
velocidad_zoom = 0.01;
function Level_Score(){
    var _puntos_estrellas = global.Platformer_Level_Stars * 10;
    var _puntos_vidas     = global.Platformer_Lives * 10;
    var _puntos_tiempo    = floor(global.Platformer_Level_Time) * 10;
    
    global.Platformer_Level_Score = _puntos_estrellas + _puntos_vidas + _puntos_tiempo;
    global.Platformer_Global_Score += global.Platformer_Level_Score;
}
