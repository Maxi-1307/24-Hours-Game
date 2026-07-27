if(global.Musica_Seleccionada == snd_Test_TVWORLD){
	if(global.Musical_Dificultad == "normal"){
		global.Musical_HighScore_SAVED[0] = global.Musical_HighScore_Guardado;
	}else{
		global.Musical_HighScore_SAVED[1] = global.Musical_HighScore_Guardado;		
	}
}else{
	if(global.Musical_Dificultad == "normal"){
		global.Musical_HighScore_SAVED[2] = global.Musical_HighScore_Guardado;
	}else{
		global.Musical_HighScore_SAVED[3] = global.Musical_HighScore_Guardado;		
	}	
}


room_goto(rm_town_arcade); 
global.CanMove = true;
oPlayer.visible = true;
global.CanInventory = true;
audio_stop_sound(audio_stream);
