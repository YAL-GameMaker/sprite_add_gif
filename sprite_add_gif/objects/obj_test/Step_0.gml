var _width = window_get_width();
var _height = window_get_height();
if (surface_get_width(application_surface) != _width
	|| surface_get_height(application_surface) != _height
) {
	surface_resize(application_surface, _width, _height);
	display_set_gui_size(_width, _height);
}

//
if (reader != undefined) {
	var _start = get_timer();
	var _until = _start + 16 * 1000;
	var _cont;
	do {
		var _elapsed = get_timer();
		_cont = reader.next();
		_elapsed = get_timer() - _elapsed;
		
		reader_total_time += _elapsed;
		
		show_debug_message(
			"Load progress:"
			+ " frame: " + string(array_length(reader_delays))
			+ " action: '" + gif_reader_get_action_name(reader.last_action) + "'"
			+ " time: " + string(_elapsed / 1000) + "ms"
		)
	} until (!_cont || get_timer() >= _until);
	
	reader_total_frames += 1;
	
	if (!_cont || mouse_check_button_pressed(mb_left)) { // finish/abort
		loadCleanup();
		
		var _elapsed = get_timer();
		gif_sprite = reader.finish();
		reader_total_time += get_timer() - _elapsed;
		reader = undefined;
		
		gif_bottom_text = ("Loaded in "
			+ string(reader_total_time div 1000) + "ms over "
			+ string(reader_total_frames) + " frames!"
		);
		
		gif_delays = reader_delays;
		gif_frame_sprites = reader_frame_sprites;
		if (gif_sprite != -1) {
			loadPost();
		}
	}
} else if (mouse_check_button_pressed(mb_left)) {
	var _path = get_open_filename("GIFs|*.gif", "");
	if (_path != "" && file_exists(_path)) loadGIF(_path);
}

if (keyboard_check_pressed(ord("1"))) opt_gradual = !opt_gradual;
if (keyboard_check_pressed(ord("2"))) opt_frame_sprites = !opt_frame_sprites;

/*if (mouse_check_button_pressed(mb_right)) {
	sprite_save_strip(gif_sprite, "sprite.png");
}*/