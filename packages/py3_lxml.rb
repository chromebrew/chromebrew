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
    aarch64: 'f38d95a9358bf69bf5964044544cad6c49ac9e8ad2589bc5348ec1096e9b1b7c',
     armv7l: 'f38d95a9358bf69bf5964044544cad6c49ac9e8ad2589bc5348ec1096e9b1b7c',
       i686: '86b31e5a3b96b6974fbdd96dd4b25e3373568bb0fa2a0a04acb01c2f22aa6172',
     x86_64: '7176c947b01760b7c3bc2bee00bc0cfab0ce8454dfd1985a807528927d0beed1'
  })

  depends_on 'glibc' # R
  depends_on 'py3_cython' => :build
  depends_on 'zlib' # R

  no_source_build
end
