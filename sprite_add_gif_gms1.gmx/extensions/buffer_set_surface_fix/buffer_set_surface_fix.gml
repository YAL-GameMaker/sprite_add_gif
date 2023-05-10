#define buffer_set_surface_hook
//#macro buffer_set_surface buffer_set_surface_hook
//#macro buffer_set_surface_base buffer_set_surface
//#macro buffer_set_surface_uses_fallback global.__buffer_set_surface_uses_fallback
//#init
var _buf = argument0, _surf = argument1, _mode = argument2, _offset = argument3, _modulo = argument4;
gml_pragma("global", "
    global.__buffer_set_surface_uses_fallback = undefined;
")
var _fb = global.__buffer_set_surface_uses_fallback;
if (_fb == undefined) {
    buffer_set_surface_detect();
    _fb = global.__buffer_set_surface_uses_fallback;
}
if (!_fb) {
    buffer_set_surface_base(_buf, _surf, _mode, _offset, _modulo);
    exit;
}
var _width = surface_get_width(_surf);
var _height = surface_get_height(_surf);
if (_offset < 0 || buffer_get_size(_buf) - _offset < _width * _height * 4) exit;
surface_set_target(_surf);
draw_clear_alpha(c_black, 0);
draw_set_blend_mode_ext(bm_one, bm_zero);
buffer_set_surface_fallback(buffer_get_address(_buf), _width, _height, _offset);
draw_set_blend_mode(bm_normal);
surface_reset_target();

#define buffer_set_surface_detect
var _fb = true;
var _surf = -1;
repeat (1) {
    if (os_type != os_windows) break;
    var _sw = 128, _sh = 1;
    var _size = _sw * _sh * 4;
    var _buf = buffer_create(_size, buffer_fixed, 1);
    buffer_fill(_buf, 0, buffer_s32, -1, _size);
    
    _surf = surface_create(_sw, _sh);
    surface_set_target(_surf);
    draw_clear(c_black);
    surface_reset_target();
    
    buffer_set_surface_base(_buf, _surf, 0, 0, 0);
    buffer_delete(_buf);
    var _col = surface_getpixel(_surf, 0, 0);
    _fb = _col == c_white;
    //if (_fb) break;
    
    surface_set_target(_surf);
    draw_clear(c_white);
    surface_reset_target();
    var _sprite = sprite_create_from_surface(_surf, 0, 0, _sw, _sh, false, false, 0, 0);
    
    var _func = "draw_sprite_stretched_ext", _cc;
    if (variable_global_exists(_func)) {
        _cc = variable_global_get(_func);
    } else {
        variable_global_set(_func, variable_global_get(_func));
        _cc = variable_global_get(_func);
        variable_global_set(_func, _cc);
    }
    buffer_set_surface_fallback_init(ptr(_cc), _sprite)
}
if (_surf != -1) surface_free(_surf);
global.__buffer_set_surface_uses_fallback = !_fb;
