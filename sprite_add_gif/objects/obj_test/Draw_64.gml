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
	var gif_width = sprite_get_width(gif_sprite);
	var gif_height = sprite_get_height(gif_sprite);
	var gif_scale = max(1, min(_width div gif_width, (_height - string_height("Q") * 2) div gif_height));
	var gif_x = (_width - gif_width * gif_scale) div 2;
	var gif_y = (_height - gif_height * gif_scale) div 2;
	draw_sprite_ext(gif_sprite, gif_subimg, gif_x, gif_y, gif_scale, gif_scale, 0, c_white, 1);
	draw_rectangle(gif_x - 1.5, gif_y - 1.5, gif_x + gif_width * gif_scale + .5, gif_y + gif_height * gif_scale + .5, 1);
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