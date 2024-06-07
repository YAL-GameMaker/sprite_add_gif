#define gif_preinit
// Generated at 2024-06-07 13:33:13 (913ms) for v1.4.1804+
/// @lint nullToAny true
// Feather disable all
//{ prototypes
globalvar mq_gif_reader; mq_gif_reader = gif_std_haxe_type_proto(undefined, /* 1:frames */undefined, /* 2:fin_frame_count */0, /* 3:width */0, /* 4:height */0, /* 5:loops */0, /* 6:xorig */0, /* 7:yorig */0, /* 8:buffer */undefined, /* 9:owns_buffer */undefined, /* 10:sprite */undefined, /* 11:frame_delays */undefined, /* 12:frame_sprites */undefined, /* 13:reader */undefined, /* 14:info */undefined, /* 15:gce */undefined, /* 16:global_color_table */undefined, /* 17:current_frame */0, /* 18:set_delay */undefined, /* 19:drawer */undefined, /* 20:last_action */undefined, /* 21:found_eof */undefined, /* 22:next_frame */undefined);
globalvar mq_gif_frame; mq_gif_frame = gif_std_haxe_type_proto(undefined, /* 1:delay */0, /* 2:buffer */undefined, /* 3:x */0, /* 4:y */0, /* 5:width */0, /* 6:height */0, /* 7:disposal_method */0);
globalvar mq_gif_drawer; mq_gif_drawer = gif_std_haxe_type_proto(undefined, /* 1:restore_buf */undefined, /* 2:surface */undefined, /* 3:gif */undefined);
globalvar mq_gif_raw_reader; mq_gif_raw_reader = gif_std_haxe_type_proto(undefined, /* 1:i */undefined);
globalvar mq_gif_std_haxe_class; mq_gif_std_haxe_class = gif_std_haxe_type_proto(undefined, /* 1:marker */undefined, /* 2:index */0, /* 3:name */undefined, /* 4:superClass */undefined, /* 5:constructor */undefined);
globalvar mq_gif_std_haxe_enum; mq_gif_std_haxe_enum = gif_std_haxe_type_proto(undefined, /* 1:marker */undefined, /* 2:index */0, /* 3:name */undefined, /* 4:constructors */undefined, /* 5:functions */undefined);
globalvar mq_gif_std_haxe_io_Bytes; mq_gif_std_haxe_io_Bytes = gif_std_haxe_type_proto(undefined, /* 1:b */undefined);
globalvar mq_gif_std_haxe_io_Output; mq_gif_std_haxe_io_Output = gif_std_haxe_type_proto(undefined, /* 1:data */undefined, /* 2:dataPos */0, /* 3:dataLen */0, /* 4:flush */undefined, /* 5:close */undefined);
globalvar mq_gif_std_haxe_io_BytesOutput; mq_gif_std_haxe_io_BytesOutput = gif_std_haxe_type_proto(undefined, /* 1:data */undefined, /* 2:dataPos */0, /* 3:dataLen */0, /* 4:flush */undefined, /* 5:close */undefined);
//}
//{ metatype
globalvar gif_std_haxe_type_markerValue; gif_std_haxe_type_markerValue = 0; gif_std_haxe_type_markerValue[0] = undefined;
globalvar mt_gif_reader; mt_gif_reader = gif_std_haxe_class_create(7, "gif_reader");
globalvar mt_gif_frame; mt_gif_frame = gif_std_haxe_class_create(8, "gif_frame");
globalvar mt_gif_drawer; mt_gif_drawer = gif_std_haxe_class_create(9, "gif_drawer");
globalvar mt_gif_raw_reader; mt_gif_raw_reader = gif_std_haxe_class_create(10, "gif_raw_reader");
globalvar mt_format_gif_block; mt_format_gif_block = gif_std_haxe_enum_create(11, "format_gif_block");
globalvar mt_format_gif_extension; mt_format_gif_extension = gif_std_haxe_enum_create(12, "format_gif_extension");
globalvar mt_format_gif_application_extension; mt_format_gif_application_extension = gif_std_haxe_enum_create(13, "format_gif_application_extension");
globalvar mt_format_gif_version; mt_format_gif_version = gif_std_haxe_enum_create(14, "format_gif_version");
globalvar mt_format_gif_disposal_method; mt_format_gif_disposal_method = gif_std_haxe_enum_create(15, "format_gif_disposal_method");
globalvar mt_gif_std_haxe_class; mt_gif_std_haxe_class = gif_std_haxe_class_create(17, "gif_std_haxe_class");
globalvar mt_gif_std_haxe_enum; mt_gif_std_haxe_enum = gif_std_haxe_class_create(18, "gif_std_haxe_enum");
globalvar mt_gif_std_haxe_io_Bytes; mt_gif_std_haxe_io_Bytes = gif_std_haxe_class_create(19, "gif_std_haxe_io_Bytes");
globalvar mt_gif_std_haxe_io_Output; mt_gif_std_haxe_io_Output = gif_std_haxe_class_create(20, "gif_std_haxe_io_Output");
globalvar mt_gif_std_haxe_io_BytesOutput; mt_gif_std_haxe_io_BytesOutput = gif_std_haxe_class_create(21, "gif_std_haxe_io_BytesOutput");
//}
enum gif_reader_action { none, meta, frame, gce, render, eof }
// gif_drawer:
globalvar g_gif_drawer_white32; /// @is {sprite}
g_gif_drawer_white32 = -1;
// gif_raw_reader:
globalvar g_gif_raw_reader_read_string_tmp_buf; /// @is {buffer}
g_gif_raw_reader_read_string_tmp_buf = -1;
/// @typedef {array} format_gif_block
// format.gif.block:
globalvar format_gif_block_beof; format_gif_block_beof = mc_format_gif_block_beof(); /// @is {format_gif_block}
/// @typedef {array} format_gif_extension
/// @typedef {array} format_gif_application_extension
/// @typedef {array} format_gif_version
// format.gif.version:
globalvar format_gif_version_gif87a; format_gif_version_gif87a = mc_format_gif_version_gif87a(); /// @is {format_gif_version}
globalvar format_gif_version_gif89a; format_gif_version_gif89a = mc_format_gif_version_gif89a(); /// @is {format_gif_version}
/// @typedef {array} format_gif_disposal_method
// format.gif.disposal_method:
globalvar format_gif_disposal_method_unspecified; format_gif_disposal_method_unspecified = mc_format_gif_disposal_method_unspecified(); /// @is {format_gif_disposal_method}
globalvar format_gif_disposal_method_no_action; format_gif_disposal_method_no_action = mc_format_gif_disposal_method_no_action(); /// @is {format_gif_disposal_method}
globalvar format_gif_disposal_method_fill_background; format_gif_disposal_method_fill_background = mc_format_gif_disposal_method_fill_background(); /// @is {format_gif_disposal_method}
globalvar format_gif_disposal_method_render_previous; format_gif_disposal_method_render_previous = mc_format_gif_disposal_method_render_previous(); /// @is {format_gif_disposal_method}
// haxe.io._bytes.bytes_impl:
globalvar g_haxe_io__bytes_bytes_impl_buffer; /// @is {buffer}
haxe_io__bytes_bytes_impl_buffer = buffer_create(128, buffer_grow, 1);

