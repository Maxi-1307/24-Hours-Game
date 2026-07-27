permanente = false;

function Undo_Effect_Box(){

    if (!position_meeting(186, 85, oPlatformer_PowerUpBox)) {
        
        random_box = instance_create_layer(186, 85, "Player", oPlatformer_PowerUpBox);
        show_debug_message("¡Botón soltado! Caja sorpresa creada en (186, 85).");
        
    } else {
        show_debug_message(" Creación cancelada: Ya hay una caja en esa posición.");
    }
}
