draw_set_color(c_white);
draw_set_font(fnt_test);

draw_text(
    50,
    50,
    string(player_lives)
);

draw_text(
    50,
    70,
    string(is_alive)
);

draw_text(
    50,
    90,
    string(sprite_get_number(spr_player_death))
);