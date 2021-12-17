// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function meta_move_fsm(target_obj) constructor {

	move_cfg = {
		spd  : 3,
		hspd : 0,
		vspd : 0,
		face : 1,
		hdir : 0,
		vdir : 0,
		target_object: target_obj,
	    fsm : new SnowState("idle")
	}

	move_cfg.fsm
		.add("idle", {
			enter: function() {	
				move_cfg.hspd = 0;
				move_cfg.vspd = 0;
			},
			step: function() {
				if (abs(move_cfg.hdir)) {
					move_cfg.fsm.change("run");
					return;
				}
			
				if (abs(move_cfg.vdir)) {
					move_cfg.fsm.change("run");
					return;
				}
			    
				//Movement and Collisions
				self.move_and_collide(move_cfg);
			}
		})
		.add("run", {
			enter: function() {
			},
			step: function() {
				var _hdir = move_cfg.hdir;
				move_cfg.hspd = move_cfg.spd * _hdir;
			
				var _vdir = move_cfg.vdir;
				move_cfg.vspd = move_cfg.spd * _vdir;
			
			
				// if no move keys are pressed, switch back to idle
				if (_hdir == 0 and _vdir == 0) {
					move_cfg.fsm.change("idle");
					return;
				}
			
				move_cfg.face = _hdir;
			
				//Movement and Collisions
				self.move_and_collide(move_cfg);
			}
		});
		
	move_and_collide = method(other, function() {
		target_move_cfg = argument[0];
	
		if (place_meeting(target_move_cfg.target_object.x + target_move_cfg.hspd, target_move_cfg.target_object.y, obj_wall)) {
			while (!place_meeting(target_move_cfg.target_object.x + sign(target_move_cfg.hspd), target_move_cfg.target_object.y, obj_wall)) target_move_cfg.target_object.x += sign(target_move_cfg.hspd);
			target_move_cfg.hspd = 0;
		}
		target_move_cfg.target_object.x += target_move_cfg.hspd;
	
		if (place_meeting(target_move_cfg.target_object.x, target_move_cfg.target_object.y + target_move_cfg.vspd, obj_wall)) {
			while (!place_meeting(target_move_cfg.target_object.x, target_move_cfg.target_object.y + sign(target_move_cfg.vspd), obj_wall)) target_move_cfg.target_object.y += sign(target_move_cfg.vspd);
			target_move_cfg.vspd = 0;
		}
		target_move_cfg.target_object.y += target_move_cfg.vspd
	});
}