# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD
# NOTE: This package should be updated along with new Rust releases.

require 'buildsystems/rust'

class Cargo_c < RUST
  description 'A cargo subcommand to build and install C-ABI compatible dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version '0.10.14'
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '928c7aba982ee2bd9e9c3852cb8a3afee2ae6ac6a312ad388bade1d88e211ba8',
     armv7l: '928c7aba982ee2bd9e9c3852cb8a3afee2ae6ac6a312ad388bade1d88e211ba8',
       i686: '718ce19f3c72d4f24dc091c94d5213efbcc470829df2548d0f6d67f58067be79',
     x86_64: 'c6ef004c68fe0077d4a8d43f58a035c6c0389020cb74b485f757d006abb9f173'
  })

  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'rust' => :build
  depends_on 'zlib' # R


end
