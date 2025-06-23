
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
;  Assim tendo um tamanho de 49 bytes
;
;   Em que tile de explosao tem a seguinte estrutura:
; pos_x {int} : #1
; pos_y {int} : #2
;  
;   Tendo uma tamanho de 2 bytes
;

player_um_bomba : var #49
    static player_um_bomba + #0, #0
    static player_um_bomba + #4, #0

player_dois_bomba : var #49
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
;  Obs: A funcao nao checa pelos limites do mapa 
; quando gerando as labredas, se na tiver a parede 
; o jogo ira crashar.
;
; @param {endereco} r0 - Bomba para gerar a explosao.
;
gerar_explosao:
    push r1
    push r2 
    push r3
    push r4 
    push r5
    push r6
    push r7

    ; pulando para a pos_x 
    loadn r3, #2
    add r3, r0, r3
    ; carregando os valores de posx e posy
    loadi r1, r3
    inc r3
    loadi r2, r3

    ; agora r3 esta gurdando o endereco da bomba
    ; colocando o estado de fogo como true
    inc r3
    loadn r0, #1
    storei r3, r0 

    ; setando o contador do fogo para zero
    inc r3
    loadn r0, #0
    storei r3, r0

    ; pulando para as tiles de explosao, 
    ; pois os seus valores serao escritos
    ; enquanto gerando as labaredas.
    inc r3 
    inc r3

    ; salvando a posicao original
    mov r6, r1
    mov r7, r2

    ; setando a tile da bomba para labereda
    storei r3, r1 
    inc r3 
    storei r3, r2
    inc r3
    loadn r0, #'*'
    call set_tile
    call two_by_two_draw

    ; Loops de criar as tiles do fogo
    ; eles vao pegando as posicaoes que estao livres 
    ; e colocando como fogo.
    ;
    ; Enquanto nao for uma parede ou o tamnho da labereda
    ; nao tiver acabado ele continua fazendo o loop.

    loadn r5, #1 ; variavel para contar a quantidade de labaredas 
    ; geradas comeca com 1 pois ja esta contando com a do meio

    ; pegar a posicao do tile map para cima
    mov r1, r6
    mov r2, r7
    dec r2

    ; salvar r6 e r7
    push r6
    push r7

    loadn r4, #0 ; variavel para contar a quantidade de labaredas 
    ; geradas na direcao

    labereda_para_cima_loop:
        push r5

        ; se a tile da frente for uma parede 
        ; para de criar labaredas
        call get_tile
        loadn r5, #'A'
        cmp r0, r5
        jeq labareda_para_cima_fim

        ; ou chegou no limite das labaredas dai para tmb
        loadn r5, #2
        cmp r4, r5
        jeq labareda_para_cima_fim

        ; salvando na bomba
        storei r3, r1
        inc r3 
        storei r3, r2
        inc r3

        ; eh necessario salvar os valores originais
        ; para ir para a procima posica
        mov r6, r1
        mov r7, r2

        ; setando para uma tile de labareda
        loadn r0, #'*'
        call set_tile
        call two_by_two_draw

        mov r1, r6
        mov r2, r7

        ; avancado o loop 
        dec r2 ; tile para cima 
        inc r4 ; quantidade de labaredas para cima 
        pop r5 
        inc r5 ; quantidade de tiles de labareda
        jmp labereda_para_cima_loop
    labareda_para_cima_fim:    

    ; fazendo o loop novamente, agora para baixo
    pop r5
    pop r7
    pop r6

    mov r1, r6
    mov r2, r7
    inc r2

    push r6
    push r7

    loadn r4, #0

    labereda_para_baixo_loop:
        push r5

        ; se a tile da frente for uma parede 
        ; para de criar labaredas
        call get_tile
        loadn r5, #'A'
        cmp r0, r5
        jeq labareda_para_baixo_fim

        ; ou chegou no limite das labaredas dai para tmb
        loadn r5, #2
        cmp r4, r5
        jeq labareda_para_baixo_fim

        ; salvando na bomba
        storei r3, r1
        inc r3 
        storei r3, r2
        inc r3

        ; eh necessario salvar os valores originais
        ; para ir para a procima posica
        mov r6, r1
        mov r7, r2

        ; setando para uma tile de labareda
        loadn r0, #'*'
        call set_tile
        call two_by_two_draw

        mov r1, r6
        mov r2, r7

        ; avancado o loop 
        inc r2 ; tile para baixo
        inc r4 ; quantidade de labaredas para cima 
        pop r5 
        inc r5 ; quantidade de tiles de labareda
        jmp labereda_para_baixo_loop
    labareda_para_baixo_fim:

    ; fazendo o loop novamente, agora para esqueda
    pop r5
    pop r7
    pop r6

    mov r1, r6
    mov r2, r7
    dec r1

    push r6
    push r7

    loadn r4, #0

    labereda_para_esquerda_loop:
        push r5

        ; se a tile da frente for uma parede 
        ; para de criar labaredas
        call get_tile
        loadn r5, #'A'
        cmp r0, r5
        jeq labareda_para_esquerda_fim

        ; ou chegou no limite das labaredas dai para tmb
        loadn r5, #2
        cmp r4, r5
        jeq labareda_para_esquerda_fim

        ; salvando na bomba
        storei r3, r1
        inc r3 
        storei r3, r2
        inc r3

        ; eh necessario salvar os valores originais
        ; para ir para a procima posica
        mov r6, r1
        mov r7, r2

        ; setando para uma tile de labareda
        loadn r0, #'*'
        call set_tile
        call two_by_two_draw

        mov r1, r6
        mov r2, r7

        ; avancado o loop 
        dec r1 ; tile para esquerda 
        inc r4 ; quantidade de labaredas para cima 
        pop r5 
        inc r5 ; quantidade de tiles de labareda
        jmp labereda_para_esquerda_loop
    labareda_para_esquerda_fim:

    ; fazendo o loop novamente, agora para direita
    pop r5
    pop r7
    pop r6

    mov r1, r6
    mov r2, r7
    inc r1

    push r6
    push r7

    loadn r4, #0

    labereda_para_direita_loop:
        push r5

        ; se a tile da frente for uma parede 
        ; para de criar labaredas
        call get_tile
        loadn r5, #'A'
        cmp r0, r5
        jeq labareda_para_direita_fim

        ; ou chegou no limite das labaredas dai para tmb
        loadn r5, #2
        cmp r4, r5
        jeq labareda_para_direita_fim

        ; salvando na bomba
        storei r3, r1
        inc r3 
        storei r3, r2
        inc r3

        ; eh necessario salvar os valores originais
        ; para ir para a procima posica
        mov r6, r1
        mov r7, r2

        ; setando para uma tile de labareda
        loadn r0, #'*'
        call set_tile
        call two_by_two_draw

        mov r1, r6
        mov r2, r7

        ; avancado o loop 
        inc r1 ; tile para direita 
        inc r4 ; quantidade de labaredas para cima 
        pop r5 
        inc r5 ; quantidade de tiles de labareda
        jmp labereda_para_direita_loop
    labareda_para_direita_fim:

    ; salvando o valor da quantidade de tiles de labaredas 
    ; que eh o r5

    pop r5
    loadn r4, #2
    ; pulando para o offset da quantidade de tiles 
    mul r1, r5, r4
    sub r3, r3, r1
    dec r3
    storei r3, r5

    ; removendo o lixo que esta na stack
    pop r7 
    pop r6

    pop r7
    pop r6
    pop r5
    pop r4
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
    loadn r2, #10
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
