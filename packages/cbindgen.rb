# Adapted from Arch Linux cbindgen PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/cbindgen/trunk/PKGBUILD

require 'buildsystems/rust'

class Cbindgen < RUST
  description 'A tool for generating C bindings to Rust code'
  homepage 'https://github.com/eqrion/cbindgen'
  version '0.29.0'
  license 'MPL2'
  compatibility 'all'
  source_url 'https://github.com/eqrion/cbindgen.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db9b20989f23947e00eec5f8bfd6181d5c41880227512e1033173b1ed6ced1af',
     armv7l: 'db9b20989f23947e00eec5f8bfd6181d5c41880227512e1033173b1ed6ced1af',
       i686: 'ceb26159248f454776599e094ebed584f3c6bb74963df861973937e3418f1078',
     x86_64: 'ca4f0b0c30a12c2f4ab196712cfa5a10379df1658b879c2fe15b92b8a2b259f6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
