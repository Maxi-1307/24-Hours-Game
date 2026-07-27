var _id = ds_map_find_value(async_load, "sound_id");

if (_id == audio_actual) {

    audio_play_sound(sndSilence, 10, true);
}
