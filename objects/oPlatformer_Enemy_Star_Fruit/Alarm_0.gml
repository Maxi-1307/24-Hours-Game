if (instance_exists(oPlatformer_Controller) && oPlatformer_Controller.state != "game_over") {
    for (var i = 0; i < 5; i++) {
        var _angulo_punta = 90 + (i * 72);
        var _bala = instance_create_depth(x, y, depth - 2, oPlatformer_Enemy_Star_Fruit_Bullet);

        if (instance_exists(_bala)) {
            _bala.direction = _angulo_punta;
            _bala.speed = velocidad_proyectil;
            _bala.image_angle = _angulo_punta - 90;
        }
    }
}
alarm[0] = frecuencia_disparo * game_get_speed(gamespeed_fps);
