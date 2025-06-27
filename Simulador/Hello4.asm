jmp main

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

;   Desenha na posicao da tela o char repetidias
; vezes em um padrao 2 x 2.
;
; Parametros:
;
; @param {const char} r0 - Eh o char que deseja 
; desenhar na posicao da tela. Esse valor nao eh
; alterado.  
;
; @param {int} r1 - Eh a posicao na tela em que 
; deseja desenhar o sprite. Tendo em mente que 
; o sprite tera o seu canto superior esquerdo
; nessa posicao.
;
;  Ex: r0 = 'A' 
;      r1 = #0
;
; Desenha:
;
;   AA 
;   AA 
;
two_by_two_draw:
    ; Salvando as registradoras
    ; usadas nessa funcao que nao sao argumento
	push r4
	
	loadn r4, #39 ; Sera o step de uma linha da tela
	
	outchar r0, r1 ; primeira posicao 
	
	; desenhando na direita da primeira pos
	inc r1
	outchar r0, r1
  
    ; desenhando na posicao abaixo da primeira pos
	add r1, r1, r4 ; pulando a linha da tela
	outchar r0, r1
  
    ; desenha na diagonal para baixo e direita 
    ; da primeira
	inc r1
	outchar r0, r1

	pop r4
	rts

;   Desenha na posicao da tela a sequencia
; de quatro chars que representam um sprite
; 2x2.
;
; Parametros:
;
; @param {char} r0 - Eh o primeiro char da 
; sequencia de caracteres que deseja desenhar
; na tela.
; @param {int} r1 - Eh a posicao na tela em que 
; deseja desenhar o sprite. Tendo em mente que 
; o sprite tera o seu canto superior esquerdo
; nessa posicao.
;
;  Ex: r0 = 'A' 
;      r1 = #0
;
; Desenha:
;
;   AB 
;   CD 
;
two_by_two_sequence_draw:
    ; Salvando as registradoras
    ; usadas nessa funcao que nao sao argumento
	push r3
	push r4
	
	loadn r3, #1  ; Sera o step para direita
	loadn r4, #39 ; Sera o step de uma linha da tela
	
	outchar r0, r1 ; primeira posicao 
	
	; desenhando na direita da primeira
	add r0, r0, r3 
	add r1, r1, r3
	outchar r0, r1
  
    ; desenhando na posicao abaixo da primeira
	add r0, r0, r3
	add r1, r1, r4 ; pulando a linha da tela
	outchar r0, r1
  
    ; desenha na diagonal para baixo e direita 
    ; da primeira
	add r0, r0, r3
	add r1, r1, r3
	outchar r0, r1

	pop r4
	pop r3
	rts

;   Faz um delay da quantidade de tempo dado por r0 * r1.
;
; @param {int} r0 - Tempo para delay
; @param {int} r1 - Multiplicado de vezes para o delay
delay_um_tempo:
	push r2 
	push r3

	loadn r2, #0
	delay_quatidade:
		cmp r2, r1 
		jeq delay_end
		inc r2
		loadn r3, #0
		delay_loop:
			cmp r0, r3
			jne delay_quatidade

			inc r3
			jmp delay_loop

	delay_end:
		pop r3 
		pop r2
		rts;   A tile map representa as tiles do mapa
