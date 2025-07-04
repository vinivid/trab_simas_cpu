
; As variaveis que representam a bomba 
; tem a seguinte strutura:
;
; colocada_ou_nao {bool} : #0
; tempo_des_de_ter_sido_colocada {int} : #1
; pos_x {int} : #2
; pos_y {int} : #3
; tamanho_do_fogo : #4
; esta_no_estado_de_fogo {bool} : #5
; quantidade_de_tempo_da_explosao {int} : #6
; quantidade_de_tiles_de_explosao {int} : #7
; tiles_de_explosao {tile_explosao[21]} : #8
;
;  Assim tendo um tamanho de 71 bytes
;
;   Em que tile de explosao tem a seguinte estrutura:
; tile_previa {char} : #0
; pos_x {int} : #1
; pos_y {int} : #2
;  
;   Tendo uma tamanho de 3 bytes
;

player_um_bomba : var #71
    static player_um_bomba + #0, #0
    static player_um_bomba + #4, #3
    static player_um_bomba + #5, #0

player_dois_bomba : var #71
    static player_dois_bomba + #0, #0
    static player_dois_bomba + #4, #3
    static player_dois_bomba + #5, #0

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

;   Apaga as labaredas geradas por uma explosao da bomba.
;
; @param {endereco} r0 - Bomba que originou as labaredas que 
; devem ser apagadas.
;
apagar_labaredas:
    push r1
    push r2
    push r3
    push r4
    push r5
    push r7

    ; salvando o endereco numa registradora melhor
    mov r7, r0

    ; pulando para se esta em labaredas
    loadn r1, #5
    add r7, r7, r1
    ; setando para nao estar mais explodindo
    loadn r2, #0
    storei r7, r2

    ; pegando quantidade de tiles
    inc r7
    inc r7
    loadi r3, r7
    inc r7

    ; variavel que conta se ja removeu as tiles do 
    loadn r4, #0

    remover_tiles:
        cmp r3, r4
        jeq remover_tiles_fim

        ; posicao x y da tile da labareda 
        inc r7
        loadi r1, r7
        inc r7
        loadi r2, r7
        inc r7

        ; se tiver um power up seta a tile quebrada 
        ; para uma do power up e desenha o power up
        call checar_se_tem_power_up
        loadn r5, #1
        cmp r0, r5
        jeq tem_powerup_nessa_posicao
            loadn r0, #0
            call set_tile
            call two_by_two_draw
            jmp final_do_if_do_powerup

        tem_powerup_nessa_posicao:
            loadn r0, #'P'
            call set_tile
            loadn r0, #'W'
            call two_by_two_sequence_draw

        final_do_if_do_powerup:

        inc r4
        jmp remover_tiles
    remover_tiles_fim:

    pop r7
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1 
    rts