//{ gif_reader

#define gif_reader_create
var _this; _this[0/* metatype */] = mt_gif_reader;
array_copy(_this, 1, mq_gif_reader, 1, 22);
/// @typedef {tuple<any,frames:array<gif_frame>,fin_frame_count:int,width:int,height:int,loops:int,xorig:int,yorig:int,buffer:buffer,owns_buffer:bool,sprite:sprite,frame_delays:array<int>,frame_sprites:array<sprite>,reader:gif_raw_reader,info:GifData?,gce:format_gif_GraphicControlExtension,global_color_table:array<int>,current_frame:int,set_delay:bool,drawer:gif_drawer,last_action:gif_reader_action,found_eof:bool,next_frame:gif_frame>} gif_reader
_this[@22/* next_frame */] = undefined;
_this[@21/* found_eof */] = false;
_this[@20/* last_action */] = gif_reader_action.none;
_this[@19/* drawer */] = undefined;
_this[@18/* set_delay */] = false;
_this[@17/* current_frame */] = -1;
_this[@16/* global_color_table */] = undefined;
_this[@15/* gce */] = undefined;
_this[@14/* info */] = undefined;
_this[@10/* sprite */] = -1;
_this[@9/* owns_buffer */] = false;
_this[@5/* loops */] = -1;
_this[@4/* height */] = 0;
_this[@3/* width */] = 0;
_this[@2/* fin_frame_count */] = 0;
_this[@1/* frames */] = gif_std_haxe_boot_decl();
_this[@8/* buffer */] = argument[0];
_this[@6/* xorig */] = argument[1];
_this[@7/* yorig */] = argument[2];
_this[@11/* frame_delays */] = argument[3];
_this[@12/* frame_sprites */] = argument[4];
return _this;

#define gif_reader_get_action_name
switch (argument[0]) {
	case gif_reader_action.none: return "None";
	case gif_reader_action.meta: return "Meta";
	case gif_reader_action.frame: return "Frame";
	case gif_reader_action.gce: return "GCE";
	case gif_reader_action.render: return "Render";
	case gif_reader_action.eof: return "EOF";
}

#define sprite_add_gif_buffer
var _frameDelays, _frameSprites;
if (argument_count > 3) _frameDelays = argument[3]; else _frameDelays = undefined;
if (argument_count > 4) _frameSprites = argument[4]; else _frameSprites = undefined;
var _gif = gif_reader_create(argument[0], argument[1], argument[2], _frameDelays, _frameSprites);
gif_reader_start(_gif);
while (gif_reader_next(_gif)) { }
return gif_reader_finish(_gif);

#define sprite_add_gif_buffer_start
var _frameDelays, _frameSprites;
if (argument_count > 3) _frameDelays = argument[3]; else _frameDelays = undefined;
if (argument_count > 4) _frameSprites = argument[4]; else _frameSprites = undefined;
var _gif = gif_reader_create(argument[0], argument[1], argument[2], _frameDelays, _frameSprites);
gif_reader_start(_gif);
return _gif;

#define sprite_add_gif
var _frameDelays, _frameSprites;
if (argument_count > 3) _frameDelays = argument[3]; else _frameDelays = undefined;
if (argument_count > 4) _frameSprites = argument[4]; else _frameSprites = undefined;
var _buf = buffer_load(argument[0]);
var _spr = sprite_add_gif_buffer(_buf, argument[1], argument[2], _frameDelays, _frameSprites);
buffer_delete(_buf);
return _spr;

#define sprite_add_gif_start
var _frameDelays, _frameSprites;
if (argument_count > 3) _frameDelays = argument[3]; else _frameDelays = undefined;
if (argument_count > 4) _frameSprites = argument[4]; else _frameSprites = undefined;
var _buf = buffer_load(argument[0]);
var _gif = sprite_add_gif_buffer_start(_buf, argument[1], argument[2], _frameDelays, _frameSprites);
_gif[@9/* owns_buffer */] = true;
return _gif;

#define gif_reader_destroy
var _this = argument[0];
var __g = 0;
var __g1 = _this[1/* frames */];
while (__g < array_length_1d(__g1)) {
	var _frame = __g1[__g];
	++__g;
	gif_frame_destroy(_frame);
}
if (_this[9/* owns_buffer */] && _this[8/* buffer */] != -1) {
	buffer_delete(_this[8/* buffer */]);
	_this[@8/* buffer */] = -1;
}
if (_this[19/* drawer */] != undefined) gif_drawer_destroy(_this[19/* drawer */]);

#define gif_reader_start
var _this = argument[0];
_this[@13/* reader */] = gif_raw_reader_create(_this[8/* buffer */]);
_this[@14/* info */] = gif_raw_reader_read(_this[13/* reader */], false);
_this[@3/* width */] = gif_std_haxe_boot_wget(gif_std_haxe_boot_wget(_this[14/* info */], 1), 0);
_this[@4/* height */] = gif_std_haxe_boot_wget(gif_std_haxe_boot_wget(_this[14/* info */], 1), 1);
if (gif_std_haxe_boot_wget(_this[14/* info */], 2) != undefined) _this[@16/* global_color_table */] = gif_loader_tools_color_table_to_vector(gif_std_haxe_boot_wget(_this[14/* info */], 2), gif_std_haxe_boot_wget(gif_std_haxe_boot_wget(_this[14/* info */], 1), 5));

