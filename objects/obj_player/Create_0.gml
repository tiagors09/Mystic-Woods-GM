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
};

enum Directions {
    UP = 90,
    RIGHT = 0,
    LEFT = 180,
    DOWN = 270,
}

current_state = States.IDLE_FRONT;

direction = Directions.DOWN;
last_direction = direction;
is_moving = false;
is_attacking = false;

idle_front = function () {
    speed = 0;
    sprite_index = spr_player_idle_front;
}

idle_right = function () {
    speed = 0;
    image_xscale = 1;
    sprite_index = spr_player_idle_right;
}

idle_back = function () {
    speed = 0;
    sprite_index = spr_player_idle_back;
}

idle_left = function () {
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

verify_last_direction_when_is_not_moving = function () {
    switch (direction) {
        case Directions.UP:
            current_state = States.IDLE_BACK;
            break;
        case Directions.RIGHT:
            current_state = States.IDLE_RIGHT;
            break;
        case Directions.DOWN:
            current_state = States.IDLE_FRONT;
            break;
        case Directions.LEFT:
            current_state = States.IDLE_LEFT;
            break;
    }
}

verify_last_direction_when_attack = function () {
    switch (direction) {
        case Directions.UP:
            current_state = States.ATTACK_BACK;
            break;
        case Directions.RIGHT:
            current_state = States.ATTACK_RIGHT;
            break;
        case Directions.DOWN:
            current_state = States.ATTACK_FRONT;
            break;
        case Directions.LEFT:
            current_state = States.ATTACK_LEFT;
            break;
    }
}

check_movement = function () {
    var _up = keyboard_check(ord("W")) or keyboard_check(vk_up);
    var _right = keyboard_check(ord("D")) or keyboard_check(vk_right);
    var _down = keyboard_check(ord("S")) or keyboard_check(vk_down);
    var _left = keyboard_check(ord("A")) or keyboard_check(vk_left);
    
    is_moving = _up or _right or _down or _left;
    
    is_attacking = (
        keyboard_check_pressed(ord("Z")) 
        or mouse_check_button_pressed(mb_left)
    ) ;
    
    
    if (_up) 
        current_state = States.RUN_BACK;
    else if(_right) 
        current_state = States.RUN_RIGHT;
    else if(_down) 
        current_state = States.RUN_FRONT;
    else if (_left) 
        current_state = States.RUN_LEFT; 
    else if(not is_moving and not is_attacking)
        verify_last_direction_when_is_not_moving();
}

check_state = function () {
    switch (current_state) {
        case States.IDLE_FRONT:
            idle_front();
            break;
        case States.IDLE_BACK:
            idle_back();
            break;
        case States.IDLE_LEFT:
            idle_left();
            break;
        case States.IDLE_RIGHT:
            idle_right();
            break;
        case States.RUN_FRONT:
            run_front();
            break;
        case States.RUN_BACK:
            run_back();
            break;
        case States.RUN_LEFT:
            run_left();
            break;
        case States.RUN_RIGHT:
            run_right();
            break;
        case States.ATTACK_FRONT:
            attack_front();
            break;
        case States.ATTACK_BACK:
            attack_back();
            break;
        case States.ATTACK_LEFT:
            attack_left();
            break;
        case States.ATTACK_RIGHT:
            attack_right();
            break;
        default:
            break;
    }
}