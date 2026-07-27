xspd = 0;
yspd = 0;

walk_spd = 1;
run_spd = 2;

image_xscale = 1.5;
image_yscale = 1.5;

global.CanMove = true;
global.CanInventory = true;

auto_move = false;

target_x = x;
target_y = y;

move_callback = undefined;

enum PLAYER_STATE {
    NORMAL,
    AUTO_MOVE,
    INTERACTING
}

state = PLAYER_STATE.NORMAL;

waypoint_list = [];
waypoint_index = 0;

