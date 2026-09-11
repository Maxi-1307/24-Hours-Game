
depth = oPlayer.depth - 1;

if (instance_exists(oPlayer)) {
    if (place_meeting(x, y, oPlayer)) {
        
        if (active == 0) {
            active = 1;
            current_wind = "right";
            cycle_counted = false;
        }
        
        if (oPlayer.image_index >= oPlayer.image_number - 1) {
            if (!cycle_counted) {
                cycle_counted = true;
                
                current_wind = (current_wind == "right") ? "left" : "right";
            }
        } else {
            cycle_counted = false;
        }

        var _is_moving = (oPlayer.xspd != 0 || oPlayer.yspd != 0);

        if (_is_moving) {
            if (current_wind == "right") {
                oPlayer.Sprites_Walking = [sprPlayerDownWindRight, sprPlayerUpWindRight, sprPlayerLeftWindRight, sprPlayerRightWindRight];
            } else {
                oPlayer.Sprites_Walking = [sprPlayerDownWindLeft, sprPlayerUpWindLeft, sprPlayerLeftWindLeft, sprPlayerRightWindLeft];
            }
        } else {
            if (current_wind == "right") {
                oPlayer.Sprites_Walking = [sprPlayerDownIdleWindRight, sprPlayerUpIdleWindRight, sprPlayerLeftIdleWindRight, sprPlayerRightIdleWindRight];
            } else {
                oPlayer.Sprites_Walking = [sprPlayerDownIdleWindLeft, sprPlayerUpIdleWindLeft, sprPlayerLeftIdleWindLeft, sprPlayerRightIdleWindLeft];
            }
        }

    } else {
        if (active == 1) {
            active = 0;
            oPlayer.Sprites_Walking = [sprPlayerDown, sprPlayerUp, sprPlayerLeft, sprPlayerRight];
        }
    }
}