function Update_Dialogos(){
    text = [];
    decisions = array_create(10, undefined); 
    decision_result = array_create(10, undefined);
    decision_script = array_create(10, undefined);
    speaker_sprite = [];
    txtb_snd = [];
    txtb_color = [];
	
    text[0] = "* ...";
	text[1] = "* ...";
	text[2] = "* ¿Hola?";
	text[3] = "* ...";
	text[4] = "* No hablas mucho verdad?";
	if(instance_exists(oTextBox)){
		show_debug_message("Existe textbox deaf");
		if(oTextBox.page == 5){
			oDeaf_Girl.image_speed = 1;
			oDeaf_Girl.image_index = 1;
			oDeaf_Girl.image_speed = 0;
			show_debug_message("Cambia sprite");
		}
	}
	text[5] = "* ...";
	text[6] = "* Oh, disculpame, no quise#ser rudo.";
	text[7] = "* H..O..la";
	text[8] = "* ...";
	
		if(instance_exists(oTextBox)){
		show_debug_message("Existe textbox deaf");
		if(oTextBox.page_number == 9){
			oDeaf_Girl.image_speed = 2;
			oDeaf_Girl.image_index = 1;
			oDeaf_Girl.image_speed = 0;
			show_debug_message("Cambia sprite");
		}
	}
    
	text[9] = "* Decides dar la vuelta y#marcharte en silencio.";
	text[11] = "* Ella te devuelve el gesto con una sonrisa."
	decision_script[8] = {
		left: function(){
			instance_destroy(oTextBox);
			var txtb_leave = instance_create_layer(0,0,"Dialogue",oTextBox);
			with(txtb_leave){
				text[0] = "* Oh, lo lamento, no#queria incomodarte.";
				text[1] = "* Ella te devuelve el gesto#con una sonrisa."
				text[2] = "* Abre su mochila buscando#algo dentro.";
				text[3] = "* Saca una libreta con#stickers pegados."
				text[4] = "* Escribe algo rapidamente#antes de dartela a leer.";
				text[5] = "* 'Hola, soy Camille,no te#puedo oir,pero lindos ojos.'";
				text[6] = "* Te señalas el ojo con tu#dedo y le sonries agradecido.";
				text[7] = "* Ella suelta una risita#antes de ofrecerte el lapiz.";
				text[8] = "* Tomas el lapiz y#escibes una respuesta.";
				text[9] = "* Gracias, son de nacimiento.";
				text[10] = "* Ella lee tu nota con#sorpresa y escribe emocionada:";
				text[11] = "* ¡Que increible!, sabes las#calles me parecen aburridas.";
				text[12] = "* Pero quizas ahora ya no#tanto.";
				text[13] = "* Ella se percata de algo#antes de ver la hora.";
				text[14] = "* Anota rapidamente en la#libreta:";
				text[15] = "* Lo lamento debo irme,#se me hace tarde.";
				text[16] = "*Te hace una seña de despedida#mientas se va.";
				for(var i=0; i < array_length(text); i++){
					speaker_sprite[i] = noone;
					txtb_snd[i] = sfx_text;
					txtb_color[i] = c_white;
				 }
			}
		}
	};
	
	
    decisions[8] = {
        left:  "Seguir",
        right: "Irte"
    };
    decision_result[8] = {
        right: 9,
    };

    for(var i=0; i < array_length(text); i++){
        speaker_sprite[i] = noone;
        txtb_snd[i] = sfx_text;
        txtb_color[i] = c_white;
    }
	txtb_color[7] = c_purple;
}
