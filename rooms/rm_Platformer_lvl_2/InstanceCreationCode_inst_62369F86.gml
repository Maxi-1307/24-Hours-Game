permanente = false;
function Effect_Box(){
            with(oPlatformer_Wall) {
                if (x == 869) {
                    instance_deactivate_object(id);
                }
            }
        }
function Undo_Effect_Box(){
            instance_activate_object(oPlatformer_Wall);
            
            with(oPlatformer_Wall) {
                if (x == 869) {
                    image_alpha = 1;
                    mask_index = sprite_index;
                }
            }
}

