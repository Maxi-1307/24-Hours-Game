draw_self();

if (!hitable) {
    image_blend = choose(c_yellow, c_white, c_green); 
} 

else if (velocidad_bonus > 0) {
    image_blend = c_aqua;
}


if (!hitable && alarm[0] <= 0) {
    image_blend = choose(c_red, c_white);
}

