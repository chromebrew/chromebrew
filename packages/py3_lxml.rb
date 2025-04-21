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
    aarch64: 'df6facf0b9f3a27f8075bb7b1cd96ae2dd6c4ca396a5b13bf4853c6a17d3df4b',
     armv7l: 'df6facf0b9f3a27f8075bb7b1cd96ae2dd6c4ca396a5b13bf4853c6a17d3df4b',
       i686: '61fcee2421205501965b781c21151ecaba9ca5a0cfcb88df40bf9b7415dfd51f',
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
