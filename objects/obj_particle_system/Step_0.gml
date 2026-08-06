// burst_script comes from editor data via User Event 0, where an unresolvable
// script name leaves asset_get_index() returning -1. Guard the call the same
// way dks_draw_method_custom does, so bad or missing editor data just means
// "no burst" instead of crashing the step.
if script_exists(burst_script)
{
 script_execute(burst_script);
}
