/// @description dks_draw_fps()
/// Small frame-rate readout in the top-right of the GUI layer, toggled with
/// CTRL+F. Deliberately separate from the F12 debug overlay: that one covers
/// a large area and is aimed at profiling, this is a glanceable number you
/// can leave on while working or while play-testing a level.
///
/// State lives in global.show_fps / global.fps_smooth so it survives the
/// editor <-> play transition.
function dks_draw_fps()
{
	// Raw fps jitters every frame and is hard to read. Ease toward it so the
	// number stays legible while still reacting to a real slowdown quickly.
	global.fps_smooth += (fps - global.fps_smooth) * 0.1;
	var _shown = round(global.fps_smooth);

	// Colour tracks the room's target speed rather than a fixed 60, so the
	// readout stays meaningful if the level runs at another rate.
	var _target = max(1, room_speed);
	var _col = global.ui_ok;
	if (_shown < _target * 0.9) _col = global.ui_accent;
	if (_shown < _target * 0.5) _col = global.ui_danger;

	var _text = string(_shown) + " FPS";

	var _prevH = draw_get_halign();
	var _prevV = draw_get_valign();
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);

	var _pad = global.ui_pad;
	var _w   = string_width(_text) + _pad*2;
	var _h   = global.ui_row - 4;
	var _x2  = display_get_gui_width() - _pad;
	var _x1  = _x2 - _w;
	var _y1  = _pad;
	var _y2  = _y1 + _h;

	dks_draw_panel(_x1, _y1, _x2, _y2, global.ui_bg, global.ui_border);

	draw_set_colour(_col);
	draw_text(_x1 + _pad, (_y1+_y2)*0.5, _text);

	draw_set_halign(_prevH);
	draw_set_valign(_prevV);
	draw_set_colour(c_white);
}
