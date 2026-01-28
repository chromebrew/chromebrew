# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD
# NOTE: This package should be updated along with new Rust releases.

require 'buildsystems/rust'

class Cargo_c < RUST
  description 'A cargo subcommand to build and install C-ABI compatible dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version "0.10.20-#{CREW_RUST_VER}"
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6a2ac5bf372a64530f61c0c5998f80bbafdec8c9caa5c900b697314499a83e6',
     armv7l: 'a6a2ac5bf372a64530f61c0c5998f80bbafdec8c9caa5c900b697314499a83e6',
       i686: '62368f476dbe177012e1208625f5f582294ed7edb40fb8e0c4171dd5e698f972',
     x86_64: 'fd535c8b73c0afc1a18dad72899defef139bb97bbb5227db841fb5429259e8c6'
  })

  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'rust' => :build
  depends_on 'zlib' # R
end
