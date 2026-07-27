permanente = false;
function Effect_Box(){
	balloon_box = instance_create_layer(320,150,"Player",oPlatformer_PowerUpBox);
	balloon_box.item = oPlatformer_Balloon;
}
function Undo_Effect_Box(){
	instance_destroy(balloon_box);
}