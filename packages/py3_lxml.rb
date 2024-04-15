require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  @_ver = '5.1.0'
  version "#{@_ver}-py3.12"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2ed57ff4cbf049b2921c8492e904904ff0e5b1c8955712eaca218959480c063',
     armv7l: 'a2ed57ff4cbf049b2921c8492e904904ff0e5b1c8955712eaca218959480c063',
       i686: '1eb148c5795e3bd95ed03d62b3f651c93118d27f0724931a88d7474ce91e4c76',
     x86_64: 'f30795fc316cc0e5885320f81ee7c724474fa17d8b02022c63158ebd19ae7eba'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R
  depends_on 'zlibpkg' # R
  no_source_build
end
