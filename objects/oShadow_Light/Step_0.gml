var minutos_amanecer = 6 * 60 + 30;
var minutos_atardecer = 18 * 60 + 30;

var sol_izquierda = -400;
var sol_derecha   = room_width + 400;

var porcentaje_dia = (global.game_minutes - minutos_amanecer) / (minutos_atardecer - minutos_amanecer);
porcentaje_dia = clamp(porcentaje_dia, 0, 1);

x = lerp(sol_izquierda, sol_derecha, porcentaje_dia);

var factor_inclinacion = lerp(-0.8, 0.8, porcentaje_dia); 

var factor_largo = sin(porcentaje_dia * pi);
var escala_v_arbol   = 1.2 + (factor_largo * 0.4);
var escala_v_jugador = 0.8 + (factor_largo * 0.3);

sombras = []; 

var num_instancias = instance_number(oDepth_Tile_Manager);

for(var i = 0; i < num_instancias; i++){
    var obj_shadow = instance_find(oDepth_Tile_Manager, i);
    
    if (instance_exists(obj_shadow)) {
        
        if (obj_shadow.object_index == oTree || object_is_ancestor(obj_shadow.object_index, oTree)) {
            array_push(sombras, {
                id_origen: obj_shadow,
                posX: obj_shadow.x,
                posY: obj_shadow.y, 
                skewX: factor_inclinacion, 
                spriteIndex: sprTreeTrunks,
                imageIndex: obj_shadow.image_index,
                escalaX: obj_shadow.image_xscale, 
                escalaY: escala_v_arbol
            });
            
            array_push(sombras, {
                id_origen: obj_shadow,
                posX: obj_shadow.x,
                posY: obj_shadow.y, 
                skewX: factor_inclinacion, 
                spriteIndex: sprTreesLeaves,
                imageIndex: obj_shadow.image_index,
                escalaX: obj_shadow.image_xscale, 
                escalaY: escala_v_arbol
            });
        } 
        else {
            array_push(sombras, {
                id_origen: obj_shadow,
                posX: obj_shadow.x,
                posY: obj_shadow.y, 
                skewX: factor_inclinacion, 
                spriteIndex: obj_shadow.sprite_index,
                imageIndex: obj_shadow.image_index,
                escalaX: obj_shadow.image_xscale, 
                escalaY: escala_v_jugador
            });
        }
    }
}
