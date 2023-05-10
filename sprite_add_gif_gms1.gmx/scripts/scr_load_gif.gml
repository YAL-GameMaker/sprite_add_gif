var _path = argument0;
if (gif_sprite != -1) sprite_delete(gif_sprite);
gif_delays = array_create(0);
var _start = get_timer();
show_debug_message("Loading `" + _path + "`...")
gif_sprite = sprite_add_gif(_path, 0, 0, gif_delays);
gif_bottom_text = "Loaded in " + string((get_timer() - _start) div 1000) + "ms!";
show_debug_message(gif_bottom_text);
if (gif_sprite < 0) exit;
show_debug_message("GIF frame timings: " + string(gif_delays));
gif_frames = array_length_1d(gif_delays);
for (var i = 0; i < gif_frames; i++) {
    gif_delays[i] = max(gif_delays[i], 100/60);
}
gif_subimg = 0;
gif_timer = 0;
