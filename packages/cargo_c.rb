# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD
# NOTE: This package should be updated along with new Rust releases.

require 'buildsystems/rust'

class Cargo_c < RUST
  description 'A cargo subcommand to build and install C-ABI compatible dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version '0.10.20+cargo-0.94.0'
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '508bd6cd29beb51a6031077fc797ceb14de2b54aaaef3aabcd2009467ef51c14',
     armv7l: '508bd6cd29beb51a6031077fc797ceb14de2b54aaaef3aabcd2009467ef51c14',
       i686: '79a4f693895c39f8beffbf6425aa6467a59aaedcab04163793d48d5d937d1c43',
     x86_64: '1f193eca5b477ebd37e6250a623560b9b232e9f5832659df13dd8a3cf5bc72fc'
  })

  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'rust' => :build
  depends_on 'zlib' # R
end
