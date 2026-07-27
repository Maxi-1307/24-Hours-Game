x += vel_x;
y += vel_y;

vel_y += 0.12; 

escala -= 0.08;

if (escala <= 0) {
    instance_destroy();
}
