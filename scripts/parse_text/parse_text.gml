function parse_text(_text)
{
    var chars  = [];
    var colors = [];
    var shakes = [];
    var sfxs   = [];
    var waits  = [];
    var speeds = [];

    var current_color = c_white;
    var current_shake = false;
    var current_speed = 1;
    var page_unskippable = false;

    var i = 1;

    while (i <= string_length(_text)) {

        var char = string_char_at(_text, i);

        if (char == "<") {

            var tag = "";
            i++;

            while (i <= string_length(_text) && string_char_at(_text, i) != ">") {
                tag += string_char_at(_text, i);
                i++;
            }

            if (tag == "unskippable") {
                page_unskippable = true;
                i++;
                continue;
            }
            
            switch (tag) {
                case "white":  current_color = c_white; break;
                case "yellow": current_color = c_yellow; break;
                case "red":    current_color = c_red; break;
                case "green":  current_color = c_lime; break;
                case "blue":   current_color = c_aqua; break;
                case "cyan":   current_color = c_aqua; break;
                case "purple": current_color = make_color_rgb(160, 0, 255); break;
                case "pink":   current_color = make_color_rgb(255, 100, 180); break;
                case "orange": current_color = make_color_rgb(255, 140, 0); break;
                case "gray":   current_color = c_gray; break;
                case "brown":  current_color = make_color_rgb(139, 69, 19); break;
            }

            if (tag == "shake") current_shake = true;
            else if (tag == "/shake") current_shake = false;

            else if (string_copy(tag,1,4) == "sfx=") {
                var snd = asset_get_index(string_delete(tag,1,4));
                array_push(chars, "");
                array_push(colors, current_color);
                array_push(shakes, current_shake);
                array_push(sfxs, snd);
                array_push(waits, 0);
                array_push(speeds, current_speed);
                i++;
                continue;
            }

            else if (string_copy(tag,1,5) == "wait=") {
                var w = real(string_delete(tag,1,5));
                array_push(chars, "");
                array_push(colors, current_color);
                array_push(shakes, current_shake);
                array_push(sfxs, -1);
                array_push(waits, w);
                array_push(speeds, current_speed);
                i++;
                continue;
            }

            else if (string_copy(tag,1,6) == "speed=") {
                current_speed = real(string_delete(tag,1,6));
            }

            i++;
            continue;
        }

        array_push(chars, char);
        array_push(colors, current_color);
        array_push(shakes, current_shake);
        array_push(sfxs, -1);
        array_push(waits, 0);
        array_push(speeds, current_speed);

        i++;
    }

    return {
        chars  : chars,
        colors : colors,
        shakes : shakes,
        sfxs   : sfxs,
        waits  : waits,
        speeds : speeds,
        unskippable : page_unskippable
    };
}