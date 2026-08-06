/// @description  TGMS_TweensExecute(tweens_string,script,arg0,...)
/// @param tweens_string
/// @param script
/// @param arg0
/// @param ...
function TGMS_TweensExecute() {
	/*
	    @tweens         Tweens to select for performing script (0=TWEENS_ALL, 1=TWEENS_GROUP, 2=TWEEN_TARGET)
	    @data           Relevant group or target when using TWEENS_GROUP or TWEENS_TARGET -- not important when using TWEENS_ALL
	    @script         Script to execute for each tween
	    @arg0...        (optional) Arguments to pass to executed script (up to 3)
    
	    return:
	        na
        
	    INFO:
	        Iterates through all relevant tweens and executes a specified script for each.
	        The following macros can be used for selecting tweens:
        
	        0 = TWEENS_ALL
	        1 = TWEENS_GROUP
	        2 = TWEENS_TARGET
        
	        Currently takes only a max of 3 optional arguments.
        
	    Example:
	        // Execute 'TweenStop' for all tweens, including those with deactivated targets
	        TweensExecute(TWEENS_ALL, 0, TweenStop);
        
	        // Execute 'TweenPause' with tweens belonging to group 2
	        TweensExecute(TWEENS_GROUP, 2, TweenPause)
        
	        // Execute 'TweenSetTime' for tweens associated with obj_Jumpy
	        TweensExecute(TWEENS_TARGET, obj_Jumpy, TweenSetTime, 2.0);
	*/

	var _tweensString = argument[0];
	var _selection = real(string_char_at(_tweensString,1));
	var _selectionDataString = string_delete(_tweensString,1,1);

	// Tolerate the GM 2026 "ref instance 100010" form as well as the bare
	// numeric form. TweensTarget() now normalises to digits before encoding,
	// but tween strings built elsewhere may still carry the reference text.
	// Sign is preserved so negative TweensGroup() values still round-trip.
	var _selectionData;
	if (string_digits(_selectionDataString) == string_replace(_selectionDataString, "-", ""))
	{
	    _selectionData = real(_selectionDataString);
	}
	else
	{
	    _selectionData = real(string_digits(_selectionDataString));
	}

	// TweensTarget() accepts either an instance or an object index. Only the
	// latter is a legal argument to object_is_ancestor() -- older runtimes
	// returned false for an out-of-range index, but GM 2026 raises a hard
	// error, so the ancestor test has to be gated on the value being one.
	// Instance ids start at 100000, so anything at or above that is never an
	// object index; check the range before calling object_exists() so it is
	// not handed an out-of-range value either.
	var _selectionIsObject = (_selectionData >= 0 && _selectionData < 100000
	                          && object_exists(_selectionData));
	var _script = argument[1];
	var _argCount = argument_count-2;
	var _arg0,_arg1,_arg2;

	switch(_argCount)
	{
	    case 3: _arg2 = argument[4];
	    case 2: _arg1 = argument[3];
	    case 1: _arg0 = argument[2];
	}

	var _tIndex = -1;

	switch(_selection)
	{
	    case 0:
	        var _tweens = ds_stack_pop(global.TGMS_TweensStack);
        
	        switch(_argCount)
	        {
	            case 0:
	                repeat(array_length(_tweens)){
	                    var _t = TGMS_FetchTween(_tweens[++_tIndex]);
	                    if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t);   
	                }
	            break;
	            case 1:
	                repeat(array_length(_tweens)){
	                    var _t = TGMS_FetchTween(_tweens[++_tIndex]);
	                    if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0);   
	                }
	            break;
	            case 2:
	                repeat(array_length(_tweens)){
	                    var _t = TGMS_FetchTween(_tweens[++_tIndex]);
	                    if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1);   
	                }
	            break;
	            case 3:
	                repeat(array_length(_tweens)){
	                    var _t = TGMS_FetchTween(_tweens[++_tIndex]);
	                    if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1, _arg2);   
	                }
	            break;
	        }
	    break;
    
	    case TWEENS_ALL:
	        var _tweens = SharedTweener().tweens;
        
	        switch(_argCount)
	        {    
	        case 0:
	            repeat(ds_list_size(_tweens)){  
	                var _t = _tweens[| ++_tIndex];
	                if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t);
	            }
	        break;
	        case 1:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0);
	            }
	        break;
	        case 2:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1);
	            }
	        break;
	        case 3:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1, _arg2);
	            }
	        break;
	        }
	    break;
    
	    case TWEENS_GROUP:
	        var _tweens = SharedTweener().tweens;
        
	        switch(_argCount)
	        {    
	        case 0:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (_t[TWEEN.GROUP] == _selectionData && TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t);
	            }
	        break;
	        case 1:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (_t[TWEEN.GROUP] == _selectionData && TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0);
	            }
	        break;
	        case 2:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (_t[TWEEN.GROUP] == _selectionData && TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1);
	            }
	        break;
	        case 3:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (_t[TWEEN.GROUP] == _selectionData && TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1, _arg2);
	            }
	        break;
	        }
	    break;
    
	    case TWEENS_TARGET:
	        var _tweens = SharedTweener().tweens;
        
	        switch(_argCount)
	        {    
	        case 0:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                var _target = _t[TWEEN.TARGET];
                
	                if (TGMS_TargetExists(_target))
	                if (_target == _selectionData || _target.object_index == _selectionData || (_selectionIsObject && object_is_ancestor(_target.object_index, _selectionData))){
	                    script_execute(_script, _t);
	                }
	            }
	        break;
	        case 1:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                var _target = _t[TWEEN.TARGET];
                
	                if (TGMS_TargetExists(_target))
	                if (_target == _selectionData || _target.object_index == _selectionData || (_selectionIsObject && object_is_ancestor(_target.object_index, _selectionData))){
	                    script_execute(_script, _t, _arg0);
	                }
	            }
	        break;
	        case 2:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                var _target = _t[TWEEN.TARGET];
                
	                if (TGMS_TargetExists(_target))
	                if (_target == _selectionData || _target.object_index == _selectionData || (_selectionIsObject && object_is_ancestor(_target.object_index, _selectionData))){
	                    script_execute(_script, _t, _arg0, _arg1);
	                }
	            }
	        break;
	        case 3:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                var _target = _t[TWEEN.TARGET];
                
	                if (TGMS_TargetExists(_target))
	                if (_target == _selectionData || _target.object_index == _selectionData || (_selectionIsObject && object_is_ancestor(_target.object_index, _selectionData))){
	                    script_execute(_script, _t, _arg0, _arg1, _arg2);
	                }
	            }
	        break;
	        }
	    break;
	}






}
