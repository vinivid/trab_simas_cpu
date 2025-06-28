jmp main

@include Map.asm
@include Player.asm
@include Bomb.asm
@include Menus.asm

main:
    call draw_start_menu
    loadn r1, #'z'
    ; esperando o botao de start   
    menu_loop:
        inchar r0
        cmp r0, r1
        jeq menu_loop_end
        jmp menu_loop
    menu_loop_end:

    loadn r5, #tile_map
    call draw_map_full
    call ini_player_um
    call ini_player_dois
    
    game_loop:
        call update_players
        call update_bombas
        jmp game_loop