#define gif_reader_read_frame
var _this = argument[0], _f = argument[1];
var _gf = gif_frame_create();
var _transparentIndex = -1;
if (_this[15/* gce */] != undefined) {
	_gf[@1/* delay */] = gif_std_haxe_boot_wget(_this[15/* gce */], 3);
	if (gif_std_haxe_boot_wget(_this[15/* gce */], 2)) _transparentIndex = gif_std_haxe_boot_wget(_this[15/* gce */], 4);
	switch (gif_std_haxe_boot_wget(gif_std_haxe_boot_wget(_this[15/* gce */], 0), 0)) {
		case 2: _gf[@7/* disposal_method */] = 1; break;
		case 3: _gf[@7/* disposal_method */] = 2; break;
	}
}
_gf[@3/* x */] = _f[0/* x */];
_gf[@4/* y */] = _f[1/* y */];
_gf[@5/* width */] = _f[2/* width */];
_gf[@6/* height */] = _f[3/* height */];
var _colorTable = _this[16/* global_color_table */];
if (_f[9/* colorTable */] != undefined) _colorTable = gif_loader_tools_color_table_to_vector(_f[9/* colorTable */], _f[7/* localColorTableSize */]);
var _fWidth = _f[2/* width */];
var _fHeight = _f[3/* height */];
var _sf = surface_create(_fWidth, _fHeight);
var _pxData = gif_std_haxe_boot_wget(_f[8/* pixels */], 1);
var _buf = buffer_create(_f[2/* width */] * _f[3/* height */] * 4, buffer_fixed, 1);
for (var _i = 0, __g1 = array_length_1d(gif_std_haxe_boot_wget(_f[8/* pixels */], 1)); _i < __g1; ++_i) {
	var _col = _pxData[_i];
	if (_col == _transparentIndex) buffer_write(_buf, buffer_s32, 0); else buffer_write(_buf, buffer_s32, _colorTable[_col]);
}
_gf[@2/* buffer */] = _buf;
buffer_set_surface(_buf, _sf, 0, 0, 0);
_this[@15/* gce */] = undefined;
gif_std_gml_internal_ArrayImpl_push(_this[1/* frames */], _gf);
_this[@22/* next_frame */] = _gf;

#define gif_reader_get_last_action
var _this = argument[0];
return _this[20/* last_action */];

#define gif_reader_get_last_action_name
var _this = argument[0];
return gif_reader_get_action_name(_this[20/* last_action */]);

#define gif_reader_get_frame_count
var _this = argument[0];
return _this[2/* fin_frame_count */];

#define gif_reader_get_sprite
var _this = argument[0];
return _this[10/* sprite */];

#define gif_reader_next
var _this = argument[0];
if (_this[21/* found_eof */]) return false;
var _frame = _this[22/* next_frame */];
if (_frame != undefined) {
	_this[@22/* next_frame */] = undefined;
	if (_this[19/* drawer */] == undefined) _this[@19/* drawer */] = gif_drawer_create(_this);
	gif_drawer_draw(_this[19/* drawer */], _frame);
	var _fdelay = _frame[1/* delay */];
	var _tmp = _this[11/* frame_delays */];
	if (_tmp != undefined) gif_std_gml_internal_ArrayImpl_push(_tmp, _fdelay);
	_this[@20/* last_action */] = gif_reader_action.render;
	_this[@2/* fin_frame_count */] += 1;
	return true;
}
var _block = gif_raw_reader_read_next(_this[13/* reader */], gif_std_haxe_boot_wget(_this[14/* info */], 3));
switch (_block[0]/* format_gif_block */) {
	case 0/* bframe */:
		gif_reader_read_frame(_this, _block[1/* frame */]);
		_this[@20/* last_action */] = gif_reader_action.frame;
		break;
	case 1/* bextension */:
		var __g = _block[1/* extension */];
		switch (__g[0]/* format_gif_extension */) {
			case 3/* eapplication_extension */:
				var __g1 = __g[1/* ext */];
				if (__g1[0]/* format_gif_application_extension */ == 0/* aenetscape_looping */) {
					var _n = __g1[1/* loops */];
					_this[@5/* loops */] = _n;
					_this[@20/* last_action */] = gif_reader_action.meta;
				} else _this[@20/* last_action */] = gif_reader_action.meta;
				break;
			case 0/* egraphic_control */:
				_this[@15/* gce */] = __g[1/* gce */];
				_this[@20/* last_action */] = gif_reader_action.gce;
				break;
			default: _this[@20/* last_action */] = gif_reader_action.meta;
		}
		break;
	case 2/* beof */:
		_this[@20/* last_action */] = gif_reader_action.eof;
		_this[@21/* found_eof */] = true;
		return false;
}
return true;

#define gif_reader_next_few
var _this = argument[0];
var _till = current_time + argument[1];
var _cont;
do {
	_cont = gif_reader_next(_this);
} until (!(_cont && current_time < _till));
return _cont;

#define gif_reader_finish
var _this = argument[0];
_this[@21/* found_eof */] = true;
gif_reader_destroy(_this);
return _this[10/* sprite */];

//}

//{ gif_frame

#define gif_frame_create
var _this; _this[0/* metatype */] = mt_gif_frame;
array_copy(_this, 1, mq_gif_frame, 1, 7);
/// @typedef {tuple<any,delay:int,buffer:buffer,x:int,y:int,width:int,height:int,disposal_method:int>} gif_frame
_this[@7/* disposal_method */] = 0;
_this[@2/* buffer */] = -1;
_this[@1/* delay */] = 0;
return _this;

#define gif_frame_destroy
var _this = argument[0];
if (_this[2/* buffer */] != -1) {
	buffer_delete(_this[2/* buffer */]);
	_this[@2/* buffer */] = -1;
}

//}

//{ gif_loader_tools

#define gif_loader_tools_color_table_to_vector
var _pal = argument[0], _num = argument[1];
var _r, _g, _b;
var _p = 0;
var _a = 255;
var _vec = gmv_array_create(_num, undefined);
for (var _i = 0; _i < _num; ++_i) {
	_r = gif_std_haxe_boot_wget(_pal[1/* b */], _p);
	_g = gif_std_haxe_boot_wget(_pal[1/* b */], _p + 1);
	_b = gif_std_haxe_boot_wget(_pal[1/* b */], _p + 2);
	var _val = ((((_a << 24) | (_r << 16)) | (_g << 8)) | _b);
	_vec[@_i] = _val;
	_p += 3;
}
return _vec;

//}

//{ gif_drawer

#define gif_drawer_create
var _this; _this[0/* metatype */] = mt_gif_drawer;
array_copy(_this, 1, mq_gif_drawer, 1, 3);
/// @typedef {tuple<any,restore_buf:buffer,surface:surface,gif:gif_reader>} gif_drawer
_this[@2/* surface */] = -1;
_this[@1/* restore_buf */] = -1;
if (g_gif_drawer_white32 == -1) gif_drawer_init_white32();
_this[@3/* gif */] = argument[0];
return _this;

#define gif_drawer_init_white32
var _ws = surface_create(32, 32);
surface_set_target(_ws);
draw_clear(16777215);
surface_reset_target();
g_gif_drawer_white32 = sprite_create_from_surface(_ws, 0, 0, surface_get_width(_ws), surface_get_height(_ws), false, false, 0, 0);
surface_free(_ws);

