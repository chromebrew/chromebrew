# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD
# NOTE: This package should be updated along with new Rust releases.

require 'buildsystems/rust'

class Cargo_c < RUST
  description 'A cargo subcommand to build and install C-ABI compatible dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version "0.10.24-#{CREW_RUST_VER}"
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5aa43b31b471aef85e1ca754bd98a4c35f8d59724afc83fe7d419887f731f4b8',
     armv7l: '5aa43b31b471aef85e1ca754bd98a4c35f8d59724afc83fe7d419887f731f4b8',
       i686: '2f7a54425ba6d5b2fc05b39e83ccd1ad16f5d3a2d481e5b19e212dfd360d44bd',
     x86_64: '2bc6c9037150e40bac115c3ef852414813cad961df7696decd2523f22352264b'
  })

  depends_on 'curl' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
  depends_on 'rust' => :build
  depends_on 'zlib' => :executable
end
