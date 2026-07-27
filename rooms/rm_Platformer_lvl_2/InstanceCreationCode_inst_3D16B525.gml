permanente = false;

function Effect_Box(){
        box = instance_create_layer(1790, 110, "Player", oPlatformer_PowerUpBox);
        
}
function Undo_Effect_Box(){
	instance_destroy(box);
}
