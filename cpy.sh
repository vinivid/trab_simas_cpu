#!/bin/bash

# Muda para o diretório do jogo
cd ./jogo_asm || exit

# Executa o script Python para combinar os arquivos ASM
python3 ./include.py ./SimasBomber.asm ../Build/tudo.asm

cd ..