;em uma grid de 20 x 13, para ser utilizada com sprites
;2 X 2.
tile_map : var #260
	static tile_map + #0, #'A'
	static tile_map + #1, #'A'
	static tile_map + #2, #'A'
	static tile_map + #3, #'A'
	static tile_map + #4, #'A'
	static tile_map + #5, #'A'
	static tile_map + #6, #'A'
	static tile_map + #7, #'A'
	static tile_map + #8, #'A'
	static tile_map + #9, #'A'
	static tile_map + #10, #'A'
	static tile_map + #11, #'A'
	static tile_map + #12, #'A'
	static tile_map + #13, #'A'
	static tile_map + #14, #'A'
	static tile_map + #15, #'A'
	static tile_map + #16, #'A'
	static tile_map + #17, #'A'
	static tile_map + #18, #'A'
	static tile_map + #19, #'A'
	static tile_map + #20, #'A'
	static tile_map + #21, #0
	static tile_map + #22, #0
	static tile_map + #23, #0
	static tile_map + #24, #'B'
	static tile_map + #25, #'B'
	static tile_map + #26, #'B'
	static tile_map + #27, #0
	static tile_map + #28, #0
	static tile_map + #29, #0
	static tile_map + #30, #0
	static tile_map + #31, #'B'
	static tile_map + #32, #0
	static tile_map + #33, #0
	static tile_map + #34, #0
	static tile_map + #35, #'B'
	static tile_map + #36, #0
	static tile_map + #37, #0
	static tile_map + #38, #0
	static tile_map + #39, #'A'
	static tile_map + #40, #'A'
	static tile_map + #41, #0
	static tile_map + #42, #'A'
	static tile_map + #43, #0
	static tile_map + #44, #'B'
	static tile_map + #45, #'B'
	static tile_map + #46, #0
	static tile_map + #47, #'B'
	static tile_map + #48, #0
	static tile_map + #49, #0
	static tile_map + #50, #0
	static tile_map + #51, #'B'
	static tile_map + #52, #0
	static tile_map + #53, #0
	static tile_map + #54, #'B'
	static tile_map + #55, #0
	static tile_map + #56, #'B'
	static tile_map + #57, #0
	static tile_map + #58, #0
	static tile_map + #59, #'A'
	static tile_map + #60, #'A'
	static tile_map + #61, #0
	static tile_map + #62, #0
	static tile_map + #63, #0
	static tile_map + #64, #0
	static tile_map + #65, #'A'
	static tile_map + #66, #0
	static tile_map + #67, #0
	static tile_map + #68, #'B'
	static tile_map + #69, #0
	static tile_map + #70, #0
	static tile_map + #71, #'B'
	static tile_map + #72, #0
	static tile_map + #73, #'B'
	static tile_map + #74, #'A'
	static tile_map + #75, #0
	static tile_map + #76, #0
	static tile_map + #77, #'B'
	static tile_map + #78, #0
	static tile_map + #79, #'A'
	static tile_map + #80, #'A'
	static tile_map + #81, #'B'
	static tile_map + #82, #'B'
	static tile_map + #83, #'B'
	static tile_map + #84, #'B'
	static tile_map + #85, #'A'
	static tile_map + #86, #0
	static tile_map + #87, #0
	static tile_map + #88, #0
	static tile_map + #89, #'B'
	static tile_map + #90, #0
	static tile_map + #91, #'B'
	static tile_map + #92, #'B'
	static tile_map + #93, #0
	static tile_map + #94, #'A'
	static tile_map + #95, #0
	static tile_map + #96, #0
	static tile_map + #97, #0
	static tile_map + #98, #'B'
	static tile_map + #99, #'A'
	static tile_map + #100, #'A'
	static tile_map + #101, #'B'
	static tile_map + #102, #'B'
	static tile_map + #103, #'B'
	static tile_map + #104, #'B'
	static tile_map + #105, #'A'
	static tile_map + #106, #0
	static tile_map + #107, #'A'
	static tile_map + #108, #0
	static tile_map + #109, #0
	static tile_map + #110, #'B'
	static tile_map + #111, #'B'
	static tile_map + #112, #'A'
	static tile_map + #113, #0
	static tile_map + #114, #'A'
	static tile_map + #115, #0
	static tile_map + #116, #0
	static tile_map + #117, #'B'
	static tile_map + #118, #0
	static tile_map + #119, #'A'
	static tile_map + #120, #'A'
	static tile_map + #121, #0
	static tile_map + #122, #0
	static tile_map + #123, #0
	static tile_map + #124, #0
	static tile_map + #125, #'A'
	static tile_map + #126, #0
	static tile_map + #127, #'A'
	static tile_map + #128, #0
	static tile_map + #129, #0
	static tile_map + #130, #0
	static tile_map + #131, #'B'
	static tile_map + #132, #'A'
	static tile_map + #133, #0
	static tile_map + #134, #'A'
	static tile_map + #135, #0
	static tile_map + #136, #'B'
	static tile_map + #137, #0
	static tile_map + #138, #0
	static tile_map + #139, #'A'
	static tile_map + #140, #'A'
	static tile_map + #141, #'B'
	static tile_map + #142, #0
	static tile_map + #143, #0
	static tile_map + #144, #0
	static tile_map + #145, #'A'
	static tile_map + #146, #0
	static tile_map + #147, #'A'
	static tile_map + #148, #0
	static tile_map + #149, #0
	static tile_map + #150, #'B'
	static tile_map + #151, #'B'
	static tile_map + #152, #'A'
	static tile_map + #153, #0
	static tile_map + #154, #'A'
	static tile_map + #155, #'B'
	static tile_map + #156, #'B'
	static tile_map + #157, #'B'
	static tile_map + #158, #'B'
	static tile_map + #159, #'A'
	static tile_map + #160, #'A'
	static tile_map + #161, #0
	static tile_map + #162, #'B'
	static tile_map + #163, #0
	static tile_map + #164, #0
	static tile_map + #165, #'A'
	static tile_map + #166, #0
	static tile_map + #167, #0
	static tile_map + #168, #0
	static tile_map + #169, #'B'
	static tile_map + #170, #0
	static tile_map + #171, #'B'
	static tile_map + #172, #0
	static tile_map + #173, #0
	static tile_map + #174, #'A'
	static tile_map + #175, #'B'
	static tile_map + #176, #'B'
	static tile_map + #177, #'B'
	static tile_map + #178, #'B'
	static tile_map + #179, #'A'
	static tile_map + #180, #'A'
	static tile_map + #181, #0
	static tile_map + #182, #0
	static tile_map + #183, #'B'
	static tile_map + #184, #0
	static tile_map + #185, #'A'
	static tile_map + #186, #0
	static tile_map + #187, #0
	static tile_map + #188, #'B'
	static tile_map + #189, #0
	static tile_map + #190, #0
	static tile_map + #191, #'B'
	static tile_map + #192, #0
	static tile_map + #193, #0
	static tile_map + #194, #'A'
	static tile_map + #195, #0
	static tile_map + #196, #0
	static tile_map + #197, #0
	static tile_map + #198, #0
	static tile_map + #199, #'A'
	static tile_map + #200, #'A'
	static tile_map + #201, #0
	static tile_map + #202, #0
	static tile_map + #203, #0
	static tile_map + #204, #'B'
	static tile_map + #205, #0
	static tile_map + #206, #0
	static tile_map + #207, #'B'
	static tile_map + #208, #0
	static tile_map + #209, #0
	static tile_map + #210, #0
	static tile_map + #211, #'B'
	static tile_map + #212, #'B'
	static tile_map + #213, #'B'
	static tile_map + #214, #0
	static tile_map + #215, #0
	static tile_map + #216, #0
	static tile_map + #217, #'A'
	static tile_map + #218, #0
	static tile_map + #219, #'A'
	static tile_map + #220, #'A'
	static tile_map + #221, #0
	static tile_map + #222, #0
	static tile_map + #223, #0
	static tile_map + #224, #0
	static tile_map + #225, #'B'
	static tile_map + #226, #'B'
	static tile_map + #227, #0
	static tile_map + #228, #0
	static tile_map + #229, #0
	static tile_map + #230, #0
	static tile_map + #231, #'B'
	static tile_map + #232, #'B'
	static tile_map + #233, #'B'
	static tile_map + #234, #0
	static tile_map + #235, #0
	static tile_map + #236, #0
	static tile_map + #237, #0
	static tile_map + #238, #0
	static tile_map + #239, #'A'
	static tile_map + #240, #'A'
	static tile_map + #241, #'A'
	static tile_map + #242, #'A'
	static tile_map + #243, #'A'
	static tile_map + #244, #'A'
	static tile_map + #245, #'A'
	static tile_map + #246, #'A'
	static tile_map + #247, #'A'
	static tile_map + #248, #'A'
	static tile_map + #249, #'A'
	static tile_map + #250, #'A'
	static tile_map + #251, #'A'
	static tile_map + #252, #'A'
	static tile_map + #253, #'A'
	static tile_map + #254, #'A'
	static tile_map + #255, #'A'
	static tile_map + #256, #'A'
	static tile_map + #257, #'A'
	static tile_map + #258, #'A'
	static tile_map + #259, #'A'

