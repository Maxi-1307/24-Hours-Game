var textbox = instance_create_layer(0, 0,"Dialogue", oTextBox);
flag_for_menu = true;
if(save_check_odd == 0){
	with (textbox) {
	    text[0] = "<unskippable>* Well, there might be a man#behind that tree.";
	    text[1] = "<unskippable>* He seems to be offering#something to you.";
	    text[2] = "<unskippable>* You start approaching him.#<wait=60> Closer<wait=60> and closer.";
	    text[3] = "<unskippable>* He is offering you#something in his hand.";
	    text[4] = "<unskippable>*<speed=0.4> But...";
	    text[5] = "<unskippable>* He couldn't.<wait=120> The reason?";
	    text[6] = "<unskippable>* Welp...<wait=120> your <cyan>SAVE FILE<white> is#corrupted lol.";
		for(var i = 0; i < array_length(text);i++){
			txtb_snd[i] = sfx_text;
			txtb_color[i] = c_white;
			speaker_sprite[i] = noone;
		}
	}
}else if (save_check_odd == 1) {
    with (textbox) {
        text[0] = "<unskippable>* Oh, that was odd.";
        text[1] = "<unskippable>* Why are you so worried?";
        text[2] = "<unskippable>* Oh, those? Those were my#taxes.";
        text[3] = "<unskippable>* Maybe I'll avoid them for#a while.";
        text[4] = "<unskippable>* What, you thought that was#your <cyan>SAVE FILE<white>?";
        text[5] = "<unskippable>* Oh, no, no, no.";
        text[6] = "<unskippable>* That one was corrupted#anyway.";
		

        for (var i = 0; i < array_length(text); i++) {
            txtb_snd[i] = sfx_text;
            txtb_color[i] = c_white;
            speaker_sprite[i] = noone;
        }
    }	
}else if (save_check_odd == 2) {
    with (textbox) {
        text[0] = "<unskippable>*<speed=0.3> ...";
        text[1] = "<unskippable>* Welp, umm...";
        text[2] = "<unskippable>* Maybe we should, umm...";
        text[3] = "<unskippable>* IDK, let's just <yellow>RESET<white>#the <cyan>SAVE FILE<white>?";
        text[4] = "<unskippable>* Yeah, that should be#for the best.";

        for (var i = 0; i < array_length(text); i++) {
            txtb_snd[i] = sfx_text;
            txtb_color[i] = c_white;
            speaker_sprite[i] = noone;
        }
    }
}