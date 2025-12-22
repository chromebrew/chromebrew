require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.5.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e61e04f431c7e3e99a73d32e4a5e584a89f0f08d8f9247eb446795a51706d627',
     armv7l: 'e61e04f431c7e3e99a73d32e4a5e584a89f0f08d8f9247eb446795a51706d627',
       i686: 'd9d9191cb501ee31be55c2e594cee73edaecce485e3e46314cb2b0aa2d229ffc',
     x86_64: 'f314eab71575a2d8b2ed2d4415ffaa6bddc79daf455e59a4593510773209f928'
  })

  depends_on 'python3'

  no_source_build
end
