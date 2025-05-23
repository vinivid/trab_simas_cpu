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
;
;  O mapa iria disponibilazr funcoes que checam se 
; se o valor em uma posicao eh uma parede, uma bomba 
; e outros assim como funcoes de desenhar tiles do mapa 
; e o mapa inteiro no buffer da gpu.
;
;  Em essencia o o objetivo do mapa e abstrair desenhar 
; as tiles e a checagem de tile para os usuarios.
