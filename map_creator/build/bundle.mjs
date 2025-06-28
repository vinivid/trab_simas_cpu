class i {
  constructor(a) {
    this.selectedTile = a;
  }
  changeSelectedTile(a) {
    this.selectedTile = a;
  }
}
function r(e) {
  const a = {
    t0: "red",
    t1: "blue",
    t2: "white",
    t3: "yellow"
  };
  Array.from(document.getElementsByClassName("tile-block")).forEach((t) => {
    t.addEventListener("click", () => {
      e.changeSelectedTile(a[t.id]);
    });
  });
}
function c(e) {
  Array.from(document.getElementsByClassName("map-block")).forEach((o) => {
    o.addEventListener("mouseover", () => {
      e.isLeftDown && (o.style.backgroundColor = e.selectedTile);
    }), o.addEventListener("mousedown", () => {
      o.style.backgroundColor = e.selectedTile;
    }), o.style.backgroundColor = "white";
  });
}
function p() {
  let e = new i("red");
  return document.addEventListener("mousedown", () => {
    e.isLeftDown = !0;
  }), document.addEventListener("mouseup", () => {
    e.isLeftDown = !1;
  }), r(e), c(e), e;
}
function d(e, a) {
  const o = new Blob(a, { type: "text/plain" }), t = document.createElement("a");
  t.href = URL.createObjectURL(o), t.download = e, t.style.display = "none", document.body.appendChild(t), t.click(), document.body.removeChild(t), URL.revokeObjectURL(t.href);
}
function m() {
  const e = Array.from(document.getElementsByClassName("map-block")), a = new Array(
    `;   A tile map representa as tiles do mapa
`,
    `;em uma grid de 20 x 13, para ser utilizada com sprites
`,
    `;2 X 2.
`,
    `tile_map : var #260
`
  ), o = new Array(
    `
; Posicao do player e 1 player 2, em que o offset 0 eh o x e o offset 1 eh o y
`,
    `player_one_ini_pos : var #2
`
  ), t = new Array(
    `

tile_map_og : var #260
`
  );
  let s = 0;
  e.forEach((n, l) => {
    n.style.backgroundColor == "red" ? (a.push(`	static tile_map + #${l}, #'A'
`), t.push(`	static tile_map_og + #${l}, #'A'
`)) : n.style.backgroundColor === "blue" ? (a.push(`	static tile_map + #${l}, #'B'
`), t.push(`	static tile_map_og + #${l}, #'B'
`)) : n.style.backgroundColor === "white" ? (a.push(`	static tile_map + #${l}, #0
`), t.push(`	static tile_map_og + #${l}, #0
`)) : n.style.backgroundColor == "yellow" ? (a.push(`	static tile_map + #${l}, #0
`), t.push(`	static tile_map_og + #${l}, #0
`), s == 0 ? (o.push(`	static player_one_ini_pos + #0, #${l % 20}
`), o.push(`	static player_one_ini_pos + #1, #${Math.floor(l / 20)}
`), s += 1) : s == 1 && (o.push(`player_two_ini_pos : var #2
`), o.push(`	static player_two_ini_pos + #0, #${l % 20}
`), o.push(`	static player_two_ini_pos + #1, #${Math.floor(l / 20)}
`), s += 1)) : console.log("invalid color");
  }), d("mapa.asm", a.concat(o).concat(t));
}
function u() {
  document.getElementById("download-map").addEventListener("click", () => m());
}
p();
u();
