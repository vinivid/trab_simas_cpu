;////////////////////////////////////////////////////
;
;          ////////////////////
;         // BOMBER SIMAS ! //
;        ////////////////////
;
;       uma contribuição de:
;       - João Daffele Dias ()
;       - Renan Banci Catarin ()
;       - Glauco Fleury Corrêa de Moraes (15456302)
;       - Murilo Leandro Garcia ()
;       - Rodrigo Silva de Almeida ()
;       - Vitor Daniel Resende ()
;       - Vinicius Souza Freitas ()
;
;//////////////////////////////////////////////////
;
;         // DECLARAÇÃO DOS DADOS & FRAMES //
;
;//////////////////////////////////////////////////

jmp main
;------------------------------------------------

; => Posição dos personagens: 4 variáveis para cada, sendo
;    2 para a atual, 2 para a anterior

; => Direção: 2 variáveis para cada, 1 para a anterior,
;    1 para a atual
;    (UP = 0, RIGHT = 4, DOWN = 8, LEFT = 12)

; => Cor: player 1 é amarelo, e o 2, verde

; => Vida: cada player nasce com 1 vida apenas

; => Especial: cada player nasce com 0 por default

; => Bomba/Mega-Bomba: caractere que marca a localização
;    da posição da bomba que o player soltou no mapa

;  -----------------PLAYER 1--------------------
;posição
pos1P1 : var #1
posPre1P1 : var #1
pos2P1 : var #1
posPre2P1 : var #1
;direção
dirP1: var #1
dirPreP1: var #1
;bomba
bombP1: var #1
;vida
lifeP1: var #1
;especial
especialP1: var #1
;cor
corP1: var #1
	static corTanque1 + #0, #2816

;  -----------------PLAYER 2--------------------
;posição
pos1P2 : var #1
posPre1P12 : var #1
pos2P2 : var #1
posPre2P2 : var #1
;direção
dirP2: var #1
dirPreP2: var #1
;bomba
bombP2: var #1
;vida
lifeP2: var #1
;especial
especialP2: var #1
;cor
corP2: var #1
	static corTanque1 + #0, #2816 ;como mudar para azul?

;
;INSERIR MAPA, EXPLOSÕES, CANHÃO -> fazer com que o player escolha!
;fazer 1 "mapa" pra cada cor disponível (é assim pra fpga)


;//////////////////////////////////////////////////
;
;         // LÓGICA PRINCIPAL: CÓDIGO //
;
;//////////////////////////////////////////////////

main:
    ;dando clean na tela
    call CleanScreen
    ;printando o menu
    call PrintMenu1
    call PrintMenu2
    call PrintMenu3

Main_Loop:
    ;tela inicial: ir pra 'Comandos' ou iniciar o game
    loadn r1, #' ' ;tecla SPACE -> começar
    loadn r2, #13 ;tecla ENTER -> commands
    inchar r3
    cmp r2, r3
    jeq PrintCommands
    cmp r1, r3
    jneq Main_Loop

    ;iniciando o game

    call CleanScreen

    call PrintMargin
    call PrintHearts
    call PrintBombs
    call PrintText
    call PrintBlocks

    call SpawnPlayer1
    call SpawnPlayer2

    loadn r0, #0 ;counter pra atualizar as coisas

    Sub_Loop:
        ;o jogo em si
        call UpdatePlayers ;atualizar de 4 em 4
        call UpdateBombs ;atualizar de 8 em 8
        call UpdateCanon ;atualizar de 1 em 1

        call Delay
        
        inc r0 ;loop incrementado
        jmp Sub_Loop

    halt




