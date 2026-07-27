var cantidad_items = array_length(items);

var altura_desfase = 4; 

var ajuste_fondo_cesta = 2; 

for (var i = 0; i < cantidad_items; i++) {
    var item_frame = items[i].frame;
    draw_sprite_ext(sprShopItems, item_frame, x, y - ajuste_fondo_cesta - (i * altura_desfase), 1, 1, 0, c_white, 1);
}


draw_self();
