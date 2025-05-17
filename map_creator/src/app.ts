class MouseSelector {
    selectedTile : string

    constructor(initTile : string) {
        this.selectedTile = initTile
    }

    changeSelectedTile(tile : string) {
        this.selectedTile = tile
    }
}

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
        this.htmlComp.style.color = tile
        this.tile = tile
    }
}

const gridColums = 3
const gridRow = 6

const selectGridColums = 3

function initSelectorGrid(mouse : MouseSelector) : Tile[] {
    const htmlMapGrid = document.getElementsByClassName('tile-cell')
    const selecTiles = new Array<Tile>()

    for (let i = 0; i < 3; i++) {
        const currGridElem = htmlMapGrid[i] as HTMLElement
        const currTile = new Tile(currGridElem, [i, 0], 'red')

        if (i == 0) {
            currGridElem.addEventListener('click', () => {
                mouse.changeSelectedTile('red')
            })
        } else if (i == 1) {
            currGridElem.addEventListener('click', () => {
                mouse.changeSelectedTile('blue')
            })
        } else {
            currGridElem.addEventListener('click', () => {
                mouse.changeSelectedTile('green')
            })
        }
    }

    return selecTiles
}

function initMapGrid(mouse : MouseSelector) : Tile[] {
    const htmlMapGrid = document.getElementsByClassName('map-block')
    const mapTiles = new Array<Tile>()

    for (let i = 0; i < gridRow; i++) {
        for (let j = 0; j < gridColums; j++) {
            const currGridElem = htmlMapGrid[i * gridColums + j] as HTMLElement
            const currTile = new Tile(currGridElem, [i, j], 'red')

            currTile.htmlComp.addEventListener('click', () => {currTile.changeTile(mouse.selectedTile)})

            mapTiles.push(currTile)
        }
    }

    return mapTiles
}

function initMapCreator() : [MouseSelector, Tile[], Tile[]]{
    let mouse = new MouseSelector('red')
    let selectGrid = initSelectorGrid(mouse)
    let mapGrid = initMapGrid(mouse)

    return [mouse, selectGrid, mapGrid]
}

let mapTiles = initMapCreator()