jmp main

@include Map.asm
@include Player.asm 

main:
    call draw_map_full
    call ini_player_um
    call ini_player_dois
    
    game_loop :
        call update_player_um
        jmp game_loop