#define gif_drawer_destroy
var _this = argument[0];
if (_this[1/* restore_buf */] != -1) {
	buffer_delete(_this[1/* restore_buf */]);
	_this[@1/* restore_buf */] = -1;
}
if (surface_exists(_this[2/* surface */])) {
	surface_free(_this[2/* surface */]);
	_this[@2/* surface */] = -1;
}

#define gif_drawer_draw
var _this = argument[0], _frame = argument[1];
var _sprite1 = gif_std_haxe_boot_wget(_this[3/* gif */], 10);
if (!surface_exists(_this[2/* surface */])) {
	var _sf = surface_create(gif_std_haxe_boot_wget(_this[3/* gif */], 3), gif_std_haxe_boot_wget(_this[3/* gif */], 4));
	surface_set_target(_sf);
	draw_clear_alpha(16777215, 0);
	if (_sprite1 != -1) draw_sprite(_sprite1, sprite_get_number(_sprite1) - 1, gif_std_haxe_boot_wget(_this[3/* gif */], 6), gif_std_haxe_boot_wget(_this[3/* gif */], 7));
	surface_reset_target();
	_this[@2/* surface */] = _sf;
}
if (_frame[7/* disposal_method */] == 2) {
	if (_this[1/* restore_buf */] == -1) _this[@1/* restore_buf */] = buffer_create(gif_std_haxe_boot_wget(_this[3/* gif */], 3) * gif_std_haxe_boot_wget(_this[3/* gif */], 4) * 4, buffer_fixed, 1);
	buffer_get_surface(_this[1/* restore_buf */], _this[2/* surface */], 0, 0, 0);
}
var _frameSurf = surface_create(_frame[5/* width */], _frame[6/* height */]);
buffer_set_surface(_frame[2/* buffer */], _frameSurf, 0, 0, 0);
surface_copy(_this[2/* surface */], _frame[3/* x */], _frame[4/* y */], _frameSurf);
surface_free(_frameSurf);
if (gif_std_haxe_boot_wget(_this[3/* gif */], 12) != undefined) {
	var _sf = _this[2/* surface */];
	var _ox = gif_std_haxe_boot_wget(_this[3/* gif */], 6);
	var _oy = gif_std_haxe_boot_wget(_this[3/* gif */], 7);
	_sprite1 = sprite_create_from_surface(_sf, 0, 0, surface_get_width(_sf), surface_get_height(_sf), false, false, _ox, _oy);
	gif_std_gml_internal_ArrayImpl_push(gif_std_haxe_boot_wget(_this[3/* gif */], 12), _sprite1);
	gif_std_haxe_boot_wset(_this[3/* gif */], 10, _sprite1);
} else if (_sprite1 == -1) {
	var _sf = _this[2/* surface */];
	var _ox = gif_std_haxe_boot_wget(_this[3/* gif */], 6);
	var _oy = gif_std_haxe_boot_wget(_this[3/* gif */], 7);
	_sprite1 = sprite_create_from_surface(_sf, 0, 0, surface_get_width(_sf), surface_get_height(_sf), false, false, _ox, _oy);
	gif_std_haxe_boot_wset(_this[3/* gif */], 10, _sprite1);
} else {
	var _sf = _this[2/* surface */];
	sprite_add_from_surface(_sprite1, _sf, 0, 0, surface_get_width(_sf), surface_get_height(_sf), false, false);
}
switch (_frame[7/* disposal_method */]) {
	case 2: buffer_set_surface(_this[1/* restore_buf */], _this[2/* surface */], 0, 0, 0); break;
	case 1:
		surface_set_target(_this[2/* surface */]);
		var _mode = bm_subtract;
		draw_set_blend_mode(_mode);
		draw_sprite_stretched(g_gif_drawer_white32, 0, _frame[3/* x */], _frame[4/* y */], _frame[5/* width */], _frame[6/* height */]);
		var _mode = bm_normal;
		draw_set_blend_mode(_mode);
		var __this = _this[2/* surface */];
		surface_reset_target();
		break;
}

//}

//{ gif_raw_reader

#define gif_raw_reader_create
var _this; _this[0/* metatype */] = mt_gif_raw_reader;
array_copy(_this, 1, mq_gif_raw_reader, 1, 1);
/// @typedef {tuple<any,i:buffer>} gif_raw_reader
_this[@1/* i */] = argument[0];
return _this;

#define gif_raw_reader_read_string
var _this = argument[0], _len = argument[1];
var _buf = g_gif_raw_reader_read_string_tmp_buf;
if (_buf == -1) {
	_buf = buffer_create(_len + 1, buffer_fixed, 1);
	g_gif_raw_reader_read_string_tmp_buf = _buf;
} else if (buffer_get_size(_buf) <= _len) {
	buffer_resize(_buf, _len + 1);
}
buffer_poke(_buf, gif_std_gml_io__Buffer_BufferImpl_readBuffer(_this[1/* i */], _buf, 0, _len), buffer_u8, 0);
buffer_seek(_buf, buffer_seek_start, 0);
return buffer_read(_buf, buffer_string);

#define gif_raw_reader_read
var _this = argument[0];
var _b = 71;
if (buffer_read(_this[1/* i */], buffer_u8) != _b) show_error(string("Invalid header"), false);
var _b = 73;
if (buffer_read(_this[1/* i */], buffer_u8) != _b) show_error(string("Invalid header"), false);
var _b = 70;
if (buffer_read(_this[1/* i */], buffer_u8) != _b) show_error(string("Invalid header"), false);
var _gifVer = gif_raw_reader_read_string(_this, 3);
var _version = format_gif_version_gif89a;
switch (_gifVer) {
	case "87a": _version = format_gif_version_gif87a; break;
	case "89a": _version = format_gif_version_gif89a; break;
	default: _version = format_gif_version_unknown(_gifVer);
}
var _width = buffer_read(_this[1/* i */], buffer_u16);
var _height = buffer_read(_this[1/* i */], buffer_u16);
var _packedField = buffer_read(_this[1/* i */], buffer_u8);
var _bgIndex = buffer_read(_this[1/* i */], buffer_u8);
var _pixelAspectRatio = buffer_read(_this[1/* i */], buffer_u8);
if (_pixelAspectRatio != 0) _pixelAspectRatio = (_pixelAspectRatio + 15) / 64; else _pixelAspectRatio = 1;
var _lsd = undefined;
_lsd[7/* pixelAspectRatio */] = _pixelAspectRatio;
_lsd[0/* width */] = _width;
_lsd[1/* height */] = _height;
_lsd[2/* hasGlobalColorTable */] = (_packedField & 128) == 128;
_lsd[3/* colorResolution */] = ((((_packedField & 112) & $FFFFFFFF) >> 4));
_lsd[4/* sorted */] = (_packedField & 8) == 8;
_lsd[5/* globalColorTableSize */] = (2 << (_packedField & 7));
_lsd[6/* backgroundColorIndex */] = _bgIndex;
var _gct = undefined;
if (_lsd[2/* hasGlobalColorTable */]) _gct = gif_raw_reader_read_color_table(_this, _lsd[5/* globalColorTableSize */]);
var _blocks = gif_std_haxe_boot_decl();
if (argument[1]) while (true) {
	var _b = gif_raw_reader_read_block(_this);
	gif_std_gml_internal_ArrayImpl_push(_blocks, _b);
	if (_b == format_gif_block_beof) break;
}
return gif_std_haxe_boot_odecl("GifData", 4, 0, _version, 1, _lsd, 2, _gct, 3, _blocks);

