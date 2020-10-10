var _width = display_get_gui_width();
var _height = display_get_gui_height();

if (gif_sprite != -1) {
	var _delta = delta_time / (1000000 / 100);
	gif_timer += _delta;
	while (gif_timer > gif_delays[gif_subimg]) {
		gif_timer -= gif_delays[gif_subimg];
		gif_subimg = (gif_subimg + 1) % gif_frames;
	}
	//
	draw_sprite(gif_sprite, gif_subimg,
		(_width - sprite_get_width(gif_sprite)) div 2,
		(_height - sprite_get_height(gif_sprite)) div 2,
	);
	//
	if (mouse_check_button_pressed(mb_right)) {
		sprite_save_strip(gif_sprite, "sprite.png");
	}
}

if (mouse_check_button_pressed(mb_left)) {
	var _path = get_open_filename("GIFs|*.gif", "");
	if (_path != "" && file_exists(_path)) loadGIF(_path);
}

draw_set_font(fnt_test);
draw_set_halign(fa_center);
draw_text(_width div 2, 5, "Click to pick a GIF!");
draw_set_valign(fa_bottom);
draw_text(_width div 2, _height - 5, gif_bottom_text);
draw_set_valign(fa_top);