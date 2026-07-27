if(global.Platformer_Global_Score <= 12200){
	var weird = instance_create_layer(x,y,"Walls",oPlatformer_WeirdLevel);
	weird.image_xscale = image_xscale;
	weird.image_yscale = image_yscale;
	instance_destroy();
}