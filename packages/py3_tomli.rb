require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d4172a8f3e0579dbed95fdc010cb07106b185f90ca856c735b5fb0574ff48a4',
     armv7l: '0d4172a8f3e0579dbed95fdc010cb07106b185f90ca856c735b5fb0574ff48a4',
       i686: '8d860d880305c8a6df743397af09337e7b2d740de2190d72c99215ec732bc304',
     x86_64: '7e5391f5523f3f7dea3857dc260d64eb8c4ac3f40bf09b5f85bb42199b2ea091'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'
  depends_on 'glibc' # R

  no_source_build
end
