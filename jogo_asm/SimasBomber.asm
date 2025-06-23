jmp main

@include Map.asm
@include Player.asm
@include Bomb.asm

main:
    call draw_map_full
    call ini_player_um
    call ini_player_dois
    
    game_loop :
        call update_players
        call update_bombas
        jmp game_loop