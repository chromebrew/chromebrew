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
    aarch64: '2fcf4ff6a6174d110be04f3b38cf8a7da5f8d56065418f55630c7749eb89a40f',
     armv7l: '2fcf4ff6a6174d110be04f3b38cf8a7da5f8d56065418f55630c7749eb89a40f',
       i686: '75880af56f9f71071ee9cf67d83044e481bd8c196d2097d055522db39b9569b0',
     x86_64: '7c138e7a3c01d1759ec724a5a0e84bda5bb423e250b089210b6100dac43fc03b'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'py3_cython' => :build
  depends_on 'zlib' # R

  no_source_build
end
