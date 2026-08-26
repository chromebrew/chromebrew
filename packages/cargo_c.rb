# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD
# NOTE: This package should be updated along with new Rust releases.

require 'buildsystems/rust'

class Cargo_c < RUST
  description 'A cargo subcommand to build and install C-ABI compatible dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version "0.10.25-#{CREW_RUST_VER}"
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '29a3789849d7aa20638e22e14a70b20d1bab9426435605d7c11b8fe7b553c1f3',
     armv7l: '29a3789849d7aa20638e22e14a70b20d1bab9426435605d7c11b8fe7b553c1f3',
       i686: '9866d4357762e019a4c3238be249a02ea43581b29aa8958423bc9beb396307e6',
     x86_64: '7c9521f56cfad0a661853ae3f13cd44fa35f3003b1b958d923e24bb77268da11'
  })

  depends_on 'curl' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
  depends_on 'rust' => :build
  depends_on 'zlib' => :executable
end
