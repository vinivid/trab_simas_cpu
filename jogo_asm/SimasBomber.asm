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

    ; inicializando o jogo
    loadn r5, #tile_map
    call draw_map_full
    call print_map_name
    call ini_player_um
    call ini_player_dois
    
    game_loop:
        call update_players
        ; checando se algum player morreu
        loadn r1, #0
        cmp r0, r1
        jne death_state

        call update_bombas
        jmp game_loop

    death_state:
        call draw_player_lose
        loadn r1, #'z'  
        death_loop:
            ; esperando pressionar z
            inchar r0
            cmp r0, r1
            jeq death_loop_end
            jmp death_loop

        death_loop_end:
            ; reinicalizando os dados e voltando 
            ; para o jogo
            call remover_player_perdeu
            call restore_tile_map
            loadn r5, #tile_map
            call draw_map_full
            call ini_player_um
            call ini_player_dois
            jmp game_loop
