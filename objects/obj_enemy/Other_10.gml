function move(){
	time = get_timer();
	
	if (change) {
		enemy_fsm.move_cfg.hdir = -1;
		enemy_fsm.move_cfg.vdir = -1;
	}
	else {
		enemy_fsm.move_cfg.hdir = 1;
		enemy_fsm.move_cfg.vdir = 1;
	}
	
	if ( time % 10 == 0) {
		change = !change;
	}
}