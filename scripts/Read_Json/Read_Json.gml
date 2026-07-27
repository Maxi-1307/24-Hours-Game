function Read_Json(_archivo)
{
    var buffer = buffer_load(_archivo);

    if (buffer == -1)
    {
        show_debug_message("No se pudo cargar: " + _archivo);
        return undefined;
    }

    var texto = buffer_read(buffer, buffer_string);

    buffer_delete(buffer);

    var datos = json_parse(texto);

    return datos;
} 