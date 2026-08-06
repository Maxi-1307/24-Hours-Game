if(!instance_exists(oInventory)){
    var _boy, _girl, _textbox, _wall, _opener, _canasta_activa;
    var _chico_salio, _chica_salio, _chico_llego, _chica_llego;
    var _layer_tiles, _layer_objs, _es_turno_chica, _cleaner;
    var _timer_limpieza, _limpio_salio, _llego_a_caja;
    var _who_should_welcome, _index, _who_speaks_again;
	
	//Cambio de Turnos//
	if (global.game_minutes >= hour) {
	    index = (in + 1) mod array_length(global.TURNS);
	    global.current_turn = global.TURNS[in];
	    hour += 792;
	}

	//systema de cobro//
    if(state == 2 && place_meeting(x,y,oPlayer) && !instance_exists(oTextBox) && keyboard_check_pressed(global.ConfirmKey)){
        canasta_cobro = noone;
        with (oShop_Basket) {
            if (!en_suelo) {
                other.canasta_cobro = id;
            }   
        }
    
        if (canasta_cobro != noone && array_length(canasta_cobro.items) > 0){
            IniciarCobro();
        }
    }

	//systema de escaneo//
    if (estado_cobro == "escaneo" && !instance_exists(oTextBox)) {
        EscanearSiguienteItem();
    }

	//si te intentas fugar//
    if(instance_exists(oShop_Basket)){
        if(!oShop_Basket.en_suelo){
            if(!instance_position(160, 230, oWall)){
                _wall = instance_create_layer(160,230,"Walls",oWall);
                _wall.image_xscale = 2;
                _wall.image_yscale = 1;
            }
        
            if(!instance_position(160, 210, oTextBox_Opener)){
                _textbox = instance_create_layer(160,210,"Objects",oTextBox_Opener);
                with(_textbox){
                    function Dialogos(){
                        if(instance_exists(oStore_EmployeeGirl) && !instance_exists(oShop_EmployeeBoy)){
                            if(array_length(oShop_Basket.items) > 0){
                                text[0] = _T("shop_escape_girl_with_items");
								speaker_sprite[0] = sprEmployeeGirl_face_nervous;
                            }else{
                                text[0] = _T("shop_escape_girl_without_items");
								speaker_sprite[0] = sprEmployeeGirl_face_nervous;
                            }
                            txtb_color[0] = #BB7547;
                        }
                        if(instance_exists(oShop_EmployeeBoy) && !instance_exists(oStore_EmployeeGirl)){
                            if(array_length(oShop_Basket.items) > 0){
                                text[0] = _T("shop_escape_boy_with_items");
								speaker_sprite[0] = sprEmployeeBoy_face_angry;
                            }else{
                                text[0] = _T("shop_escape_boy_without_items");
								speaker_sprite[0] = sprEmployeeBoy_face_angry;
                            }
                            txtb_color[0] = #71413B;
                        }
                        if(instance_exists(oStore_EmployeeGirl) && instance_exists(oShop_EmployeeBoy)){
                            if(array_length(oShop_Basket.items) > 0){
                                text[0] = _T("shop_escape_both_with_items_1");
                                text[1] = _T("shop_escape_both_with_items_2");
                                txtb_color[0] = #71413B;
                                txtb_color[1] = #BB7547;
								speaker_sprite[0] = sprEmployeeBoy_face_angry;
								speaker_sprite[0] = sprEmployeeGirl_face_nervous;
                            }else{
                                text[0] = _T("shop_escape_both_without_items_1");
                                text[1] = _T("shop_escape_both_without_items_2");
                                text[2] = _T("shop_escape_both_without_items_3");
                                txtb_color[0] = #71413B;
                                txtb_color[1] = #BB7547;
                                txtb_color[2] = #BB7547;
								speaker_sprite[0] = sprEmployeeBoy_face_normal;
								speaker_sprite[0] = sprEmployeeGirl_face_nervous;
								speaker_sprite[0] = sprEmployeeGirl_face_nervous;
                            }
                        }
                        for(var i = 0; i < array_length(text);i++){
                            txtb_snd[i] = sfx_text;
                        }
                    }
                }
            }
        }else{
            _wall = instance_position(160, 230, oWall);
            if (_wall != noone) {
                instance_destroy(_wall);
            }
            _opener = instance_position(160, 210, oTextBox_Opener);
            if (_opener != noone) {
                instance_destroy(_opener);
            }
        }
    }

	//Cinematica de gomitas//
    if (state == 0) {    
        switch(paso_escena) {
            case 0:
                oPlayer.state = PLAYER_STATE.INTERACTING;
                oPlayer.sprite_index = sprPlayerUp;
                global.CanInventory = false;
                global.CanMove = false;
                oPlayer.image_speed = 0;
            
                _boy = instance_create_layer(225, 173, "Employees", oShop_EmployeeBoy);
                _boy.sprite_index = sprStore_EmployeeBoy_Filming;
                _boy.depth = -9999;
            
                _girl = instance_create_layer(249, 130, "Employees", oStore_EmployeeGirl);
                _girl.sprite_index = sprStore_EmployeeGirl_Gummys;
                _girl.image_speed = 0;
                _girl.image_index = 0;
                _girl.depth = -9999;
            
                if (!instance_exists(oTextBox)) {
                    _textbox = instance_create_layer(0, 0, "Dialogue", oTextBox);
                    with(_textbox) {
                        text[0] = _T("gummy_cinematic_1");
                        text[1] = _T("gummy_cinematic_2");
                        text[2] = _T("gummy_cinematic_3");
                        text[3] = _T("gummy_cinematic_4");
                        text[4] = _T("gummy_cinematic_5");
                        text[5] = _T("gummy_cinematic_6");
                        txtb_color[0] = #BB7547;
                        txtb_color[1] = #BB7547;
                        txtb_color[2] = #71413B;
                        txtb_color[3] = #BB7547;
                        txtb_color[4] = #71413B;
                        txtb_color[5] = #BB7547;
						speaker_sprite[0] = sprEmployeeGirl_face_normal;
						speaker_sprite[1] = sprEmployeeGirl_face_nervous;
						speaker_sprite[2] = sprEmployeeBoy_face_lost;
						speaker_sprite[3] = sprEmployeeGirl_face_normal;
						speaker_sprite[4] = sprEmployeeBoy_face_normal;
						speaker_sprite[5] = sprEmployeeGirl_face_glad;
                        for(var i = 0; i < array_length(text); i++) {
                            txtb_snd[i] = sfx_text;
                        }
                    }
                }
            
                paso_escena = 1;
                break;

            case 1:
                if (!instance_exists(oTextBox)) {
                    paso_escena = 2;
                }
                break;

            case 2:
                if (instance_exists(oStore_EmployeeGirl)) {
                    _girl = oStore_EmployeeGirl;
                    _girl.image_index += 0.15;
                
                    if (floor(_girl.image_index) >= 2) {
                        _girl.image_index = 2;
                        espera_timer = 60;
                        paso_escena = 3;
                    }
                }
                break;

            case 3:
                espera_timer--;
                if (espera_timer <= 0) {
                    paso_escena = 4;
                }
                break;

            case 4:
                if (instance_exists(oStore_EmployeeGirl)) {
                    _girl = oStore_EmployeeGirl;
                    _girl.image_index += 0.15;
                
                    if (floor(_girl.image_index) >= 6) {
                        _girl.image_index = 6;
                        audio_play_sound(sfx_splat, 1, false); 
                        espera_timer = 60;
                        paso_escena = 5;
                    }
                }
                break;

            case 5:
                espera_timer--;
                if (espera_timer <= 0) {
                    if (instance_exists(oStore_EmployeeGirl)) {
                        oStore_EmployeeGirl.image_speed = 0; 
                    }
                    paso_escena = 6;
                }
                break;

            case 6:
                if (instance_exists(oStore_EmployeeGirl)) {
                    _girl = oStore_EmployeeGirl;
                    _girl.image_index += 0.15;
                
                    if (floor(_girl.image_index) >= 10) {
                        _girl.image_index = 10;
                        espera_timer = 60;
                        paso_escena = 7;
                    }
                }
                break;

            case 7:
                espera_timer--;
                oStore_EmployeeGirl.image_index = 10;
                if (espera_timer <= 0) {
                    _textbox = instance_create_layer(0, 0, "Dialogue", oTextBox);
                    with(_textbox) {
                        oStore_EmployeeGirl.image_index = 10;
                        text[0] = _T("gummy_cinematic_after_1");
                        text[1] = _T("gummy_cinematic_after_2");
                        text[2] = _T("gummy_cinematic_after_3");
                        text[3] = _T("gummy_cinematic_after_4");
                        text[4] = _T("gummy_cinematic_after_5");
                        text[5] = _T("gummy_cinematic_after_6");
                        text[6] = _T("gummy_cinematic_after_7");
                        txtb_color[0] = #BB7547;
                        txtb_color[1] = #71413B;
                        txtb_color[2] = #BB7547;
                        txtb_color[3] = #71413B;
                        txtb_color[4] = #BB7547;
                        txtb_color[5] = #BB7547;
                        txtb_color[6] = #BB7547;
						speaker_sprite[0] = sprEmployeeGirl_face_nervous;
						speaker_sprite[1] = sprEmployeeBoy_face_normal;
						speaker_sprite[2] = sprEmployeeGirl_face_normal;
						speaker_sprite[3] = sprEmployeeBoy_face_normal;
						speaker_sprite[4] = sprEmployeeGirl_face_shocked;
						speaker_sprite[5] = sprEmployeeBoy_face_surprised;
						speaker_sprite[6] = sprEmployeeGirl_face_nervous;
                    
                        for(var i = 0; i < array_length(text); i++) {
                            txtb_snd[i] = sfx_text;
                        }
                    }
                
                    paso_escena = 8;
                }
                break;

            case 8:
                if (!instance_exists(oTextBox)) {
                    if (instance_exists(oStore_EmployeeGirl)) {
                        oStore_EmployeeGirl.sprite_index = sprStoreEmployee;
                        oStore_EmployeeGirl.depth = 800;
                    }
                    if (instance_exists(oShop_EmployeeBoy)) {
                        oShop_EmployeeBoy.sprite_index = sprStore_EmployeeBoy;
                        oShop_EmployeeBoy.depth = 800;
                    }
                
                    _chico_salio = false;
                    _chica_salio = false;
                
                    if (instance_exists(oShop_EmployeeBoy)) {
                        oShop_EmployeeBoy.x = lerp(oShop_EmployeeBoy.x, 500, 0.017);
                        if (abs(oShop_EmployeeBoy.x - 500) <= 5) _chico_salio = true;
                    } else { _chico_salio = true; }
                
                    if (instance_exists(oStore_EmployeeGirl)) {
                        oStore_EmployeeGirl.x = lerp(oStore_EmployeeGirl.x, 500, 0.017);
                        if (abs(oStore_EmployeeGirl.x - 500) <= 5) _chica_salio = true;
                    } else { _chica_salio = true; }
                
                    if (_chico_salio && _chica_salio) {
                        if (instance_exists(oShop_EmployeeBoy)) {
                            oShop_EmployeeBoy.x = 338;
                            oShop_EmployeeBoy.y = 75;
                        }
                        if (instance_exists(oStore_EmployeeGirl)) {
                            oStore_EmployeeGirl.x = 375;
                            oStore_EmployeeGirl.y = 74;
                        }
                    
                        paso_escena = 9;
                    }
                }
                break;

            case 9:
                _chico_llego = false;
                _chica_llego = false;
            
                if (instance_exists(oShop_EmployeeBoy)) {
                    _boy = oShop_EmployeeBoy;
                    _boy.x = lerp(_boy.x, 191, 0.017); 
                
                    if (abs(_boy.x - 191) <= 1) {
                        _boy.x = 191;
                        _chico_llego = true;
                    }
                } else { 
                    _chico_llego = true; 
                }
            
                if (instance_exists(oStore_EmployeeGirl)) {
                    _girl = oStore_EmployeeGirl;
                    _girl.x = lerp(_girl.x, 226, 0.017);
                
                    if (abs(_girl.x - 226) <= 1) {
                        _girl.x = 226;
                        _chica_llego = true;
                    }
                } else { 
                    _chica_llego = true; 
                }
            
                if (_chico_llego && _chica_llego) {
                    espera_timer = 60;
                    paso_escena = 10;  
                }
                break;

            case 10:
                espera_timer--;
                if (espera_timer <= 0) {
                    oPlayer.state = PLAYER_STATE.NORMAL;
                    global.CanInventory = true;
                    global.CanMove = true;
                    state = 2; 
                }
                break;
        }
    }

	//cinematica de trapeo//
    if (state == 1) {
        switch(paso_escena) {
            case 0:
                oPlayer.state = PLAYER_STATE.INTERACTING;
                oPlayer.sprite_index = sprPlayerUp;
                oPlayer.image_speed = 0;
                global.CanInventory = false;
                global.CanMove = false;
            
                _layer_tiles = layer_get_id("Mopping");
                _layer_objs = layer_get_id("Mopping_objects");
                if (layer_exists(_layer_objs)) {
                    layer_set_visible(_layer_objs, true);
                    instance_activate_layer(_layer_objs);
                }
                if (layer_exists(_layer_tiles)) layer_set_visible(_layer_tiles, true);
                if (layer_exists(_layer_objs))  layer_set_visible(_layer_objs, true);
            
                _es_turno_chica = irandom(1); 
            
                if (_es_turno_chica) {
                    _cleaner = instance_create_layer(249, 130, "Employees", oStore_EmployeeGirl);
                    _cleaner.sprite_index = sprStore_EmployeeGirl_Mopping;
                    _cleaner.image_speed = 0.8;
                    _cleaner.depth = -9999;
                } else {
                    _cleaner = instance_create_layer(249, 132, "Employees", oShop_EmployeeBoy);
                    _cleaner.sprite_index = sprStore_EmployeeBoy_Mopping;
                    _cleaner.image_speed = 0.8;
                    _cleaner.depth = -9999;
                }
            
                timer_limpieza = 180;
                paso_escena = 1;
                break;
            
            case 1:
                timer_limpieza--;
                if (timer_limpieza <= 0) {
                    if (instance_exists(oStore_EmployeeGirl)) oStore_EmployeeGirl.image_speed = 0;
                    if (instance_exists(oShop_EmployeeBoy))  oShop_EmployeeBoy.image_speed = 0;
                
                    _textbox = instance_create_layer(0, 0, "Dialogue", oTextBox);
                    with(_textbox) {
                        if (instance_exists(oStore_EmployeeGirl)) {
                            text[0] = _T("mopping_girl");
                            txtb_color[0] = #BB7547;
							speaker_sprite[0] = sprEmployeeGirl_face_nervous;
                        } else {
                            text[0] = _T("mopping_boy_1");
                            text[1] = _T("mopping_boy_2");
                            txtb_color[0] = #71413B;
                            txtb_color[1] = #71413B;
                            txtb_snd[1] = sfx_text;
                            speaker_sprite[0] = sprEmployeeBoy_face_lost;
							speaker_sprite[1] = sprEmployeeBoy_face_normal;
                        }
                    
                        txtb_snd[0] = sfx_text;
                    }
                
                    paso_escena = 2;
                }
                break;
            
            case 2:
                if (!instance_exists(oTextBox)) {
                    if (instance_exists(oStore_EmployeeGirl)) oStore_EmployeeGirl.sprite_index = sprStoreEmployee;
                    if (instance_exists(oShop_EmployeeBoy))  oShop_EmployeeBoy.sprite_index = sprStore_EmployeeBoy;
                
                    _limpio_salio = false;
                
                    if (instance_exists(oShop_EmployeeBoy)) {
                        oShop_EmployeeBoy.x = lerp(oShop_EmployeeBoy.x, 500, 0.02);
                        if (abs(oShop_EmployeeBoy.x - 500) <= 5) _limpio_salio = true;
                    }
                    if (instance_exists(oStore_EmployeeGirl)) {
                        oStore_EmployeeGirl.x = lerp(oStore_EmployeeGirl.x, 500, 0.02);
                        if (abs(oStore_EmployeeGirl.x - 500) <= 5) _limpio_salio = true;
                    }
                
                    if (_limpio_salio) {
                        if (instance_exists(oShop_EmployeeBoy)) {
                            oShop_EmployeeBoy.x = 338;
                            oShop_EmployeeBoy.y = 75;
                            oShop_EmployeeBoy.depth = 800;
                        }
                        if (instance_exists(oStore_EmployeeGirl)) {
                            oStore_EmployeeGirl.x = 375;
                            oStore_EmployeeGirl.y = 74;
                            oStore_EmployeeGirl.depth = 800;
                        }
                    
                        paso_escena = 3;
                    }
                }
                break;
            
            case 3:
                _llego_a_caja = false;
            
                if (instance_exists(oShop_EmployeeBoy)) {
                    _boy = oShop_EmployeeBoy;
                    _boy.x = lerp(_boy.x, 191, 0.017);
                    if (abs(_boy.x - 191) <= 1) { _boy.x = 191; _llego_a_caja = true; }
                }
                if (instance_exists(oStore_EmployeeGirl)) {
                    _girl = oStore_EmployeeGirl;
                    _girl.x = lerp(_girl.x, 226, 0.017);
                    if (abs(_girl.x - 226) <= 1) { _girl.x = 226; _llego_a_caja = true; }
                }
            
                if (_llego_a_caja) {
                    espera_timer = 60;
                    paso_escena = 4;
                }
                break;
            
            case 4:
                espera_timer--;
                if (espera_timer <= 0) {
                    oPlayer.state = PLAYER_STATE.NORMAL;
                    global.CanInventory = true;
                    global.CanMove = true;
                    state = 2; 
                }
                break;
        }
    }

	//Dialogos en tienda//
    if(state == 2){
        if(place_meeting(x,y,oPlayer)){
        
            //SOLO CHICA ALONE//
            if(!instance_exists(oShop_EmployeeBoy) && instance_exists(oStore_EmployeeGirl)){
                if(keyboard_check_pressed(global.ConfirmKey) && !instance_exists(oTextBox)){
                    _textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
                
                    if(oShop_Basket.en_suelo){
                        with(_textbox){
                            if(other.girl_alone_interact == 0){
                                text[0] = _T("shop_girl_first_1");
                                text[1] = _T("shop_girl_first_2");
								speaker_sprite[0] = sprEmployeeGirl_face_glad;
								speaker_sprite[1] = sprEmployeeGirl_face_normal;
                            }else if(other.girl_alone_interact < 3){
                                text[0] = _T("shop_girl_repeat_1");
                                text[1] = _T("shop_girl_repeat_2");
								speaker_sprite[0] = sprEmployeeGirl_face_nervous;
								speaker_sprite[1] = sprEmployeeGirl_face_normal;
                            }else{
                                text[0] = _T("shop_girl_later_1");
                                text[1] = _T("shop_girl_later_2");
								speaker_sprite[0] = sprEmployeeGirl_face_normal;
								speaker_sprite[1] = sprEmployeeGirl_face_nervous;
                            }
                    
                            decisions[1] = {
                                left: _T("option_how_to_shop"),
                                right: _T("option_job")
                            };
                            decision_result[1] = {};
                            decision_script[1] = {
                                left: function(){
                                    instance_destroy(oTextBox);
                                    var textboxgirl = instance_create_layer(0,0,"Dialogue",oTextBox);
                                    with(textboxgirl){
                                        text[0] = _T("shop_girl_how_to_shop_1");
                                        text[1] = _T("shop_girl_how_to_shop_2");
                                        text[2] = _T("shop_girl_how_to_shop_3");
                                        text[3] = _T("shop_girl_how_to_shop_4");
										speaker_sprite[0] = sprEmployeeGirl_face_normal;
										speaker_sprite[1] = sprEmployeeGirl_face_normal;
										speaker_sprite[2] = sprEmployeeGirl_face_normal;
										speaker_sprite[3] = sprEmployeeGirl_face_glad;
                                        for(var i = 0; i < array_length(text); i++){
                                            txtb_color[i] = #BB7547;
                                            txtb_snd[i] = sfx_text;
                                        }
                                    }
                                },
                                right : function(){
                                    instance_destroy(oTextBox);
                                    var textboxgirl = instance_create_layer(0,0,"Dialogue",oTextBox);
                                    with(textboxgirl){
                                        text[0] = _T("shop_girl_job_1");
                                        text[1] = _T("shop_girl_job_2");
                                        text[2] = _T("shop_girl_job_3");
                                        text[3] = _T("shop_girl_job_4");
										speaker_sprite[0] = sprEmployeeGirl_face_nervous;
										speaker_sprite[1] = sprEmployeeGirl_face_normal;
										speaker_sprite[2] = sprEmployeeGirl_face_glad;
										speaker_sprite[3] = sprEmployeeGirl_face_nervous;
                    
                                        for(var i = 0; i < array_length(text); i++){
                                            txtb_color[i] = #BB7547;
                                            txtb_snd[i] = sfx_text;
                                        }
                                    }
                                }
                            };
                    
                            for(var i = 0; i < array_length(text); i++){
                                txtb_color[i] = #BB7547;
                                txtb_snd[i] = sfx_text;
                            }
                        }
                    }else if(!oShop_Basket.en_suelo && array_length(oShop_Basket.items) == 0){
                        with(_textbox){
                            text[0] = _T("shop_girl_basket_empty");
                            txtb_color[0] = #BB7547;
                            txtb_snd[0] = sfx_text;
                            speaker_sprite[0] = sprEmployeeGirl_face_normal;
                        }
                    }
                    girl_alone_interact++; 
                }
            }
    
            //EL CHICO ALONE//
            if(!instance_exists(oStore_EmployeeGirl) && instance_exists(oShop_EmployeeBoy)){
                if(!instance_exists(oTextBox) && keyboard_check_pressed(global.ConfirmKey)){
                    _textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
                
                    if(oShop_Basket.en_suelo){
                        with(_textbox){
                            text[0] = _T("shop_boy_first_1");
							speaker_sprite[0] = sprEmployeeBoy_face_lost;
                            if(other.boy_alone_interact == 0){
                                text[1] = _T("shop_boy_first_2");
								speaker_sprite[1] = sprEmployeeBoy_face_realize;
                            }else if(other.boy_alone_interact < 3){
                                text[1] = _T("shop_boy_repeat_1");
								speaker_sprite[1] = sprEmployeeBoy_face_normal;
                            }else{
                                text[1] = _T("shop_boy_later_1");
								speaker_sprite[1] = sprEmployeeBoy_face_angry;
                            }
                
                            decisions[1] = {
                                left: _T("option_how_to_shop"),
                                right: _T("option_job")
                            };
                            decision_result[1] = {};
                            decision_script[1] = {
                                left: function(){
                                    instance_destroy(oTextBox);
                                    var textboxgirl = instance_create_layer(0,0,"Dialogue",oTextBox);
                                    with(textboxgirl){
                                        text[0] = _T("shop_boy_how_to_shop_1");
                                        text[1] = _T("shop_boy_how_to_shop_2");
                                        text[2] = _T("shop_boy_how_to_shop_3");
                                        text[3] = _T("shop_boy_how_to_shop_4");
                                        text[4] = _T("shop_boy_how_to_shop_5");
                                        text[5] = _T("shop_boy_how_to_shop_6");
										speaker_sprite[0] = sprEmployeeBoy_face_realize;
										speaker_sprite[1] = sprEmployeeBoy_face_angry;
										speaker_sprite[2] = sprEmployeeBoy_face_angry;
										speaker_sprite[3] = sprEmployeeBoy_face_angry;
										speaker_sprite[4] = sprEmployeeBoy_face_angry;
										speaker_sprite[5] = sprEmployeeBoy_face_normal;
                                        for(var i = 0; i < array_length(text); i++){
                                            txtb_color[i] = #71413B;
                                            txtb_snd[i] = sfx_text;
                                        }
                                    }
                                },
                                right : function(){
                                    instance_destroy(oTextBox);
                                    var textboxboy = instance_create_layer(0,0,"Dialogue",oTextBox);
                                    with(textboxboy){
                                        text[0] = _T("shop_boy_job_1");
                                        text[1] = _T("shop_boy_job_2");
                                        text[2] = _T("shop_boy_job_3");
                                        text[3] = _T("shop_boy_job_4");
                                        text[4] = _T("shop_boy_job_5");
                                        text[5] = _T("shop_boy_job_6");
                                        text[6] = _T("shop_boy_job_7");
										speaker_sprite[0] = sprEmployeeBoy_face_surprised;
										speaker_sprite[1] = sprEmployeeBoy_face_normal;
										speaker_sprite[2] = sprEmployeeBoy_face_normal;
										speaker_sprite[3] = sprEmployeeBoy_face_realize;
										speaker_sprite[4] = sprEmployeeBoy_face_angry;
										speaker_sprite[5] = sprEmployeeBoy_face_angry;
										speaker_sprite[6] = sprEmployeeBoy_face_normal;
                    
                                        for(var i = 0; i < array_length(text); i++){
                                            txtb_color[i] = #71413B;
                                            txtb_snd[i] = sfx_text;
                                        }
                                    }
                                }
                            };
                    
                            for(var i = 0; i < array_length(text); i++){
                                txtb_color[i] = #71413B;
                                txtb_snd[i] = sfx_text;
                            }
                            txtb_color[1] = c_white; 
                        }
                    }else if(!oShop_Basket.en_suelo && array_length(oShop_Basket.items) == 0){
                        with(_textbox){
                            text[0] = _T("shop_boy_basket_empty_1");
                            text[1] = _T("shop_boy_basket_empty_2");
                            txtb_color[0] = #71413B;
                            txtb_color[1] = #71413B;
                            txtb_snd[0] = sfx_text;
                            txtb_snd[1] = sfx_text;
                            speaker_sprite[0] = sprEmployeeBoy_face_surprised;
                            speaker_sprite[1] = sprEmployeeBoy_face_normal;
                        }
                    }
                    boy_alone_interact++; 
                }
            }
        
			//AMBOS EMPEADOS//
			if(instance_exists(oShop_EmployeeBoy) && instance_exists(oStore_EmployeeGirl)){
			    if(keyboard_check_pressed(global.ConfirmKey) && !instance_exists(oTextBox)){
			        _textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
			        with(_textbox){
			            if(oShop_Basket.en_suelo){
			                if(other.both_interact == 0){
			                    _who_should_welcome = irandom(1);
			                    _index = 7;
			                    text[0] = _T("shop_both_welcome_1");
			                    text[1] = _T("shop_both_welcome_2");
			                    text[2] = _T("shop_both_welcome_3");
			                    text[3] = _T("shop_both_welcome_4");
								speaker_sprite[0] = sprEmployeeBoy_face_lost;
								speaker_sprite[1] = sprEmployeeGirl_face_normal;
								speaker_sprite[2] = sprEmployeeBoy_face_realize;
								speaker_sprite[3] = sprEmployeeGirl_face_normal;
			                    if(_who_should_welcome == 0){
			                        text[4] = _T("shop_both_welcome_5a");
			                        text[5] = _T("shop_both_welcome_6a");
			                        text[6] = _T("shop_both_welcome_7a");
			                        text[7] = _T("shop_both_welcome_8a");
			                        txtb_color[4] = #71413B;
			                        txtb_color[5] = #BB7547;
			                        txtb_color[6] = #BB7547;
			                        txtb_color[7] = #71413B;	
									speaker_sprite[4] = sprEmployeeBoy_face_shocked;
									speaker_sprite[5] = sprEmployeeGirl_face_nervous;
									speaker_sprite[6] = sprEmployeeGirl_face_glad;
									speaker_sprite[7] = sprEmployeeBoy_face_lost;
			                    }else{
			                        text[4] = _T("shop_both_welcome_5b");
			                        text[5] = _T("shop_both_welcome_6b");
			                        text[6] = _T("shop_both_welcome_7b");
			                        txtb_color[4] = #71413B;
			                        txtb_color[5] = c_white;
			                        txtb_color[6] = #BB7547;
									speaker_sprite[4] = sprEmployeeBoy_face_angry;
									speaker_sprite[5] = sprEmployeeBoy_face_normal;
									speaker_sprite[6] = sprEmployeeGirl_face_nervous;
			                        _index = 6;
			                    }
			                    txtb_color[0] = #71413B;
			                    txtb_color[1] = #BB7547;
			                    txtb_color[2] = #71413B;
			                    txtb_color[3] = #BB7547;
			                }else if(other.both_interact < 3){
			                    text[0] = _T("shop_both_repeat_1");
			                    text[1] = _T("shop_both_repeat_2");
			                    text[2] = _T("shop_both_repeat_3");
			                    _index = 2;
			                    txtb_color[0] = #71413B;
			                    txtb_color[1] = #BB7547;
			                    txtb_color[2] = #BB7547;
								speaker_sprite[0] = sprEmployeeBoy_face_realize;
								speaker_sprite[1] = sprEmployeeGirl_face_nervous;
								speaker_sprite[2] = sprEmployeeGirl_face_glad;
			                }else{
			                    text[0] = _T("shop_both_later_1");
			                    text[1] = _T("shop_both_later_2");
			                    text[2] = _T("shop_both_later_3");
			                    _index = 2;
			                    txtb_color[0] = #71413B;
			                    txtb_color[1] = #BB7547;
			                    txtb_color[2] = #BB7547;
								speaker_sprite[0] = sprEmployeeBoy_face_angry;
								speaker_sprite[1] = sprEmployeeGirl_face_shocked;
								speaker_sprite[2] = sprEmployeeGirl_face_nervous;
			                }

			                var _duck_unlocked = (global.DuckStory >= 1);
                
			                var _decision_struct = {};
			                var _decision_script_struct = {};
                
			                _decision_struct.left = _T("option_how_to_shop");
			                _decision_struct.right = _T("option_job");
                
			                if (_duck_unlocked) {
			                    _decision_struct.up = "Duck";
			                }
                

			                // LEFT How to shop
			                _decision_script_struct.left = function(){
			                    instance_destroy(oTextBox);
			                    var textbox_how_to_shop = instance_create_layer(0,0,"Dialogue",oTextBox);
			                    with(textbox_how_to_shop){
			                        text[0] = _T("shop_both_how_to_shop_1");
			                        text[1] = _T("shop_both_how_to_shop_2");
			                        text[2] = _T("shop_both_how_to_shop_3");
			                        text[3] = _T("shop_both_how_to_shop_4");
			                        text[4] = _T("shop_both_how_to_shop_5");
			                        text[5] = _T("shop_both_how_to_shop_6");
			                        txtb_color[0] = #71413B;
			                        txtb_color[1] = #71413B;
			                        txtb_color[2] = #BB7547;
			                        txtb_color[3] = #BB7547;
			                        txtb_color[4] = #BB7547;
			                        txtb_color[5] = #71413B;
									speaker_sprite[0] = sprEmployeeBoy_face_angry;
									speaker_sprite[1] = sprEmployeeGirl_face_normal;
									speaker_sprite[2] = sprEmployeeGirl_face_nervous;
									speaker_sprite[3] = sprEmployeeGirl_face_normal;
									speaker_sprite[4] = sprEmployeeGirl_face_normal;
									speaker_sprite[5] = sprEmployeeBoy_face_normal;
									
									
			                        for(var i = 0; i<array_length(text);i++){
			                            txtb_snd[i] = sfx_text;
			                        }
			                    }
			                };
                
			                // RIGHT Job
			                _decision_script_struct.right = function(){
			                    instance_destroy(oTextBox);
			                    var textbox_job = instance_create_layer(0,0,"Dialogue",oTextBox);
			                    with(textbox_job){
			                        text[0] = _T("shop_both_job_1");
			                        text[1] = _T("shop_both_job_2");
			                        text[2] = _T("shop_both_job_3");
			                        text[3] = _T("shop_both_job_4");
			                        txtb_color[0] = #BB7547;
			                        txtb_color[1] = #71413B;
			                        txtb_color[2] = #BB7547;
			                        txtb_color[3] = #71413B;
									speaker_sprite[0] = sprEmployeeGirl_face_normal;
									speaker_sprite[1] = sprEmployeeBoy_face_normal;
									speaker_sprite[2] = sprEmployeeGirl_face_nervous;
									speaker_sprite[3] = sprEmployeeBoy_face_normal;
									
			                        for(var i = 0; i < array_length(text);i++){
			                            txtb_snd[i] = sfx_text;
			                        }
			                    }
			                };
                
			                // UP DUCK
			                if (global.DuckStory == 3) {
			                    // DuckStory == 3: YA USASTE EL PIENSO, NO TE DARÁN MÁS
			                    _decision_script_struct.up = function(){
			                        instance_destroy(oTextBox);
			                        var textbox_duck = instance_create_layer(0,0,"Dialogue",oTextBox);
			                        with(textbox_duck){
			                            text[0] = "* Oh, you again?";
			                            text[1] = "* We already gave you food#for the duck.";
			                            text[2] = "* You should use it wisely.";
			                            text[3] = "* ...";
			                            text[4] = "* <brown>Mr. Butterscotch<white> is#a special duck.";
			                            text[5] = "* If you already used the food,#maybe it worked?";
			                            text[6] = "* ...";
			                            text[7] = "* I don't think we can give#you more.";
			                            text[8] = "* Sorry.";
                            
			                            txtb_color[0] = c_white;
			                            txtb_color[1] = #BB7547;
			                            txtb_color[2] = #71413B;
			                            txtb_color[3] = #71413B;
			                            txtb_color[4] = #BB7547;
			                            txtb_color[5] = #BB7547;
			                            txtb_color[6] = #71413B;
			                            txtb_color[7] = #BB7547;
			                            txtb_color[8] = #BB7547;
                            
			                            for(var i = 0; i < array_length(text); i++){
			                                txtb_snd[i] = sfx_text;
			                                speaker_sprite[i] = noone;
			                            }
			                        }
			                    };
			                } else if (global.DuckStory == 2) {
			                    // DuckStory == 2: YA TIENES EL PIENSO (o lo tiraste)
			                    _decision_script_struct.up = function(){
			                        instance_destroy(oTextBox);
                        
			                        var _has_feed = false;
			                        for (var i = 0; i < array_length(global.Inventory); i++) {
			                            if (global.Inventory[i].item_id == "Duck_Feed") {
			                                _has_feed = true;
			                                break;
			                            }
			                        }
                        
			                        if (_has_feed) {
			                            // TIENE EL PIENSO que se lo dé al pato
			                            var textbox_duck = instance_create_layer(0,0,"Dialogue",oTextBox);
			                            with(textbox_duck){
			                                text[0] = "* Oh, you still have the food!";
			                                text[1] = "* You should give it to the#<brown>duck<white>.";
			                                text[2] = "* He's usually near the#park or the lake.";
			                                text[3] = "* ...";
			                                text[4] = "* Just approach him and#use the food.";
			                                text[5] = "* He'll come to you if#he trusts you.";
                                
			                                txtb_color[0] = #BB7547;
			                                txtb_color[1] = #BB7547;
			                                txtb_color[2] = #BB7547;
			                                txtb_color[3] = #71413B;
			                                txtb_color[4] = #BB7547;
			                                txtb_color[5] = #BB7547;
                                
			                                for(var i = 0; i < array_length(text); i++){
			                                    txtb_snd[i] = sfx_text;
			                                    speaker_sprite[i] = noone;
			                                }
			                            }
			                        } else {
			                            // NO TIENE EL PIENSO chica quiere dar más, chico no
			                            var textbox_duck = instance_create_layer(0,0,"Dialogue",oTextBox);
			                            with(textbox_duck){
			                                text[0] = "* ...";
			                                text[1] = "* (He doesn't have the food...)";
			                                text[2] = "* (I told you he would lose it!)";
			                                text[3] = "* (But maybe he just used it?)";
			                                text[4] = "* (Used it? He didn't even#know what to do!)";
			                                text[5] = "* ...";
			                                text[6] = "* We could give him another...";
			                                text[7] = "* NO! We can't keep giving#him food!";
			                                text[8] = "* ...";
			                                text[9] = "* *She looks at you with pity*";
			                                text[10] = "* Here... take this one.";
			                                text[11] = "* BUT-";
			                                text[12] = "* But nothing! It's just#a small bag!";
			                                text[13] = "* ...";
			                                text[14] = "* Use it well this time.#Please.";
                                
			                                txtb_color[0] = c_white;
			                                txtb_color[1] = #BB7547;
			                                txtb_color[2] = #71413B;
			                                txtb_color[3] = #BB7547;
			                                txtb_color[4] = #71413B;
			                                txtb_color[5] = c_white;
			                                txtb_color[6] = #BB7547;
			                                txtb_color[7] = #71413B;
			                                txtb_color[8] = c_white;
			                                txtb_color[9] = #BB7547;
			                                txtb_color[10] = #BB7547;
			                                txtb_color[11] = #71413B;
			                                txtb_color[12] = #BB7547;
			                                txtb_color[13] = c_white;
			                                txtb_color[14] = #BB7547;
                                
			                                for(var i = 0; i < array_length(text); i++){
			                                    txtb_snd[i] = sfx_text;
			                                    speaker_sprite[i] = noone;
			                                }
			                            }
                            
			                            // DARLE OTRO PIENSO Y CAMBIAR A DuckStory = 3
			                            global.DuckStory = 3;
			                            AddItem("Duck_Feed");
			                        }
			                    };
			                } else if (global.DuckStory == 1) {
			                    // DuckStory == 1: PRIMERA VEZ QUE HABLAN DEL PATO
			                    _decision_script_struct.up = function(){
			                        instance_destroy(oTextBox);
			                        var textbox_duck = instance_create_layer(0,0,"Dialogue",oTextBox);
			                        with(textbox_duck){
			                            text[0] = "* ...";
			                            text[1] = "* Oh... you speak about#<wait=30><brown>Mr. Butterscotch<white>?!";
			                            text[2] = "* He's an adorable, silly,#cutie ducky, isn't it?";
			                            text[3] = "* Yeah.";
			                            text[4] = "* Did you saw it?";
			                            text[5] = "* Mmmm";
			                            text[6] = "* Yeah it usually isn't#polite with visitors.";
			                            text[7] = "* Yeah, it's cool.";
			                            text[8] = "* ... Anyways if you wanna#pet it you can try with#it's favorite food.";
			                            text[9] = "* Here have some :D";
                            
			                            txtb_color[0] = c_white;
			                            txtb_color[1] = #BB7547;
			                            txtb_color[2] = #BB7547;
			                            txtb_color[3] = #71413B;
			                            txtb_color[4] = #BB7547;
			                            txtb_color[5] = #BB7547;
			                            txtb_color[6] = #BB7547;
			                            txtb_color[7] = #71413B;
			                            txtb_color[8] = #BB7547;
			                            txtb_color[9] = #BB7547;
										AddItem(global.Items.Duck_Feed);
										global.DuckStory = 2;                            
			                            for(var i = 0; i < array_length(text); i++){
			                                txtb_snd[i] = sfx_text;
			                                speaker_sprite[i] = noone;
			                            }
			                        }
			                    };
			                }
                
			                decisions[_index] = _decision_struct;
			                decision_result[_index] = {};
			                decision_script[_index] = _decision_script_struct;
                
			                if (!_duck_unlocked) {
			                    variable_struct_remove(decision_script[_index], "up");
			                }

			                for(var i = 0;i < array_length(text);i++){
			                    txtb_snd[i] = sfx_text;
			                }
			            }else if(!oShop_Basket.en_suelo && array_length(oShop_Basket.items) == 0){
			                _who_speaks_again = irandom(1);
			                if(_who_speaks_again == 0){
			                    text[0] = _T("shop_both_basket_empty_1a");
			                    text[1] = _T("shop_both_basket_empty_2a");
			                    text[2] = _T("shop_both_basket_empty_3a");
			                    txtb_color[0] = #BB7547;
			                    txtb_color[1] = #71413B;
			                    txtb_color[2] = #BB7547;
			                }else{
			                    text[0] = _T("shop_both_basket_empty_1b");
			                    text[1] = _T("shop_both_basket_empty_2b");
			                    txtb_color[0] = #71413B;
			                    txtb_color[1] = #BB7547;
			                }
			                for(var i = 0; i < array_length(text);i++){
			                    txtb_snd[i] = sfx_text;
			                    speaker_sprite[i] = noone;
			                }
			            }
			        }
			        both_interact++;
			    }
			}
        }
    }

	//dar el itme del pato//
    if (duck_dialog_active && global.DuckStory == 1) {
		show_debug_message("intenta darlo");
        if (instance_exists(oTextBox)) {
            if (oTextBox.page == 9) {
                duck_dialog_active = false; 
                AddItem(global.Items.Duck_Feed);
				global.DuckStory = 2;
            }
        } else {
            duck_dialog_active = false;
        }
    }

}
show_debug_message(global.DuckStory);