function Dialogos(){
	text[0] = "* Notas que hay una nota en#tu buzón.";
	text[1] = "* Decides abrirlo y...";
	text[2] = "* Es una tarjeta que dice:";
	text[3] = "* ¡Feliz Cumpleaños Max13!";
	text[4] = "* Te sorprende porque nadie#se llama asi...";
	text[5] = "* ¿Oh si...?"
	
	if(oTextBox.page == 5){
		oPlayer.sprite_index = sprPlayerDown;
	}

    var _len = array_length(text);
    
    for (var i = 0; i < _len; i++) {
        speaker_sprite[i] = noone;
        txtb_snd[i]       = sfx_text;
        txtb_color[i]     = c_white;
    }
}
