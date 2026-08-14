var _volume = global.Is_Indoors ? 0.5 : 1;

if (sound != last_sound)
{
    if (audio_id != noone)
    {
        audio_stop_sound(audio_id);
        audio_id = noone;
    }

    audio_id = audio_play_sound(sound, 10, true, _volume);
    last_sound = sound;
    last_volume = _volume;
}

if (audio_id == noone || !audio_is_playing(audio_id))
{
    audio_id = audio_play_sound(sound, 10, true, _volume);
}

if (_volume != last_volume)
{
    audio_sound_gain(audio_id, _volume, 0);
    last_volume = _volume;
}