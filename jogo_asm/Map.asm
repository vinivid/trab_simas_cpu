; Explicacao da ideia para fazer o mapa
;
;   A ideia do mapa e separar o que deve 
; ser desenhado do cenario, com as caracteristicas
; de cada tile, de forma a ser mais legivel 
; e modularizado.
;   Porque nao fazer o mapa diretamente na 
; memoria de video? R: Como esta sendo feito
; que cada tile eh 2x2 teriam possibilidades
; de mais para checar se e uma tile especifica,
; com o objetivo de simplificar essas checagens
; eu sugiro fazer uma parte do mapa que e a jogavel
; e a partir dela voce pode desenhar as tiles correspondentes
; no local desejado.
;
;   O mapa tem um buffer principal que eh o tile map 
; cada tile eh representado por um inteiro, por exemplo, 
; o 1 representa um tile de parede, o 2 representa um tile 
; de de bloco quebravel, o 3 representa uma explosao da 
; bomba direita e etc.

;   O map buffer eh um vetor que ira repsentar os tiles do mapa.
map_buffer : var #208

;  Variaveis que representam as dimensoes do mapa
; para conveniencia
map_width  : var #16
map_heigth : var #13
