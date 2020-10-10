var _width = window_get_width();
var _height = window_get_height();
if (surface_get_width(application_surface) != _width
	|| surface_get_height(application_surface) != _height
) {
	surface_resize(application_surface, _width, _height);
	display_set_gui_size(_width, _height);
}