/// @description  TweensTarget(target)
/// @param target
/// @description returns tween ids associated with target, for scripts supporting 'tween[s]' argument
function TweensTarget(argument0) {

	/// @param target   target instance associated with tweens

	/*
	    The Tweens* scripts can be used with any tween scripts
	    which show 'tween[s]' as an argument.
    
	    e.g.
	        TweenPause(TweensTarget(id)); // pause all tweens associated with target instance
	        TweenResume(TweensTarget(obj_Player));
	*/

	// GM 2026 changed string(instance) from "100010" to "ref instance 100010",
	// which broke the numeric round-trip in TGMS_TweensExecute. real() accepts
	// both instance references and object indices and always yields the bare
	// numeric id, so encode through it rather than through string().
	return "3"+string(real(argument0));






}
