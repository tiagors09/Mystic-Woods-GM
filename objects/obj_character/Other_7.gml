if (
    current_state == attack_back 
    or current_state == attack_front 
    or current_state == attack_left
    or current_state == attack_right
)
    attacking = false;
else if (current_state == die)
    image_index = sprite_get_number(spr_death) - 1;