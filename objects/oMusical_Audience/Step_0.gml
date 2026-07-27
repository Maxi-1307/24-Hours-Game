y = lerp(y, y_target, 0.15);

if (fase_publico == "bajando" && abs(y - 260) < 1) {
    instance_destroy();
}
