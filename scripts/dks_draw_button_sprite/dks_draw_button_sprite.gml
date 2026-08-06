/// @description dks_draw_button_sprite(Button array2D)
/// @param Button array2D
/// Icon buttons keep their sprite -- the artwork is the content here, so it
/// is drawn on top of a themed surface rather than replaced by one.
function dks_draw_button_sprite(argument0)
{
	var a = argument0;
	var s = array_length(a);

	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	var _held = mouse_check_button(mb_left);

	for (var i = 0; i < s; i++)
	{
	 var x1 = a[i][0], y1 = a[i][1], x2 = a[i][2], y2 = a[i][3];

	 var _hover = point_in_rectangle(_mx, _my, x1, y1, x2, y2);
	 var _press = (_hover && _held);
	 var _sink = _press ? 1 : 0;

	 dks_draw_panel(x1, y1, x2, y2,
	                _press ? global.ui_surface_a
	                       : (_hover ? global.ui_surface_h : global.ui_surface),
	                _hover ? a[i][7] : global.ui_border);

	 draw_sprite_ext(a[i][15], 0, x1, y1+_sink, 1, 1, 0, _hover ? a[i][7] : a[i][6], 1);
	 draw_sprite_ext(a[i][15], 1, x1, y1+_sink, 1, 1, 0, _hover ? a[i][9] : a[i][8], 1);
	}

	draw_set_color(c_white);
}
