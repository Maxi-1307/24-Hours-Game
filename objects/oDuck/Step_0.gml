
if(can_swim){
    x += spd * facing;
    
    if(x > start_x + range){
        facing = -1;
        image_xscale = 1;
    } else if(x < start_x - range){
        facing = 1;
        image_xscale = -1;
    }
    
    float_timer += 0.05;
    float_offset = sin(float_timer) * 1.5;
    y += float_offset * 0.1;
}