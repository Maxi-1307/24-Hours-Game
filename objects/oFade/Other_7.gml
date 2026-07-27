room_goto(target_room);
oPlayer.x = target_x;
oPlayer.y = target_y;
global.CanMove = true;
global.CanInventory = true;
global.Is_Indoors = is_indoors;

switch(facing){
	case 0: oPlayer.sprite_index = sprPlayerRight;break;
	case 1: oPlayer.sprite_index = sprPlayerLeft;break;
	case 2: oPlayer.sprite_index = sprPlayerDown;break;
	case 3: oPlayer.sprite_index = sprPlayerUp;break;
}
image_speed = -1;