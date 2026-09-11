if(place_meeting(x + 2,y + 2,oPlayer) && !instance_exists(oTextBox) && keyboard_check_pressed(global.ConfirmKey)){
	var textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
	with(textbox){
		function Update_Dialogos(){
			var textbox_tips =  inst_5BF5779D; //ID del textbox_opener de los tips			
			if(!other.welcome){
				text[0] = "* Oh, greetings my son.";
				text[1] = "* You know, it's been some#time since I've seen you#around here.";
				text[2] = "* I'm glad to see you again#and know that you're doing#well.";
				text[3] = "* You know that you will#always be welcome here.";
				text[4] = "* You know, every day I pray#that our sister is in a#good place.";
				text[5] = "* I know that perhaps you#think the same.";
				text[6] = "* ...";
				text[7] = "* Oh, I wouldn't want to#overwhelm you with my sermons.#Continue your way.";
				other.welcome = true;
			
			}else if(textbox_tips.donated_full && !textbox_tips.donated_hopeful && !textbox_tips.donated_halful && !other.donated_full_dialogue){
				text[0] = "* Oh, my son.";
				text[1] = "* You didn't have to donate.";
				text[2] = "* But I thank you for it.";
				other.donated_full_dialogue = true;
			}else if(!textbox_tips.donated_full && !textbox_tips.donated_hopeful && textbox_tips.donated_halful && !other.donated_halful_dialogue){
				text[0] = "* Oh, my son.";
				text[1] = "* You didn't have to donate.";
				text[2] = "* Especially if it was the#last you had.";
				text[3] = "* Ahh...";
				text[4] = "* I'll let it pass this#time.";
				other.donated_halful_dialogue = true;
			}else if(!textbox_tips.donated_full && textbox_tips.donated_hopeful && !textbox_tips.donated_halful && !other.donated_hopeful_dialogue){
				text[0] = "* Oh, my son.";
				text[1] = "* I saw how you wanted to#put something in.";
				text[2] = "* I thank you very much.";
				text[3] = "* Here, at least so you can#buy something to eat.";
				text[4] = "* You receive under the table#<yellow>7 dollars<white>!";
				global.Money += 7;
				other.donated_hopeful_dialogue = true;
			}else {
				text[0] = "* Tell me,my son,what is it?";
				
				text[1] = "* Oh, you mean the little#organ over there?";
				text[2] = "* Heh, yes, it's been here#for quite a while.";
				text[3] = "* Some children who come here#try to play it.";
				text[4] = "* Or we lend it for practices#and such.";
				text[5] = "* Actually, that reminds me#of when you used to come#and try to play it.";
				text[6] = "* You weren't the best,of#course, but you got way too#excited.";
				text[7] = "* That was priceless.";
				
				text[8] = "* Ah, you mean the donation#box?";
				text[9] = "* Yes, many kind people have#helped us keep the church#going.";
				text[10] = "* We don't have luxuries,but#at leastthere are good benches#to sit on.";
				
				text[11] = "* Oh, you want to know why#they're closed?";
				text[12] = "* Well, that's because#they're preparing everything#for today's mass.";
				text[13] = "* And thanks to the mayor#donating us new fans.";
				text[14] = "* They're installing them,#haha.";
				
				text[15] = "* Nothing? Who's nothing?#*Haha";
				decisions[0] = {
					left: "Piano",
					right: "Donation",
					up: "Doors",
					down: "Nothing"
				};
				decision_result[0] = {
					left: 1,
					right:8,
					up: 11,
					down: 15
				};
				decision_script[0] = {};
				
			}
			
		
			for(var i = 0; i < array_length(text);i++){
				speaker_sprite[i] = noone;
				txtb_color[i] = c_white;
				txtb_snd[i] = sfx_text;
			}
		}
		Update_Dialogos();
		
	}
	
	
}