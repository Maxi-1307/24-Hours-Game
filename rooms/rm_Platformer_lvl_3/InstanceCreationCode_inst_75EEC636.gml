permanente = false;
function Effect_Box(){
	button = instance_create_layer(1975,70,"Objects",oPlatformer_Button);
	with(button){
		permanente = false;

		function Effect_Box(){
		    with(oPlatformer_Wall) {
		        if (x == 1657 || x == 1514 || x == 2871) {
		            instance_deactivate_object(id); 
		        }
		    }
		}

		function Undo_Effect_Box(){
		    instance_activate_object(oPlatformer_Wall);
    
		    with(oPlatformer_Wall) {
		        if (x == 2871) {
		            image_alpha = 1;
		            mask_index = sprite_index; 
		        }
		    }
		}

	}
}
function Undo_Effect_Box(){
	instance_destroy(button);
}