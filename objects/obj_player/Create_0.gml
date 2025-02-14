event_inherited();

player_lives = MAX_LIFE;

spr_idle_front = spr_player_idle_front;
spr_idle_right = spr_player_idle_right;
spr_idle_back = spr_player_idle_back;
spr_run_front = spr_player_run_front;
spr_run_right = spr_player_run_right;
spr_run_back = spr_player_run_back;
spr_attack_front = spr_player_attack_front;
spr_attack_right = spr_player_attack_right;
spr_attack_back = spr_player_attack_back;
spr_death = spr_player_death;

check_input = function () {
    var _up = keyboard_check(ord("W")) or keyboard_check(vk_up);
    var _right = keyboard_check(ord("D")) or keyboard_check(vk_right);
    var _down = keyboard_check(ord("S")) or keyboard_check(vk_down);
    var _left = keyboard_check(ord("A")) or keyboard_check(vk_left);
        
    var _attack = (
        keyboard_check_pressed(ord("Z")) 
        or keyboard_check_pressed(ord("K"))
    ) ;
    
    var _is_moving = _up or _right or _down or _left;
    
    if (is_alive and not attacking and not _is_moving)
        update_idle_state();
    
    if (is_alive and not attacking and _is_moving) {
        if (_up) 
            current_state = run_back;
        else if(_left) 
            current_state = run_left;
        else if (_down) 
            current_state = run_front;
        else if(_right) 
            current_state = run_right;
    }
    
    if (is_alive and _attack and not attacking and not _is_moving)
        attacking = true;
    
    if (is_alive and attacking)
        update_attack_state();
    
    if (player_lives <= 0)
        is_alive = false;
    
    if (not is_alive)
        current_state = die;
}

run_speed = 2;