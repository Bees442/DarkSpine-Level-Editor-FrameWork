/// @description dks_draw_button_rectangle(Button array2D)
/// @param Button array2D
/// Label-less variant (sliders, colour swatches, hit zones). Keeps the same
/// surface and border treatment as the rest of the editor chrome.
function dks_draw_button_rectangle(argument0)
{
	var b = argument0;
	var s = array_length(b);

	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	var _held = mouse_check_button(mb_left);

	for (var i = 0; i < s; i++)
	{
	 var x1 = b[i][0], y1 = b[i][1], x2 = b[i][2], y2 = b[i][3];

	 var _hover = point_in_rectangle(_mx, _my, x1, y1, x2, y2);
	 var _press = (_hover && _held);

	 dks_draw_panel(x1, y1, x2, y2,
	                _press ? global.ui_surface_a
	                       : (_hover ? global.ui_surface_h : global.ui_surface),
	                _hover ? b[i][7] : global.ui_border);
	}

	draw_set_color(c_white);
}
