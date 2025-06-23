
; As variaveis que representam a bomba 
; tem a seguinte strutura:
;
; colocada_ou_nao {bool} : #0
; tempo_des_de_ter_sido_colocada {int} : #1
; pos_x {int} : #2
; pos_y {int} : #3
; esta_no_estado_de_fogo {bool} : #4
; quantidade_de_tempo_da_explosao {int} : #5
; quantidade_de_tiles_de_explosao {int} : #6
; tiles_de_explosao {tile_explosao[21]} : #7
;
;  Assim tendo um tamanho de 70 bytes
;
;   Em que tile de explosao tem a seguinte estrutura:
; char_para_desenhar {char} : #0
; pos_x {int} : #1
; pos_y {int} : #2
;  
;   Tendo uma tamanho de 3 bytes
;

player_um_bomba : var #70
    static player_um_bomba + #0, #0
    static player_um_bomba + #4, #0
player_dois_bomba : var #70
    static player_dois_bomba + #0, #0
    static player_dois_bomba + #4, #0

;   A funcao colocar bomba coloca uma bomba no pe 
; do player, atualizando o charmap e desenhando a 
; bomba na tela.
;
; @param {endereco} r0 - Endereco da variavel que representa a 
; bomoba do player.
; @param {int} r1 - Posicao x do player que ira colocar 
; a bomba.
; @param {int} r2 - Posicao y do player que ira colocar 
; a bomba.
colocar_bomba:
    push r3
    push r4

    ; verificando se a bomba ja foi colocada 
    ; se ja foi, nao coloca
    loadi r3, r0 
    loadn r4, #1
    cmp r3, r4 
    jeq fim_colocar_bomba

    ; Se nao foi colocada atualizar os campos 
    ; e salvar no charmap 

    ; campo colocada_ou_nao
    loadn r3, #1
    storei r0, r3 

    ; campo tempo_des_de_ter_sido_colocada
    inc r0
    loadn r3, #0
    storei r0, r3

    ; campo pos_x
    inc r0 
    storei r0, r1

    ; campo pos_y
    inc r0 
    storei r0, r2 

    ; colocar a tile de bomba
    loadn r0, #'#'
    call set_tile
    call two_by_two_sequence_draw

    fim_colocar_bomba:
        pop r4
        pop r3 
        rts


;   Gera a explosao da bomba.
;
; @param {endereco} r0 - Bomba para gerar a explosao.
;
gerar_explosao:
    push r1
    push r2 
    push r3
    push r7

    ; pulando para a pos_x 
    loadn r3, #2
    add r3, r0, r3
    loadi r1, r3
    inc r3
    loadi r2, r3

    loadn r0, #8
    call set_tile
    call two_by_two_draw 

    pop r7 
    pop r3 
    pop r2
    pop r1
    rts

;  Incrementa o contador do tempo que a bomba foi 
; colocada, se chegou no momento dela explodir, 
; explode ela.
;
; @param {endereco} r0 - Endereco da bomba para 
; fazer o update.
;
update_bomba:
    push r1
    push r2

    ; verificando se tem um bomba colocada.
    loadi r1, r0
    loadn r2, #0
    cmp r1, r2 
    jeq update_fogo

    inc r0 
    loadi r1, r0 
    inc r1 
    storei r0, r1

    ; Se a bomba chegou no tempo limite explode 
    ; ela.
    loadn r2, #1000
    cmp r1, r2
    jne fim_do_update_bomba
        ; tirando a flag de bomba colocada
        dec r0 
        loadn r1, #0
        storei r0, r1

        call gerar_explosao
        jmp fim_do_update_bomba

    update_fogo:
        ; dar update no fogo se estiver no 
        ; estado de fogo

    fim_do_update_bomba:
        pop r2
        pop r1 
        rts

;  Faz o update das bombas dos players.
;
update_bombas:
    push r0

    loadn r0, #player_um_bomba
    call update_bomba

    pop r0
    rts