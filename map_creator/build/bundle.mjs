class y {
  constructor(a) {
    this.selectedTile = a;
  }
  changeSelectedTile(a) {
    this.selectedTile = a;
  }
}
function f(e) {
  const a = {
    t0: "red",
    t1: "blue",
    t2: "white",
    t3: "yellow"
  };
  Array.from(document.getElementsByClassName("tile-block")).forEach((o) => {
    o.addEventListener("click", () => {
      e.changeSelectedTile(a[o.id]);
    });
  });
}
function g(e) {
  Array.from(document.getElementsByClassName("map-block")).forEach((n) => {
    n.addEventListener("mouseover", () => {
      e.isLeftDown && (n.style.backgroundColor = e.selectedTile);
    }), n.addEventListener("mousedown", () => {
      n.style.backgroundColor = e.selectedTile;
    }), n.style.backgroundColor = "white";
  });
}
function w() {
  let e = new y("red");
  return document.addEventListener("mousedown", () => {
    e.isLeftDown = !0;
  }), document.addEventListener("mouseup", () => {
    e.isLeftDown = !1;
  }), f(e), g(e), e;
}
function b(e, a) {
  const n = new Blob(a, { type: "text/plain" }), o = document.createElement("a");
  o.href = URL.createObjectURL(n), o.download = e, o.style.display = "none", document.body.appendChild(o), o.click(), document.body.removeChild(o), URL.revokeObjectURL(o.href);
}
function v() {
  let e = document.getElementById("nam_map").value;
  e.length > 40 && (e = "bomberman"), e = e.toLowerCase();
  let a = 40 - e.length, n = Math.ceil(a / 2);
  const o = `
tile_map_name : string "${e}"
`, _ = `
tile_map_location : var #1
static tile_map_location + #0, #${n}
`, h = Array.from(document.getElementsByClassName("map-block")), s = new Array(
    `;   A tile map representa as tiles do mapa
`,
    `;em uma grid de 20 x 13, para ser utilizada com sprites
`,
    `;2 X 2.
`,
    `tile_map : var #260
`
  ), i = new Array(
    `
; Posicao do player e 1 player 2, em que o offset 0 eh o x e o offset 1 eh o y
`,
    `player_one_ini_pos : var #2
`
  ), r = new Array(
    `

tile_map_og : var #260
`
  );
  let c = 0;
  const m = new Array(), u = new Array(
    `
; Posicao que tem um power up dentro da caixa
`,
    `

tile_map_pu : var #260
`
  ), d = new Array(
    `
; copia dos powrups original
`,
    `

tile_map_pu_og : var #260
`
  );
  h.forEach((l, t) => {
    d.push(`	static tile_map_pu_og + #${t}, #0
`), u.push(`	static tile_map_pu + #${t}, #0
`), l.style.backgroundColor == "red" ? (s.push(`	static tile_map + #${t}, #'A'
`), r.push(`	static tile_map_og + #${t}, #'A'
`)) : l.style.backgroundColor === "blue" ? (m.push(t), s.push(`	static tile_map + #${t}, #'B'
`), r.push(`	static tile_map_og + #${t}, #'B'
`)) : l.style.backgroundColor === "white" ? (s.push(`	static tile_map + #${t}, #0
`), r.push(`	static tile_map_og + #${t}, #0
`)) : l.style.backgroundColor == "yellow" ? (s.push(`	static tile_map + #${t}, #0
`), r.push(`	static tile_map_og + #${t}, #0
`), c == 0 ? (i.push(`	static player_one_ini_pos + #0, #${t % 20}
`), i.push(`	static player_one_ini_pos + #1, #${Math.floor(t / 20)}
`), c += 1) : c == 1 && (i.push(`player_two_ini_pos : var #2
`), i.push(`	static player_two_ini_pos + #0, #${t % 20}
`), i.push(`	static player_two_ini_pos + #1, #${Math.floor(t / 20)}
`), c += 1)) : console.log("invalid color");
  });
  for (let l = 1; l <= 4; l++) {
    var p = m[Math.floor(Math.random() * m.length)];
    u[p + 2] = `	static tile_map_pu + #${p}, #1
`, d[p + 2] = `	static tile_map_pu_og + #${p}, #1
`;
  }
  b("mapa.asm", s.concat(i).concat(r).concat(o).concat(_).concat(u).concat(d));
}
function E() {
  document.getElementById("download-map").addEventListener("click", () => v());
}
w();
E();
