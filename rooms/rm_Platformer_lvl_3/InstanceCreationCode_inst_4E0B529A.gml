permanente = false;

function Effect_Box(){
            with(oPlatformer_Wall) {
                // Filtramos el muro por su coordenada X exacta
                if (x == 1514) {
                    instance_deactivate_object(id); // Lo apaga por completo del mapa
                }
            }
            show_debug_message("¡Muros en X = 1514 desactivados!");
        }
        
        // Esta función se ejecuta automáticamente dentro de oPlatformer_Button al QUITAR el peso
function Undo_Effect_Box(){
            // Despertamos los bloques inmediatamente en este mismo frame
            instance_activate_object(oPlatformer_Wall);
            
            with(oPlatformer_Wall) {
                if (x == 1514) {
                    image_alpha = 1;
                    mask_index = sprite_index; // Restaura su cuerpo sólido seguro
                }
            }
            show_debug_message("Muros en X = 1514 restaurados.");
}
