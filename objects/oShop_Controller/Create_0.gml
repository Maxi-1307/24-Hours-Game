state = 0;
var layer_objs = layer_get_id("Mopping_objects");
if (layer_exists(layer_objs)) {
    instance_deactivate_layer(layer_objs);
}



#region Odd of employees
paso_escena = 0;
espera_timer = 0;

var entro_por_la_puerta = (instance_exists(oPlayer) && oPlayer.x == 160 && oPlayer.y == 232 && oPlayer.sprite_index == sprPlayerUp);

var dado = random(100);

if (!entro_por_la_puerta) {
    dado = 99; 
}

if (dado < 15) {
    state = 0; 
} 
else if (dado >= 15 && dado < 30) {
    state = 1; 
} 
else {
    state = 2; 
    
    var tipo_turno_normal = choose(0, 1, 2); 
    
    switch(tipo_turno_normal) {
        case 0:
            var girl = instance_create_layer(226, 74, "Employees", oStore_EmployeeGirl);
            girl.sprite_index = sprStoreEmployee; 
            break;
            
        case 1:
            var boy = instance_create_layer(191, 75, "Employees", oShop_EmployeeBoy);
            boy.sprite_index = sprStore_EmployeeBoy; 
            break;
            
        case 2: 
            var boy2 = instance_create_layer(191, 75, "Employees", oShop_EmployeeBoy);
            var girl2 = instance_create_layer(226, 74, "Employees", oStore_EmployeeGirl);
            boy2.sprite_index = sprStore_EmployeeBoy;
            girl2.sprite_index = sprStoreEmployee;
            break;
    }
    
    oPlayer.state = PLAYER_STATE.NORMAL;
    global.CanInventory = true;
    global.CanMove = true;
}
#endregion

girl_alone_interact = 0;
boy_alone_interact = 0;
both_interact = 0;

canasta_cobro = noone;
items_escaneados = [];
indice_escaneo = 0;
total_compra = 0;
paso_cobro = 0;
estado_cobro = "inactivo";

duck_dialog_active = false;


function IniciarCobro() {
    estado_cobro = "intro";
    paso_cobro = 0;
    
    var _textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
    with(_textbox){
        var _choosed = 0;
        
        if(instance_exists(oStore_EmployeeGirl) && !instance_exists(oShop_EmployeeBoy)){
            text[0] = _T("checkout_girl_ready");
            txtb_color[0] = #BB7547;
            _choosed = 0;
        }else if(instance_exists(oShop_EmployeeBoy) && !instance_exists(oStore_EmployeeGirl)){
            text[0] = _T("checkout_boy_ready_1");
            text[1] = _T("checkout_boy_ready_2");
            txtb_color[0] = #71413B;
            txtb_color[1] = #71413B;
            _choosed = 1;
        }else{
            var who_asks = irandom(1);
            text[0] = "* ...";
            text[1] = "* ...";
            if(who_asks == 0){
                text[2] = _T("checkout_both_ready_1");
                txtb_color[2] = #BB7547;
            }else{
                text[2] = _T("checkout_both_ready_2");
                txtb_color[2] = #71413B;
            }
            _choosed = 2;
            txtb_color[0] = #71413B;
            txtb_color[1] = #BB7547;
        }
        
        for(var i = 0;i < array_length(text);i++){
            txtb_snd[i] = sfx_text;
            speaker_sprite[i] = noone;
        }
        
        decisions[_choosed] = {
            left: _T("option_sure"),
            right: _T("option_unsure")
        };
        decision_result[_choosed] = {};
        decision_script[_choosed] = {
            left: function(){
                instance_destroy(oTextBox);
                with(oShop_Controller){
                    IniciarEscaneo();
                }
            },
            right: function(){
                instance_destroy(oTextBox);
                with(oShop_Controller){
                    CancelarCobro("Unsure");
                }
            }
        };
    }
}

function IniciarEscaneo() {
    estado_cobro = "escaneo";
    indice_escaneo = 0;
    items_escaneados = [];
    total_compra = 0;
    
    for (var i = 0; i < array_length(canasta_cobro.items); i++) {
        array_push(items_escaneados, canasta_cobro.items[i]);
    }
    
    EscanearSiguienteItem();
}

function EscanearSiguienteItem() {
    if (indice_escaneo >= array_length(items_escaneados)) {
        MostrarTotal();
        return;
    }
    
    var _item = items_escaneados[indice_escaneo];
    total_compra += _item.precio;
    
    var _textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
    with(_textbox){
        var _text = _T("checkout_scan_item");
        _text = string_replace(_text, "{name}", _item.nombre);
        _text = string_replace(_text, "{price}", string(_item.precio));
        text[0] = _text;
        txtb_color[0] = c_white;
        txtb_snd[0] = sfx_text;
        speaker_sprite[0] = noone;
    }
    
    indice_escaneo++;
}

