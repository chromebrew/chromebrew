require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.6.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '071c1d0b074e5d12a7529ecbeb3b2e384a3960c3b2c53e7d8953eeb5c7f54511',
     armv7l: '071c1d0b074e5d12a7529ecbeb3b2e384a3960c3b2c53e7d8953eeb5c7f54511',
       i686: 'b6616715cd87db56a463edbfff8d1391a927248178ba1899ee481f3f3919e4cc',
     x86_64: '6752203712240bb1d784c3f3f949955946866afdccb96d1e8dc0a92dcf9d7215'
  })

  depends_on 'python3'

  no_source_build
end
