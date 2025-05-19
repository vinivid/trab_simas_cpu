import sys

"""Funcionamento:
Inclui todos os conteudos do arquivo no primeiro argumento para 
o arquivo do segundo argumento.

No arquivo para incluir o conteudo é necessario escrever

@include "nome do arquivo"

sem as aspas e sem nenhum conteudo a mais ou comentarios
Ele recusivamente inclui o conteudo para incluir nos outros
arquivos

ex:

py ./include.py SimasBomber.asm final.asm
"""

def giga_copy(f : str, inc_dict : dict[str, bool]) -> str :
    if f in inc_dict:
        return ""

    inc_dict.update({f : True})
    file_contents = []
    with open(f, 'r') as fr:
        for line in fr:
            content = line.split(' ')

            if content[0].lstrip() == '@include':
                file_contents.append(giga_copy(content[1].rstrip(), inc_dict))
            else:
                file_contents.append(line)
    
    return ''.join(file_contents)

def recurse_include(f : str) -> str:
    return giga_copy(f, {})
    
args = sys.argv

with open(args[2], 'w') as fw:
    fw.write(recurse_include(args[1]))