MAX_LIFE = 1;

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
attacking = false;

spr_idle_front = -1;
spr_idle_right = -1;
spr_idle_back = -1;
spr_run_front = -1;
spr_run_right = -1;
spr_run_back = -1;
spr_attack_front = -1;
spr_attack_right = -1;
spr_attack_back = -1;
spr_death = -1;

run_speed = 0;
attack_speed = 0;

idle_front = function () {
    direction = Directions.DOWN;
    speed = 0;
    sprite_index = spr_idle_front;
}

idle_right = function () {
    direction = Directions.RIGHT;
    speed = 0;
    image_xscale = 1;
    sprite_index = spr_idle_right;
}

idle_back = function () {
    direction = Directions.UP;
    speed = 0;
    sprite_index = spr_idle_back;
}

idle_left = function () {
    direction = Directions.LEFT;
    speed = 0;
    image_xscale = -1;
    sprite_index = spr_idle_right;
}

run_front = function () {
    speed = run_speed;
    direction = Directions.DOWN;
    sprite_index = spr_run_front;
}

run_right = function () {
    speed = run_speed;
    direction = Directions.RIGHT;
    image_xscale = 1;
    sprite_index = spr_run_right;
}

run_back = function (){
    speed = run_speed;
    direction = Directions.UP;
    sprite_index = spr_run_back;
}

run_left = function () {
    speed = run_speed;
    direction = Directions.LEFT;
    image_xscale = -1;
    sprite_index = spr_run_right;
}

attack_front = function () {
    speed = attack_speed;
    sprite_index = spr_attack_front;
}

attack_left = function () {
    speed = attack_speed;
    image_xscale = -1;
    sprite_index = spr_attack_right;
}

attack_right = function () {
    speed = attack_speed;
    image_xscale = 1;
    sprite_index = spr_attack_right;
}

attack_back = function () {
    speed = attack_speed;
    sprite_index = spr_attack_back;
}

die = function () {
    speed = 0;
    sprite_index = spr_death;
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