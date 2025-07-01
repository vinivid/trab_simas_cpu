@include Map.asm
@include menu_principal.asm

bomberman_msg : string "bomberman"
init_msg : string "pressione z para iniciar"
wipe_init_msg : string "                        "
wipe_bomberman_str : string "         "

;  Desenha a tela de menu na tela.
;
draw_start_menu:
    push r0
    push r1
    push r2 
    push r5

    ; printando o nome do jogo
    loadn r0, #bomberman_msg
    loadn r1, #16
    loadn r2, #2304
    call print_str_colored

    ; printando a mensagem de inicio
    loadn r0, #init_msg
    loadn r1, #87
    call print_str

    loadn r5, #menu_map
    call draw_map_full

    pop r5
    pop r2
    pop r1 
    pop r0
    rts

pu_loss : string "player 1 perdeu"
pd_loss : string "player 2 perdeu"
start_again_string : string "pressione z para reiniciar"
wipe_loss : string "               "
wipe_loss_restart : string "                                "

;  Imprime a string de que um dos players perdeu,
; se for o player 1 que perdeu eh necessasario passar
; 1 para funcao, 2 caso tenha sido o player 2.
;
; @param {int} r0 - O numero do player que perdeu
draw_player_lose:
    push r1 
    push r2

    loadn r1, #1
    cmp r1, r0 
    jeq player_one_lost

        ; essa eh a branch se o player 2 perdeu
        loadn r0, #pd_loss
        loadn r1, #52
        loadn r2, #2304
        call print_str_colored
        jmp draw_player_lose_end

    player_one_lost:
        loadn r0, #pu_loss
        loadn r1, #52
        loadn r2, #2304
        call print_str_colored

    draw_player_lose_end:
        loadn r0, #start_again_string
        loadn r1, #87
        call print_str

        pop r2
        pop r1
        rts

;   Remove o texto do player que perdeu.
remover_player_perdeu:
    push r0
    push r1

    ; remove o player perdeu 
    loadn r0, #wipe_loss
    loadn r1, #52
    call print_str

    ; remove o texto de restart
    loadn r0, #wipe_loss_restart
    loadn r1, #87
    call print_str

    pop r0
    pop r1
    rts

; Imprime o nome do mapa com a cor azul
print_map_name:
    push r0 
    push r1
    push r2

    ; tirando o nome do bomberman
    loadn r0, #wipe_bomberman_str
    loadn r1, #16
    call print_str

    ; tirando o nome do bomberman
    loadn r0, #wipe_init_msg
    loadn r1, #87
    call print_str

    ; escrevendo o nome do mapa
    loadn r0, #tile_map_name
    load r1, tile_map_location
    loadn r2, #3072 ; cor azul
    call print_str_colored

    pop r2
    pop r1
    pop r0
    rts