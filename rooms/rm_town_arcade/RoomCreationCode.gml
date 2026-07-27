audio_pause_all();

if (oBorder_Screen.borde_sprite != sprBorder_Screen_Town) {
    oBorder_Screen.borde_anterior = oBorder_Screen.borde_sprite;
    oBorder_Screen.borde_sprite = sprBorder_Screen_Town;
    oBorder_Screen.borde_alpha = 0.0; // Empieza invisible y hace fade in encima del anterior
}