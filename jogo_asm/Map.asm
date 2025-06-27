;  Esse arquivo inclui o mapa, as tiles pertencetes
; ao mapa e funcoes para interagir com o mapa.
;
;  O mapa eh a tela que contem o player as bombas 
; e os obsctaculos e eh representado por um tile map 
; (uma grid) de 20 X 13 tiles. Por exemplo, as paredes
; sao tiles no mapa, o player eh uma tile no mapa a 
; bomba e a explosao eh uma tile no mapa e etc.
;
;  O mapa tem a seguinte grid.
;
;    0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 
; 0 
; 1
; 2
; 3
; 4
; 5
; 6
; 7
; 8
; 9
; 10
; 11
; 12
;
;  Ou seja, o eixo x do mapa vai de [0, 19] e o eixo y
; do mapa vai de [0, 12]. Uma posicao no mapa eh dado por 
; (x, y). 
;   Em cada uma das posicoes do mapa existe um 
; caracter que representara cada uma das tiles. Por exemplo 
; a tile de parede pode ser representado pelo caracter 'A' 
; (que eh igual a 65 em decimal) ou por qualquer outro numero
; inteiro.
;   As tiles que sao obstaculos do mapa/chao, como as paredes 
; as caixas e o chao terao de ser tiles de dois por dois 
; de um unico caracter. (Para facilitar a implementacao de 
; desenhar o mapa). Essas tiles necessasriamente precisao 
; que o char para desenhar elas seja o mesmo para representa-las 
; como uma tile e para desenhalas.
;   As tiles que nao sao dois por dois de um unico char, e que 
; podem possuir mais de um desenho serao representadas apenas 
; por um numero definido que nao necessasriamente e o mesmo char 
; inicial para desenha-las. Ex: A tile do player eh diferente do 
; desenho do player se vc considerar que o player pode ter diferentes
; desenhos para posicoes em que ele esta olhando.
;
;   As tiles que representam cada coisa serao definidas e explicitadas
; abaixo para referencia:
;

@include util.asm
@include mapa.asm

;   Desenha o mapa da linha 5 ate a linha 30, 
; desenhando em cima do que estava la previamente.
; Ele desenha somente as tile 2 x 2 de um unico caracter 
; que sao os basicos do mapa.
;
;
; @param {endereco} r5 - Endereco do mapa que voce deseja desenhar.
;
draw_map_full:
    push r0
    push r1 
    push r2
    push r3
    push r4
    push r5
    ;push r6
    push r7

    ; primeiro char da quinta linha da tela
    loadn r2, #160
    loadn r3, #2    ; step horizontal
    loadn r4, #20   ; fim do loop da coluna
    loadn r5, #tile_map
    loadn r6, #0    ; variavel do lop
    loadn r7, #12   ; limite do loop de linhas

    push r6
    loadn r6, #0
    colum_draw_map_loop:
        cmp r6, r4
        jeq row_draw_loop

        loadi r0, r5
        mov r1, r2
        call two_by_two_draw

        add r2, r2, r3 ; proxima posicao na tela 
        inc r5 ; indo para a proxima tile
        inc r6 ; avancando o loop das colunas
        jmp colum_draw_map_loop

    row_draw_loop:
        ; checando se acabou de escrever todas as linhas
        pop r6
        cmp r6, r7 
        jeq draw_map_full_end
        ; nao acabou todas linhas entao vao para a proxima
        inc r6
        push r6 
        loadn r6, #0
        loadn r0, #40  ; step de duas linhas 
        add r2, r2, r0 ; pulando duas linahs
        jmp colum_draw_map_loop

    draw_map_full_end:
        pop r7
        ;pop r6
        pop r5
        pop r4 
        pop r3 
        pop r2 
        pop r1 
        pop r0
        rts

;    A funcao set tile muda uma tile 
; na posicao do mapa para a tile passada
; como argumento.
;
; @param {const char} r0 - Tile para ser setada na posicao,
; o valor de r0 nao eh alterado.
; @param {int} r1 - Cordenada x da posicao do 
; tile map que deseja mudar.
; @param {int} r2 - Coordenada y da poscicao do 
; tile map que deseja mudar.
;
; @return {int} r1 - Posicao na tela para que o 
; a tile seja desenhada na tela.
;
; Obs: A funcao eh feita de forma que logo apos executa-la 
; e possivel desenhar na tela a tile.
;
; Exemplos:
; // Setando uma tile de um unico char e desenhando ela logo apos.
;   loadn r0, #'A'
;   loadn r1, #3
;   loadn r2, #4
;   call set_tile 
;   call two_by_two_draw
;
;  ------
; // Setando uma tile que nao eh represeentado por um unic char 
; // e depois desenhando
;   loadn r0, #'G'
;   loadn r1, #3
;   loadn r2, #4
;   call set_tile
;   loadn r0, #32
;   call two_by_two_sequence_draw
;
set_tile:
    push r3
    push r4

    ; Escrevendo a tile no mapa
    loadn r3, #20 ; step de uma linha 
    mul r4, r2, r3 ; pulando as linhas
    add r4, r1, r4 ; pulando as colunas
    loadn r3, #tile_map
    add r3, r3, r4
    storei r3, r0

    loadn r3, #80 ; step de duas linhas na tela 
    loadn r4, #2  ; step de uma coluna na tela
    mul r2, r2, r3 ; pulando as linhas 
    mul r1, r1, r4 ; pulando as colunas
    add r1, r1, r2
    loadn r2, #160 ; pulando as linhas que nao 
    ; sao do mapa 
    add r1, r1, r2

    pop r4
    pop r3 
    rts

;   Pega a tile na coordenada passada.
;
; @param {const int} r1 - Coordenada x da tile que deseja pegar 
; @param {const int} r2 - Coordenada y da tile que deseja pegar 
; @return {char} r0 - Tile na posicao dada por (r1, r2)
;
get_tile:
    push r3 
    
    ; transformando para um endereco valido
    loadn r3, #20
    mul r0, r2, r3
    add r0, r0, r1 

    ; pegando o valor no tile map 
    loadn r3, #tile_map
    add r3, r3, r0 
    loadi r0, r3

    pop r3
    rts

