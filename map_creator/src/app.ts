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

/* Representa um tile do jogo
*/
class Tile {
    htmlComp : HTMLElement;
    pos      : readonly [number, number];
    tile     : string;

    constructor(component : HTMLElement, pos : [number, number], tile : string) {
        this.htmlComp = component
        this.pos = pos
        this.tile = tile
    }

    changeTile(tile : string) {
        this.htmlComp.style.background = tile
        this.tile = tile
    }
}

/* Inicia os blocos da grid de selecao, de forma que 
ao clicar em qualquer um dos blocos a tile selecionada
mudara
*/
function initSelectorGrid(mouse : MouseSelector) : Tile[] {
    // Esse map representa os dados de cada tile no seletor
    // onde a chave e o id na grid de selecao
    const selectGridTiles = {
        't0' : 'red',
        't1' : 'blue',
        't2' : 'white'
    }

    const gridRows = 3
    const htmlMapGrid = document.getElementsByClassName('tile-block')
    const selecTiles = new Array<Tile>()

    for (let i = 0; i < gridRows; i++) {
        const currGridElem = htmlMapGrid[i] as HTMLElement
        const currTile = new Tile(currGridElem, [0, i], 'red')

        currGridElem.addEventListener('click', () => {
            mouse.changeSelectedTile(selectGridTiles[currGridElem.id])
        })

        selecTiles.push(currTile)
    }

    return selecTiles
}

/* Inicia cada bloco da grid do mapa com os eventos
necessarios para mudar a tile do mapa com base na tile
selecionada.
*/
function initMapGrid(mouse : MouseSelector) : Tile[] {
    //Tamanho da tela do jogo
    const gridColums = 40
    const gridRows   = 30

    const htmlMapGrid = document.getElementsByClassName('map-block')
    const mapTiles = new Array<Tile>()

    for (let i = 0; i < gridRows; i++) {
        for (let j = 0; j < gridColums; j++) {
            const currGridElem = htmlMapGrid[i * gridColums + j] as HTMLElement
            const currTile = new Tile(currGridElem, [i, j], 'red')

            // Se o usuario esta segurando o mouse e o mouse passa por cima
            // do tile coloca o que esta selecionado
            currGridElem.addEventListener('mouseover', () => {
                if (mouse.isLeftDown) {
                    currTile.changeTile(mouse.selectedTile)
                    console.log(`is on ${i} ${j}`)
                }
            })

            // Se o usuario clicou no tile coloca o que esta selecionado
            currGridElem.addEventListener('mousedown', () => {
                currTile.changeTile(mouse.selectedTile)
                console.log(`is on ${i} ${j}`)
            })

            mapTiles.push(currTile)
        }
    }

    return mapTiles
}

/* Inicia as grids necessarias para criar um mapa e a classe 
que idica qual valor es selecionado no momento
*/
function initMapCreator() : [MouseSelector, Tile[], Tile[]]{
    let mouse = new MouseSelector('red')

    // É necesssario guardar se o usuario esta clicando
    // o mouse para ser possiver segurar e colocar tiles
    document.addEventListener('mousedown', () => {
        mouse.isLeftDown = true
    })

    document.addEventListener('mouseup', () => {
        mouse.isLeftDown = false
    })

    let selectGrid = initSelectorGrid(mouse)
    let mapGrid = initMapGrid(mouse)

    return [mouse, selectGrid, mapGrid]
}

let mapTiles = initMapCreator()