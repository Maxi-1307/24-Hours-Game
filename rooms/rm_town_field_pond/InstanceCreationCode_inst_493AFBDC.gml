	target_room = rm_town_field_1;
	target_x = 625;
	facing = 1;
function refresh(){
	target_y = oPlayer.y;
}//Ah pues:
//Seria cazar bugs y tambien una funcion para coordinar los turnoa en la tienda, digamos que defino q de 6:30 hasta las 11:30 el turno es de la chica, de 11:30 a 4:30 es del chico, de 4:30 a 9:30 es de ambos y de 9:30 a 12:00 es del chico. Y bueno con eso definido sabriamos quien esta igual en turno apra que al llamar por el telefono tengamos distinto dialogo segun quien este en turno