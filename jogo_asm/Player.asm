
@include util.asm
@include Map.asm

;  As coordenadas da localizacao do player 1
pu_posx : var #1
pu_posy : var #1

;   Inicializa o player no mapa na posicao do player1 
; dada pela variavel player_one_ini_pos
init_player_one:
    push r0
    push r1
    push r2

    ; pegar posicao x e y
    loadn r0, #player_one_ini_pos
    loadi r1, r0 
    inc r0 
    loadi r2, r0 

    ; Guardando as variaveis nos enderecos staticos
    store pu_posx, r1
    store pu_posy, r2

    ; Setando no mapa e desenhando na tela
    loadn r0, #'G'
    call set_tile
    call two_by_two_sequence_draw

    pop r2 
    pop r1 
    pop r0


;   A funcao atuar no player altera o estado do player 
; com base no char passado (tecla).
;
; @param {char} r0 - Acao a ser feita no player, 'w' para 
; ir para cima, 'a' para ir para esquerda, 's' para ir para 
; baixo, 'd' para ir para direita e 'z' para colocar uma bomba.
; Se o caractere passado nao representar uma acao valida a funcao 
; nao faz nada.
; @param {endereco} r6 - Endereco da posicao x do player 
; @param {endereco} r7 - Endereco da posicao y do player
; 
atuar_no_player:
    push r1 
    push r2

    loadn r1, #'w'
    cmp r0, r1
    jeq para_cima

    loadn r1, #'s'
    cmp r0, r1
    jeq para_baixo

    loadn r1, #'a'
    cmp r0, r1
    jeq para_esquerda

    loadn r1, #'d'
    cmp r0, r1
    jeq para_direita

    ; nao foi nenhum dos inputs de controlar o player 
    jmp atuar_return

    para_cima:
        loadi r2, r7 
        ; Se tiver na ultima tile do topo nao vai pra cima 
        loadn r3, #0
        cmp r2, r3 
        jeq atuar_return 
        loadi r1, r6

        ; verifica se eh uma tile vazia para que o player possa ir
        dec r2 
        call get_tile
        cmp r0, r3
        jne atuar_return
        inc r2

        ; apagando a tile do player que anterioremente estava la 
        call set_tile
        call two_by_two_draw

        ; colocando o player na proxima posicao
        loadi r1, r6
        loadi r2, r7 
        dec r2
        storei r7, r2

        loadn r0, #'G'
        call set_tile
        call two_by_two_sequence_draw
        jmp atuar_return

    para_baixo:
        loadi r2, r7 
        ; Se tiver na ultima tile de baixo nao vai pra baixo 
        loadn r3, #12
        cmp r2, r3 
        jeq atuar_return 
        loadi r1, r6

        ; verifica se eh uma tile vazia para que o player possa ir
        loadn r3, #0
        inc r2 
        call get_tile
        cmp r0, r3
        jne atuar_return
        dec r2

        ; apagando a tile do player que anterioremente estava la 
        call set_tile
        call two_by_two_draw

        ; colocando o player na proxima posicao
        loadi r1, r6
        loadi r2, r7 
        inc r2
        storei r7, r2

        loadn r0, #'G'
        call set_tile
        call two_by_two_sequence_draw
        jmp atuar_return

    para_esquerda:
        loadi r1, r6 
        ; Se tiver na ultima tile da esqueda nao vai pra esquerda 
        loadn r3, #0
        cmp r1, r3 
        jeq atuar_return 
        loadi r2, r7

        ; verifica se eh uma tile vazia para que o player possa ir
        dec r1 
        call get_tile
        cmp r0, r3
        jne atuar_return
        inc r1

        ; apagando a tile do player que anterioremente estava la 
        call set_tile
        call two_by_two_draw

        ; colocando o player na proxima posicao
        loadi r1, r6
        loadi r2, r7 
        dec r1
        storei r6, r1

        loadn r0, #'G'
        call set_tile
        call two_by_two_sequence_draw
        jmp atuar_return

    para_direita:
        loadi r1, r6 
        ; Se tiver na ultima tile da direita nao vai pra direita
        loadn r3, #19
        cmp r1, r3 
        jeq atuar_return 
        loadi r2, r7

        ; verifica se eh uma tile vazia para que o player possa ir
        loadn r3, #0
        inc r1 
        call get_tile
        cmp r0, r3
        jne atuar_return
        dec r1

        ; apagando a tile do player que anterioremente estava la 
        call set_tile
        call two_by_two_draw

        ; colocando o player na proxima posicao
        loadi r1, r6
        loadi r2, r7 
        inc r1
        storei r6, r1

        loadn r0, #'G'
        call set_tile
        call two_by_two_sequence_draw
        jmp atuar_return

    atuar_return:
        pop r4 
        pop r3
        rts

;   Essa funcao le o teclado e ajusta o estado do player se
; for uma das teclas de mover o player 1.
input_player_um:
    push r0 

    inchar r0 
    loadn r6, #pu_posx
    loadn r7, #pu_posy
    call atuar_no_player

    pop r0
    rts
