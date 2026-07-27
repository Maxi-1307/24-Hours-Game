ancho_pantalla = display_get_gui_width();
alto_pantalla = display_get_gui_height();

tamano_cuadro = 64;
columnas = ceil(ancho_pantalla / tamano_cuadro) + 1;
filas = ceil(alto_pantalla / tamano_cuadro) + 1;

progreso = 0;
velocidad = 0.02;
siguiente_sala = room_next(room);

estado = 0; 
