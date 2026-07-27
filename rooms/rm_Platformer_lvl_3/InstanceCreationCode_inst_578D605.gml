permanente = false;

function Effect_Box(){
   box = instance_create_layer(709,192,"Player",oPlatformer_Box);
   power_box = instance_create_layer(805,130,"Player",oPlatformer_PowerUpBox);  
   power_box.item = oPlatformer_Balloon;
}

function Undo_Effect_Box(){
	instance_destroy(box);
	instance_destroy(power_box);
}
