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

; Tem o mesmo funcionamento do two by two draw, so que 
; ele desenha as tiles com a cor passada como argumento.
;
; Parametros:
;
; @param {const char} r0 - Eh o char que deseja 
; desenhar na posicao da tela. Esse valor nao eh
; alterado.  
; @param {int} r1 - Eh a posicao na tela em que 
; deseja desenhar o sprite. Tendo em mente que 
; o sprite tera o seu canto superior esquerdo
; nessa posicao.
; @param {int} r2 - Eh a cor na qual cada tile deve ser 
; desenhada.
;
two_by_two_draw_colored:
    ; Salvando as registradoras
    ; usadas nessa funcao que nao sao argumento
	push r3
	push r4
	
	mov r3, r0 ; salvando o valor original
	loadn r4, #39 ; Sera o step de uma linha da tela

	add r0, r0, r2
	outchar r0, r1 ; primeira posicao 
	
	; desenhando na direita da primeira pos
	inc r1
	; pegando o char original e adicionando a cor
	mov r0, r3 
	add r0, r0, r2
	outchar r0, r1 ; printando o char 
  
    ; desenhando na posicao abaixo da primeira pos
	add r1, r1, r4 ; pulando a linha da tela
	mov r0, r3 
	add r0, r0, r2
	outchar r0, r1 ; printando o char
  
    ; desenha na diagonal para baixo e direita 
    ; da primeira
	inc r1
	mov r0, r3 
	add r0, r0, r2
	outchar r0, r1 ; printando o char

	pop r4
	pop r3
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
	push r4
	
	loadn r4, #39 ; Sera o step de uma linha da tela
	
	outchar r0, r1 ; primeira posicao 
	
	; desenhando na direita da primeira
	inc r0 
	inc r1
	outchar r0, r1
  
    ; desenhando na posicao abaixo da primeira
	inc r0
	add r1, r1, r4 ; pulando a linha da tela
	outchar r0, r1
  
    ; desenha na diagonal para baixo e direita 
    ; da primeira
	inc r0
	inc r1
	outchar r0, r1

	pop r4
	rts

;   Igual o two by two sequence draw, com o aditivo de 
; colocar a cor para cada char.
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
; @param {int} r2 - Eh a cor na qual cada tile deve ser 
; desenhada.
;
two_by_two_sequence_draw_colored:
    ; Salvando as registradoras
    ; usadas nessa funcao que nao sao argumento
	push r3
	push r4
	
	loadn r3, #1  ; Sera o step para direita
	loadn r4, #39 ; Sera o step de uma linha da tela
	
	mov r3, r0; salvando char
	add r0, r0, r2 ; adicionando a cor
	outchar r0, r1 ; primeira posicao 
	mov r0, r3 ; pegando o valor dnv

	; desenhando na direita da primeira
	inc r0 
	inc r1
	mov r3, r0; salvando char
	add r0, r0, r2 ; adicionando a cor
	outchar r0, r1 ; primeira posicao 
	mov r0, r3 ; pegando o valor dnv
  
    ; desenhando na posicao abaixo da primeira
	inc r0
	add r1, r1, r4 ; pulando a linha da tela
	mov r3, r0; salvando char
	add r0, r0, r2 ; adicionando a cor
	outchar r0, r1 ; primeira posicao 
	mov r0, r3 ; pegando o valor dnv
  
    ; desenha na diagonal para baixo e direita 
    ; da primeira
	inc r0
	inc r1
	mov r3, r0; salvando char
	add r0, r0, r2 ; adicionando a cor
	outchar r0, r1 ; primeira posicao 
	mov r0, r3 ; pegando o valor dnv

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
		rts

;  Imprime a string na posicao passada como argumento.
;
; @param {endereco} r0 - Endereco da str que deseja imprimir.
; @param {int} r1 - Posicao da tela na qual deseja imprimir.
;
print_str:
	push r2
	push r3

	print_str_loop:
		loadi r2, r0
		loadn r3, #'\0' 
		cmp r3, r2
		jeq print_str_loop_end

		outchar r2, r1
		inc r1 ; proxima posicao na tela
		inc r0 ; proximo char 
		jmp print_str_loop

	print_str_loop_end:

	pop r3
	pop r2
	rts

;  Imprime a string na posicao passada como argumento em que 
; cada caracter vai ter a cor passada como argumento.
;
; @param {endereco} r0 - Endereco da str que deseja imprimir.
; @param {int} r1 - Posicao da tela na qual deseja imprimir.
; @param {cor} r2 - Cor para imprimir cada caracter.
;
print_str_colored:
	push r3
	push r4

	print_str_colored_loop:
		loadi r3, r0
		loadn r4, #'\0' 
		cmp r4, r3
		jeq print_str_loop_end

		add r3, r3, r2 ; adicionando a cor no caracter
		outchar r3, r1
		inc r1 ; proxima posicao na tela
		inc r0 ; proximo char 
		jmp print_str_colored_loop

	print_str_colored_loop_end:

	pop r4
	pop r3
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
	static tile_map + #26, #0
	static tile_map + #27, #0
	static tile_map + #28, #0
	static tile_map + #29, #0
	static tile_map + #30, #'A'
	static tile_map + #31, #0
	static tile_map + #32, #'B'
	static tile_map + #33, #0
	static tile_map + #34, #0
	static tile_map + #35, #'B'
	static tile_map + #36, #0
	static tile_map + #37, #0
	static tile_map + #38, #'B'
	static tile_map + #39, #'A'
	static tile_map + #40, #'A'
	static tile_map + #41, #0
	static tile_map + #42, #0
	static tile_map + #43, #0
	static tile_map + #44, #'B'
	static tile_map + #45, #'B'
	static tile_map + #46, #0
	static tile_map + #47, #0
	static tile_map + #48, #'A'
	static tile_map + #49, #0
	static tile_map + #50, #'B'
	static tile_map + #51, #0
	static tile_map + #52, #0
	static tile_map + #53, #'B'
	static tile_map + #54, #0
	static tile_map + #55, #'A'
	static tile_map + #56, #0
	static tile_map + #57, #'B'
	static tile_map + #58, #0
	static tile_map + #59, #'A'
	static tile_map + #60, #'A'
	static tile_map + #61, #0
	static tile_map + #62, #0
	static tile_map + #63, #0
	static tile_map + #64, #'A'
	static tile_map + #65, #'B'
	static tile_map + #66, #0
	static tile_map + #67, #0
	static tile_map + #68, #'B'
	static tile_map + #69, #0
	static tile_map + #70, #'A'
	static tile_map + #71, #0
	static tile_map + #72, #0
	static tile_map + #73, #0
	static tile_map + #74, #'B'
	static tile_map + #75, #'B'
	static tile_map + #76, #'B'
	static tile_map + #77, #0
	static tile_map + #78, #0
	static tile_map + #79, #'A'
	static tile_map + #80, #'A'
	static tile_map + #81, #0
	static tile_map + #82, #0
	static tile_map + #83, #'A'
	static tile_map + #84, #'A'
	static tile_map + #85, #'B'
	static tile_map + #86, #0
	static tile_map + #87, #'A'
	static tile_map + #88, #0
	static tile_map + #89, #0
	static tile_map + #90, #'B'
	static tile_map + #91, #0
	static tile_map + #92, #0
	static tile_map + #93, #'A'
	static tile_map + #94, #0
	static tile_map + #95, #'B'
	static tile_map + #96, #0
	static tile_map + #97, #'A'
	static tile_map + #98, #0
	static tile_map + #99, #'A'
	static tile_map + #100, #'A'
	static tile_map + #101, #'B'
	static tile_map + #102, #'B'
	static tile_map + #103, #'B'
	static tile_map + #104, #'B'
	static tile_map + #105, #'B'
	static tile_map + #106, #0
	static tile_map + #107, #0
	static tile_map + #108, #0
	static tile_map + #109, #0
	static tile_map + #110, #'A'
	static tile_map + #111, #0
	static tile_map + #112, #'B'
	static tile_map + #113, #0
	static tile_map + #114, #0
	static tile_map + #115, #0
	static tile_map + #116, #0
	static tile_map + #117, #0
	static tile_map + #118, #'B'
	static tile_map + #119, #'A'
	static tile_map + #120, #'A'
	static tile_map + #121, #'B'
	static tile_map + #122, #'B'
	static tile_map + #123, #'B'
	static tile_map + #124, #'B'
	static tile_map + #125, #'B'
	static tile_map + #126, #'B'
	static tile_map + #127, #'B'
	static tile_map + #128, #'B'
	static tile_map + #129, #'B'
	static tile_map + #130, #'A'
	static tile_map + #131, #0
	static tile_map + #132, #0
	static tile_map + #133, #'B'
	static tile_map + #134, #0
	static tile_map + #135, #0
	static tile_map + #136, #0
	static tile_map + #137, #'B'
	static tile_map + #138, #0
	static tile_map + #139, #'A'
	static tile_map + #140, #'A'
	static tile_map + #141, #0
	static tile_map + #142, #0
	static tile_map + #143, #0
	static tile_map + #144, #'B'
	static tile_map + #145, #0
	static tile_map + #146, #0
	static tile_map + #147, #0
	static tile_map + #148, #0
	static tile_map + #149, #0
	static tile_map + #150, #'A'
	static tile_map + #151, #'B'
	static tile_map + #152, #'B'
	static tile_map + #153, #'B'
	static tile_map + #154, #'B'
	static tile_map + #155, #'B'
	static tile_map + #156, #'B'
	static tile_map + #157, #'B'
	static tile_map + #158, #'B'
	static tile_map + #159, #'A'
	static tile_map + #160, #'A'
	static tile_map + #161, #'B'
	static tile_map + #162, #0
	static tile_map + #163, #0
	static tile_map + #164, #0
	static tile_map + #165, #'A'
	static tile_map + #166, #'B'
	static tile_map + #167, #0
	static tile_map + #168, #0
	static tile_map + #169, #0
	static tile_map + #170, #'B'
	static tile_map + #171, #0
	static tile_map + #172, #0
	static tile_map + #173, #0
	static tile_map + #174, #'B'
	static tile_map + #175, #'A'
	static tile_map + #176, #'A'
	static tile_map + #177, #0
	static tile_map + #178, #0
	static tile_map + #179, #'A'
	static tile_map + #180, #'A'
	static tile_map + #181, #0
	static tile_map + #182, #0
	static tile_map + #183, #'B'
	static tile_map + #184, #0
	static tile_map + #185, #0
	static tile_map + #186, #0
	static tile_map + #187, #'B'
	static tile_map + #188, #0
	static tile_map + #189, #0
	static tile_map + #190, #'A'
	static tile_map + #191, #0
	static tile_map + #192, #'B'
	static tile_map + #193, #0
	static tile_map + #194, #'B'
	static tile_map + #195, #'A'
	static tile_map + #196, #0
	static tile_map + #197, #0
	static tile_map + #198, #0
	static tile_map + #199, #'A'
	static tile_map + #200, #'A'
	static tile_map + #201, #0
	static tile_map + #202, #'A'
	static tile_map + #203, #0
	static tile_map + #204, #0
	static tile_map + #205, #0
	static tile_map + #206, #'B'
	static tile_map + #207, #0
	static tile_map + #208, #'A'
	static tile_map + #209, #0
	static tile_map + #210, #'B'
	static tile_map + #211, #0
	static tile_map + #212, #0
	static tile_map + #213, #0
	static tile_map + #214, #'B'
	static tile_map + #215, #'B'
	static tile_map + #216, #0
	static tile_map + #217, #0
	static tile_map + #218, #0
	static tile_map + #219, #'A'
	static tile_map + #220, #'A'
	static tile_map + #221, #0
	static tile_map + #222, #0
	static tile_map + #223, #'B'
	static tile_map + #224, #0
	static tile_map + #225, #'B'
	static tile_map + #226, #0
	static tile_map + #227, #0
	static tile_map + #228, #0
	static tile_map + #229, #0
	static tile_map + #230, #'A'
	static tile_map + #231, #0
	static tile_map + #232, #'B'
	static tile_map + #233, #0
	static tile_map + #234, #'B'
	static tile_map + #235, #'B'
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


tile_map_og : var #260
	static tile_map_og + #0, #'A'
	static tile_map_og + #1, #'A'
	static tile_map_og + #2, #'A'
	static tile_map_og + #3, #'A'
	static tile_map_og + #4, #'A'
	static tile_map_og + #5, #'A'
	static tile_map_og + #6, #'A'
	static tile_map_og + #7, #'A'
	static tile_map_og + #8, #'A'
	static tile_map_og + #9, #'A'
	static tile_map_og + #10, #'A'
	static tile_map_og + #11, #'A'
	static tile_map_og + #12, #'A'
	static tile_map_og + #13, #'A'
	static tile_map_og + #14, #'A'
	static tile_map_og + #15, #'A'
	static tile_map_og + #16, #'A'
	static tile_map_og + #17, #'A'
	static tile_map_og + #18, #'A'
	static tile_map_og + #19, #'A'
	static tile_map_og + #20, #'A'
	static tile_map_og + #21, #0
	static tile_map_og + #22, #0
	static tile_map_og + #23, #0
	static tile_map_og + #24, #'B'
	static tile_map_og + #25, #'B'
	static tile_map_og + #26, #0
	static tile_map_og + #27, #0
	static tile_map_og + #28, #0
	static tile_map_og + #29, #0
	static tile_map_og + #30, #'A'
	static tile_map_og + #31, #0
	static tile_map_og + #32, #'B'
	static tile_map_og + #33, #0
	static tile_map_og + #34, #0
	static tile_map_og + #35, #'B'
	static tile_map_og + #36, #0
	static tile_map_og + #37, #0
	static tile_map_og + #38, #'B'
	static tile_map_og + #39, #'A'
	static tile_map_og + #40, #'A'
	static tile_map_og + #41, #0
	static tile_map_og + #42, #0
	static tile_map_og + #43, #0
	static tile_map_og + #44, #'B'
	static tile_map_og + #45, #'B'
	static tile_map_og + #46, #0
	static tile_map_og + #47, #0
	static tile_map_og + #48, #'A'
	static tile_map_og + #49, #0
	static tile_map_og + #50, #'B'
	static tile_map_og + #51, #0
	static tile_map_og + #52, #0
	static tile_map_og + #53, #'B'
	static tile_map_og + #54, #0
	static tile_map_og + #55, #'A'
	static tile_map_og + #56, #0
	static tile_map_og + #57, #'B'
	static tile_map_og + #58, #0
	static tile_map_og + #59, #'A'
	static tile_map_og + #60, #'A'
	static tile_map_og + #61, #0
	static tile_map_og + #62, #0
	static tile_map_og + #63, #0
	static tile_map_og + #64, #'A'
	static tile_map_og + #65, #'B'
	static tile_map_og + #66, #0
	static tile_map_og + #67, #0
	static tile_map_og + #68, #'B'
	static tile_map_og + #69, #0
	static tile_map_og + #70, #'A'
	static tile_map_og + #71, #0
	static tile_map_og + #72, #0
	static tile_map_og + #73, #0
	static tile_map_og + #74, #'B'
	static tile_map_og + #75, #'B'
	static tile_map_og + #76, #'B'
	static tile_map_og + #77, #0
	static tile_map_og + #78, #0
	static tile_map_og + #79, #'A'
	static tile_map_og + #80, #'A'
	static tile_map_og + #81, #0
	static tile_map_og + #82, #0
	static tile_map_og + #83, #'A'
	static tile_map_og + #84, #'A'
	static tile_map_og + #85, #'B'
	static tile_map_og + #86, #0
	static tile_map_og + #87, #'A'
	static tile_map_og + #88, #0
	static tile_map_og + #89, #0
	static tile_map_og + #90, #'B'
	static tile_map_og + #91, #0
	static tile_map_og + #92, #0
	static tile_map_og + #93, #'A'
	static tile_map_og + #94, #0
	static tile_map_og + #95, #'B'
	static tile_map_og + #96, #0
	static tile_map_og + #97, #'A'
	static tile_map_og + #98, #0
	static tile_map_og + #99, #'A'
	static tile_map_og + #100, #'A'
	static tile_map_og + #101, #'B'
	static tile_map_og + #102, #'B'
	static tile_map_og + #103, #'B'
	static tile_map_og + #104, #'B'
	static tile_map_og + #105, #'B'
	static tile_map_og + #106, #0
	static tile_map_og + #107, #0
	static tile_map_og + #108, #0
	static tile_map_og + #109, #0
	static tile_map_og + #110, #'A'
	static tile_map_og + #111, #0
	static tile_map_og + #112, #'B'
	static tile_map_og + #113, #0
	static tile_map_og + #114, #0
	static tile_map_og + #115, #0
	static tile_map_og + #116, #0
	static tile_map_og + #117, #0
	static tile_map_og + #118, #'B'
	static tile_map_og + #119, #'A'
	static tile_map_og + #120, #'A'
	static tile_map_og + #121, #'B'
	static tile_map_og + #122, #'B'
	static tile_map_og + #123, #'B'
	static tile_map_og + #124, #'B'
	static tile_map_og + #125, #'B'
	static tile_map_og + #126, #'B'
	static tile_map_og + #127, #'B'
	static tile_map_og + #128, #'B'
	static tile_map_og + #129, #'B'
	static tile_map_og + #130, #'A'
	static tile_map_og + #131, #0
	static tile_map_og + #132, #0
	static tile_map_og + #133, #'B'
	static tile_map_og + #134, #0
	static tile_map_og + #135, #0
	static tile_map_og + #136, #0
	static tile_map_og + #137, #'B'
	static tile_map_og + #138, #0
	static tile_map_og + #139, #'A'
	static tile_map_og + #140, #'A'
	static tile_map_og + #141, #0
	static tile_map_og + #142, #0
	static tile_map_og + #143, #0
	static tile_map_og + #144, #'B'
	static tile_map_og + #145, #0
	static tile_map_og + #146, #0
	static tile_map_og + #147, #0
	static tile_map_og + #148, #0
	static tile_map_og + #149, #0
	static tile_map_og + #150, #'A'
	static tile_map_og + #151, #'B'
	static tile_map_og + #152, #'B'
	static tile_map_og + #153, #'B'
	static tile_map_og + #154, #'B'
	static tile_map_og + #155, #'B'
	static tile_map_og + #156, #'B'
	static tile_map_og + #157, #'B'
	static tile_map_og + #158, #'B'
	static tile_map_og + #159, #'A'
	static tile_map_og + #160, #'A'
	static tile_map_og + #161, #'B'
	static tile_map_og + #162, #0
	static tile_map_og + #163, #0
	static tile_map_og + #164, #0
	static tile_map_og + #165, #'A'
	static tile_map_og + #166, #'B'
	static tile_map_og + #167, #0
	static tile_map_og + #168, #0
	static tile_map_og + #169, #0
	static tile_map_og + #170, #'B'
	static tile_map_og + #171, #0
	static tile_map_og + #172, #0
	static tile_map_og + #173, #0
	static tile_map_og + #174, #'B'
	static tile_map_og + #175, #'A'
	static tile_map_og + #176, #'A'
	static tile_map_og + #177, #0
	static tile_map_og + #178, #0
	static tile_map_og + #179, #'A'
	static tile_map_og + #180, #'A'
	static tile_map_og + #181, #0
	static tile_map_og + #182, #0
	static tile_map_og + #183, #'B'
	static tile_map_og + #184, #0
	static tile_map_og + #185, #0
	static tile_map_og + #186, #0
	static tile_map_og + #187, #'B'
	static tile_map_og + #188, #0
	static tile_map_og + #189, #0
	static tile_map_og + #190, #'A'
	static tile_map_og + #191, #0
	static tile_map_og + #192, #'B'
	static tile_map_og + #193, #0
	static tile_map_og + #194, #'B'
	static tile_map_og + #195, #'A'
	static tile_map_og + #196, #0
	static tile_map_og + #197, #0
	static tile_map_og + #198, #0
	static tile_map_og + #199, #'A'
	static tile_map_og + #200, #'A'
	static tile_map_og + #201, #0
	static tile_map_og + #202, #'A'
	static tile_map_og + #203, #0
	static tile_map_og + #204, #0
	static tile_map_og + #205, #0
	static tile_map_og + #206, #'B'
	static tile_map_og + #207, #0
	static tile_map_og + #208, #'A'
	static tile_map_og + #209, #0
	static tile_map_og + #210, #'B'
	static tile_map_og + #211, #0
	static tile_map_og + #212, #0
	static tile_map_og + #213, #0
	static tile_map_og + #214, #'B'
	static tile_map_og + #215, #'B'
	static tile_map_og + #216, #0
	static tile_map_og + #217, #0
	static tile_map_og + #218, #0
	static tile_map_og + #219, #'A'
	static tile_map_og + #220, #'A'
	static tile_map_og + #221, #0
	static tile_map_og + #222, #0
	static tile_map_og + #223, #'B'
	static tile_map_og + #224, #0
	static tile_map_og + #225, #'B'
	static tile_map_og + #226, #0
	static tile_map_og + #227, #0
	static tile_map_og + #228, #0
	static tile_map_og + #229, #0
	static tile_map_og + #230, #'A'
	static tile_map_og + #231, #0
	static tile_map_og + #232, #'B'
	static tile_map_og + #233, #0
	static tile_map_og + #234, #'B'
	static tile_map_og + #235, #'B'
	static tile_map_og + #236, #0
	static tile_map_og + #237, #0
	static tile_map_og + #238, #0
	static tile_map_og + #239, #'A'
	static tile_map_og + #240, #'A'
	static tile_map_og + #241, #'A'
	static tile_map_og + #242, #'A'
	static tile_map_og + #243, #'A'
	static tile_map_og + #244, #'A'
	static tile_map_og + #245, #'A'
	static tile_map_og + #246, #'A'
	static tile_map_og + #247, #'A'
	static tile_map_og + #248, #'A'
	static tile_map_og + #249, #'A'
	static tile_map_og + #250, #'A'
	static tile_map_og + #251, #'A'
	static tile_map_og + #252, #'A'
	static tile_map_og + #253, #'A'
	static tile_map_og + #254, #'A'
	static tile_map_og + #255, #'A'
	static tile_map_og + #256, #'A'
	static tile_map_og + #257, #'A'
	static tile_map_og + #258, #'A'
	static tile_map_og + #259, #'A'

tile_map_name : string "balatro"

tile_map_location : var #1
static tile_map_location + #0, #17

; Posicao que tem um power up dentro da caixa


tile_map_pu : var #260
	static tile_map_pu + #0, #0
	static tile_map_pu + #1, #0
	static tile_map_pu + #2, #0
	static tile_map_pu + #3, #0
	static tile_map_pu + #4, #0
	static tile_map_pu + #5, #0
	static tile_map_pu + #6, #0
	static tile_map_pu + #7, #0
	static tile_map_pu + #8, #0
	static tile_map_pu + #9, #0
	static tile_map_pu + #10, #0
	static tile_map_pu + #11, #0
	static tile_map_pu + #12, #0
	static tile_map_pu + #13, #0
	static tile_map_pu + #14, #0
	static tile_map_pu + #15, #0
	static tile_map_pu + #16, #0
	static tile_map_pu + #17, #0
	static tile_map_pu + #18, #0
	static tile_map_pu + #19, #0
	static tile_map_pu + #20, #0
	static tile_map_pu + #21, #0
	static tile_map_pu + #22, #0
	static tile_map_pu + #23, #0
	static tile_map_pu + #24, #0
	static tile_map_pu + #25, #0
	static tile_map_pu + #26, #0
	static tile_map_pu + #27, #0
	static tile_map_pu + #28, #0
	static tile_map_pu + #29, #0
	static tile_map_pu + #30, #0
	static tile_map_pu + #31, #0
	static tile_map_pu + #32, #0
	static tile_map_pu + #33, #0
	static tile_map_pu + #34, #0
	static tile_map_pu + #35, #0
	static tile_map_pu + #36, #0
	static tile_map_pu + #37, #0
	static tile_map_pu + #38, #0
	static tile_map_pu + #39, #0
	static tile_map_pu + #40, #0
	static tile_map_pu + #41, #0
	static tile_map_pu + #42, #0
	static tile_map_pu + #43, #0
	static tile_map_pu + #44, #0
	static tile_map_pu + #45, #0
	static tile_map_pu + #46, #0
	static tile_map_pu + #47, #0
	static tile_map_pu + #48, #0
	static tile_map_pu + #49, #0
	static tile_map_pu + #50, #0
	static tile_map_pu + #51, #0
	static tile_map_pu + #52, #0
	static tile_map_pu + #53, #0
	static tile_map_pu + #54, #0
	static tile_map_pu + #55, #0
	static tile_map_pu + #56, #0
	static tile_map_pu + #57, #0
	static tile_map_pu + #58, #0
	static tile_map_pu + #59, #0
	static tile_map_pu + #60, #0
	static tile_map_pu + #61, #0
	static tile_map_pu + #62, #0
	static tile_map_pu + #63, #0
	static tile_map_pu + #64, #0
	static tile_map_pu + #65, #0
	static tile_map_pu + #66, #0
	static tile_map_pu + #67, #0
	static tile_map_pu + #68, #0
	static tile_map_pu + #69, #0
	static tile_map_pu + #70, #0
	static tile_map_pu + #71, #0
	static tile_map_pu + #72, #0
	static tile_map_pu + #73, #0
	static tile_map_pu + #74, #0
	static tile_map_pu + #75, #0
	static tile_map_pu + #76, #0
	static tile_map_pu + #77, #0
	static tile_map_pu + #78, #0
	static tile_map_pu + #79, #0
	static tile_map_pu + #80, #0
	static tile_map_pu + #81, #0
	static tile_map_pu + #82, #0
	static tile_map_pu + #83, #0
	static tile_map_pu + #84, #0
	static tile_map_pu + #85, #0
	static tile_map_pu + #86, #0
	static tile_map_pu + #87, #0
	static tile_map_pu + #88, #0
	static tile_map_pu + #89, #0
	static tile_map_pu + #90, #0
	static tile_map_pu + #91, #0
	static tile_map_pu + #92, #0
	static tile_map_pu + #93, #0
	static tile_map_pu + #94, #0
	static tile_map_pu + #95, #1
	static tile_map_pu + #96, #0
	static tile_map_pu + #97, #0
	static tile_map_pu + #98, #0
	static tile_map_pu + #99, #0
	static tile_map_pu + #100, #0
	static tile_map_pu + #101, #0
	static tile_map_pu + #102, #0
	static tile_map_pu + #103, #0
	static tile_map_pu + #104, #0
	static tile_map_pu + #105, #0
	static tile_map_pu + #106, #0
	static tile_map_pu + #107, #0
	static tile_map_pu + #108, #0
	static tile_map_pu + #109, #0
	static tile_map_pu + #110, #0
	static tile_map_pu + #111, #0
	static tile_map_pu + #112, #0
	static tile_map_pu + #113, #0
	static tile_map_pu + #114, #0
	static tile_map_pu + #115, #0
	static tile_map_pu + #116, #0
	static tile_map_pu + #117, #0
	static tile_map_pu + #118, #0
	static tile_map_pu + #119, #0
	static tile_map_pu + #120, #0
	static tile_map_pu + #121, #0
	static tile_map_pu + #122, #0
	static tile_map_pu + #123, #0
	static tile_map_pu + #124, #0
	static tile_map_pu + #125, #0
	static tile_map_pu + #126, #0
	static tile_map_pu + #127, #0
	static tile_map_pu + #128, #0
	static tile_map_pu + #129, #1
	static tile_map_pu + #130, #0
	static tile_map_pu + #131, #0
	static tile_map_pu + #132, #0
	static tile_map_pu + #133, #0
	static tile_map_pu + #134, #0
	static tile_map_pu + #135, #0
	static tile_map_pu + #136, #0
	static tile_map_pu + #137, #0
	static tile_map_pu + #138, #0
	static tile_map_pu + #139, #0
	static tile_map_pu + #140, #0
	static tile_map_pu + #141, #0
	static tile_map_pu + #142, #0
	static tile_map_pu + #143, #0
	static tile_map_pu + #144, #0
	static tile_map_pu + #145, #0
	static tile_map_pu + #146, #0
	static tile_map_pu + #147, #0
	static tile_map_pu + #148, #0
	static tile_map_pu + #149, #0
	static tile_map_pu + #150, #0
	static tile_map_pu + #151, #0
	static tile_map_pu + #152, #0
	static tile_map_pu + #153, #0
	static tile_map_pu + #154, #0
	static tile_map_pu + #155, #0
	static tile_map_pu + #156, #0
	static tile_map_pu + #157, #1
	static tile_map_pu + #158, #0
	static tile_map_pu + #159, #0
	static tile_map_pu + #160, #0
	static tile_map_pu + #161, #0
	static tile_map_pu + #162, #0
	static tile_map_pu + #163, #0
	static tile_map_pu + #164, #0
	static tile_map_pu + #165, #0
	static tile_map_pu + #166, #0
	static tile_map_pu + #167, #0
	static tile_map_pu + #168, #0
	static tile_map_pu + #169, #0
	static tile_map_pu + #170, #0
	static tile_map_pu + #171, #0
	static tile_map_pu + #172, #0
	static tile_map_pu + #173, #0
	static tile_map_pu + #174, #0
	static tile_map_pu + #175, #0
	static tile_map_pu + #176, #0
	static tile_map_pu + #177, #0
	static tile_map_pu + #178, #0
	static tile_map_pu + #179, #0
	static tile_map_pu + #180, #0
	static tile_map_pu + #181, #0
	static tile_map_pu + #182, #0
	static tile_map_pu + #183, #0
	static tile_map_pu + #184, #0
	static tile_map_pu + #185, #0
	static tile_map_pu + #186, #0
	static tile_map_pu + #187, #0
	static tile_map_pu + #188, #0
	static tile_map_pu + #189, #0
	static tile_map_pu + #190, #0
	static tile_map_pu + #191, #0
	static tile_map_pu + #192, #0
	static tile_map_pu + #193, #0
	static tile_map_pu + #194, #0
	static tile_map_pu + #195, #0
	static tile_map_pu + #196, #0
	static tile_map_pu + #197, #0
	static tile_map_pu + #198, #0
	static tile_map_pu + #199, #0
	static tile_map_pu + #200, #0
	static tile_map_pu + #201, #0
	static tile_map_pu + #202, #0
	static tile_map_pu + #203, #0
	static tile_map_pu + #204, #0
	static tile_map_pu + #205, #0
	static tile_map_pu + #206, #0
	static tile_map_pu + #207, #0
	static tile_map_pu + #208, #0
	static tile_map_pu + #209, #0
	static tile_map_pu + #210, #0
	static tile_map_pu + #211, #0
	static tile_map_pu + #212, #0
	static tile_map_pu + #213, #0
	static tile_map_pu + #214, #0
	static tile_map_pu + #215, #0
	static tile_map_pu + #216, #0
	static tile_map_pu + #217, #0
	static tile_map_pu + #218, #0
	static tile_map_pu + #219, #0
	static tile_map_pu + #220, #0
	static tile_map_pu + #221, #0
	static tile_map_pu + #222, #0
	static tile_map_pu + #223, #1
	static tile_map_pu + #224, #0
	static tile_map_pu + #225, #0
	static tile_map_pu + #226, #0
	static tile_map_pu + #227, #0
	static tile_map_pu + #228, #0
	static tile_map_pu + #229, #0
	static tile_map_pu + #230, #0
	static tile_map_pu + #231, #0
	static tile_map_pu + #232, #0
	static tile_map_pu + #233, #0
	static tile_map_pu + #234, #0
	static tile_map_pu + #235, #0
	static tile_map_pu + #236, #0
	static tile_map_pu + #237, #0
	static tile_map_pu + #238, #0
	static tile_map_pu + #239, #0
	static tile_map_pu + #240, #0
	static tile_map_pu + #241, #0
	static tile_map_pu + #242, #0
	static tile_map_pu + #243, #0
	static tile_map_pu + #244, #0
	static tile_map_pu + #245, #0
	static tile_map_pu + #246, #0
	static tile_map_pu + #247, #0
	static tile_map_pu + #248, #0
	static tile_map_pu + #249, #0
	static tile_map_pu + #250, #0
	static tile_map_pu + #251, #0
	static tile_map_pu + #252, #0
	static tile_map_pu + #253, #0
	static tile_map_pu + #254, #0
	static tile_map_pu + #255, #0
	static tile_map_pu + #256, #0
	static tile_map_pu + #257, #0
	static tile_map_pu + #258, #0
	static tile_map_pu + #259, #0

; copia dos powrups original


tile_map_pu_og : var #260
	static tile_map_pu_og + #0, #0
	static tile_map_pu_og + #1, #0
	static tile_map_pu_og + #2, #0
	static tile_map_pu_og + #3, #0
	static tile_map_pu_og + #4, #0
	static tile_map_pu_og + #5, #0
	static tile_map_pu_og + #6, #0
	static tile_map_pu_og + #7, #0
	static tile_map_pu_og + #8, #0
	static tile_map_pu_og + #9, #0
	static tile_map_pu_og + #10, #0
	static tile_map_pu_og + #11, #0
	static tile_map_pu_og + #12, #0
	static tile_map_pu_og + #13, #0
	static tile_map_pu_og + #14, #0
	static tile_map_pu_og + #15, #0
	static tile_map_pu_og + #16, #0
	static tile_map_pu_og + #17, #0
	static tile_map_pu_og + #18, #0
	static tile_map_pu_og + #19, #0
	static tile_map_pu_og + #20, #0
	static tile_map_pu_og + #21, #0
	static tile_map_pu_og + #22, #0
	static tile_map_pu_og + #23, #0
	static tile_map_pu_og + #24, #0
	static tile_map_pu_og + #25, #0
	static tile_map_pu_og + #26, #0
	static tile_map_pu_og + #27, #0
	static tile_map_pu_og + #28, #0
	static tile_map_pu_og + #29, #0
	static tile_map_pu_og + #30, #0
	static tile_map_pu_og + #31, #0
	static tile_map_pu_og + #32, #0
	static tile_map_pu_og + #33, #0
	static tile_map_pu_og + #34, #0
	static tile_map_pu_og + #35, #0
	static tile_map_pu_og + #36, #0
	static tile_map_pu_og + #37, #0
	static tile_map_pu_og + #38, #0
	static tile_map_pu_og + #39, #0
	static tile_map_pu_og + #40, #0
	static tile_map_pu_og + #41, #0
	static tile_map_pu_og + #42, #0
	static tile_map_pu_og + #43, #0
	static tile_map_pu_og + #44, #0
	static tile_map_pu_og + #45, #0
	static tile_map_pu_og + #46, #0
	static tile_map_pu_og + #47, #0
	static tile_map_pu_og + #48, #0
	static tile_map_pu_og + #49, #0
	static tile_map_pu_og + #50, #0
	static tile_map_pu_og + #51, #0
	static tile_map_pu_og + #52, #0
	static tile_map_pu_og + #53, #0
	static tile_map_pu_og + #54, #0
	static tile_map_pu_og + #55, #0
	static tile_map_pu_og + #56, #0
	static tile_map_pu_og + #57, #0
	static tile_map_pu_og + #58, #0
	static tile_map_pu_og + #59, #0
	static tile_map_pu_og + #60, #0
	static tile_map_pu_og + #61, #0
	static tile_map_pu_og + #62, #0
	static tile_map_pu_og + #63, #0
	static tile_map_pu_og + #64, #0
	static tile_map_pu_og + #65, #0
	static tile_map_pu_og + #66, #0
	static tile_map_pu_og + #67, #0
	static tile_map_pu_og + #68, #0
	static tile_map_pu_og + #69, #0
	static tile_map_pu_og + #70, #0
	static tile_map_pu_og + #71, #0
	static tile_map_pu_og + #72, #0
	static tile_map_pu_og + #73, #0
	static tile_map_pu_og + #74, #0
	static tile_map_pu_og + #75, #0
	static tile_map_pu_og + #76, #0
	static tile_map_pu_og + #77, #0
	static tile_map_pu_og + #78, #0
	static tile_map_pu_og + #79, #0
	static tile_map_pu_og + #80, #0
	static tile_map_pu_og + #81, #0
	static tile_map_pu_og + #82, #0
	static tile_map_pu_og + #83, #0
	static tile_map_pu_og + #84, #0
	static tile_map_pu_og + #85, #0
	static tile_map_pu_og + #86, #0
	static tile_map_pu_og + #87, #0
	static tile_map_pu_og + #88, #0
	static tile_map_pu_og + #89, #0
	static tile_map_pu_og + #90, #0
	static tile_map_pu_og + #91, #0
	static tile_map_pu_og + #92, #0
	static tile_map_pu_og + #93, #0
	static tile_map_pu_og + #94, #0
	static tile_map_pu_og + #95, #1
	static tile_map_pu_og + #96, #0
	static tile_map_pu_og + #97, #0
	static tile_map_pu_og + #98, #0
	static tile_map_pu_og + #99, #0
	static tile_map_pu_og + #100, #0
	static tile_map_pu_og + #101, #0
	static tile_map_pu_og + #102, #0
	static tile_map_pu_og + #103, #0
	static tile_map_pu_og + #104, #0
	static tile_map_pu_og + #105, #0
	static tile_map_pu_og + #106, #0
	static tile_map_pu_og + #107, #0
	static tile_map_pu_og + #108, #0
	static tile_map_pu_og + #109, #0
	static tile_map_pu_og + #110, #0
	static tile_map_pu_og + #111, #0
	static tile_map_pu_og + #112, #0
	static tile_map_pu_og + #113, #0
	static tile_map_pu_og + #114, #0
	static tile_map_pu_og + #115, #0
	static tile_map_pu_og + #116, #0
	static tile_map_pu_og + #117, #0
	static tile_map_pu_og + #118, #0
	static tile_map_pu_og + #119, #0
	static tile_map_pu_og + #120, #0
	static tile_map_pu_og + #121, #0
	static tile_map_pu_og + #122, #0
	static tile_map_pu_og + #123, #0
	static tile_map_pu_og + #124, #0
	static tile_map_pu_og + #125, #0
	static tile_map_pu_og + #126, #0
	static tile_map_pu_og + #127, #0
	static tile_map_pu_og + #128, #0
	static tile_map_pu_og + #129, #1
	static tile_map_pu_og + #130, #0
	static tile_map_pu_og + #131, #0
	static tile_map_pu_og + #132, #0
	static tile_map_pu_og + #133, #0
	static tile_map_pu_og + #134, #0
	static tile_map_pu_og + #135, #0
	static tile_map_pu_og + #136, #0
	static tile_map_pu_og + #137, #0
	static tile_map_pu_og + #138, #0
	static tile_map_pu_og + #139, #0
	static tile_map_pu_og + #140, #0
	static tile_map_pu_og + #141, #0
	static tile_map_pu_og + #142, #0
	static tile_map_pu_og + #143, #0
	static tile_map_pu_og + #144, #0
	static tile_map_pu_og + #145, #0
	static tile_map_pu_og + #146, #0
	static tile_map_pu_og + #147, #0
	static tile_map_pu_og + #148, #0
	static tile_map_pu_og + #149, #0
	static tile_map_pu_og + #150, #0
	static tile_map_pu_og + #151, #0
	static tile_map_pu_og + #152, #0
	static tile_map_pu_og + #153, #0
	static tile_map_pu_og + #154, #0
	static tile_map_pu_og + #155, #0
	static tile_map_pu_og + #156, #0
	static tile_map_pu_og + #157, #1
	static tile_map_pu_og + #158, #0
	static tile_map_pu_og + #159, #0
	static tile_map_pu_og + #160, #0
	static tile_map_pu_og + #161, #0
	static tile_map_pu_og + #162, #0
	static tile_map_pu_og + #163, #0
	static tile_map_pu_og + #164, #0
	static tile_map_pu_og + #165, #0
	static tile_map_pu_og + #166, #0
	static tile_map_pu_og + #167, #0
	static tile_map_pu_og + #168, #0
	static tile_map_pu_og + #169, #0
	static tile_map_pu_og + #170, #0
	static tile_map_pu_og + #171, #0
	static tile_map_pu_og + #172, #0
	static tile_map_pu_og + #173, #0
	static tile_map_pu_og + #174, #0
	static tile_map_pu_og + #175, #0
	static tile_map_pu_og + #176, #0
	static tile_map_pu_og + #177, #0
	static tile_map_pu_og + #178, #0
	static tile_map_pu_og + #179, #0
	static tile_map_pu_og + #180, #0
	static tile_map_pu_og + #181, #0
	static tile_map_pu_og + #182, #0
	static tile_map_pu_og + #183, #0
	static tile_map_pu_og + #184, #0
	static tile_map_pu_og + #185, #0
	static tile_map_pu_og + #186, #0
	static tile_map_pu_og + #187, #0
	static tile_map_pu_og + #188, #0
	static tile_map_pu_og + #189, #0
	static tile_map_pu_og + #190, #0
	static tile_map_pu_og + #191, #0
	static tile_map_pu_og + #192, #0
	static tile_map_pu_og + #193, #0
	static tile_map_pu_og + #194, #0
	static tile_map_pu_og + #195, #0
	static tile_map_pu_og + #196, #0
	static tile_map_pu_og + #197, #0
	static tile_map_pu_og + #198, #0
	static tile_map_pu_og + #199, #0
	static tile_map_pu_og + #200, #0
	static tile_map_pu_og + #201, #0
	static tile_map_pu_og + #202, #0
	static tile_map_pu_og + #203, #0
	static tile_map_pu_og + #204, #0
	static tile_map_pu_og + #205, #0
	static tile_map_pu_og + #206, #0
	static tile_map_pu_og + #207, #0
	static tile_map_pu_og + #208, #0
	static tile_map_pu_og + #209, #0
	static tile_map_pu_og + #210, #0
	static tile_map_pu_og + #211, #0
	static tile_map_pu_og + #212, #0
	static tile_map_pu_og + #213, #0
	static tile_map_pu_og + #214, #0
	static tile_map_pu_og + #215, #0
	static tile_map_pu_og + #216, #0
	static tile_map_pu_og + #217, #0
	static tile_map_pu_og + #218, #0
	static tile_map_pu_og + #219, #0
	static tile_map_pu_og + #220, #0
	static tile_map_pu_og + #221, #0
	static tile_map_pu_og + #222, #0
	static tile_map_pu_og + #223, #1
	static tile_map_pu_og + #224, #0
	static tile_map_pu_og + #225, #0
	static tile_map_pu_og + #226, #0
	static tile_map_pu_og + #227, #0
	static tile_map_pu_og + #228, #0
	static tile_map_pu_og + #229, #0
	static tile_map_pu_og + #230, #0
	static tile_map_pu_og + #231, #0
	static tile_map_pu_og + #232, #0
	static tile_map_pu_og + #233, #0
	static tile_map_pu_og + #234, #0
	static tile_map_pu_og + #235, #0
	static tile_map_pu_og + #236, #0
	static tile_map_pu_og + #237, #0
	static tile_map_pu_og + #238, #0
	static tile_map_pu_og + #239, #0
	static tile_map_pu_og + #240, #0
	static tile_map_pu_og + #241, #0
	static tile_map_pu_og + #242, #0
	static tile_map_pu_og + #243, #0
	static tile_map_pu_og + #244, #0
	static tile_map_pu_og + #245, #0
	static tile_map_pu_og + #246, #0
	static tile_map_pu_og + #247, #0
	static tile_map_pu_og + #248, #0
	static tile_map_pu_og + #249, #0
	static tile_map_pu_og + #250, #0
	static tile_map_pu_og + #251, #0
	static tile_map_pu_og + #252, #0
	static tile_map_pu_og + #253, #0
	static tile_map_pu_og + #254, #0
	static tile_map_pu_og + #255, #0
	static tile_map_pu_og + #256, #0
	static tile_map_pu_og + #257, #0
	static tile_map_pu_og + #258, #0
	static tile_map_pu_og + #259, #0

;   Desenha o mapa da linha 5 ate a linha 30, 
; desenhando em cima do que estava la previamente.
; Ele desenha somente as tile 2 x 2 de um unico caracter 
; que sao os basicos do mapa.
;
; @param {endereco} r5 - Endereco do mapa que deseja desenhar na
; tela
draw_map_full:
    push r0
    push r1 
    push r2
    push r3
    push r4
    push r6
    push r7

    ; primeiro char da quinta linha da tela
    loadn r2, #160
    loadn r3, #2    ; step horizontal
    loadn r4, #20   ; fim do loop da coluna
    loadn r6, #0    ; variavel do lop
    loadn r7, #12   ; limite do loop de linhas

    push r6
    loadn r6, #0
    colum_draw_map_loop:
        cmp r6, r4
        jeq row_draw_loop

        loadi r0, r5
        mov r1, r2

        ; decidir qual tile desewnhar e de qual forma
        push r7
        loadn r7, #'A'
        cmp r0, r7
        jeq draw_brick_tile

        loadn r7, #'B'
        cmp r0, r7
        jeq draw_box_tile

        ; desenhar o chao de preto
        call two_by_two_draw
        jmp end_draw_if

        draw_brick_tile:
            push r2
            loadn r2, #1792
            call two_by_two_draw_colored
            pop r2
            jmp end_draw_if

        draw_box_tile:
            push r2
            loadn r2, #256
            call two_by_two_draw_colored
            pop r2
            jmp end_draw_if

        end_draw_if:

        ; popando o r7
        pop r7

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
        pop r6
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

;   Restaura o tile map para o seu estado inicial.
restore_tile_map:
    push r0 
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6

    loadn r0, #tile_map_og
    loadn r1, #tile_map
    loadn r5, #tile_map_pu_og
    loadn r6, #tile_map_pu

    loadn r2, #0 ; variavel para iterar pelo char map
    loadn r3, #260 ; quantidade de tiles em um mapa

    restore_tile_map_loop:
        cmp r2, r3
        jeq restore_tile_map_loop_end

        loadi r4, r0 ;carregando o valor do mapa original
        storei r1, r4 ; colocar no tile map o valor original

        loadi r4, r5 ; carregando o valor orignal do mapa de powerup
        storei r6, r4 ; colocando no 

        inc r0 ; proximo endereco do tile map original
        inc r1 ; proximo endereco do tile map
        inc r5 ; poxima posicao no mapa da bomba original
        inc r6 ; proxima posicao do tile map de power up  
        inc r2 ; indo para a proxima posicao        
        jmp restore_tile_map_loop
    restore_tile_map_loop_end:

    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

;   Checa se a tile tem um powerup para colocar
; no tile map, so existiram powerups nas tiles que eram 
; caixas anteriormente.
;
; @param {const int} r1 - Coordenada x da tile que deseja pegar 
; @param {const int} r2 - Coordenada y da tile que deseja pegar
; @return {bool} r0 - Retorna 1 se possui um power up naquela 
; posicao, zero caso contrario. 
checar_se_tem_power_up:
    push r3 
    
    ; transformando para um endereco valido
    loadn r3, #20
    mul r0, r2, r3
    add r0, r0, r1 

    ; pegando o valor no tile map 
    loadn r3, #tile_map_pu
    add r3, r3, r0 
    loadi r0, r3 ; pela forma que eh o mapa de power map 
    ; vc ja vai ter 0 ou 1

    pop r3
    rts

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

;   Inicializa o player na posicao determinada pelo 
; endereco de inicializacao.
;
; @param {endereco} r0 - Endereco de inicializacao do 
; player.
; @param {cor} r4 - Cor do player para iniciar ele
; @param {endereco} r5 - Endereco da bomba do player
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
    mov r2, r4
    call two_by_two_sequence_draw_colored

    ; setando a bomba colocada como falsa
    loadn r1, #0
    storei r5, r1

    ; indo para o tamanho da de fogo explosao e setando como 
    ; o valor default
    loadn r1, #4
    add r5, r5, r1
    loadn r1, #2
    storei r5, r1

    ; indo para o estado de fogo e setando para zero
    inc r5
    loadn r1, #0
    storei r5, r1

    pop r2 
    pop r1 
    rts

;   A funcao player para cima move o player para cima atualizando 
; suas informacoes
;
; @param {const cor} r4 - Cor para pintar o personagem.
; @param {const endereco} r5 - Endereco da bomba do player
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

    ; verifica se eh uma tile de de powerup
    dec r2
    loadn r3, #'P'
    call get_tile
    cmp r0, r3
    jne sem_powerup_acima
        call adcionar_powerup_na_bomba
        jmp andar_para_cima
    sem_powerup_acima:

    ; verifica se eh uma tile vazia para que o player possa ir
    loadn r3, #0
    call get_tile
    cmp r0, r3
    jne player_para_cima_end
    andar_para_cima:
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
    mov r2, r4
    call two_by_two_sequence_draw_colored

    player_para_cima_end:
        pop r3 
        pop r2 
        pop r1 
        pop r0 
        rts

;   A funcao player para baixo move o player para baixo atualizando 
; suas informacoes
;
; @param {const cor} r4 - Cor para pintar o personagem.
; @param {const endereco} r5 - Endereco da bomba do player
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

    ; verifica se eh uma tile de de powerup
    inc r2
    loadn r3, #'P'
    call get_tile
    cmp r0, r3
    jne sem_powerup_abaixo
        call adcionar_powerup_na_bomba
        jmp andar_para_baixo
    sem_powerup_abaixo:

    ; verifica se eh uma tile vazia para que o player possa ir
    loadn r3, #0
    call get_tile
    cmp r0, r3
    jne player_para_baixo_end
    andar_para_baixo:
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
    mov r2, r4
    call two_by_two_sequence_draw_colored

    player_para_baixo_end:
        pop r3 
        pop r2 
        pop r1 
        pop r0 
        rts

;   A funcao player para esquerda move o player para esquerda atualizando 
; suas informacoes.
;
; @param {const cor} r4 - Cor para pintar o personagem.
; @param {const endereco} r5 - Endereco da bomba do player
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

    ; verifica se eh uma tile de de powerup
    dec r1
    loadn r3, #'P'
    call get_tile
    cmp r0, r3
    jne sem_powerup_a_esquerda
        call adcionar_powerup_na_bomba
        jmp andar_para_esquerda
    sem_powerup_a_esquerda:

    ; verifica se eh uma tile vazia para que o player possa ir
    loadn r3, #0
    call get_tile
    cmp r0, r3
    jne player_para_esquerda_end
    andar_para_esquerda:
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
    mov r2, r4
    call two_by_two_sequence_draw_colored

    player_para_esquerda_end:
        pop r3 
        pop r2 
        pop r1 
        pop r0 
        rts

;   A funcao player para direita move o player para direita atualizando 
; suas informacoes.
;
; @param {const cor} r4 - Cor para pintar o personagem.
; @param {const endereco} r5 - Endereco da bomba do player
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

    ; verifica se eh uma tile de de powerup
    inc r1
    loadn r3, #'P'
    call get_tile
    cmp r0, r3
    jne sem_powerup_a_direita
        call adcionar_powerup_na_bomba
        jmp andar_para_direita
    sem_powerup_a_direita:

    ; verifica se eh uma tile vazia para que o player possa ir
    loadn r3, #0
    call get_tile
    cmp r0, r3
    jne player_para_direita_end
    andar_para_direita:
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
    mov r2, r4
    call two_by_two_sequence_draw_colored

    player_para_direita_end:
        pop r3 
        pop r2 
        pop r1 
        pop r0 
        rts

;   Verifica se o player morreu (tenha sido
; atingindo por uma labareda), caso tenha morrido
; retorna 1, caso contrario retorna zero. 
;
; @param {int} r1 - Posicao x do player.
; @param {int} r2 - Posicao y do player.
; @return {bool} r3 - 1 caso o player tenha morrido,
; 0 caso contrario
checar_se_player_morreu:
    push r0
      
    ; pegando a tile que o player esta 
    call get_tile

    loadn r3, #'*'
    cmp r3, r0
    jeq o_player_morreu
        ; se nao for uma tile de bomba
        loadn r3, #0
        pop r0
        rts

    ; se for uma tile de bomba
    o_player_morreu:
        loadn r3, #1  
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
    loadn r4, #0
    loadn r5, #player_um_bomba
    loadn r6, #pu_posx
    loadn r7, #pu_posy
    call ini_player
    pop r0 
    rts

;   A funcao  altera o estado do player um
; com base no char passado (tecla), tambem checando 
; pela morte do player.
;
; @param {char} r0 - Acao a ser feita no player, 'w' para 
; ir para cima, 'a' para ir para esquerda, 's' para ir para 
; baixo, 'd' para ir para direita e 'z' para colocar uma bomba.
; Se o caractere passado nao representar uma acao valida a funcao 
; nao faz nada.
; @param {const endereco} r6 - Endereco da posicao x do player 
; @param {const endereco} r7 - Endereco da posicao y do player
; @return {bool} r5 - Retorna 1 caso o player tenha morrido.
atuar_no_player_um:
    push r1 
    push r2
    push r3
    push r4
    push r6
    push r7
    loadn r6, #pu_posx
    loadn r7, #pu_posy

    load r1, pu_posx
    load r2, pu_posy
    call checar_se_player_morreu
    loadn r1, #1
    cmp r1, r3
    jeq player_um_morte

    loadn r5, #player_um_bomba
    ; cor branca do player 1
    loadn r4, #0

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
        ; o z esta pressionado, entao colocar a bomba
        loadn r0, #player_um_bomba
        load r1, pu_posx
        load r2, pu_posy
        call colocar_bomba

    atuar_no_player_um_fim:
        loadn r5, #0
        pop r7 
        pop r6
        pop r4
        pop r3
        pop r2 
        pop r1 
        rts

    player_um_morte:
        loadn r5, #1
        pop r7 
        pop r6
        pop r4
        pop r3
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
    loadn r4, #3072
    loadn r5, #player_dois_bomba
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
    push r3
    push r4
    push r6
    push r7
    loadn r6, #pd_posx
    loadn r7, #pd_posy

    load r1, pd_posx
    load r2, pd_posy
    call checar_se_player_morreu
    loadn r1, #1
    cmp r1, r3
    jeq player_dois_morte

    loadn r5, #player_dois_bomba
    ; valor azul do player 2
    loadn r4, #3072

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
        loadn r5, #0
        pop r7 
        pop r6
        pop r4
        pop r3
        pop r2 
        pop r1 
        rts

    player_dois_morte:
        loadn r5, #1
        pop r7 
        pop r6
        pop r4
        pop r3
        pop r2 
        pop r1
        rts

; coisas de ler input

;   Essa funcao le o teclado e ajusta o estado dos players 
; caso alguma tecla de controle tenha sido pressionada, caso 
; algum player tenha morrido, retorna o numero dele, zero caso
; nao ninguem tenha morrido.
;
; @return {int} r0 - Numero do player que morreu, ou zero caso 
; nao tenha ocorrido mortes.
update_players:
    push r1
    push r5

    inchar r0 
    call atuar_no_player_um
    loadn r1, #1
    cmp r5, r1
    jeq player_um_mortis 

    call atuar_no_player_dois
    loadn r1, #1
    cmp r5, r1
    jeq player_dois_mortis 

        ; nenhum dos playeres morreu entao retorna zero
        loadn r0, #0
        pop r5
        pop r1
        rts

    player_um_mortis:
        loadn r0, #1
        pop r5
        pop r1
        rts

    player_dois_mortis:
        loadn r0, #2
        pop r5
        pop r1
        rts


menu_map : var #260
	static menu_map + #0, #0
	static menu_map + #1, #0
	static menu_map + #2, #0
	static menu_map + #3, #0
	static menu_map + #4, #0
	static menu_map + #5, #0
	static menu_map + #6, #0
	static menu_map + #7, #0
	static menu_map + #8, #0
	static menu_map + #9, #'B'
	static menu_map + #10, #0
	static menu_map + #11, #0
	static menu_map + #12, #0
	static menu_map + #13, #0
	static menu_map + #14, #0
	static menu_map + #15, #0
	static menu_map + #16, #0
	static menu_map + #17, #0
	static menu_map + #18, #0
	static menu_map + #19, #0
	static menu_map + #20, #0
	static menu_map + #21, #0
	static menu_map + #22, #0
	static menu_map + #23, #0
	static menu_map + #24, #0
	static menu_map + #25, #0
	static menu_map + #26, #0
	static menu_map + #27, #0
	static menu_map + #28, #0
	static menu_map + #29, #0
	static menu_map + #30, #'B'
	static menu_map + #31, #'B'
	static menu_map + #32, #0
	static menu_map + #33, #0
	static menu_map + #34, #0
	static menu_map + #35, #0
	static menu_map + #36, #0
	static menu_map + #37, #0
	static menu_map + #38, #0
	static menu_map + #39, #0
	static menu_map + #40, #0
	static menu_map + #41, #0
	static menu_map + #42, #0
	static menu_map + #43, #0
	static menu_map + #44, #0
	static menu_map + #45, #0
	static menu_map + #46, #0
	static menu_map + #47, #0
	static menu_map + #48, #0
	static menu_map + #49, #'B'
	static menu_map + #50, #'B'
	static menu_map + #51, #0
	static menu_map + #52, #0
	static menu_map + #53, #0
	static menu_map + #54, #0
	static menu_map + #55, #0
	static menu_map + #56, #0
	static menu_map + #57, #0
	static menu_map + #58, #0
	static menu_map + #59, #0
	static menu_map + #60, #0
	static menu_map + #61, #0
	static menu_map + #62, #0
	static menu_map + #63, #0
	static menu_map + #64, #0
	static menu_map + #65, #0
	static menu_map + #66, #'A'
	static menu_map + #67, #'A'
	static menu_map + #68, #'A'
	static menu_map + #69, #'A'
	static menu_map + #70, #'A'
	static menu_map + #71, #'A'
	static menu_map + #72, #'A'
	static menu_map + #73, #0
	static menu_map + #74, #0
	static menu_map + #75, #0
	static menu_map + #76, #0
	static menu_map + #77, #0
	static menu_map + #78, #0
	static menu_map + #79, #0
	static menu_map + #80, #0
	static menu_map + #81, #0
	static menu_map + #82, #0
	static menu_map + #83, #0
	static menu_map + #84, #0
	static menu_map + #85, #'A'
	static menu_map + #86, #'A'
	static menu_map + #87, #'A'
	static menu_map + #88, #'A'
	static menu_map + #89, #'A'
	static menu_map + #90, #'A'
	static menu_map + #91, #'A'
	static menu_map + #92, #'A'
	static menu_map + #93, #'A'
	static menu_map + #94, #0
	static menu_map + #95, #0
	static menu_map + #96, #0
	static menu_map + #97, #0
	static menu_map + #98, #0
	static menu_map + #99, #0
	static menu_map + #100, #0
	static menu_map + #101, #0
	static menu_map + #102, #0
	static menu_map + #103, #0
	static menu_map + #104, #'A'
	static menu_map + #105, #'A'
	static menu_map + #106, #'A'
	static menu_map + #107, #'A'
	static menu_map + #108, #'A'
	static menu_map + #109, #'A'
	static menu_map + #110, #'A'
	static menu_map + #111, #'A'
	static menu_map + #112, #'A'
	static menu_map + #113, #'A'
	static menu_map + #114, #'A'
	static menu_map + #115, #0
	static menu_map + #116, #0
	static menu_map + #117, #0
	static menu_map + #118, #0
	static menu_map + #119, #0
	static menu_map + #120, #0
	static menu_map + #121, #0
	static menu_map + #122, #0
	static menu_map + #123, #'A'
	static menu_map + #124, #'A'
	static menu_map + #125, #'A'
	static menu_map + #126, #'A'
	static menu_map + #127, #'A'
	static menu_map + #128, #'A'
	static menu_map + #129, #'A'
	static menu_map + #130, #'A'
	static menu_map + #131, #'A'
	static menu_map + #132, #'A'
	static menu_map + #133, #'A'
	static menu_map + #134, #'A'
	static menu_map + #135, #'A'
	static menu_map + #136, #0
	static menu_map + #137, #0
	static menu_map + #138, #0
	static menu_map + #139, #0
	static menu_map + #140, #0
	static menu_map + #141, #0
	static menu_map + #142, #0
	static menu_map + #143, #'A'
	static menu_map + #144, #'A'
	static menu_map + #145, #'A'
	static menu_map + #146, #'A'
	static menu_map + #147, #'A'
	static menu_map + #148, #'A'
	static menu_map + #149, #'A'
	static menu_map + #150, #'A'
	static menu_map + #151, #'A'
	static menu_map + #152, #'A'
	static menu_map + #153, #'A'
	static menu_map + #154, #'A'
	static menu_map + #155, #'A'
	static menu_map + #156, #0
	static menu_map + #157, #0
	static menu_map + #158, #0
	static menu_map + #159, #0
	static menu_map + #160, #0
	static menu_map + #161, #0
	static menu_map + #162, #0
	static menu_map + #163, #'A'
	static menu_map + #164, #'A'
	static menu_map + #165, #'A'
	static menu_map + #166, #'A'
	static menu_map + #167, #'A'
	static menu_map + #168, #'A'
	static menu_map + #169, #'A'
	static menu_map + #170, #'A'
	static menu_map + #171, #'A'
	static menu_map + #172, #'A'
	static menu_map + #173, #'A'
	static menu_map + #174, #'A'
	static menu_map + #175, #'A'
	static menu_map + #176, #0
	static menu_map + #177, #0
	static menu_map + #178, #0
	static menu_map + #179, #0
	static menu_map + #180, #0
	static menu_map + #181, #0
	static menu_map + #182, #0
	static menu_map + #183, #'A'
	static menu_map + #184, #'A'
	static menu_map + #185, #'A'
	static menu_map + #186, #'A'
	static menu_map + #187, #'A'
	static menu_map + #188, #'A'
	static menu_map + #189, #'A'
	static menu_map + #190, #'A'
	static menu_map + #191, #'A'
	static menu_map + #192, #'A'
	static menu_map + #193, #'A'
	static menu_map + #194, #'A'
	static menu_map + #195, #'A'
	static menu_map + #196, #0
	static menu_map + #197, #0
	static menu_map + #198, #'B'
	static menu_map + #199, #0
	static menu_map + #200, #'A'
	static menu_map + #201, #0
	static menu_map + #202, #0
	static menu_map + #203, #0
	static menu_map + #204, #'A'
	static menu_map + #205, #'A'
	static menu_map + #206, #'A'
	static menu_map + #207, #'A'
	static menu_map + #208, #'A'
	static menu_map + #209, #'A'
	static menu_map + #210, #'A'
	static menu_map + #211, #'A'
	static menu_map + #212, #'A'
	static menu_map + #213, #'A'
	static menu_map + #214, #'A'
	static menu_map + #215, #0
	static menu_map + #216, #0
	static menu_map + #217, #0
	static menu_map + #218, #'B'
	static menu_map + #219, #'B'
	static menu_map + #220, #'A'
	static menu_map + #221, #'A'
	static menu_map + #222, #0
	static menu_map + #223, #0
	static menu_map + #224, #0
	static menu_map + #225, #'A'
	static menu_map + #226, #'A'
	static menu_map + #227, #'A'
	static menu_map + #228, #'A'
	static menu_map + #229, #'A'
	static menu_map + #230, #'A'
	static menu_map + #231, #'A'
	static menu_map + #232, #'A'
	static menu_map + #233, #'A'
	static menu_map + #234, #0
	static menu_map + #235, #0
	static menu_map + #236, #'B'
	static menu_map + #237, #'B'
	static menu_map + #238, #'B'
	static menu_map + #239, #0
	static menu_map + #240, #0
	static menu_map + #241, #'A'
	static menu_map + #242, #0
	static menu_map + #243, #0
	static menu_map + #244, #0
	static menu_map + #245, #0
	static menu_map + #246, #'A'
	static menu_map + #247, #'A'
	static menu_map + #248, #'A'
	static menu_map + #249, #'A'
	static menu_map + #250, #'A'
	static menu_map + #251, #'A'
	static menu_map + #252, #'A'
	static menu_map + #253, #0
	static menu_map + #254, #0
	static menu_map + #255, #0
	static menu_map + #256, #'B'
	static menu_map + #257, #0
	static menu_map + #258, #0
	static menu_map + #259, #0

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
main:
    call draw_start_menu
    loadn r1, #'z'
    ; esperando o botao de start
    menu_loop:
        inchar r0
        cmp r0, r1
        jeq menu_loop_end
        jmp menu_loop
    menu_loop_end:

    ; inicializando o jogo
    loadn r5, #tile_map
    call draw_map_full
    call print_map_name
    call ini_player_um
    call ini_player_dois
    
    game_loop:
        call update_players
        ; checando se algum player morreu
        loadn r1, #0
        cmp r0, r1
        jne death_state
        call update_bombas

        loadn r0, #1000
        loadn r1, #3
        call delay_um_tempo
        jmp game_loop

    death_state:
        call draw_player_lose
        loadn r1, #'z'  
        death_loop:
            ; esperando pressionar z
            inchar r0
            cmp r0, r1
            jeq death_loop_end
            jmp death_loop

        death_loop_end:
            ; reinicalizando os dados e voltando 
            ; para o jogo
            call remover_player_perdeu
            call restore_tile_map
            loadn r5, #tile_map
            call draw_map_full
            call ini_player_um
            call ini_player_dois
            jmp game_loop
