/// @description Methods
function get_input(){
	player_fsm.move_cfg.hdir	= max(keyboard_check(ord("D")), keyboard_check(vk_right)) -
			          max(keyboard_check(ord("A")), keyboard_check(vk_left));
	player_fsm.move_cfg.vdir	= max(keyboard_check(ord("S")), keyboard_check(vk_down)) - 
					  max(keyboard_check(ord("W")), keyboard_check(vk_up));
}
