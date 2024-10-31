require 'buildsystems/pip'

class Py3_werkzeug < Pip
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  version "3.0.6-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a227dc1eb22a5321d202f16fa4b7d4d6161ba65281b860a3292a9c1022e24e3a',
     armv7l: 'a227dc1eb22a5321d202f16fa4b7d4d6161ba65281b860a3292a9c1022e24e3a',
       i686: 'c3b81160ecc6cab28eaaff0f9e81cadc76283d4a038ad26dd28a45496fd38757',
     x86_64: 'bdcb6e78e219084861761adf74f15b5d16fd93ed91d7f2e107bff7553b19a032'
  })

  depends_on 'python3' => :build

  no_source_build
end
