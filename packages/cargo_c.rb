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
    aarch64: '2aebd7d525dbf904e40a30a6759e2fbcefaaffdfb4172550ea16185cf6140df8',
     armv7l: '2aebd7d525dbf904e40a30a6759e2fbcefaaffdfb4172550ea16185cf6140df8',
       i686: '9e0e6db34635c21db285a89bfeae71c3ca6cc2a26d62854acb50feb100109f9e',
     x86_64: '29bd71e1c6f9787e596605874d9be30f5837e92b60cd3cc1f90f62764eee8998'
  })

  depends_on 'curl' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
  depends_on 'rust' => :build
  depends_on 'zlib' => :executable
end
