global.textos_localizados = {}; 

function cargar_idioma(_nombre_idioma) {
    var _archivo = "languages/" + _nombre_idioma + ".json";
    
    if (file_exists(_archivo)) {
        var _buffer = buffer_load(_archivo);
        var _texto_plano = buffer_read(_buffer, buffer_string);
        buffer_delete(_buffer);
        
        global.textos_localizados = json_parse(_texto_plano);
        global.idioma = _nombre_idioma;
		Items();
        show_debug_message("¡Se cargó con éxito el idioma: " + _archivo);
    } else {
        show_debug_message("Error: El archivo " + _archivo + " no existe.");
    }
}

function _T(_etiqueta) {
    if (variable_struct_exists(global.textos_localizados, _etiqueta)) {
        return variable_struct_get(global.textos_localizados, _etiqueta);
    }
    return "Falta Traducir: " + _etiqueta; 
}
