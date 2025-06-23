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
		rts