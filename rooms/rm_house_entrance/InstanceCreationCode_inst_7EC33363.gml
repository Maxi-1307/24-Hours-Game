function Dialogos(){
	text[0] = _T("bookshelf_desc_1");
	text[1] = _T("bookshelf_desc_2");
	text[2] = _T("bookshelf_desc_3");
	
	for(var i = 0; i < array_length(text);i++){
		speaker_sprite[i] = noone;
		txtb_snd[i] = sfx_text;
		txtb_color[i] = c_white;
	}
}

