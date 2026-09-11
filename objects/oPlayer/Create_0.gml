global.Money = 250;

global.next_bus = false;
xspd = 0;
yspd = 0;
walk_spd = 1;
run_spd = 2;
image_xscale = 1.5;
image_yscale = 1.5;
global.CanMove = true;
global.CanInventory = true;
auto_move = false;
facing_dir = 0;
move_callback = undefined;
Sprites_Walking = [sprPlayerDown, sprPlayerUp, sprPlayerLeft, sprPlayerRight];

enum PLAYER_STATE {
    NORMAL,
    AUTO_MOVE,
    INTERACTING
}
state = PLAYER_STATE.NORMAL;
waypoint_list = [];
waypoint_index = 0;

global.pf_cell_size = 16;

if (variable_global_exists("pf_grid") && ds_exists(global.pf_grid, ds_type_grid)) {
    mp_grid_destroy(global.pf_grid);
}

global.pf_grid = mp_grid_create(
    0, 0,
    room_width  / global.pf_cell_size,
    room_height / global.pf_cell_size,
    global.pf_cell_size,
    global.pf_cell_size
);

mp_grid_add_instances(global.pf_grid, oWall, false);