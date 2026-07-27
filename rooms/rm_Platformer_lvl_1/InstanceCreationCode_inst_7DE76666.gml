permanente = false;

function Effect_Box(){
    button_created = instance_create_layer(1230, 50, "Player", oPlatformer_Button);
    
    with(button_created){
        permanente = false;
        
        function Effect_Box(){
            with(oPlatformer_Wall) {
                if (x == 1620) {
                    instance_deactivate_object(id);
                }
            }
        }
        
        function Undo_Effect_Box(){
            instance_activate_object(oPlatformer_Wall);
            
            with(oPlatformer_Wall) {
                if (x == 1620) {
                    image_alpha = 1;
                    mask_index = sprite_index;
                }
            }
        }
    }
}

function Undo_Effect_Box(){
    instance_activate_object(oPlatformer_Wall);
    
    with(oPlatformer_Wall) {
        if (x == 1620) {
            image_alpha = 1;
            mask_index = sprite_index;
        }
    }
    
    if (instance_exists(button_created)) {
        instance_destroy(button_created);
    }
}
