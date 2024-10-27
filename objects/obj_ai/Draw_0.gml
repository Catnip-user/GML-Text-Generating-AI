var max_width = 300;
var line_height = 20;
var wrapped_text = string_wrap(text, max_width);
var lines = string_split(wrapped_text, "\n");

for (var i = 0; i < array_length(lines); i++) {
    draw_text(x, y + i * line_height, lines[i]);
}