#define gif_raw_reader_read_next
var _this = argument[0];
var _b = gif_raw_reader_read_block(_this);
gif_std_gml_internal_ArrayImpl_push(argument[1], _b);
return _b;

#define gif_raw_reader_read_block
var _this = argument[0];
var _blockID = buffer_read(_this[1/* i */], buffer_u8);
switch (_blockID) {
	case 44: return gif_raw_reader_read_image(_this);
	case 33: return gif_raw_reader_read_extension(_this);
	case 59: return format_gif_block_beof;
}
return format_gif_block_beof;

#define gif_raw_reader_read_image
var _this = argument[0];
var _x = buffer_read(_this[1/* i */], buffer_u16);
var _y = buffer_read(_this[1/* i */], buffer_u16);
var _width = buffer_read(_this[1/* i */], buffer_u16);
var _height = buffer_read(_this[1/* i */], buffer_u16);
var _packed = buffer_read(_this[1/* i */], buffer_u8);
var _localColorTable = (_packed & 128) == 128;
var _interlaced = (_packed & 64) == 64;
var _sorted = (_packed & 32) == 32;
var _localColorTableSize = (2 << (_packed & 7));
var _lct = undefined;
if (_localColorTable) _lct = gif_raw_reader_read_color_table(_this, _localColorTableSize);
var _frame = undefined;
_frame[9/* colorTable */] = _lct;
_frame[0/* x */] = _x;
_frame[1/* y */] = _y;
_frame[2/* width */] = _width;
_frame[3/* height */] = _height;
_frame[4/* localColorTable */] = _localColorTable;
_frame[5/* interlaced */] = _interlaced;
_frame[6/* sorted */] = _sorted;
_frame[7/* localColorTableSize */] = _localColorTableSize;
_frame[8/* pixels */] = gif_raw_reader_read_pixels(_this, _width, _height, _interlaced);
return format_gif_block_bframe(_frame);

#define gif_raw_reader_read_pixels
var _this = argument[0], _width = argument[1], _height = argument[2];
var _input = _this[1/* i */];
var _pixelsCount = _width * _height;
var _pixels = gif_std_haxe_io_Bytes_create(gmv_array_create(_pixelsCount, 0));
var _minCodeSize = buffer_read(_input, buffer_u8);
var _blockSize = buffer_read(_input, buffer_u8) - 1;
var _bits = buffer_read(_input, buffer_u8);
var _bitsCount = 8;
var _clearCode = (1 << _minCodeSize);
var _eoiCode = _clearCode + 1;
var _codeSize = _minCodeSize + 1;
var _codeSizeLimit = (1 << _codeSize);
var _codeMask = _codeSizeLimit - 1;
var _baseDict = gif_std_haxe_boot_decl();
for (var _i = 0; _i < _clearCode; ++_i) {
	_baseDict[@_i] = gif_std_haxe_boot_decl(_i);
}
var _dict = gif_std_haxe_boot_decl();
var _dictLen = _clearCode + 2;
var _newRecord;
var _i = 0;
var _code = 0;
var _last;
while (_i < _pixelsCount) {
	_last = _code;
	while (_bitsCount < _codeSize) {
		if (_blockSize == 0) break;
		_bits |= (buffer_read(_input, buffer_u8) << _bitsCount);
		_bitsCount += 8;
		--_blockSize;
		if (_blockSize == 0) _blockSize = buffer_read(_input, buffer_u8);
	}
	_code = (_bits & _codeMask);
	_bits = _bits >> _codeSize;
	_bitsCount -= _codeSize;
	if (_code == _clearCode) {
		_dict = gif_std_gml_internal_ArrayImpl_copy(_baseDict);
		_dictLen = _clearCode + 2;
		_codeSize = _minCodeSize + 1;
		_codeSizeLimit = (1 << _codeSize);
		_codeMask = _codeSizeLimit - 1;
		continue;
	}
	if (_code == _eoiCode) break;
	if (_code < _dictLen) {
		if (_last != _clearCode) {
			_newRecord = gif_std_gml_internal_ArrayImpl_copy(_dict[_last]);
			gif_std_gml_internal_ArrayImpl_push(_newRecord, gif_std_haxe_boot_wget(_dict[_code], 0));
			_dict[@_dictLen++] = _newRecord;
		}
	} else {
		if (_code != _dictLen) show_error(string("Invalid LZW code. Excepted: " + string(_dictLen) + ", got: " + string(_code)), false);
		_newRecord = gif_std_gml_internal_ArrayImpl_copy(_dict[_last]);
		gif_std_gml_internal_ArrayImpl_push(_newRecord, _newRecord[0]);
		_dict[@_dictLen++] = _newRecord;
	}
	_newRecord = _dict[_code];
	var __g = 0;
	while (__g < array_length_1d(_newRecord)) {
		var _item = _newRecord[__g];
		++__g;
		gif_std_haxe_boot_wset(_pixels[1/* b */], _i++, (_item & 255));
	}
	if (_dictLen == _codeSizeLimit && _codeSize < 12) {
		++_codeSize;
		_codeSizeLimit = (1 << _codeSize);
		_codeMask = _codeSizeLimit - 1;
	}
}
while (_blockSize > 0) {
	buffer_read(_input, buffer_u8);
	--_blockSize;
	if (_blockSize == 0) _blockSize = buffer_read(_input, buffer_u8);
}
while (_i < _pixelsCount) {
	gif_std_haxe_boot_wset(_pixels[1/* b */], _i++, 0);
}
if (argument[3]) {
	var _buffer1 = gif_std_haxe_io_Bytes_create(gmv_array_create(_pixelsCount, 0));
	var _offset = gif_raw_reader_deinterlace(_this, _pixels, _buffer1, 8, 0, 0, _width, _height);
	_offset = gif_raw_reader_deinterlace(_this, _pixels, _buffer1, 8, 4, _offset, _width, _height);
	_offset = gif_raw_reader_deinterlace(_this, _pixels, _buffer1, 4, 2, _offset, _width, _height);
	_offset = gif_raw_reader_deinterlace(_this, _pixels, _buffer1, 2, 1, _offset, _width, _height);
	_pixels = _buffer1;
}
return _pixels;

