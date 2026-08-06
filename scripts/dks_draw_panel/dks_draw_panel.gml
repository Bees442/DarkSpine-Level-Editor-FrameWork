/// @description dks_draw_panel(x1,y1,x2,y2,fill,border)
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param fill
/// @param border
/// Rounded surface with a hairline border, drawn procedurally so the editor
/// no longer depends on fixed-size button PNGs for its chrome.
function dks_draw_panel(argument0, argument1, argument2, argument3, argument4, argument5)
{
	var x1 = argument0, y1 = argument1, x2 = argument2, y2 = argument3;
	var _fill = argument4, _border = argument5;
	var r = global.ui_radius;

	// Guard against radius exceeding half the smaller side, which would make
	// draw_roundrect render inside-out on very short rows.
	var _minSide = min(x2-x1, y2-y1);
	if (r*2 > _minSide) r = max(0, _minSide*0.5);

	draw_set_colour(_fill);
	if (r <= 0) draw_rectangle(x1,y1,x2,y2,false);
	else        draw_roundrect_ext(x1,y1,x2,y2,r,r,false);

	if (_border != _fill)
	{
	 draw_set_colour(_border);
	 if (r <= 0) draw_rectangle(x1,y1,x2,y2,true);
	 else        draw_roundrect_ext(x1,y1,x2,y2,r,r,true);
	}
}
