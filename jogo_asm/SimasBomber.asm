jmp main

@include Map.asm
@include Player.asm 
@include Bomb.asm

main:
    call init_player_one

    game_loop : 
        call input_player_um
        jmp game_loop