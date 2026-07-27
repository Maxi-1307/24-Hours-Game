function Dialogos(){
    // 1. CARGA DE TEXTO DESDE EL JSON (Con tus índices rígidos de página)
	text[0] = _T("picnic_trash_1");
	text[1] = _T("picnic_trash_2");

    // 2. RELLENADOR AUTOMÁTICO INTELIGENTE
    // Mide cuántas páginas tiene el texto en este frame y configura los vectores
    var _len = array_length(text);
    
    for (var i = 0; i < _len; i++) {
        speaker_sprite[i] = noone;
        txtb_snd[i]       = sfx_text;
        txtb_color[i]     = c_white;
    }
}