; Posicao do player e 1 player 2, em que o offset 0 eh o x e o offset 1 eh o y
player_one_ini_pos : var #2
	static player_one_ini_pos + #0, #2
	static player_one_ini_pos + #1, #2
player_two_ini_pos : var #2
	static player_two_ini_pos + #0, #17
	static player_two_ini_pos + #1, #10

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
; tile_previa {char} : #0
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
    push r7

    ; salvando o endereco numa registradora melhor
    mov r7, r0

    ; pulando para se esta em labaredas
    loadn r1, #4
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

        ; valor da tile na posicao x y 
        loadi r0, r7
        inc r7
        loadi r1, r7
        inc r7
        loadi r2, r7
        inc r7

        ; Se for para adicionar power ups, 
        ; em vez de quebrar os locais e transformar
        ; em livre, teria de checar se eh uma caixa 
        ; com o r0 e spawnar o powerup caso a caixa 
        ; tenha

        loadn r0, #0
        call set_tile
        call two_by_two_draw

        inc r4
        jmp remover_tiles
    remover_tiles_fim:

    pop r7 
    pop r4
    pop r3
    pop r2
    pop r1 
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
    loadn r0, #0
    storei r3, r0 
    inc r3
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
    inc r1 
    storei r0, r1

    ; Se a bomba chegou no tempo limite explode 
    ; ela.
    loadn r2, #10
    cmp r1, r2
    jne fim_do_update_bomba
        ; retornando r0 ao endereco original
        dec r0 
        call gerar_explosao
        jmp fim_do_update_bomba

    update_fogo:
        ; dar update no fogo se estiver no 
        ; estado de fogo
        loadn r2, #4
        add r0, r0, r2
        loadi r2, r0
        loadn r1, #0
        cmp r2, r1
        jeq fim_do_update_bomba

        ; esta com explosao
        inc r0 
        loadi r1, r0
        inc r1
        storei r0, r1

        loadn r2, #4
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

    loadn r1, #'n'
    cmp r0, r1 
    jne atuar_no_player_dois_fim
        loadn r0, #player_dois_bomba
        load r1, pd_posx
        load r2, pd_posy
        call colocar_bomba
        
    atuar_no_player_dois_fim:
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
main:
    call draw_map_full
    call ini_player_um
    call ini_player_dois
    
    game_loop:
        call update_players
        call update_bombas
        jmp game_loop