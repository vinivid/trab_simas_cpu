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
function s(e) {
  Array.from(document.getElementsByClassName("map-block")).forEach((o) => {
    o.addEventListener("mouseover", () => {
      e.isLeftDown && (o.style.backgroundColor = e.selectedTile);
    }), o.addEventListener("mousedown", () => {
      o.style.backgroundColor = e.selectedTile;
    }), o.style.backgroundColor = "white";
  });
}
function a() {
  let e = new l("red");
  return document.addEventListener("mousedown", () => {
    e.isLeftDown = !0;
  }), document.addEventListener("mouseup", () => {
    e.isLeftDown = !1;
  }), i(e), s(e), e;
}
function r(e, t) {
  const o = new Blob(t, { type: "text/plain" }), n = document.createElement("a");
  n.href = URL.createObjectURL(o), n.download = e, n.style.display = "none", document.body.appendChild(n), n.click(), document.body.removeChild(n), URL.revokeObjectURL(n.href);
}
function c() {
  const e = Array.from(document.getElementsByClassName("map-block")), t = new Array(
    `;   A tile map representa as tiles do mapa
`,
    `;em uma grid de 20 x 13, para ser utilizada com sprites
`,
    `;2 X 2.
`,
    `tile_map : var #260
`
  );
  e.forEach((o, n) => {
    o.style.backgroundColor == "red" ? t.push(`	static tile_map + #${n}, #'A'
`) : o.style.backgroundColor === "blue" ? t.push(`	static tile_map + #${n}, #1
`) : o.style.backgroundColor === "white" ? t.push(`	static tile_map + #${n}, #2
`) : console.log("invalid color");
  }), t.forEach((o) => console.log(o)), r("mapa.asm", t);
}
function d() {
  document.getElementById("download-map").addEventListener("click", () => c());
}
a();
d();
