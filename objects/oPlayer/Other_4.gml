if(!instance_exists(oSave) && global.CanMove){
	instance_create_layer(0,0,"Dialogue",oSave);
}
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