# Adapted from Arch Linux cbindgen PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/cbindgen/trunk/PKGBUILD

require 'buildsystems/rust'

class Cbindgen < RUST
  description 'A tool for generating C bindings to Rust code'
  homepage 'https://github.com/eqrion/cbindgen'
  version '0.29.2'
  license 'MPL2'
  compatibility 'all'
  source_url 'https://github.com/eqrion/cbindgen.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8af4b7ea672d356f40a932d46fd1d90cd76654e26680d5c2d9d025d72b540eea',
     armv7l: '8af4b7ea672d356f40a932d46fd1d90cd76654e26680d5c2d9d025d72b540eea',
       i686: 'd48fd6f06e25120ffe9eca3705b1c60432ed0f1a16eb385268df1fb9d74753fc',
     x86_64: '33e2838b0e6d5730c71f3ab8a7a77008e5557cf03e1c7083d2169dc8177a9d1b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
