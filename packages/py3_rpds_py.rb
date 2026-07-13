# Adapted from Arch Linux python-rpds-py PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-rpds-py/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_rpds_py < Pip
  description 'Python bindings to the Rust rpds crate for persistent data structures'
  homepage 'https://github.com/crate-py/rpds'
  version '2026.6.3'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '666d8c618c7f5b09720d0a12219a4d74fcf6726b33776b6f59ab704082f861d4',
     armv7l: '666d8c618c7f5b09720d0a12219a4d74fcf6726b33776b6f59ab704082f861d4',
       i686: '116bffebdf8281fa3eee55932d245e71ec6417d1cfc7cdc2749411dac73669c1',
     x86_64: 'bb1480d78fcc86307a9b1c408a9e0ee741a0c609ff668a551fea18560a936d05'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
