function Update_Dialogos(){
	can_interact = (oPlayer.sprite_index == sprPlayerUp);
}

function Dialogos(){
	text[0] = "<unskippable>* ...";
	text[1] = "<unskippable>* You try to read the name#of the tombstone.";
	text[2] = "<unskippable>*<speed=0.4> But...";
	text[3] = "<unskippable>*<speed=0.4> You barely uttered the#first two letters...";
	text[4] = "<unskippable>*<speed=0.3> You felt a lump form in#your throat.";
	text[5] = "<unskippable>*<speed=0.2> It prevented you from#saying another word...";
	if(global.TOMBSTONE == 0 && !instance_exists(oSomeone)){
		instance_create_layer(128,480,"Objects",oSomeone);
	}
	for(var i = 0; i < array_length(text);i++){
		speaker_sprite[i] = noone;
		txtb_color[i] = c_white;
		txtb_snd[i] = sfx_text;
	}
}