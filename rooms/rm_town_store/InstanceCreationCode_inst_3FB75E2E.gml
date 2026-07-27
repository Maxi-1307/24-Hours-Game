
function Update_Dialogos(){
	can_interact = (oPlayer.sprite_index == sprPlayerDown && oShop_Basket.en_suelo);
}
function Dialogos(){
		text[0] = "* You tried to identify the#products.";
		text[1] = "* .<wait=30>.<wait=30>.";
		if(instance_exists(oShop_EmployeeBoy) && instance_exists(oStore_EmployeeGirl)){
			text[2] = "* (Why is he staring at#the shelf?)"
			text[3] = "* (IDK)";
			text[4] = "* (It's like he can't notice#the products in there.)"
			txtb_color[2] =  #BB7547;
			txtb_color[3] = #71413B;
			txtb_color[4] = #71413B;
		}
	
		txtb_color[0] = c_white;
		txtb_color[1] = c_white;
	
		for(var i= 0;i<array_length(text);i++){
			txtb_snd[i] = sfx_text;
			speaker_sprite[i] = noone;
		}
}