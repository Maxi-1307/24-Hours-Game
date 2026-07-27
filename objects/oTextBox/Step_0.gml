if (instance_exists(oInventory)) {
    if (oInventory.menu_state != 6 && oInventory.menu_state != 3) {
        instance_destroy();
        exit;
    }
}

if (!setup) exit;
if (array_length(parsed) == 0) exit;
if (page >= array_length(parsed) && instance_exists(oInventory)) { 
    instance_destroy(); 
    exit; 
}

var data = parsed[page];

if (pause_timer > 0) {
    pause_timer--;
    exit;
}

var confirm_pressed = keyboard_check_pressed(global.ConfirmKey);  // Z
var cancel_pressed = keyboard_check_pressed(global.CancelKey);    // X
var skip_pressed = keyboard_check_pressed(global.MenuKey);        // C

var confirm_released = keyboard_check_released(global.ConfirmKey);
var cancel_released = keyboard_check_released(global.CancelKey);

if (confirm_released) block_confirm = false;
if (cancel_released) block_cancel = false;
if (keyboard_check_released(global.MenuKey)) block_skip = false;

var text_finished = (draw_char >= text_length[page]);
var has_decisions = (array_length(decisions) > page && is_struct(decisions[page]));


if (text_finished) {
    text_fully_visible = true;
}

var is_page_unskippable = false;
if (variable_struct_exists(data, "unskippable")) {
    is_page_unskippable = data.unskippable;
}

function PlayRemainingSFX(_data, _start_idx) {
    for (var i = _start_idx; i < array_length(_data.chars); i++) {
        var snd = _data.sfxs[i];
        if (snd != -1) {
            audio_play_sound(snd, 10, false);
        }
    }
}

if (cancel_pressed && !block_cancel) {
    if (!choosing) {
        if (!is_page_unskippable) {
            PlayRemainingSFX(data, draw_char);
            draw_char = text_length[page];
            txt_progress = 0;
            text_fully_visible = true;
        }
    }
    block_cancel = true;
}

if (!choosing && !text_finished) {
    var txt_speed = data.speeds[clamp(draw_char, 0, text_length[page] - 1)];
    txt_progress += txt_speed * 0.5;

    while (txt_progress >= 1 && draw_char < text_length[page]) {
        txt_progress -= 1;
        draw_char++;
        
        var idx = draw_char - 1;
        var w = data.waits[idx];
        if (w > 0) { 
            pause_timer = w; 
            break; 
        }
        
        var snd = data.sfxs[idx];
        if (snd != -1) audio_play_sound(snd, 10, false);
        else if (data.chars[idx] != " " && data.chars[idx] != "#") audio_play_sound(txtb_snd[page], 10, false);
    }
    
    if (draw_char >= text_length[page]) {
        text_fully_visible = true;
    }
}


if (skip_pressed && !block_skip) {
    if (!choosing) {
        if (is_page_unskippable) {
            block_skip = true;
        } else {
            PlayRemainingSFX(data, draw_char);
            draw_char = text_length[page];
            txt_progress = 0;
            text_fully_visible = true;
            
            if (!has_decisions) {
                if (camino_inicio != -1 && camino_fin != -1) {
                    if (page < camino_fin) {
                        page++;
                        draw_char = 0;
                        txt_progress = 0;
                        text_fully_visible = false;
                        block_confirm = true;
                        block_skip = true;
                    } else {
                        global.CanMove = true;
                        global.CanInventory = true;
                        instance_destroy();
                    }
                } else if (page >= page_number - 1) {
                    global.CanMove = true;
                    global.CanInventory = true;
                    instance_destroy();
                } else {
                    page++;
                    draw_char = 0;
                    txt_progress = 0;
                    text_fully_visible = false;
                    block_confirm = true;
                    block_skip = true;
                }
            }
        }
    }
    block_skip = true;
}

if (choosing) {
    var d = decisions[page];
    if (is_struct(d)) {
        var old_choice = choice_dir;
        
        if (keyboard_check_pressed(global.UpKey) && variable_struct_exists(d, "up")) {
            choice_dir = "up";
        }
        else if (keyboard_check_pressed(global.DownKey) && variable_struct_exists(d, "down")) {
            choice_dir = "down";
        }
        else if (keyboard_check_pressed(global.LeftKey) && variable_struct_exists(d, "left")) {
            choice_dir = "left";
        }
        else if (keyboard_check_pressed(global.RightKey) && variable_struct_exists(d, "right")) {
            choice_dir = "right";
        }
        
        if (!variable_struct_exists(d, choice_dir)) {
            choice_dir = old_choice;
        }
    }
}

if (confirm_pressed && !block_confirm) {
    
    if (!text_finished && !choosing) {
        block_confirm = true;
    }
    
    else if (text_finished && has_decisions && !choosing) {
        choosing = true;
        block_confirm = true;
    }
    
    else if (choosing) {
        var d_res = decision_result[page];
        var d_scr = decision_script[page];
        
        var d = decisions[page];
        if (is_struct(d) && variable_struct_exists(d, choice_dir)) {
            
            if (is_struct(d_scr) && variable_struct_exists(d_scr, choice_dir)) {
                var scr = d_scr[$ choice_dir];
                if (is_callable(scr)) scr();
            }
            
            if (is_struct(d_res) && variable_struct_exists(d_res, choice_dir)) {
                var _next_page = d_res[$ choice_dir];
                var _end_page = array_length(text) - 1;
                
                var _smallest_reserved = -1;
                for (var i = 0; i < array_length(decision_result); i++) {
                    if (is_struct(decision_result[i])) {
                        var _dr = decision_result[i];
                        if (variable_struct_exists(_dr, "left")) {
                            var _val = _dr.left;
                            if (_val > _next_page && (_smallest_reserved == -1 || _val < _smallest_reserved)) {
                                _smallest_reserved = _val;
                            }
                        }
                        if (variable_struct_exists(_dr, "right")) {
                            var _val = _dr.right;
                            if (_val > _next_page && (_smallest_reserved == -1 || _val < _smallest_reserved)) {
                                _smallest_reserved = _val;
                            }
                        }
                        if (variable_struct_exists(_dr, "up")) {
                            var _val = _dr.up;
                            if (_val > _next_page && (_smallest_reserved == -1 || _val < _smallest_reserved)) {
                                _smallest_reserved = _val;
                            }
                        }
                        if (variable_struct_exists(_dr, "down")) {
                            var _val = _dr.down;
                            if (_val > _next_page && (_smallest_reserved == -1 || _val < _smallest_reserved)) {
                                _smallest_reserved = _val;
                            }
                        }
                    }
                }
                
                if (_smallest_reserved != -1) {
                    _end_page = _smallest_reserved - 1;
                }
                
                camino_inicio = _next_page;
                camino_fin = _end_page;
                
                page = _next_page;
                draw_char = 0;
                txt_progress = 0;
                text_fully_visible = false;
                choosing = false;
                is_answering = true;
                block_confirm = true;
            }
        }
    }
    
    else if (text_finished && !has_decisions && !choosing) {
        if (camino_inicio != -1 && camino_fin != -1) {
            if (page < camino_fin) {
                page++;
                draw_char = 0;
                txt_progress = 0;
                text_fully_visible = false;
                block_confirm = true;
            } else {
                global.CanMove = true;
                global.CanInventory = true;
                instance_destroy();
            }
        } else {
            if (page >= page_number - 1) {
                global.CanMove = true;
                global.CanInventory = true;
                instance_destroy();
            } else {
                page++;
                draw_char = 0;
                txt_progress = 0;
                text_fully_visible = false;
                block_confirm = true;
            }
        }
    }
}