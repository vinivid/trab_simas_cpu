const gridColums = 3
const gridRow = 6

const mapGrid = document.getElementsByClassName('map-block')

function initializeMapGrid() {
    for (let i = 0; i < gridRow; i++) {
        for (let j = 0; j < gridColums; j++) {
            mapGrid[i * gridColums + j]
                .addEventListener("click", (event) => {
                    if (event.target instanceof HTMLElement) {
                        event.target.style.color = "red"
                    }
                })
        }
    }
}

initializeMapGrid()