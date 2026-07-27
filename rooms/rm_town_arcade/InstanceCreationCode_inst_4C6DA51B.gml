interacted = false;
function Dialogos(){
    oArcade_Personal.animacion_especial = false;
    oArcade_Personal.image_speed = 0;
    
    text = [];
    decisions = array_create(10, undefined); 
    decision_result = array_create(10, undefined);
    decision_script = array_create(10, undefined);
    speaker_sprite = [];
    txtb_snd = [];
    txtb_color = [];
    
    if (!interacted){
        text[0] = "* Hola, ¡Bienvenido al#arcade!";
        text[1] = "* Sientete libre de usar#las maquinas";
        text[2] = "* Solo considera que, hay#algunas bajo reparación.";
        text[3] = "* Pero no dejes que#te desanime.";
        
        for(var i = 0; i < array_length(text); i++){
            txtb_color[i] = c_white;
            txtb_snd[i] = sfx_text;
            speaker_sprite[i] = noone;
        }
        interacted = true;
    } 
    else {
        text[0] = "* Hola de nuevo.";
        text[1] = "* ¿Te ayudo en algo?";
        text[2] = "* ¡Que te diviertas!";
        
        for(var i = 0; i < array_length(text); i++){
            txtb_color[i] = c_white;
            txtb_snd[i] = sfx_text;
            speaker_sprite[i] = noone;
        }
        
        decisions[1] = {
            left: "Nada",
            right: "Sobre ti"
        };
        
        decision_result[1] = {
            left: 2,
        };
        
        decision_script[1] = {
            right: function(){
				instance_destroy(oTextBox);
                var txtb = instance_create_layer(0,0,"Dialogue",oTextBox);
                with(txtb){
                    text[0] = "* Oh, bueno...";
                    text[1] = "* Qué te puedo decir,trabajo#aquí en el arcade.";
                    text[2] = "* Es algo aburrido,pero#manejable.";
                    text[3] = "* ...";
                    text[4] = "* Sabes,deberías intentar#romper algún récord.";
					text[5] = "* Y yo seguire cuidando#el arcade, ¿va?";
                        
                    for(var i = 0; i < array_length(text); i++){
                        txtb_color[i] = c_red;
                        txtb_snd[i] = sfx_text;
                        speaker_sprite[i] = noone;
                    }
                }
            }
        };
        
    }
    
}
