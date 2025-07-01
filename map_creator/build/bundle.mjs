class d {
  constructor(a) {
    this.selectedTile = a;
  }
  changeSelectedTile(a) {
    this.selectedTile = a;
  }
}
function u(e) {
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
function _(e) {
  Array.from(document.getElementsByClassName("map-block")).forEach((l) => {
    l.addEventListener("mouseover", () => {
      e.isLeftDown && (l.style.backgroundColor = e.selectedTile);
    }), l.addEventListener("mousedown", () => {
      l.style.backgroundColor = e.selectedTile;
    }), l.style.backgroundColor = "white";
  });
}
function h() {
  let e = new d("red");
  return document.addEventListener("mousedown", () => {
    e.isLeftDown = !0;
  }), document.addEventListener("mouseup", () => {
    e.isLeftDown = !1;
  }), u(e), _(e), e;
}
function y(e, a) {
  const l = new Blob(a, { type: "text/plain" }), t = document.createElement("a");
  t.href = URL.createObjectURL(l), t.download = e, t.style.display = "none", document.body.appendChild(t), t.click(), document.body.removeChild(t), URL.revokeObjectURL(t.href);
}
function f() {
  let e = document.getElementById("nam_map").value;
  e.length > 40 && (e = "bomberman");
  let a = 40 - e.length, l = Math.ceil(a / 2);
  const t = `
tile_map_name : string "${e}"
`, p = `
tile_map_location : var #1
static tile_map_location + #0, #${l}
`, m = Array.from(document.getElementsByClassName("map-block")), i = new Array(
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
  ), s = new Array(
    `

tile_map_og : var #260
`
  );
  let c = 0;
  m.forEach((r, o) => {
    r.style.backgroundColor == "red" ? (i.push(`	static tile_map + #${o}, #'A'
`), s.push(`	static tile_map_og + #${o}, #'A'
`)) : r.style.backgroundColor === "blue" ? (i.push(`	static tile_map + #${o}, #'B'
`), s.push(`	static tile_map_og + #${o}, #'B'
`)) : r.style.backgroundColor === "white" ? (i.push(`	static tile_map + #${o}, #0
`), s.push(`	static tile_map_og + #${o}, #0
`)) : r.style.backgroundColor == "yellow" ? (i.push(`	static tile_map + #${o}, #0
`), s.push(`	static tile_map_og + #${o}, #0
`), c == 0 ? (n.push(`	static player_one_ini_pos + #0, #${o % 20}
`), n.push(`	static player_one_ini_pos + #1, #${Math.floor(o / 20)}
`), c += 1) : c == 1 && (n.push(`player_two_ini_pos : var #2
`), n.push(`	static player_two_ini_pos + #0, #${o % 20}
`), n.push(`	static player_two_ini_pos + #1, #${Math.floor(o / 20)}
`), c += 1)) : console.log("invalid color");
  }), y("mapa.asm", i.concat(n).concat(s).concat(t).concat(p));
}
function g() {
  document.getElementById("download-map").addEventListener("click", () => f());
}
h();
g();
