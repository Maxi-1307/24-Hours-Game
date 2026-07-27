 var draw_tutorial_text = function(_x, _y, _texto) {
        // Sombra (#101066)
        draw_text_transformed_colour(_x, _y, _texto, 0.5, 0.5, 0, #101066, #101066, #101066, #101066, 1);
        // Frente (#E5E5E5) un píxel a la derecha
        draw_text_transformed_colour(_x + 1, _y, _texto, 0.5, 0.5, 0, #E5E5E5, #E5E5E5, #E5E5E5, #E5E5E5, 1);
    };

if (global.Platformer_Level == 1) {
	 
    var _key_confirm = key_to_string(global.ConfirmKey);
    var _key_cancel  = key_to_string(global.CancelKey);

    // Letrero 1: Recoger Objeto
    draw_tutorial_text(458, 41, string_replace(_T("tut_pick_item"), "{0}", _key_confirm));

    // Letrero 2: Soltar Objeto
    draw_tutorial_text(623, 45, string_replace(_T("tut_drop_item"), "{0}", _key_cancel));

    // Letrero 3: Información de Cajas
    draw_tutorial_text(761, 17, _T("tut_boxes_info"));

    // Letrero 4: Necesidad de Botón
    draw_tutorial_text(1096, 108, _T("tut_button_need"));

    // Letrero 5: Atar Globo
    draw_tutorial_text(1356, 84, string_replace(_T("tut_balloon_attach"), "{0}", _key_confirm));
	draw_tutorial_text(1767, 13, _T("tut_glomies_charge"));
	
}else if(global.Platformer_Level == 3){
	draw_tutorial_text(908,18,_T("tut_ghost_walls"));
}