#define gif_raw_reader_deinterlace
var _input = argument[1], _output = argument[2], _y = argument[4], _offset = argument[5], _width = argument[6];
while (_y < argument[7]) {
	array_copy(_output[1/* b */], _y * _width, _input[1/* b */], _offset, _width);
	_offset += _width;
	_y += argument[3];
}
return _offset;

#define gif_raw_reader_read_extension
var _this = argument[0];
var _subId = buffer_read(_this[1/* i */], buffer_u8);
switch (_subId) {
	case 249:
		if (buffer_read(_this[1/* i */], buffer_u8) != 4) show_error(string("Incorrect Graphic Control Extension block size!"), false);
		var _packed = buffer_read(_this[1/* i */], buffer_u8);
		var _disposalMethod;
		switch ((_packed & 28) >> 2) {
			case 2: _disposalMethod = format_gif_disposal_method_fill_background; break;
			case 3: _disposalMethod = format_gif_disposal_method_render_previous; break;
			case 1: _disposalMethod = format_gif_disposal_method_no_action; break;
			case 0: _disposalMethod = format_gif_disposal_method_unspecified; break;
			default: _disposalMethod = format_gif_disposal_method_undefined_hx(((_packed & 28) >> 2));
		}
		var _delay = buffer_read(_this[1/* i */], buffer_u16);
		var _gcx = undefined;
		_gcx[4] = 0;
		_gcx[0/* disposalMethod */] = _disposalMethod;
		_gcx[1/* userInput */] = (_packed & 2) == 2;
		_gcx[2/* hasTransparentColor */] = (_packed & 1) == 1;
		_gcx[3/* delay */] = _delay;
		_gcx[4/* transparentIndex */] = buffer_read(_this[1/* i */], buffer_u8);
		var _b = format_gif_block_bextension(format_gif_extension_egraphic_control(_gcx));
		buffer_read(_this[1/* i */], buffer_u8);
		return _b;
	case 1:
		if (buffer_read(_this[1/* i */], buffer_u8) != 12) show_error(string("Incorrect size of Plain Text Extension introducer block."), false);
		var _textGridX = buffer_read(_this[1/* i */], buffer_u16);
		var _textGridY = buffer_read(_this[1/* i */], buffer_u16);
		var _textGridWidth = buffer_read(_this[1/* i */], buffer_u16);
		var _textGridHeight = buffer_read(_this[1/* i */], buffer_u16);
		var _charCellWidth = buffer_read(_this[1/* i */], buffer_u8);
		var _charCellHeight = buffer_read(_this[1/* i */], buffer_u8);
		var _textForegroundColorIndex = buffer_read(_this[1/* i */], buffer_u8);
		var _textBackgroundColorIndex = buffer_read(_this[1/* i */], buffer_u8);
		var _buffer1 = gif_std_haxe_io_BytesOutput_create();
		var _bytes = gif_std_haxe_io_Bytes_create(gmv_array_create(255, 0));
		for (var _bdata = _bytes[1/* b */], _len = buffer_read(_this[1/* i */], buffer_u8); _len != 0; _len = buffer_read(_this[1/* i */], buffer_u8)) {
			for (var _k = 0; _k < _len; ++_k) {
				_bdata[@_k] = buffer_read(_this[1/* i */], buffer_u8);
			}
			gif_std_haxe_io_Output_writeBytes(_buffer1, _bytes, 0, _len);
		}
		script_execute(_buffer1[4/* flush */], _buffer1);
		_bytes = gif_std_haxe_io_Bytes_create(_buffer1[1/* data */]);
		script_execute(_buffer1[5/* close */], _buffer1);
		var __this = _bytes;
		var _ptx = undefined;
		_ptx[8] = 0;
		_ptx[0/* textGridX */] = _textGridX;
		_ptx[1/* textGridY */] = _textGridY;
		_ptx[2/* textGridWidth */] = _textGridWidth;
		_ptx[3/* textGridHeight */] = _textGridHeight;
		_ptx[4/* charCellWidth */] = _charCellWidth;
		_ptx[5/* charCellHeight */] = _charCellHeight;
		_ptx[6/* textForegroundColorIndex */] = _textForegroundColorIndex;
		_ptx[7/* textBackgroundColorIndex */] = _textBackgroundColorIndex;
		_ptx[8/* text */] = haxe_io__bytes_bytes_impl_get_string(__this[1/* b */], 0, array_length_1d(__this[1/* b */]));
		return format_gif_block_bextension(format_gif_extension_etext(_ptx));
	case 254:
		var _buffer1 = gif_std_haxe_io_BytesOutput_create();
		var _bytes = gif_std_haxe_io_Bytes_create(gmv_array_create(255, 0));
		for (var _bdata = _bytes[1/* b */], _len = buffer_read(_this[1/* i */], buffer_u8); _len != 0; _len = buffer_read(_this[1/* i */], buffer_u8)) {
			for (var _k = 0; _k < _len; ++_k) {
				_bdata[@_k] = buffer_read(_this[1/* i */], buffer_u8);
			}
			gif_std_haxe_io_Output_writeBytes(_buffer1, _bytes, 0, _len);
		}
		script_execute(_buffer1[4/* flush */], _buffer1);
		_bytes = gif_std_haxe_io_Bytes_create(_buffer1[1/* data */]);
		script_execute(_buffer1[5/* close */], _buffer1);
		var __this = _bytes;
		return format_gif_block_bextension(format_gif_extension_ecomment(haxe_io__bytes_bytes_impl_get_string(__this[1/* b */], 0, array_length_1d(__this[1/* b */]))));
	case 255: return gif_raw_reader_read_application_extension(_this);
	default:
		var _buffer1 = gif_std_haxe_io_BytesOutput_create();
		var _bytes = gif_std_haxe_io_Bytes_create(gmv_array_create(255, 0));
		for (var _bdata = _bytes[1/* b */], _len = buffer_read(_this[1/* i */], buffer_u8); _len != 0; _len = buffer_read(_this[1/* i */], buffer_u8)) {
			for (var _k = 0; _k < _len; ++_k) {
				_bdata[@_k] = buffer_read(_this[1/* i */], buffer_u8);
			}
			gif_std_haxe_io_Output_writeBytes(_buffer1, _bytes, 0, _len);
		}
		script_execute(_buffer1[4/* flush */], _buffer1);
		_bytes = gif_std_haxe_io_Bytes_create(_buffer1[1/* data */]);
		script_execute(_buffer1[5/* close */], _buffer1);
		return format_gif_block_bextension(format_gif_extension_eunknown(_subId, _bytes));
}

