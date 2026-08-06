function dks_menu_draw_interface()
{
	// Backdrop and heading only -- the rows themselves now come out of
	// dks_draw_button_reel in the shared style, so drawing them here as well
	// would double up.
	var _info = button_setter_interface_info;
	var _int  = button_setter_interface_int;
	var _rows = array_length(_info);
	var _pad  = global.ui_pad;

	dks_draw_panel(_info[0][0]-_pad, _info[0][1]-_pad-24,
	               _int[0][2]+_pad,  _info[_rows-1][3]+_pad,
	               global.ui_bg, global.ui_border);

	var _prevH = draw_get_halign();
	var _prevV = draw_get_valign();
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_colour(global.ui_text_dim);
	draw_text(_info[0][0], _info[0][1]-_pad-12, "INTERFACE");
	draw_set_halign(_prevH);
	draw_set_valign(_prevV);

	dks_draw_button_reel(_info);
	dks_draw_button_reel(_int);

	draw_set_colour(c_white);
}
