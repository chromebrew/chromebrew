# Adapted from Arch Linux cbindgen PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/cbindgen/trunk/PKGBUILD

require 'buildsystems/rust'

class Cbindgen < RUST
  description 'A tool for generating C bindings to Rust code'
  homepage 'https://github.com/eqrion/cbindgen'
  version '0.29.4'
  license 'MPL2'
  compatibility 'all'
  source_url 'https://github.com/eqrion/cbindgen.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e9e69afdfb577e376a7964e04b1a40f27f4843cdcf6a707ebfd3dee6dde0ac2',
     armv7l: '3e9e69afdfb577e376a7964e04b1a40f27f4843cdcf6a707ebfd3dee6dde0ac2',
       i686: 'ce984d9b467bcecc2305c032a9be1c6a2df9805a566dd9cf8f00e610014d33a5',
     x86_64: '4851cb46c1e5d4102559f45dc56fcc65448551bcc1c2a3a006eae382dcfffbd8'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
end
