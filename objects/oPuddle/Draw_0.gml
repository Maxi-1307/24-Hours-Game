if (!instance_exists(oPlayer)) { 
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, alpha_dinamico);
    exit; 
}

var _cam_w = camera_get_view_width(view_camera);
var _cam_h = camera_get_view_height(view_camera);
var _cam_x = camera_get_view_x(view_camera);
var _cam_y = camera_get_view_y(view_camera);

if (!surface_exists(puddle_surf)) {
    puddle_surf = surface_create(_cam_w, _cam_h);
}

surface_set_target(puddle_surf);
draw_clear_alpha(c_black, 0);

draw_sprite_ext(sprite_index, image_index, x - _cam_x, y - _cam_y, image_xscale, image_yscale, image_angle, c_white, 1);

gpu_set_blendmode_ext(bm_dest_alpha, bm_inv_dest_alpha);

var _distancia_y = oPlayer.y - y;

var _ref_x = oPlayer.x - _cam_x;
var _ref_y = (y - _distancia_y) - _cam_y;

draw_sprite_ext(oPlayer.sprite_index, oPlayer.image_index,  _ref_x, _ref_y, oPlayer.image_xscale, oPlayer.image_yscale, 180,#2a3546,0.80);

gpu_set_blendmode(bm_normal);
draw_sprite_ext(sprite_index, image_index, x - _cam_x, y - _cam_y, image_xscale, image_yscale, image_angle, c_white, 0.40);

surface_reset_target();

draw_surface_ext(puddle_surf, _cam_x, _cam_y, 1, 1, 0, c_white, alpha_dinamico);
