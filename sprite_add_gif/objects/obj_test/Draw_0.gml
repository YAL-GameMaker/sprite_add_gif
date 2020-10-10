
if (gif_sprite != -1) {
	gif_timer += delta_time / (1000000 / 100);
	while (gif_timer > gif_delays[gif_subimg]) {
		gif_timer -= gif_delays[gif_subimg];
		gif_subimg = (gif_subimg + 1) % gif_frames;
	}
	//
	draw_sprite(gif_sprite, gif_subimg,
		(room_width - sprite_get_width(gif_sprite)) div 2,
		(room_height - sprite_get_height(gif_sprite)) div 2,
	);
}

if (mouse_check_button_pressed(mb_left)) {
	var _path = get_open_filename("GIFs|*.gif", "");
	if (_path != "" && file_exists(_path)) loadGIF(_path);
}

draw_set_font(fnt_test);
draw_set_halign(fa_center);
draw_text(room_width div 2, 5, "Click to pick a GIF!");
draw_set_valign(fa_bottom);
draw_text(room_width div 2, room_height - 5, gif_bottom_text);
draw_set_valign(fa_top);