MAX_PLAYER_LIFE = 1;

enum States {
    IDLE_FRONT,
    IDLE_BACK,
    IDLE_LEFT,
    IDLE_RIGHT,
    RUN_FRONT,
    RUN_BACK,
    RUN_LEFT,
    RUN_RIGHT,
    ATTACK_FRONT,
    ATTACK_BACK,
    ATTACK_LEFT,
    ATTACK_RIGHT,
    DIE,
};

enum Directions {
    UP = 90,
    RIGHT = 0,
    LEFT = 180,
    DOWN = 270,
}

is_alive = true;
player_lives = MAX_PLAYER_LIFE;
attacking = false;

idle_front = function () {
    direction = Directions.DOWN;
    speed = 0;
    sprite_index = spr_player_idle_front;
}

idle_right = function () {
    direction = Directions.RIGHT;
    speed = 0;
    image_xscale = 1;
    sprite_index = spr_player_idle_right;
}

idle_back = function () {
    direction = Directions.UP;
    speed = 0;
    sprite_index = spr_player_idle_back;
}

idle_left = function () {
    direction = Directions.LEFT;
    speed = 0;
    image_xscale = -1;
    sprite_index = spr_player_idle_right;
}

run_front = function () {
    speed = 2;
    direction = Directions.DOWN;
    sprite_index = spr_player_run_front;
}

run_right = function () {
    speed = 2;
    direction = Directions.RIGHT;
    image_xscale = 1;
    sprite_index = spr_player_run_right;
}

run_back = function (){
    speed = 2;
    direction = Directions.UP;
    sprite_index = spr_player_run_back;
}

run_left = function () {
    speed = 2;
    direction = Directions.LEFT;
    image_xscale = -1;
    sprite_index = spr_player_run_right;
}

attack_front = function () {
    speed = 0;
    sprite_index = spr_player_attack_front;
}

attack_left = function () {
    speed = 0;
    image_xscale = -1;
    sprite_index = spr_player_attack_right;
}

attack_right = function () {
    speed = 0;
    image_xscale = 1;
    sprite_index = spr_player_attack_right;
}

attack_back = function () {
    speed = 0;
    sprite_index = spr_player_attack_back;
}

die = function () {
    speed = 0;
    sprite_index = spr_player_death;
}

current_state = idle_front;

update_idle_state = function () {
    switch (direction) {
        case Directions.UP:
            current_state = idle_back;
            break;
        case Directions.RIGHT:
            current_state = idle_right;
            break;
        case Directions.DOWN:
            current_state = idle_front;
            break;
        case Directions.LEFT:
            current_state = idle_left;
            break;
    }
}

update_attack_state = function () {
    switch (direction) {
        case Directions.UP:
            current_state = attack_back;
            break;
        case Directions.RIGHT:
            current_state = attack_right;
            break;
        case Directions.DOWN:
            current_state = attack_front;
            break;
        case Directions.LEFT:
            current_state = attack_left;
            break;
    }
}

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