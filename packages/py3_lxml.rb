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
