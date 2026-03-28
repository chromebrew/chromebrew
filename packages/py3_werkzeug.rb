require 'buildsystems/pip'

class Py3_werkzeug < Pip
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  version "3.1.7-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c0ac777f5abfa3f706e0f9484d5052d318cc19bdfab8f810a3bfee2e19ba2171',
     armv7l: 'c0ac777f5abfa3f706e0f9484d5052d318cc19bdfab8f810a3bfee2e19ba2171',
       i686: '62690f123a30503f8c555d51366ba83ab2aa8048c272786fd1550232a88a6216',
     x86_64: 'baccaa2bc9b5f5d4e911e73fc20e7b8564cfd56b12a59024046d6fd895de5c57'
  })

  depends_on 'python3' => :logical

  no_source_build
end
