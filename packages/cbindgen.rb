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
    aarch64: 'bff4096b9ddb3498d3ca1feb006692b291f0f42ccea2e47a9397920125781cc7',
     armv7l: 'bff4096b9ddb3498d3ca1feb006692b291f0f42ccea2e47a9397920125781cc7',
       i686: '996c15252098babc8a93dee25739e4a74e8b891d59569c772aca743f8e061d91',
     x86_64: 'ca4f0b0c30a12c2f4ab196712cfa5a10379df1658b879c2fe15b92b8a2b259f6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
