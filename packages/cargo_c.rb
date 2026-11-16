# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD
# NOTE: This package should be updated along with new Rust releases.

require 'buildsystems/rust'

class Cargo_c < RUST
  description 'A cargo subcommand to build and install C-ABI compatible dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version "0.10.27-#{CREW_RUST_VER}"
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7a2958770df4776d1186bee4d00455c8f7719020df7a9f3234b4c0dcbd22e60',
     armv7l: 'b7a2958770df4776d1186bee4d00455c8f7719020df7a9f3234b4c0dcbd22e60',
       i686: '8a85e057d46e90f1bf2eed8730e69c589ab575b4c43c8e8c675b49ab9e1064ee',
     x86_64: 'adac1ed70e7e6f5572f49f7077d91e3dc1097a716bda88a200ca2da4fb145d33'
  })

  depends_on 'curl' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
  depends_on 'rust' => :build
  depends_on 'zlib' => :executable
end
