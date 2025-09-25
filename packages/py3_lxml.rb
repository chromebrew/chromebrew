require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "6.0.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f92623729f39f902a2b3460faeed8710b1e529ba4d9a0075dd813d5e226d961c',
     armv7l: 'f92623729f39f902a2b3460faeed8710b1e529ba4d9a0075dd813d5e226d961c',
       i686: 'f36b49f192e24461390d47e3316ec0539b559a9407d025973ad4915dcd879f9d',
     x86_64: '2e6326c457b333832aefc12e12692e358f4a1788672fa2c0cdf6890ec6938303'
  })

  depends_on 'glibc' # R
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R

  no_source_build
end