#define gif_raw_reader_read_application_extension
var _this = argument[0];
if (buffer_read(_this[1/* i */], buffer_u8) != 11) show_error(string("Incorrect size of Application Extension introducer block."), false);
var _name = gif_raw_reader_read_string(_this, 8);
var _version = gif_raw_reader_read_string(_this, 3);
var _buffer1 = gif_std_haxe_io_BytesOutput_create();
var _bytes = gif_std_haxe_io_Bytes_create(gmv_array_create(255, 0));
for (var _bdata = _bytes[1/* b */], _len = buffer_read(_this[1/* i */], buffer_u8); _len != 0; _len = buffer_read(_this[1/* i */], buffer_u8)) {
	for (var _k = 0; _k < _len; ++_k) {
		_bdata[@_k] = buffer_read(_this[1/* i */], buffer_u8);
	}
	gif_std_haxe_io_Output_writeBytes(_buffer1, _bytes, 0, _len);
}
script_execute(_buffer1[4/* flush */], _buffer1);
_bytes = gif_std_haxe_io_Bytes_create(_buffer1[1/* data */]);
script_execute(_buffer1[5/* close */], _buffer1);
var _data = _bytes;
if (_name == "NETSCAPE" && _version == "2.0" && gif_std_haxe_boot_wget(_data[1/* b */], 0) == 1) return format_gif_block_bextension(format_gif_extension_eapplication_extension(format_gif_application_extension_aenetscape_looping((gif_std_haxe_boot_wget(_data[1/* b */], 1) | (gif_std_haxe_boot_wget(_data[1/* b */], 2) << 8)))));
return format_gif_block_bextension(format_gif_extension_eapplication_extension(format_gif_application_extension_aeunknown(_name, _version, _data)));

#define gif_raw_reader_read_color_table
var _this = argument[0], _size = argument[1];
_size *= 3;
var _output = gif_std_haxe_io_Bytes_create(gmv_array_create(_size, 0));
for (var _c = 0; _c < _size; _c += 3) {
	var _v = buffer_read(_this[1/* i */], buffer_u8);
	gif_std_haxe_boot_wset(_output[1/* b */], _c, (_v & 255));
	var _v1 = buffer_read(_this[1/* i */], buffer_u8);
	gif_std_haxe_boot_wset(_output[1/* b */], _c + 1, (_v1 & 255));
	var _v2 = buffer_read(_this[1/* i */], buffer_u8);
	gif_std_haxe_boot_wset(_output[1/* b */], _c + 2, (_v2 & 255));
}
return _output;

//}

//{ format.gif.block

#define format_gif_block_bframe
var _this;
_this[0/* id */] = 0;
_this[1/* frame */] = argument[0];
return _this;

#define format_gif_block_bextension
var _this;
_this[0/* id */] = 1;
_this[1/* extension */] = argument[0];
return _this;

#define mc_format_gif_block_beof
var _this;
_this[0/* id */] = 2;
return _this;

//}

//{ format.gif.extension

#define format_gif_extension_egraphic_control
var _this;
_this[0/* id */] = 0;
_this[1/* gce */] = argument[0];
return _this;

#define format_gif_extension_ecomment
var _this;
_this[0/* id */] = 1;
_this[1/* text */] = argument[0];
return _this;

#define format_gif_extension_etext
var _this;
_this[0/* id */] = 2;
_this[1/* pte */] = argument[0];
return _this;

#define format_gif_extension_eapplication_extension
var _this;
_this[0/* id */] = 3;
_this[1/* ext */] = argument[0];
return _this;

#define format_gif_extension_eunknown
var _this;
_this[0/* id */] = 4;
_this[1/* id */] = argument[0];
_this[2/* data */] = argument[1];
return _this;

//}

//{ format.gif.application_extension

#define format_gif_application_extension_aenetscape_looping
var _this;
_this[0/* id */] = 0;
_this[1/* loops */] = argument[0];
return _this;

#define format_gif_application_extension_aeunknown
var _this;
_this[0/* id */] = 1;
_this[1/* name */] = argument[0];
_this[2/* version */] = argument[1];
_this[3/* data */] = argument[2];
return _this;

//}

//{ format.gif.version

#define mc_format_gif_version_gif87a
var _this;
_this[0/* id */] = 0;
return _this;

#define mc_format_gif_version_gif89a
var _this;
_this[0/* id */] = 1;
return _this;

#define format_gif_version_unknown
var _this;
_this[0/* id */] = 2;
_this[1/* version */] = argument[0];
return _this;

//}

//{ format.gif.disposal_method

#define mc_format_gif_disposal_method_unspecified
var _this;
_this[0/* id */] = 0;
return _this;

#define mc_format_gif_disposal_method_no_action
var _this;
_this[0/* id */] = 1;
return _this;

#define mc_format_gif_disposal_method_fill_background
var _this;
_this[0/* id */] = 2;
return _this;

#define mc_format_gif_disposal_method_render_previous
var _this;
_this[0/* id */] = 3;
return _this;

#define format_gif_disposal_method_undefined_hx
var _this;
_this[0/* id */] = 4;
_this[1/* index */] = argument[0];
return _this;

//}

//{ gif_std.haxe.type

#define gif_std_haxe_type_proto
var _n = argument_count;
var _out = undefined;
for (var _i = 0; _i < _n; ++_i) {
	_out[_i] = argument[_i];
}
return _out;

//}

//{ gif_std.haxe.class

#define gif_std_haxe_class_create
var _this; _this[0/* metatype */] = "mt_gif_std_haxe_class";
array_copy(_this, 1, mq_gif_std_haxe_class, 1, 5);
/// @typedef {tuple<any,marker:any,index:int,name:string,superClass:haxe_class<any>,constructor:any>} gif_std_haxe_class
_this[@4/* superClass */] = undefined;
_this[@1/* marker */] = gif_std_haxe_type_markerValue;
_this[@2/* index */] = argument[0];
_this[@3/* name */] = argument[1];
return _this;

//}

//{ gif_std.haxe.enum

