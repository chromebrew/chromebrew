require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.1.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e2df511460904f9392bc61f6ae1964a5767f61c8bb7eb30eb200c516ade4d13',
     armv7l: '7e2df511460904f9392bc61f6ae1964a5767f61c8bb7eb30eb200c516ade4d13',
       i686: '61f9a44f431250e30bf30085024147b11c50ee1958313d179cbc67cd153546e3',
     x86_64: 'a60fb97fb872d467632e9a592ddef76d832a83b1c0a2bc731a3f2d7640ae9ad3'
  })

  depends_on 'python3'

  no_source_build
end
