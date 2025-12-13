# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD
# NOTE: This package should be updated along with new Rust releases.

require 'buildsystems/rust'

class Cargo_c < RUST
  description 'A cargo subcommand to build and install C-ABI compatible dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version '0.10.18'
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d72a64b0bb32cefe89565acffb4f87b95b6685ba8e7df1e8d6e496785a45c80',
     armv7l: '3d72a64b0bb32cefe89565acffb4f87b95b6685ba8e7df1e8d6e496785a45c80',
       i686: '066c9375c62f0c7a55dec648e1299b5a6b180ac6faa5ac59972f34c0766ed8ba',
     x86_64: 'fa3dfadca2c4465983550b3f52cc36018eb68b9125f1870cc9e3ed68ffd81d1f'
  })

  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'rust' => :build
  depends_on 'zlib' # R
end
