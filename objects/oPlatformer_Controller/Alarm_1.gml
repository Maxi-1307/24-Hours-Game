var _trans = instance_create_depth(0, 0, -10000, oPlatformer_Transition);

_trans.siguiente_sala = rm_town_arcade; 

if (instance_exists(oPlayer)) {
    global.CanMove = true;
	global.CanInventory = true;
}

instance_destroy();
