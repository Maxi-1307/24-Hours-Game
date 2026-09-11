permanente = false;

function Effect_Box(){
            with(oPlatformer_Wall) {
                if (x == 1514) {
                    instance_deactivate_object(id);
                }
            }
            show_debug_message("¡Muros en X = 1514 desactivados!");
        }
        
function Undo_Effect_Box(){
            instance_activate_object(oPlatformer_Wall);
            
            with(oPlatformer_Wall) {
                if (x == 1514) {
                    image_alpha = 1;
                    mask_index = sprite_index;
                }
            }
            show_debug_message("Muros en X = 1514 restaurados.");
}
