var _weather = global.CURRENT_WEATHER;
var _period = oTimeAtmosphere.period;

var _pool = global.ambience[$ _weather][$ _period];

var _pool_id = _weather + "_" + _period;

if (_pool_id != last_pool_id)
{
    last_pool_id = _pool_id;

    if (array_length(_pool) > 0)
    {
        sound = _pool[irandom(array_length(_pool) - 1)];
    }
    else
    {
        sound = noone;
    }
}