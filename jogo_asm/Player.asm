
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

;   Essa funcao le o teclado e ajusta o estado do player se
; for uma das teclas de mover o player 1.
update_player_um:
    push r0 

    inchar r0 
    loadn r6, #pu_posx
    loadn r7, #pu_posy
    call atuar_no_player

    pop r0
    rts

; A partir daqui sao funcoes do player 2, que eh controlado 
; por uma IA estupida

;  As coordenadas da localizacao do player 2
pd_posx : var #1
pd_posy : var #1

; O estado doo player 2. Se nao colocou uma bomba 
; ele esta no estado de corajoso em que ele vai ativamente
; ir na direcao do player esse eh o estado 0. O outro 
; estado eh o estado covarde, em que ele foje ativamente 
; da posicao da bomba que ele colocou.
; A ia comeca no estado corajoso
ia_stado : var #1
    static ia_stado + #0, #0

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

; Gera uma decisao corajosa com base na posicao do player 1.
;
;  As decisoes corajosas serao as decisoes que levam o player 
; 2 mais proximas ao player 1. Isso sera feito fazendo o a diferenca
; das distancias dos dois players. A direcao que tiver a menor distancia 
; e nao tiver nenhum obstaculo no caminho sera a decisa tomada. Caso 
; o obstaculo no caminho da menor dista seja uma parede, coloca uma bomba 
; no local e vai para o estado de covarde.
;
; @return {char} r0 - Acao a ser efetuada.
decisao_corajosa:

; Gera uma decisao covarde com base na posicao da bomba do player 2.
;
;  As decisoes covardes serao decisoes que levam o player 2 mais longe
; da bomba que ele colocara. A direcao que for oposta a bomba e nao 
; ter obstucalos sera a direcao tomada. O player 2 continua neste 
; estado ate que a bomba que ele colocou suma.
;
; @return {char} r0 - Acao a ser efetuada.
decisao_covarde:


; Calcula a acao que deve ser feita pelo player 2
;
; @return {char} r0 - Acao a ser efetuada.
decisao_de_acao:


;  Atualiza a Ia e o estado do player dois
update_player_dois: