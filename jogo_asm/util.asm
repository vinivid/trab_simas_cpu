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
	rts