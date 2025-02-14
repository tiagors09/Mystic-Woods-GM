event_inherited();

MIN_DISTANCE_TO_FOLLOW = 50;
MIN_DISTANCE_TO_ATTACK = 20;
PATROL_TIME = 2;

timer_patrol = game_get_speed(gamespeed_fps) * PATROL_TIME;

spr_idle_front = spr_slime_idle_front;
spr_idle_right = spr_slime_idle_right;
spr_idle_back = spr_slime_idle_back;
spr_run_front = spr_slime_run_front;
spr_run_right = spr_slime_run_right;
spr_run_back = spr_slime_run_back;
spr_attack_front = spr_slime_attack_front;
spr_attack_right = spr_slime_attack_right;
spr_attack_back = spr_slime_attack_back;
spr_death = spr_slime_die;

is_patroling = true;
is_following_player = false;
is_attacking_player = false;
dead = false;

run_speed = .5;
attack_speed = 1;

patrol = function () {
    if (is_patroling and timer_patrol)
        timer_patrol--;
    else {
        current_state = choose(
            idle_front,
            idle_back,
            idle_left,
            idle_right,
            run_front,
            run_back,
            run_right,
            run_left
        );
        
        timer_patrol = game_get_speed(gamespeed_fps) * PATROL_TIME;
    }
}

follow= function () {
    if (is_following_player) {
        
    }
}

attack = function  () {
    
}

update_behavior_state = function () {
    if (instance_exists(obj_player)) {
        var _player_distance = distance_to_point(
            obj_player.x, 
            obj_player.y
        );
        
        if (
            _player_distance > MIN_DISTANCE_TO_FOLLOW
        ) {
            is_following_player = false;
            is_attacking_player = false;
            is_patroling = true;
        }
        
        if (
            _player_distance <= MIN_DISTANCE_TO_FOLLOW
            and _player_distance > MIN_DISTANCE_TO_ATTACK 
        ) {
            is_following_player = true;
            is_attacking_player = false;
            is_patroling = false;
        }
        
        if (
            _player_distance <= MIN_DISTANCE_TO_ATTACK
        ) {
            is_following_player = false;
            is_attacking_player = true;  
            is_patroling = false;
        }
    } else {
        is_following_player = false;
        is_attacking_player = false; 
        is_patroling = true;
    }
}