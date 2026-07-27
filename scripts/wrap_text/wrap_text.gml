function wrap_text_to_lines(_chars, _line_width, _sx)
{
    var lines = [];
    var current_line = [];
    var line_w = 0;

    var i = 0;
    var len = array_length(_chars);

    while (i < len) {

        var char = _chars[i];

        if (char == "#") {
            array_push(lines, current_line);
            current_line = [];
            line_w = 0;
            i++;
            continue;
        }

        var word = [];
        var word_w = 0;

        while (i < len) {
            var c = _chars[i];
            if (c == " " || c == "#") break;

            if (c != "")
                word_w += string_width(c) * _sx;

            array_push(word, i);
            i++;
        }

        if (line_w + word_w > _line_width && line_w > 0) {
            array_push(lines, current_line);
            current_line = [];
            line_w = 0;
        }

        for (var j = 0; j < array_length(word); j++) {
            var idx = word[j];
            array_push(current_line, idx);

            if (_chars[idx] != "")
                line_w += string_width(_chars[idx]) * _sx;
        }

        if (i < len && _chars[i] == " ") {
            array_push(current_line, i);
            line_w += string_width(" ") * _sx;
            i++;
        }
    }

    if (array_length(current_line) > 0) {
        array_push(lines, current_line);
    }

    return lines;
}