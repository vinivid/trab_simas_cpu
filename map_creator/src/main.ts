/* Essa classe é um wrapper da tile que esta selecionado
no momento, que serve para interagir com os outros componentes
*/
class MouseSelector {
    selectedTile : string
    isLeftDown   : boolean

    constructor(initTile : string) {
        this.selectedTile = initTile
    }

    changeSelectedTile(tile : string) {
        this.selectedTile = tile
    }
}

/* Inicia os blocos da grid de selecao, de forma que 
ao clicar em qualquer um dos blocos a tile selecionada
mudara
*/
function initSelectorGrid(mouse : MouseSelector) {
    // Esse map representa os dados de cada tile no seletor
    // onde a chave e o id na grid de selecao
    const selectGridTiles = {
        't0' : 'red',
        't1' : 'blue',
        't2' : 'white',
        't3' : 'yellow'
    }

    const htmlSelectGrid = Array.from(document.getElementsByClassName('tile-block')) as HTMLElement[]

    htmlSelectGrid.forEach((ele) => {
        ele.addEventListener('click', () => {
            mouse.changeSelectedTile(selectGridTiles[ele.id])
        })
    })
}

function initMapGrid(mouse : MouseSelector) {
    const gridElems = Array.from(document.getElementsByClassName('map-block')) as HTMLElement[]
    gridElems.forEach((ele) => {
        ele.addEventListener('mouseover', () => {
            if (mouse.isLeftDown) {
                ele.style.backgroundColor = mouse.selectedTile
            }
        })

        ele.addEventListener('mousedown', () => {
            ele.style.backgroundColor = mouse.selectedTile
        })

        ele.style.backgroundColor = 'white'
    })
}

/* Inicia as grids necessarias para criar um mapa e a classe 
que idica qual valor es selecionado no momento
*/
function initMapCreator() : MouseSelector{
    let mouse = new MouseSelector('red')

    // É necesssario guardar se o usuario esta clicando
    // o mouse para ser possiver segurar e colocar tiles
    document.addEventListener('mousedown', () => {
        mouse.isLeftDown = true
    })

    document.addEventListener('mouseup', () => {
        mouse.isLeftDown = false
    })

    initSelectorGrid(mouse)
    initMapGrid(mouse)

    return mouse
}

function downloadFile(filename : string, contents : string[]) {
    const fileBlob = new Blob(contents, {type: 'text/plain'})
    const dowloadElem = document.createElement('a')
    dowloadElem.href  = URL.createObjectURL(fileBlob)
    dowloadElem.download = filename
    dowloadElem.style.display = 'none'

    document.body.appendChild(dowloadElem)
    dowloadElem.click()
    document.body.removeChild(dowloadElem)

    URL.revokeObjectURL(dowloadElem.href)
}

function gridTilesToFile() {
    const htmlMapGrid = Array.from(document.getElementsByClassName('map-block')) as HTMLElement[]
    const tileMapAsm : string[] = new Array(';   A tile map representa as tiles do mapa\n',
        ';em uma grid de 20 x 13, para ser utilizada com sprites\n',
        ';2 X 2.\n',
        'tile_map : var #260\n'
    )

    const players_pos : string[] = new Array('\n; Posicao do player e 1 player 2, em que o offset 0 eh o x e o offset 1 eh o y\n',
        'player_one_ini_pos : var #2\n'
    )

    htmlMapGrid.forEach((ele, id) => {
        if(ele.style.backgroundColor == 'red') {
            tileMapAsm.push(`\tstatic tile_map + #${id}, #'A'\n`)
        } else if (ele.style.backgroundColor === 'blue') {
            tileMapAsm.push(`\tstatic tile_map + #${id}, #1\n`)
        } else if (ele.style.backgroundColor === 'white') {
            tileMapAsm.push(`\tstatic tile_map + #${id}, #0\n`)
        }
        else if (ele.style.backgroundColor == 'yellow') {
            tileMapAsm.push(`\tstatic tile_map + #${id}, #'A'\n`)
            players_pos.push(`\tstatic player_one_ini_pos + #1, #${id % 20}\n`)
            players_pos.push(`\tstatic player_one_ini_pos + #0, #${Math.floor(id / 20)}\n`)
        } else {
            console.log('invalid color')
        }
    })

    downloadFile('mapa.asm', tileMapAsm.concat(players_pos))
}

function initExportButton() {
    document.getElementById('download-map')!
        .addEventListener('click', () => gridTilesToFile())
}

let mapTiles = initMapCreator()
initExportButton()