; essa variavel sera o tamnho do fogo
tamanho_do_fogo : var #1

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

    ; setando colocado para zero
    loadn r1, #0
    storei r0, r1

    ; pulando para a pos_x 
    loadn r3, #2
    add r3, r0, r3 
    ; carregando os valores de posx e posy
    loadi r1, r3
    inc r3
    loadi r2, r3

    ; colocando o offset da bomba no tamanho do fogo
    ; e guardando o valor
    loadn r4, #4
    add r0, r0, r4
    loadi r4, r0

    ; guardando o tamanho do fogo
    store tamanho_do_fogo, r4

    ; agora r3 esta gurdando o endereco da bomba
    ; colocando o estado de fogo como true
    inc r3
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
    loadn r0, #0
    storei r3, r0 
    inc r3
    storei r3, r1 
    inc r3 
    storei r3, r2
    inc r3
    loadn r0, #'*'
    call set_tile
    ; colocando o centro da bomba
    loadn r0, #'K'
    push r2
    loadn r2, #2816
    call two_by_two_sequence_draw_colored
    pop r2

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
        load r5, tamanho_do_fogo
        cmp r4, r5
        jeq labareda_para_cima_fim

        ; salvando na bomba
        ; r0 eh a tile q tinha sido getada
        storei r3, r0
        inc r3
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
        ; desenhando a tile
        loadn r0, #79
        push r2
        loadn r2, #2816
        call two_by_two_sequence_draw_colored
        pop r2
    
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
        load r5, tamanho_do_fogo
        cmp r4, r5
        jeq labareda_para_baixo_fim

        ; salvando na bomba
        ; r0 eh a tile q tinha sido getada
        storei r3, r0
        inc r3
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
        loadn r0, #79
        push r2
        loadn r2, #2816
        call two_by_two_sequence_draw_colored
        pop r2

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
        load r5, tamanho_do_fogo
        cmp r4, r5
        jeq labareda_para_esquerda_fim

        ; salvando na bomba
        ; r0 eh a tile q tinha sido getada
        storei r3, r0
        inc r3
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
        loadn r0, #83
        push r2
        loadn r2, #2816
        call two_by_two_sequence_draw_colored
        pop r2

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
        load r5, tamanho_do_fogo
        cmp r4, r5
        jeq labareda_para_direita_fim

        ; salvando na bomba
        ; r0 eh a tile q tinha sido getada
        storei r3, r0
        inc r3
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
        loadn r0, #83
        push r2
        loadn r2, #2816
        call two_by_two_sequence_draw_colored
        pop r2

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
    loadn r4, #3
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
    push r7
    mov r7, r0

    ; verificando se tem um bomba colocada.
    loadi r1, r0
    loadn r2, #0
    cmp r1, r2 
    jeq update_fogo

    inc r0 
    loadi r1, r0 
    inc r1 ; aumentando o tempo em que a bomba foi colocada
    storei r0, r1

    ; Se a bomba chegou no tempo limite explode 
    ; ela.
    loadn r2, #23
    cmp r1, r2
    jne fim_do_update_bomba
        ; retornando r0 ao endereco original
        dec r0 
        call gerar_explosao
        jmp fim_do_update_bomba

    update_fogo:
        ; dar update no fogo se estiver no 
        ; estado de fogo
        loadn r2, #5
        add r0, r0, r2
        loadi r2, r0 ; estado da bomba esta em r2
        loadn r1, #0
        cmp r2, r1
        jeq fim_do_update_bomba

        ; esta com explosao
        inc r0 
        loadi r1, r0 ; quantidade de tempo da explosao
        inc r1
        storei r0, r1 ; salvando quantidade de tempo da explosao

        loadn r2, #7 ; valor do fim da bomba
        cmp r1, r2
        jne fim_do_update_bomba
            mov r0, r7
            call apagar_labaredas
            jmp fim_do_update_bomba

    fim_do_update_bomba:
        pop r7
        pop r2
        pop r1 
        rts

;   Essa funcao adiciona um power up na 
; bomba, acrescentando em um o limite que 
; ela pode chegar.
;
; @param {const int} r1 - Coordenada x na qual o power up foi 
; encontrado.
; @param {const int} r2 - Coordenada y na qual o power up foi 
; encontrado.
; @param {const endereco} r5 - Endereco da bomba do 
; player a ser modificada.
adcionar_powerup_na_bomba:
    push r0
    push r3

    ; colocando o endereco da bomba para r1 
    ; para que ela n seja modificada
    mov r3, r5

    ; pulando para o tamanho da bomba
    loadn r0, #4
    add r3, r3, r0
    loadi r0, r3 ; pegando o tamanho da bomba atualizando
    inc r0
    storei r3, r0 ; salvando na posicao da memoria

    ; transformando para um endereco valido
    loadn r3, #20
    mul r0, r2, r3
    add r0, r0, r1 

    ; indo para o endereco no power up map 
    loadn r3, #tile_map_pu
    add r3, r3, r0
    loadn r0, #0
    storei r3, r0 ; setando a posicao para 0

    pop r3
    pop r0
    rts

;  Faz o update das bombas dos players.
;
update_bombas:
    push r0

    loadn r0, #player_um_bomba
    call update_bomba
    loadn r0, #player_dois_bomba
    call update_bomba

    pop r0
    rts
