
@include util.asm
@include Map.asm
@include Bomb.asm

;   Inicializa o player na posicao determinada pelo 
; endereco de inicializacao.
;
; @param {endereco} r0 - Endereco de inicializacao do 
; player
; @param {endereco} r6 - Endereco da pos x do player 
; @param {endereco} r7 - Enderece da pos y do player
ini_player:
    push r1
    push r2

    ; pegando posicao x e y
    loadi r1, r0 
    inc r0 
    loadi r2, r0 

    ; Guardando as variaveis nos enderecos staticos
    storei r6, r1
    storei r7, r2

    ; Setando no mapa e desenhando na tela
    loadn r0, #'G'
    call set_tile
    call two_by_two_sequence_draw

    pop r2 
    pop r1 
    rts

;   A funcao player para cima move o player para cima atualizando 
; suas informacoes
;
; @param {const endereco} r6 - Endereco da posicao x do player 
; @param {const endereco} r7 - Endereco da posicao y do player
; 
player_para_cima:
    push r0
    push r1
    push r2
    push r3

    loadi r2, r7 

    ; Se tiver na ultima tile do topo nao vai pra cima 
    loadn r3, #0
    cmp r2, r3 
    jeq player_para_cima_end
    loadi r1, r6

    ; verifica se eh uma tile vazia para que o player possa ir
    dec r2 
    call get_tile
    cmp r0, r3
    jne player_para_cima_end
    inc r2

    ; apagando a tile do player que anterioremente estava la
    ; se nao for uma tile de bomba.
    call get_tile
    loadn r3, #'#'
    cmp r0, r3
    jeq pular_desnhar_sobre_bomba_cima
        loadn r0, #0
        call set_tile
        call two_by_two_draw

    pular_desnhar_sobre_bomba_cima:

    ; colocando o player na proxima posicao
    loadi r1, r6
    loadi r2, r7 
    dec r2
    storei r7, r2

    loadn r0, #'G'
    call set_tile
    call two_by_two_sequence_draw

    player_para_cima_end:
        pop r3 
        pop r2 
        pop r1 
        pop r0 
        rts

;   A funcao player para baixo move o player para baixo atualizando 
; suas informacoes
;
; @param {const endereco} r6 - Endereco da posicao x do player 
; @param {const endereco} r7 - Endereco da posicao y do player
; 
player_para_baixo:
    push r0
    push r1
    push r2
    push r3

    loadi r2, r7 
    ; Se tiver na ultima tile de baixo nao vai pra baixo 
    loadn r3, #12
    cmp r2, r3 
    jeq player_para_baixo_end
    loadi r1, r6

    ; verifica se eh uma tile vazia para que o player possa ir
    loadn r3, #0
    inc r2 
    call get_tile
    cmp r0, r3
    jne player_para_baixo_end
    dec r2

    ; apagando a tile do player que anterioremente estava la
    ; se nao for uma tile de bomba.
    call get_tile
    loadn r3, #'#'
    cmp r0, r3
    jeq pular_desnhar_sobre_bomba_baixo
        loadn r0, #0
        call set_tile
        call two_by_two_draw

    pular_desnhar_sobre_bomba_baixo:

    ; colocando o player na proxima posicao
    loadi r1, r6
    loadi r2, r7 
    inc r2
    storei r7, r2

    loadn r0, #'G'
    call set_tile
    call two_by_two_sequence_draw

    player_para_baixo_end:
        pop r3 
        pop r2 
        pop r1 
        pop r0 
        rts

;   A funcao player para esquerda move o player para esquerda atualizando 
; suas informacoes.
;
; @param {const endereco} r6 - Endereco da posicao x do player 
; @param {const endereco} r7 - Endereco da posicao y do player
; 
player_para_esquerda:
    push r0
    push r1
    push r2
    push r3

    loadi r1, r6 
    ; Se tiver na ultima tile da esqueda nao vai pra esquerda 
    loadn r3, #0
    cmp r1, r3 
    jeq player_para_esquerda_end
    loadi r2, r7

    ; verifica se eh uma tile vazia para que o player possa ir
    dec r1 
    call get_tile
    cmp r0, r3
    jne player_para_esquerda_end
    inc r1

    call get_tile
    loadn r3, #'#'
    cmp r0, r3
    jeq pular_desnhar_sobre_bomba_esquerda
        loadn r0, #0
        call set_tile
        call two_by_two_draw

    pular_desnhar_sobre_bomba_esquerda:

    ; colocando o player na proxima posicao
    loadi r1, r6
    loadi r2, r7 
    dec r1
    storei r6, r1

    loadn r0, #'G'
    call set_tile
    call two_by_two_sequence_draw

    player_para_esquerda_end:
        pop r3 
        pop r2 
        pop r1 
        pop r0 
        rts

