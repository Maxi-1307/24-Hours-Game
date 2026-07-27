/// @desc Activa un golpe de zoom rápido hacia el centro del arcade
/// @param {real} amount Nivel del zoom (ej: 0.9 = Zoom cercano, 1.0 = normal)
/// @param {real} speed Qué tan rápido regresa al estado original (ej: 0.15)
function musical_camera_zoom(_amount, _speed) {
    if (instance_exists(oMusical_Camera)) {
        oMusical_Camera.cam_zoom = _amount;
        oMusical_Camera.cam_zoom_speed = _speed;
    }
}

/// @desc Activa un destello blanco en la pantalla general
/// @param {real} alpha Opacidad inicial (0.0 a 1.0)
/// @param {real} duration_frames Duración en frames del desvanecimiento (ej: 10)
function musical_camera_flash(_alpha, _duration_frames) {
    if (instance_exists(oMusical_Camera)) {
        oMusical_Camera.flash_general_alfa = _alpha;
        oMusical_Camera.flash_general_decay = _alpha / _duration_frames;
    }
}