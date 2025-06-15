class l {
  constructor(t) {
    this.selectedTile = t;
  }
  changeSelectedTile(t) {
    this.selectedTile = t;
  }
}
function i(e) {
  const t = {
    t0: "red",
    t1: "blue",
    t2: "white"
  };
  Array.from(document.getElementsByClassName("tile-block")).forEach((n) => {
    n.addEventListener("click", () => {
      e.changeSelectedTile(t[n.id]);
    });
  });
}
function r(e) {
  Array.from(document.getElementsByClassName("map-block")).forEach((o) => {
    o.addEventListener("mouseover", () => {
      e.isLeftDown && (o.style.backgroundColor = e.selectedTile);
    }), o.addEventListener("mousedown", () => {
      o.style.backgroundColor = e.selectedTile;
    }), o.style.backgroundColor = "white";
  });
}
function s() {
  let e = new l("red");
  return document.addEventListener("mousedown", () => {
    e.isLeftDown = !0;
  }), document.addEventListener("mouseup", () => {
    e.isLeftDown = !1;
  }), i(e), r(e), e;
}
function d(e, t) {
  const o = new Blob(t, { type: "text/plain" }), n = document.createElement("a");
  n.href = URL.createObjectURL(o), n.download = e, n.style.display = "none", document.body.appendChild(n), n.click(), document.body.removeChild(n), URL.revokeObjectURL(n.href);
}
function c() {
  const e = Array.from(document.getElementsByClassName("map-block")), t = new Array(
    `;   A tile grid representa as tiles do mapa
`,
    `;em uma grid de 16 x 13, para ser utilizada com sprites
`,
    `;2 X 2
`,
    `tile_grid:
`
  );
  e.forEach((o, n) => {
    o.style.backgroundColor ? t.push(`	static tile_grid + #${n}, #0
`) : o.style.backgroundColor === "blue" ? t.push(`	static tile_grid + #${n}, #1
`) : o.style.backgroundColor === "white" ? t.push(`	static tile_grid + #${n}, #2
`) : console.log("invalid color");
  }), t.forEach((o) => console.log(o)), d("mapa.asm", t);
}
function a() {
  document.getElementById("download-map").addEventListener("click", () => c());
}
s();
a();
