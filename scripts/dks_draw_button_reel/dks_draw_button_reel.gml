/// @description dks_draw_button_reel(Button array2D)
/// @param Button array2D
/// Central button renderer for the whole editor -- mode columns, inspector,
/// physics, layers and every settings menu draw through here.
///
/// Draws procedurally instead of stamping the fixed-size button PNGs, so the
/// look is defined by dks_theme rather than by the sprite art. Geometry is
/// untouched: obj_input instances are positioned from these same rectangles
/// at create time, so moving them would detach the text fields.
function dks_draw_button_reel(argument0)
{
	var a = argument0;
	var s = array_length(a);

	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	var _held = mouse_check_button(mb_left);

	var _prevH = draw_get_halign();
	var _prevV = draw_get_valign();
	draw_set_valign(fa_middle);
	draw_set_halign(fa_left);

	for (var i = 0; i < s; i++)
	{
	 var x1 = a[i][0], y1 = a[i][1], x2 = a[i][2], y2 = a[i][3];

	 var _hover = point_in_rectangle(_mx, _my, x1, y1, x2, y2);
	 var _press = (_hover && _held);

	 // The reel's configured colour (a[i][7]) is the mode's identity colour.
	 // It becomes a thin left stripe instead of flooding the whole control,
	 // which is what let every button read as one solid block before.
	 var _accent = a[i][7];

	 var _fill = _press ? global.ui_surface_a
	           : (_hover ? global.ui_surface_h : global.ui_surface);
	 var _edge = _hover ? _accent : global.ui_border;

	 dks_draw_panel(x1, y1, x2, y2, _fill, _edge);

	 draw_set_colour(_accent);
	 draw_rectangle(x1+1, y1+2, x1+global.ui_stripe, y2-2, false);

	 // Text sits on the 8px rhythm from the stripe, not on the reel's own
	 // xf/yf margins -- those were tuned per-menu and drifted badly between
	 // 128px and 256px wide reels.
	 draw_set_colour(_hover ? global.ui_text : global.ui_text_dim);
	 draw_text(x1 + global.ui_stripe + global.ui_pad, (y1+y2)*0.5, a[i][10]);
	}

	draw_set_halign(_prevH);
	draw_set_valign(_prevV);
	draw_set_color(c_white);
}
