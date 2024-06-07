opt_gradual = true;
opt_frame_sprites = true;

gif_sprite = -1; // sprite containing the GIF frames
gif_frame_sprites = undefined;
gif_subimg = 0; // current frame index
gif_delays = [0]; // delays per frame, in centiseconds
gif_frames = 0; // number of frames in the GIF
gif_timer = 0; // accumulates centiseconds for moving over to the next frame
gif_bottom_text = ""; // informative

// gradual loading:
reader = undefined; /// @is {gif_reader}
reader_total_time = 0; // total time
reader_total_frames = 0;
reader_delays = [];
reader_frame_sprites = [];

function loadGIF(_path) {
	show_debug_message("Loading `" + _path + "`...");
	
	//
	var _start = get_timer();
	if (opt_gradual) {
		reader_delays = [];
		reader_frame_sprites = opt_frame_sprites ? [] : undefined;
		reader = sprite_add_gif_start(_path, 0, 0, reader_delays, reader_frame_sprites);
		reader_total_time = get_timer() - _start;
		reader_total_frames = 1;
		exit;
	}
	
	// all at once!
	loadCleanup();
	gif_delays = [];
	gif_frame_sprites = opt_frame_sprites ? [] : undefined;
	gif_sprite = sprite_add_gif(_path, 0, 0, gif_delays, gif_frame_sprites);
	gif_bottom_text = "Loaded in " + string((get_timer() - _start) div 1000) + "ms!";
	show_debug_message(gif_bottom_text);
	if (!sprite_exists(gif_sprite)) exit;
	
	//
	loadPost();
}
function loadCleanup() {
	// cleanup old stuff:
	if (gif_frame_sprites != undefined) {
		var n = array_length(gif_frame_sprites);
		for (var i = 0; i < n; i++) {
			sprite_delete(gif_frame_sprites[i]);
		}
		gif_frame_sprites = undefined;
		gif_sprite = -1;
		
		// (gif_sprite is part of gif_frame_sprites)
	} else if (gif_sprite != -1) {
		sprite_delete(gif_sprite);
		gif_sprite = -1;
	}
}
function loadPost() {
	show_debug_message("GIF frame timings: " + string(gif_delays));
	gif_frames = array_length(gif_delays);
	gif_subimg = 0;
	gif_timer = 0;
	
	// TODO: zero-length frames are shown at *some* delay but maybe not 60fps
	for (var i = 0; i < gif_frames; i++) {
		gif_delays[i] = max(gif_delays[i], 100/60);
	}
}
loadGIF("Edited Frog Run Cycle from Pixel Adventure by Pixel Frog.gif");