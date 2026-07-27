permanente = false;
function Effect_Box(){
            with(oPlatformer_Wall) {
                if (x == 1137) {
                    instance_deactivate_object(id);
                }
            }
        }
		if(!instance_exists(oPlatformer_Balloon)){
			balloon_box = instance_create_layer(810,150,"Player",oPlatformer_PowerUpBox);
			balloon_box.item = oPlatformer_Balloon;
		}
function Undo_Effect_Box(){
            instance_activate_object(oPlatformer_Wall);
            
            with(oPlatformer_Wall) {
                if (x == 1137) {
                    image_alpha = 1;
                    mask_index = sprite_index;
                }
            }
			instance_destroy(balloon_box);
}

