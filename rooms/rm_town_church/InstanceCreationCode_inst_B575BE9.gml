function Dialogos(){
	text[0] = "* It looks like a bubbler.";
	text[1] = "* You can drink some water.";
	text[2] = "* Drink?";
	
	text[3] = "* You give a big slurp.";
	text[4] = "* You feel hydrated!";
	
	text[5] = "* Maybe try using H2O then...";
	decisions[2] = {
		left: "Sure",
		right: "Nope"
	};
	decision_script[2] = {};
	
	decision_result[2] = {
		left:3,
		right: 5
	};
	
	for(var i = 0; i < array_length(text); i++){
		speaker_sprite[i] = noone;
		txtb_snd[i] = sfx_text;
		txtb_color[i] = c_white;
	}
	
}