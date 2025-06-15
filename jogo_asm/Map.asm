;  Esse arquivo inclui o mapa, as tiles pertencetes
; ao mapa e funcoes para interagir com o mapa.

call draw_map_full

@include util.asm
@include mapa.asm

;  Desenha o mapa da linha 5 ate a linha 30, 
; desenhando em cima do que estava la previamente.
;
draw_map_full:
    push r0
    push r1 
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    ; primeiro char da quinta linha da tela
    loadn r2, #200
    loadn r3, #2    ; step horizontal
    loadn r4, #20   ; fim do loop da coluna
    loadn r5, #tile_map   ; endereco da primeira posicao da grid
    loadn r6, #0    ; variavel do lop
    loadn r7, #13   ; limite do loop de linhas

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
        pop r6
        cmp r6, r7 
        jeq draw_map_full_end


    draw_map_full_end:
        pop r7
        pop r6
        pop r5 
        pop r4 
        pop r3 
        pop r2 
        pop r1 
        pop r0
        rts