function MostrarTotal() {
    estado_cobro = "total";
    
    var _textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
    with(_textbox){
        var _text = _T("checkout_total");
        _text = string_replace(_text, "{total}", string(other.total_compra));
        text[0] = _text;
        txtb_color[0] = c_white;
        
        decisions[0] = {
            left: _T("option_pay"),
            right: _T("option_not_yet")
        };
        decision_result[0] = {};
        decision_script[0] = {
            left: function(){
                instance_destroy(oTextBox);
                with(oShop_Controller){
                    ProcesarPago();
                }
            },
            right: function(){
                instance_destroy(oTextBox);
                with(oShop_Controller){
                    CancelarCobro("NotYet");
                }
            }
        };
        
        for(var i = 0; i < array_length(text); i++){
            txtb_snd[i] = sfx_text;
            speaker_sprite[i] = noone;
        }
    }
}

function ProcesarPago() {
    estado_cobro = "pago";
    
    if (global.Money < total_compra) {
        var _textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
        with(_textbox){
            var _text = _T("checkout_not_enough_money");
            _text = string_replace(_text, "{needed}", string(other.total_compra));
            _text = string_replace(_text, "{have}", string(global.Money));
            text[0] = _text;
            txtb_color[0] = c_red;
            txtb_snd[0] = sfx_text;
            speaker_sprite[0] = noone;
        }
        FinalizarCobro();
        return;
    }
    
    global.Money -= total_compra;
    
    for (var i = 0; i < array_length(canasta_cobro.items); i++) {
        var _item = canasta_cobro.items[i];
        var _nuevo_item = {
            item_id: _item.id
        };
        array_push(global.Inventory, _nuevo_item);
    }
    
    canasta_cobro.items = [];
    
    canasta_cobro.x = canasta_cobro.x_origen;
    canasta_cobro.y = canasta_cobro.y_origen;
    canasta_cobro.en_suelo = true;
    canasta_cobro.propietario = noone;
    
    var _textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
    with(_textbox){
        var _hay_girl = instance_exists(oStore_EmployeeGirl);
        var _hay_boy = instance_exists(oShop_EmployeeBoy);
        
        if (_hay_girl && !_hay_boy) {
            text[0] = _T("checkout_pay_success_girl");
            txtb_color[0] = #BB7547;
        } else if (_hay_boy && !_hay_girl) {
            text[0] = _T("checkout_pay_success_boy_1");
            text[1] = _T("checkout_pay_success_boy_2");
            txtb_color[0] = #71413B;
            txtb_color[1] = #71413B;
        } else {
            text[0] = _T("checkout_pay_success_both_1");
            text[1] = _T("checkout_pay_success_both_2");
            text[2] = _T("checkout_pay_success_both_3");
            txtb_color[0] = #BB7547;
            txtb_color[1] = #71413B;
            txtb_color[2] = #71413B;
        }
        
        for(var i = 0; i < array_length(text); i++){
            speaker_sprite[i] = noone;
            txtb_snd[i] = sfx_text;
        }
    }
    
    FinalizarCobro();
}

function CancelarCobro(_razon) {
    var _textbox = instance_create_layer(0,0,"Dialogue",oTextBox);
    with(_textbox){
        var _hay_girl = instance_exists(oStore_EmployeeGirl);
        var _hay_boy = instance_exists(oShop_EmployeeBoy);
        
        if (_razon == "Unsure") {
            if (_hay_boy && !_hay_girl) {
                text[0] = _T("checkout_cancel_unsure_boy_1");
                text[1] = _T("checkout_cancel_unsure_boy_2");
                txtb_color[0] = #71413B;
                txtb_color[1] = #71413B;
            } else if (_hay_girl && !_hay_boy) {
                text[0] = _T("checkout_cancel_unsure_girl_1");
                text[1] = _T("checkout_cancel_unsure_girl_2");
                txtb_color[0] = #BB7547;
                txtb_color[1] = #BB7547;
            } else {
                text[0] = _T("checkout_cancel_unsure_both_1");
                text[1] = _T("checkout_cancel_unsure_both_2");
                txtb_color[0] = #BB7547;
                txtb_color[1] = #71413B;
            }
        } else {
            if (_hay_girl && !_hay_boy) {
                text[0] = _T("checkout_cancel_notyet_girl");
                txtb_color[0] = #BB7547;
            } else if (_hay_boy && !_hay_girl) {
                text[0] = _T("checkout_cancel_notyet_boy_1");
                text[1] = _T("checkout_cancel_notyet_boy_2");
                txtb_color[0] = #71413B;
                txtb_color[1] = #71413B;
            } else {
                text[0] = _T("checkout_cancel_notyet_both");
                txtb_color[0] = c_white;
            }
        }
        
        for(var i = 0; i < array_length(text); i++){
            speaker_sprite[i] = noone;
            txtb_snd[i] = sfx_text;
        }
    }
    
    FinalizarCobro();
}

function FinalizarCobro() {
    estado_cobro = "inactivo";
    canasta_cobro = noone;
    items_escaneados = [];
    indice_escaneo = 0;
    total_compra = 0;
    paso_cobro = 0;
}
