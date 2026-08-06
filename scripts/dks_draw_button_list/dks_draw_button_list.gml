/// @description dks_draw_button_list(Button array2D,text list)
/// @param Button array2D
/// @param text list
/// Same visual language as dks_draw_button_reel, for reels whose labels live
/// in a ds_list (sprite pickers, layer lists).
function dks_draw_button_list(argument0, argument1)
{
	var b = argument0;
	var l = argument1;
	var s = array_length(b);

	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	var _held = mouse_check_button(mb_left);

	var _prevH = draw_get_halign();
	var _prevV = draw_get_valign();
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);

	for (var i = 0; i < s; i++)
	{
	 var x1 = b[i][0], y1 = b[i][1], x2 = b[i][2], y2 = b[i][3];

	 var _hover = point_in_rectangle(_mx, _my, x1, y1, x2, y2);
	 var _press = (_hover && _held);
	 var _accent = b[i][7];

	 dks_draw_panel(x1, y1, x2, y2,
	                _press ? global.ui_surface_a
	                       : (_hover ? global.ui_surface_h : global.ui_surface),
	                _hover ? _accent : global.ui_border);

	 draw_set_colour(_accent);
	 draw_rectangle(x1+1, y1+2, x1+global.ui_stripe, y2-2, false);

	 draw_set_colour(_hover ? global.ui_text : global.ui_text_dim);
	 draw_text(x1 + global.ui_stripe + global.ui_pad, (y1+y2)*0.5, l[| i]);
	}

	draw_set_halign(_prevH);
	draw_set_valign(_prevV);
	draw_set_color(c_white);
}