;   A funcao player para direita move o player para direita atualizando 
; suas informacoes.
;
; @param {const endereco} r6 - Endereco da posicao x do player 
; @param {const endereco} r7 - Endereco da posicao y do player
; 
player_para_direita:
    push r0
    push r1
    push r2
    push r3

    loadi r1, r6 
    ; Se tiver na ultima tile da direita nao vai pra direita
    loadn r3, #19
    cmp r1, r3 
    jeq player_para_direita_end 
    loadi r2, r7

    ; verifica se eh uma tile vazia para que o player possa ir
    loadn r3, #0
    inc r1 
    call get_tile
    cmp r0, r3
    jne player_para_direita_end
    dec r1

    ; apagando a tile do player que anterioremente estava la
    ; se nao for uma tile de bomba.
    call get_tile
    loadn r3, #'#'
    cmp r0, r3
    jeq pular_desnhar_sobre_bomba_direita
        loadn r0, #0
        call set_tile
        call two_by_two_draw

    pular_desnhar_sobre_bomba_direita:

    ; colocando o player na proxima posicao
    loadi r1, r6
    loadi r2, r7 
    inc r1
    storei r6, r1

    loadn r0, #'G'
    call set_tile
    call two_by_two_sequence_draw

    player_para_direita_end:
        pop r3 
        pop r2 
        pop r1 
        pop r0 
        rts

; Coisas do player 1


;  As coordenadas da localizacao do player 1
pu_posx : var #1
pu_posy : var #1

; Inicializa o player 1
ini_player_um:
    push r0
    loadn r0, #player_one_ini_pos
    loadn r6, #pu_posx
    loadn r7, #pu_posy
    call ini_player
    pop r0 
    rts

;   A funcao  altera o estado do player um
; com base no char passado (tecla).
;
; @param {char} r0 - Acao a ser feita no player, 'w' para 
; ir para cima, 'a' para ir para esquerda, 's' para ir para 
; baixo, 'd' para ir para direita e 'z' para colocar uma bomba.
; Se o caractere passado nao representar uma acao valida a funcao 
; nao faz nada.
; @param {const endereco} r6 - Endereco da posicao x do player 
; @param {const endereco} r7 - Endereco da posicao y do player
; 
atuar_no_player_um:
    push r1 
    push r2
    push r6
    push r7
    loadn r6, #pu_posx
    loadn r7, #pu_posy

    loadn r1, #'w'
    cmp r0, r1
    ceq player_para_cima

    loadn r1, #'a'
    cmp r0, r1
    ceq player_para_esquerda

    loadn r1, #'s'
    cmp r0, r1
    ceq player_para_baixo

    loadn r1, #'d'
    cmp r0, r1
    ceq player_para_direita

    loadn r1, #'z'
    cmp r0, r1 
    jne atuar_no_player_um_fim
        loadn r0, #player_um_bomba
        load r1, pu_posx
        load r2, pu_posy
        call colocar_bomba
    atuar_no_player_um_fim:
        pop r7 
        pop r6
        pop r2 
        pop r1 
        rts

; coisas do player 2

;  As coordenadas da localizacao do player 2
pd_posx : var #1
pd_posy : var #1

;   Inicializa o player dois no mapa na posicao do player2 
; dada pela variavel player_two_ini_pos
ini_player_dois:
    push r0
    loadn r0, #player_two_ini_pos
    loadn r6, #pd_posx
    loadn r7, #pd_posy
    call ini_player
    pop r0
    rts

;   A funcao  altera o estado do player dois
; com base no char passado (tecla).
;
; @param {char} r0 - Acao a ser feita no player, 'i' para 
; ir para cima, 'j' para ir para esquerda, 'k' para ir para 
; baixo, 'l' para ir para direita e 'n' para colocar uma bomba.
; Se o caractere passado nao representar uma acao valida a funcao 
; nao faz nada.
; @param {const endereco} r6 - Endereco da posicao x do player 
; @param {const endereco} r7 - Endereco da posicao y do player
; 
atuar_no_player_dois:
    push r1 
    push r2
    push r6
    push r7
    loadn r6, #pd_posx
    loadn r7, #pd_posy

    loadn r1, #'i'
    cmp r0, r1
    ceq player_para_cima

    loadn r1, #'j'
    cmp r0, r1
    ceq player_para_esquerda

    loadn r1, #'k'
    cmp r0, r1
    ceq player_para_baixo

    loadn r1, #'l'
    cmp r0, r1
    ceq player_para_direita

    pop r7 
    pop r6
    pop r2 
    pop r1 
    rts

; coisas de ler input

;   Essa funcao le o teclado e ajusta o estado dos players 
; caso alguma tecla de controle tenha sido pressionada.
update_players:
    push r0 

    inchar r0 
    call atuar_no_player_um
    call atuar_no_player_dois

    pop r0
    rts