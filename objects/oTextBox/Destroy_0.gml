if (is_item_dialog && instance_exists(oInventory)) {
    with (oInventory) {
        menu_state = 1;
        items_act_index = 0;
        items_index = clamp(items_index, 0, array_length(global.Inventory));
    }
}

if (instance_exists(oInventory)) {
    with (oInventory) {
        if (menu_state == 6) {
            menu_state = 4;
            contact_index = 0;
            phone_submenu = false;
        }
    }
}