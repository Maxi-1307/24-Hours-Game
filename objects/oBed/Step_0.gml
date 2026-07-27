global.CanMove = false;
global.CanInventory = false;
switch (state) {
    case 0:
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
            state = 1;
            timer = 0;
        }
    break;

    case 1:
        timer++;
        if (timer >= wait_time) {
            state = 2;
			if(instance_exists(oTextBox)){
				instance_destroy(oTextBox);
			}
            image_speed = -1;
        }
    break;

    case 2:
        if (image_index + image_speed <= 0) { 
            image_index = 0;
            image_speed = 0;
            audio_resume_all();
            global.CanInventory = true;
            global.CanMove = true;
			oPlayer.sprite_index = sprPlayerDown;
            
            instance_destroy(); 
        }
    break;
}
