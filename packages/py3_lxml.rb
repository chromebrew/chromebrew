require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "6.0.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '828c39402232b971908924dc19e22c41137d8dc338231f7fe37ca02b11a92a0d',
     armv7l: '828c39402232b971908924dc19e22c41137d8dc338231f7fe37ca02b11a92a0d',
       i686: '254ff9beb2f554e870fa55ef86f26458b8b188b5bb6e7cf25e43363bcecf731d',
     x86_64: 'f896171eeeb8518f7fdd3eb9d80c5d49c0b0e4527b970742e5b14e4a05c615df'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R

  no_source_build
end
