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
    aarch64: '0f23fe4cd20b5a93305638bb2590215df77524d1b360525a791f7eded771a4a9',
     armv7l: '0f23fe4cd20b5a93305638bb2590215df77524d1b360525a791f7eded771a4a9',
       i686: '8ee676ffbbbe4126998aeb3c2deecfa85db3d755b74504a964f57c533a14fd1d',
     x86_64: '269fe0575a46cc4cccd5af15071ddd14d14901a29a5dab31d4cdf7ee01e5458f'
  })

  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'rust' => :build
  depends_on 'zlib' # R
end
