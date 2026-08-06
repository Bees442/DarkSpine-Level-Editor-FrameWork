/// @description Control the application
// Play and Stop button Check
if mouse_check_button_pressed(mb_right)
{
 for (var i = 0; i<2;i++)
 {
  if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),button_play[i][0],button_play[i][1],button_play[i][2],button_play[i][3])
  {
   switch(i)
   {
	// Start the simulation, the editor toll is destroyed, leaving the 90% of the power in test mode
    case 0 : dks_editor_work_play(); instance_create_depth( x, y, depth,obj_joint_test);exit;
	// Stop the simulation and load the last available workspace saved, launching the editor tool.
    case 1 :
            if (is_playing)
            {
             dks_work_stop();
             depth = -1;
             is_playing =false;
            }
    exit;
   } 
  }
 }  
} 

// CTRL+F toggles the FPS readout. Handled here rather than only in
// obj_deco_creator so it works while a level is playing, where the editor
// object no longer exists. Guarded on obj_input so typing never flips it.
if (keyboard_check_pressed(ord("F")) && keyboard_check(vk_control))
{
 if (!dks_input_object_get_active(obj_input))
 {
  global.show_fps = !global.show_fps;
 }
}

// If we are in simulation mode, by pressing F6 you can draw the physics geometry of your objects
if (is_playing)
{
 if keyboard_check_pressed(vk_anykey)
 {
  switch(keyboard_key)
  {
   case vk_f6 : global.all_collision = !global.all_collision;break;


  }
 }
}