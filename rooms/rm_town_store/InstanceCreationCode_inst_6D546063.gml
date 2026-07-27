function Update_Dialogos(){
    can_interact = (oPlayer.sprite_index == sprPlayerUp && oShop_Basket.en_suelo);
}
function Dialogos(){
    text[0] = _T("shelf_h2o");
    txtb_color[0] = c_white;
    for(var i= 0;i<array_length(text);i++){
        txtb_snd[i] = sfx_text;
        speaker_sprite[i] = noone;
    }
}