if(variable_global_exists("Is_Indoors")){
	var _is_indoors = global.Is_Indoors;

	if ((image_alpha > 0 && visible) && !_is_indoors && instance_exists(oShadow_Light)) {
	    var _lista = oShadow_Light.sombras;
	    var _total = array_length(_lista);
    
	    for (var i = 0; i < _total; i++) {
	        var _smd = _lista[i];
        
	        if (_smd.id_origen == id && _smd.spriteIndex >= 0) {
	            var _matrix_antigua = matrix_get(matrix_world);

	            var _matrix_shadow = matrix_build( _smd.posX, _smd.posY, 0,0, 0, 0,_smd.escalaX, _smd.escalaY, 1);
	            _matrix_shadow[4] = _smd.skewX; 
            
	            matrix_set(matrix_world, _matrix_shadow);
            
	            draw_sprite_ext(_smd.spriteIndex,  _smd.imageIndex, 0, 0, 1, 1, 0, c_black,0.55 );
            
	            matrix_set(matrix_world, _matrix_antigua);
	        }
	    }
	}

	if (sprite_index >= 0) {
	    draw_self();
	}
}