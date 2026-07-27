function RemoveItem(_item_id) {
    var _total = array_length(global.Inventory);
    for (var i = 0; i < _total; i++) {
        if (global.Inventory[i].item_id == _item_id) {
            array_delete(global.Inventory, i, 1);
            show_debug_message("Item eliminado del inventario: " + string(_item_id));
            return true;
        }
    }
    show_debug_message(" No se encontró el item " + string(_item_id) + " para remover.");
    return false;
}
