function Update_Dialogos(){
	can_interact = (oPlayer.sprite_index == sprPlayerUp);
}

function Dialogos(){
	text[0] = "* This is a <yellow>gravestone<white>.";
	text[1] = "* It has some text in it.";
	text[2] = "* <blue>Sandra Stone<white><wait=30>#'A true coffee lover.'<wait=30>#19XX - 20XX";
	for(var i = 0; i < array_length(text);i++){
		speaker_sprite[i] = noone;
		txtb_color[i] = c_white;
		txtb_snd[i] = sfx_text;
	}
}