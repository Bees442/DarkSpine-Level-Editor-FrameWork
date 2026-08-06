/// @description dks_theme()
/// Single source of truth for the editor's visual language.
///
/// Called once from dks_color_init so every menu can read the same palette
/// and spacing values instead of repeating literals. The legacy pastel
/// colours still exist alongside these -- this does not replace them, it
/// gives new drawing code something consistent to reference.
function dks_theme()
{
	// --- Surfaces -------------------------------------------------------
	// Four neutral steps, darkest at the back. Keeping them close together
	// (12 -> 46) is what reads as "modern": depth comes from small value
	// jumps plus a border, not from heavy contrast.
	global.ui_bg        = make_colour_rgb(24,26,30);   // panel backdrop
	global.ui_surface   = make_colour_rgb(34,37,43);   // control at rest
	global.ui_surface_h = make_colour_rgb(46,50,58);   // control hovered
	global.ui_surface_a = make_colour_rgb(58,63,73);   // control pressed
	global.ui_border    = make_colour_rgb(58,63,73);   // hairline divider

	// --- Text -----------------------------------------------------------
	// Three tiers so labels, values and headings are separable at a glance.
	// The old UI drew everything in one bold weight, which is the main
	// reason it reads as flat.
	global.ui_text      = make_colour_rgb(228,230,235); // primary
	global.ui_text_dim  = make_colour_rgb(148,155,168); // secondary/labels
	global.ui_text_mute = make_colour_rgb(104,110,122); // disabled/hints

	// --- Accent ---------------------------------------------------------
	// One accent for focus, selection and active state. Mode colours stay
	// available for the thin indicator stripe only.
	global.ui_accent    = make_colour_rgb(88,166,255);
	global.ui_accent_dk = make_colour_rgb(56,116,190);

	// --- Semantic -------------------------------------------------------
	global.ui_danger    = make_colour_rgb(232,93,93);
	global.ui_ok        = make_colour_rgb(126,192,111);

	// --- Metrics --------------------------------------------------------
	// An 8px rhythm. Row height 28 keeps 7-item menus compact while leaving
	// room for 10pt text plus breathing space.
	global.ui_pad       = 8;   // inner padding, control to text
	global.ui_gap       = 2;   // gap between stacked rows
	global.ui_row       = 28;  // standard row height
	global.ui_radius    = 3;   // corner rounding
	global.ui_stripe    = 3;   // mode indicator stripe width
}
