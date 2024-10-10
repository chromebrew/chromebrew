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
    aarch64: 'b1e588b01736069ba8a9e88232d11bfdab02b24bee0fd148615f8a86a690fd9d',
     armv7l: 'b1e588b01736069ba8a9e88232d11bfdab02b24bee0fd148615f8a86a690fd9d',
       i686: '74c04f4fd712baf9aaeb4d69cbab26a3d6e02b1d65abba877d28c9abf6fb97b4',
     x86_64: 'a2c0db561b5d795394b5e9f006d8eb85c13cff7ffd9df9d2119e8df5c860c520'
  })

  depends_on 'python3' => :build

  no_source_build
end
