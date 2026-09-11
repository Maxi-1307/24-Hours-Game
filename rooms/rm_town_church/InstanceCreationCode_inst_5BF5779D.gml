donated_hopeful = false;
donated_full = false;
donated_halful = false;
function Dialogos(){
	donated_full = false;
	donated_halful = false;
	can_interact = (oPlayer.sprite_index == sprPlayerUp);
    text[0] = "* It's a tip box with the#label:";
    text[1] = "* 'A tip to help our small#church?'";
    text[2] = "* Do you wanna leave a tip?";

    // Solo mostrar qué pasaría según el dinero actual
    if (global.Money >= 10) {
        text[3] = "* You leave some tip, hoping#it was helpful.";
		global.Money -= 10;
		other.donated_full = true;
    }
    else if (global.Money > 0) {
        text[3] = "* Even without having much,#you donated it anyway.";
		 global.Money = 0;
		 other.donated_halful = true;
		
    }
    else {
        text[3] = "* Even without money, your will#to donate feels helpful too!";
		 other.donated_hopeful = true;
    }

    text[4] = "* It's okay, you don't have#to if you don't want.";
    text[5] = "* It's fine, maybe,<wait=120>maybe#another time if you feel#comfortable.";

    decisions[2] = {
        left: "Sure",
        right: "No",
        up: "Not now"
    };

    decision_script[2] = {};

    decision_result[2] = {
        left: 3,
        right: 4,
        up: 5
    };

    for(var i = 0; i < array_length(text); i++){
        txtb_color[i] = c_white;
        speaker_sprite[i] = noone;
        txtb_snd[i] = sfx_text;
    }
}