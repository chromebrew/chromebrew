# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD
# NOTE: This package should be updated along with new Rust releases.

require 'buildsystems/rust'

class Cargo_c < RUST
  description 'A cargo subcommand to build and install C-ABI compatible dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version "0.10.22-#{CREW_RUST_VER}"
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4463d8577a4c08d0bf5d22e763a42ee95feea9d8fdf88384c05d537dfbea230b',
     armv7l: '4463d8577a4c08d0bf5d22e763a42ee95feea9d8fdf88384c05d537dfbea230b',
       i686: '9bb8e8ebebda6d5739a4ce04b0c37d8cb4f178b2ef1a57151b50328d60c2a164',
     x86_64: 'aa881bf1199d8a33a0114c17546fd885190dbc615964a245f1193e8fa43c23ca'
  })

  depends_on 'curl' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'openssl' => :executable
  depends_on 'rust' => :build
  depends_on 'zlib' => :executable
end