#define gif_std_haxe_enum_create
var _this; _this[0/* metatype */] = "mt_gif_std_haxe_enum";
array_copy(_this, 1, mq_gif_std_haxe_enum, 1, 5);
/// @typedef {tuple<any,marker:any,index:int,name:string,constructors:array<string>,functions:array<function>>} gif_std_haxe_enum
var _constructors, _functions;
if (argument_count > 2) _constructors = argument[2]; else _constructors = undefined;
if (argument_count > 3) _functions = argument[3]; else _functions = undefined;
_this[@1/* marker */] = gif_std_haxe_type_markerValue;
_this[@2/* index */] = argument[0];
_this[@3/* name */] = argument[1];
_this[@4/* constructors */] = _constructors;
_this[@5/* functions */] = _functions;
return _this;

//}

//{ gif_std.gml.internal.ArrayImpl

#define gif_std_gml_internal_ArrayImpl_push
var _arr = argument[0];
var _i = array_length_1d(_arr);
_arr[@_i] = argument[1];
return _i;

#define gif_std_gml_internal_ArrayImpl_copy
var _arr = argument[0];
var _out;
var _len = array_length_1d(_arr);
if (_len > 0) {
	_out = gmv_array_create(_len, 0);
	array_copy(_out, 0, _arr, 0, _len);
} else _out = gif_std_haxe_boot_decl();
return _out;

//}

//{ gif_std.gml.io._Buffer.BufferImpl

#define gif_std_gml_io__Buffer_BufferImpl_readBuffer
var _src = argument[0], _dst = argument[1], _dstPos = argument[2];
var _srcPos = buffer_tell(_src);
var _srcLen = min(argument[3], buffer_get_size(_src) - _srcPos);
var _dstLen = min(_srcLen, buffer_get_size(_dst) - _dstPos);
if (_srcLen < 0) return 0;
if (_dstLen < 0) {
	buffer_seek(_src, buffer_seek_relative, _srcLen);
	return 0;
}
buffer_copy(_src, _srcPos, _dstLen, _dst, _dstPos);
buffer_seek(_src, buffer_seek_relative, _srcLen);
return _dstLen;

//}

//{ gif_std.haxe.io.Bytes

#define gif_std_haxe_io_Bytes_create
var _this; _this[0/* metatype */] = mt_gif_std_haxe_io_Bytes;
array_copy(_this, 1, mq_gif_std_haxe_io_Bytes, 1, 1);
/// @typedef {tuple<any,b:haxe_io_BytesData>} gif_std_haxe_io_Bytes
_this[@1/* b */] = argument[0];
return _this;

//}

//{ haxe.io._bytes.bytes_impl

#define haxe_io__bytes_bytes_impl_get_string
var _d = argument[0];
var _b = haxe_io__bytes_bytes_impl_buffer;
buffer_seek(_b, buffer_seek_start, 0);
while (--argument[2] >= 0) {
	buffer_write(_b, buffer_u8, _d[argument[1]++]);
}
buffer_write(_b, buffer_u8, 0);
buffer_seek(_b, buffer_seek_start, 0);
return buffer_read(_b, buffer_string);

//}

//{ gif_std.haxe.io.Output

#define gif_std_haxe_io_Output_new
var _this = argument[0];
_this[@3/* dataLen */] = 32;
_this[@2/* dataPos */] = 0;
_this[@1/* data */] = gmv_array_create(32, 0);

#define gif_std_haxe_io_Output_create
var _this; _this[0/* metatype */] = mt_gif_std_haxe_io_Output;
array_copy(_this, 1, mq_gif_std_haxe_io_Output, 1, 5);
/// @typedef {tuple<any,data:haxe_io_BytesData,dataPos:int,dataLen:int,flush:function<void>,close:function<void>>} gif_std_haxe_io_Output
_this[@4/* flush */] = gif_std_haxe_io_Output_flush;
_this[@5/* close */] = gif_std_haxe_io_Output_close;
gif_std_haxe_io_Output_new(_this);
return _this;

#define gif_std_haxe_io_Output_flush
var _this = argument[0];


#define gif_std_haxe_io_Output_close
var _this = argument[0];


#define gif_std_haxe_io_Output_writeBytes
var _this = argument[0], _b = argument[1], _len = argument[3];
var _bd = _b[1/* b */];
var _p0 = _this[2/* dataPos */];
var _p1 = _p0 + _len;
var _d = _this[1/* data */];
var _dlen = _this[3/* dataLen */];
if (_p1 > _dlen) {
	do {
		_dlen *= 2;
	} until (_p1 <= _dlen);
	_dlen *= 2;
	_d[@_dlen - 1] = 0;
	_this[@3/* dataLen */] = _dlen;
}
array_copy(_d, _p0, _bd, argument[2], _len);
_this[@2/* dataPos */] = _p1;
return _len;

//}

//{ gif_std.haxe.io.BytesOutput

#define gif_std_haxe_io_BytesOutput_create
var _this; _this[0/* metatype */] = mt_gif_std_haxe_io_BytesOutput;
array_copy(_this, 1, mq_gif_std_haxe_io_BytesOutput, 1, 5);
/// @typedef {tuple<any,data:haxe_io_BytesData,dataPos:int,dataLen:int,flush:function<void>,close:function<void>>} gif_std_haxe_io_BytesOutput
_this[@4/* flush */] = gif_std_haxe_io_Output_flush;
_this[@5/* close */] = gif_std_haxe_io_Output_close;
gif_std_haxe_io_Output_new(_this);
return _this;

//}

//{ gif_std.haxe.boot

#define gif_std_haxe_boot_decl
var _n = argument_count;
var _i, _r;
if (_n == 0) {
	_r = undefined;
	var _val = undefined;
	_r[1, 0] = _val;
	return _r;
}
if (os_browser != browser_not_a_browser) {
	_r = undefined;
	_r[@0] = argument[0];
	_i = 0;
	while (++_i < _n) {
		_r[_i] = argument[_i];
	}
} else {
	_r = undefined;
	while (--_n >= 0) {
		_r[_n] = argument[_n];
	}
}
return _r;

#define gif_std_haxe_boot_odecl
var _size = argument[1];
var _i;
var _r = undefined;
if (os_browser != browser_not_a_browser) {
	_i = 0;
	while (_i < _size) {
		_r[_i] = undefined;
	}
} else {
	_i = _size;
	while (--_i >= 0) {
		_r[_i] = undefined;
	}
}
var _n = argument_count;
for (_i = 2; _i < _n; _i += 2) {
	_r[@argument[_i]] = argument[_i + 1];
}
return _r;

#define gif_std_haxe_boot_wget
var _arr = argument[0], _index = argument[1];
return _arr[_index];

#define gif_std_haxe_boot_wset
var _arr = argument[0], _index = argument[1];
_arr[@_index] = argument[2];

//}

/// @typedef {array<int>} haxe_io_BytesData
/// @typedef {any} format_gif_GraphicControlExtension
/// @typedef {any} GifData