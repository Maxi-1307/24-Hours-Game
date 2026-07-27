if (estado == 0) {
    progreso += velocidad;
    
    if (progreso >= 1.2) {
        progreso = 1.2;
        estado = 1;
        
        if (global.CanMove){
            oPlayer.visible = true;
        }else{
			oPlayer.visible = false;
		}
        
        room_goto(siguiente_sala);
    }
} else {
    progreso -= velocidad;
    
    if (progreso <= 0) {
        instance_destroy(); 
    }
}
