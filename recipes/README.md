# Receitas Kalyx

Receitas sao scripts shell pequenos usados por `scripts/pkg-build`.

Exemplo minimo:

```bash
pkg_name="zlib"
pkg_version="1.3.1"
source_url="https://zlib.net/fossils/zlib-1.3.1.tar.xz"
source_sha256="38ef96b8dfe510d42707d9c781877914792541133e1870841463bfa73f883e32"

build() {
  cd "$srcdir/zlib-1.3.1"
  ./configure --prefix=/usr
  make
}

package() {
  cd "$srcdir/zlib-1.3.1"
  make DESTDIR="$pkgdir" install
}
```

Fases planejadas:

- `toolchain`: compiladores, binutils e ferramentas temporarias;
- `base`: sistema minimo bootavel;
- `desktop`: XFCE, NetworkManager, audio e apps essenciais.
