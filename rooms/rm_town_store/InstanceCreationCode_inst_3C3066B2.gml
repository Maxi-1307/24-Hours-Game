function Dialogos(){
		if(instance_exists(oSoundStep) && oSoundStep.steped == true){
			text[0] = "* Well you clearly didn't#care about the sign!";
			text[1] = "* Seriously, why the sign#then?!";
			speaker_sprite[1] = noone;
			txtb_snd[1] = sfx_text;
		}else{
		text[0] = "* It's a mopping sign.";
		text[1] = "* It clearly says: 'Don't#step on the wet floor.'";
		speaker_sprite[1] = noone;
		txtb_snd[1] = sfx_text;
	}
}