class a {
  constructor(l) {
    this.selectedTile = l;
  }
  changeSelectedTile(l) {
    this.selectedTile = l;
  }
}
function i(e) {
  const l = {
    t0: "red",
    t1: "blue",
    t2: "white",
    t3: "yellow"
  };
  Array.from(document.getElementsByClassName("tile-block")).forEach((o) => {
    o.addEventListener("click", () => {
      e.changeSelectedTile(l[o.id]);
    });
  });
}
function r(e) {
  Array.from(document.getElementsByClassName("map-block")).forEach((t) => {
    t.addEventListener("mouseover", () => {
      e.isLeftDown && (t.style.backgroundColor = e.selectedTile);
    }), t.addEventListener("mousedown", () => {
      t.style.backgroundColor = e.selectedTile;
    }), t.style.backgroundColor = "white";
  });
}
function c() {
  let e = new a("red");
  return document.addEventListener("mousedown", () => {
    e.isLeftDown = !0;
  }), document.addEventListener("mouseup", () => {
    e.isLeftDown = !1;
  }), i(e), r(e), e;
}
function d(e, l) {
  const t = new Blob(l, { type: "text/plain" }), o = document.createElement("a");
  o.href = URL.createObjectURL(t), o.download = e, o.style.display = "none", document.body.appendChild(o), o.click(), document.body.removeChild(o), URL.revokeObjectURL(o.href);
}
function p() {
  const e = Array.from(document.getElementsByClassName("map-block")), l = new Array(
    `;   A tile map representa as tiles do mapa
`,
    `;em uma grid de 20 x 13, para ser utilizada com sprites
`,
    `;2 X 2.
`,
    `tile_map : var #260
`
  ), t = new Array(
    `
; Posicao do player e 1 player 2, em que o offset 0 eh o x e o offset 1 eh o y
`,
    `player_one_ini_pos : var #2
`
  );
  let o = 0;
  e.forEach((s, n) => {
    s.style.backgroundColor == "red" ? l.push(`	static tile_map + #${n}, #'A'
`) : s.style.backgroundColor === "blue" ? l.push(`	static tile_map + #${n}, #'B'
`) : s.style.backgroundColor === "white" ? l.push(`	static tile_map + #${n}, #0
`) : s.style.backgroundColor == "yellow" ? (l.push(`	static tile_map + #${n}, #'A'
`), o == 0 ? (t.push(`	static player_one_ini_pos + #0, #${n % 20}
`), t.push(`	static player_one_ini_pos + #1, #${Math.floor(n / 20)}
`), o += 1) : o == 1 && (t.push(`player_two_ini_pos : var #2
`), t.push(`	static player_two_ini_pos + #0, #${n % 20}
`), t.push(`	static player_two_ini_pos + #1, #${Math.floor(n / 20)}
`), o += 1)) : console.log("invalid color");
  }), d("mapa.asm", l.concat(t));
}
function m() {
  document.getElementById("download-map").addEventListener("click", () => p());
}
c();
m();
