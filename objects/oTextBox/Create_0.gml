base_cam_w = 200;
base_cam_h = 100;
base_box_draw_x = 100;
base_box_draw_y = 75;

setup = false;

textbox_width  = 175;
textbox_height = 40;

border  = -95;
bordery = -18;
line_sep = 28;

txtb_sprite = sprTextBox;

page = 0;
page_number = 0;

draw_char = 0;
old_draw_char = 0;

text[0] = "text";

txtb_color = [];

parsed = [];
text_length = [];

text_x_offset = [];
portrait_x_offset = [];

speaker_sprite[0] = noone;
txtb_snd[0] = sfx_text;

base_text_scale_x = 0.35;
base_text_scale_y = 0.35;

txt_progress = 0;
pause_timer = 0;

target_box_y = 0;
textbox_side = 1;

decisions = [];
decision_result = [];
decision_script = [];

choosing = false;
choice_dir = "down";
result_mode = false;

block_confirm = true;
block_cancel = true;
block_skip = true;

text_fully_visible = false;
can_skip_text = true;
can_skip_page = false;
is_unskippable = false;
pending_page_skip = false;

show_debug_message("Existe el textbox");

setup = false;
page = 0;
draw_char = 0;
txt_progress = 0;
pause_timer = 0;
choosing = false;
is_answering = false;
block_confirm = true;
block_cancel = true;
block_skip = true;
text_fully_visible = false;
can_skip_text = true;
can_skip_page = false;
is_unskippable = false;
pending_page_skip = false;


camino_inicio = -1;
camino_fin = -1;

text_font = MainFont;

// Al final del Create Event
is_item_dialog = false;  // Flag para saber si es un diálogo de item