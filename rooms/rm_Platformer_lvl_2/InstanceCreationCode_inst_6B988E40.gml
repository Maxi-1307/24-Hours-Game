permanente = false;
function Effect_Box(){
	powerbox = instance_create_layer(1235,150,"Player",oPlatformer_PowerUpBox);
	powerbox.item = oPlatformer_Balloon;
}
function Undo_Effect_Box(){
	instance_destroy(powerbox);
}