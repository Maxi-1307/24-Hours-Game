if (state == 0) {
    image_speed = 0;
    image_index = image_number - 1;
    
    sonido_id = audio_play_sound(sonido_a_reproducir, 10, false);
    state = 1;
}
