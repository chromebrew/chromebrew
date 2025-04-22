require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "5.3.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db231ba90b5707e20cb689f280e8e3c03e1058b09fb202ca114f01f4f16b7189',
     armv7l: 'db231ba90b5707e20cb689f280e8e3c03e1058b09fb202ca114f01f4f16b7189',
       i686: '61fcee2421205501965b781c21151ecaba9ca5a0cfcb88df40bf9b7415dfd51f',
     x86_64: '40f90b8984a60bd395caacfc91d8546ce105c2b12b397174aa78a04e42a6abb1'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R
  no_source_build
end
