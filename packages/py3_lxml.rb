require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "5.3.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '561a45432b37e8ec6a4784dd23adc1bfe8977f7de2f4a06091ccb0935571691d',
     armv7l: '561a45432b37e8ec6a4784dd23adc1bfe8977f7de2f4a06091ccb0935571691d',
       i686: '2518c767de0b3cfc19e9eafac38a0a2b6378c188928fa55d92e920857e5c5496',
     x86_64: 'b781d75756818bbb65693344d7281aeec7dbe9960128a377feb7680d5997593b'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R
  no_source_build
end
