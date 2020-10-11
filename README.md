# sprite_add_gif
Load animated GIFs as sprites in GameMaker Studio 2.3+ games
**Quick links:** [itch.io page](https://yellowafterlife.itch.io/gamemaker-sprite-add-gif)  
**Supported platforms:** All (see notes below)  
**Supported versions:** GameMaker Studio≥2.3

This extension allows you to load animated GIFs as sprites into your GameMaker games!  
It is based on Haxe ["format" library](https://github.com/HaxeFoundation/format) implementation contributed by [Yanrishatum](https://github.com/Yanrishatum).

## Functions

- **sprite_add_gif(path, xorigin, yorigin, ?delays_array)➜sprite**  
  Equivalent of sprite_add. Path should point to a valid GIF file.  
  If `delays_array` is provided (optional), per-frame delays (in centiseconds) will be pushed to it,
  allowing for accurate playback (see demo project).
- **sprite_add_gif_buffer(buffer, xorigin, yorigin, ?delays_array)➜sprite**  
  Same as above, but takes a buffer with GIF file inside.

## Setting up

Import the `GifHx` script into your GMS≥2.3 project.

## Notes

- As a pure-GML extension, it isn't _super_ fast.  
  Doing LZW decompression in GML hurts! (though slightly better with YYC)  
  Probably don't use this to load multi-megabyte GIFs.  
  It may be possible to optimize the code a little.
- As of beta runtime 23.1.1.190, doesn't work on HTML5 due to a code generation bug.  
  This will probably get fixed sometime soon.
- Note that the example project is mostly intended for Windows because GM doesn't implement file dialogs on other platforms.  
  The default sample GIF will still load though!
