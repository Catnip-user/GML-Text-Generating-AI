function string_wrap(str, max_width) {
    var text_wrapped = "";
    var space = -1;
    var char_pos = 1;
    while (string_length(str) >= char_pos) {
        if (string_width(string_copy(str, 1, char_pos)) > max_width) {
            if (space != -1) {
                text_wrapped += string_copy(str, 1, space) + "\n";
                str = string_delete(str, 1, space);
                char_pos = 1;
                space = -1;
            } else {
                text_wrapped += string_copy(str, 1, char_pos - 1) + "\n";
                str = string_delete(str, 1, char_pos - 1);
                char_pos = 1;
            }
        }
        if (string_char_at(str, char_pos) == " ") {
            space = char_pos;
        }
        char_pos += 1;
    }
    if (string_length(str) > 0) {
        text_wrapped += str;
    }
    return text_wrapped;
}