function dks_gui_vsync_set()
{
	// Was written as "if (vsync = false)" -- valid GML, but a single '=' in a
	// condition reads as an assignment and is easy to misedit later.
	vsync = !vsync;
	display_reset(a_a, vsync);
	dks_message(vsync ? "Vsync_enabled" : "Vsync_disabled");
}
