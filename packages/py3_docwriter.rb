require 'buildsystems/pip'

class Py3_docwriter < Pip
  description 'API documentation generator of the FreeType library.'
  homepage 'https://gitlab.freedesktop.org/freetype/docwriter'
  version "1.3.3-#{CREW_PY_VER}"
  license 'FTL and GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e38c865217c44d9e4160dd4fcc322fe3ce6597833b2215c91fdc8c114044426',
     armv7l: '9e38c865217c44d9e4160dd4fcc322fe3ce6597833b2215c91fdc8c114044426',
       i686: 'febca9dfa7ab5c01b88c6b12e12201066cb9febdc192a410509f423df04d125b',
     x86_64: 'a420a5764dde1d6268404966c91ba59f3b7b38b6b794349b33226a6406dae8eb'
  })

  depends_on 'python3' => :build

  no_source_build
end
