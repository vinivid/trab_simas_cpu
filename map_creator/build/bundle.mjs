class s {
  constructor(o) {
    this.selectedTile = o;
  }
  changeSelectedTile(o) {
    this.selectedTile = o;
  }
}
function a(e) {
  const o = {
    t0: "red",
    t1: "blue",
    t2: "white",
    t3: "yellow"
  };
  Array.from(document.getElementsByClassName("tile-block")).forEach((t) => {
    t.addEventListener("click", () => {
      e.changeSelectedTile(o[t.id]);
    });
  });
}
function i(e) {
  Array.from(document.getElementsByClassName("map-block")).forEach((n) => {
    n.addEventListener("mouseover", () => {
      e.isLeftDown && (n.style.backgroundColor = e.selectedTile);
    }), n.addEventListener("mousedown", () => {
      n.style.backgroundColor = e.selectedTile;
    }), n.style.backgroundColor = "white";
  });
}
function r() {
  let e = new s("red");
  return document.addEventListener("mousedown", () => {
    e.isLeftDown = !0;
  }), document.addEventListener("mouseup", () => {
    e.isLeftDown = !1;
  }), a(e), i(e), e;
}
function c(e, o) {
  const n = new Blob(o, { type: "text/plain" }), t = document.createElement("a");
  t.href = URL.createObjectURL(n), t.download = e, t.style.display = "none", document.body.appendChild(t), t.click(), document.body.removeChild(t), URL.revokeObjectURL(t.href);
}
function d() {
  const e = Array.from(document.getElementsByClassName("map-block")), o = new Array(
    `;   A tile map representa as tiles do mapa
`,
    `;em uma grid de 20 x 13, para ser utilizada com sprites
`,
    `;2 X 2.
`,
    `tile_map : var #260
`
  ), n = new Array(
    `
; Posicao do player e 1 player 2, em que o offset 0 eh o x e o offset 1 eh o y
`,
    `player_one_ini_pos : var #2
`
  );
  e.forEach((t, l) => {
    t.style.backgroundColor == "red" ? o.push(`	static tile_map + #${l}, #'A'
`) : t.style.backgroundColor === "blue" ? o.push(`	static tile_map + #${l}, #1
`) : t.style.backgroundColor === "white" ? o.push(`	static tile_map + #${l}, #0
`) : t.style.backgroundColor == "yellow" ? (o.push(`	static tile_map + #${l}, #'A'
`), n.push(`	static player_one_ini_pos + #1, #${l % 20}
`), n.push(`	static player_one_ini_pos + #0, #${Math.floor(l / 20)}
`)) : console.log("invalid color");
  }), c("mapa.asm", o.concat(n));
}
function m() {
  document.getElementById("download-map").addEventListener("click", () => d());
}
r();
m();
