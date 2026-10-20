require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "17.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5ec1c72e9e1a70e7290a99ea42c1a8e2b0c0cbd77c092594ab7762e1d255b2e',
     armv7l: 'a5ec1c72e9e1a70e7290a99ea42c1a8e2b0c0cbd77c092594ab7762e1d255b2e',
       i686: 'cc7929677b42a92338df9f7047de602bb7e0fb82fb3ace274a13ce7563c53368',
     x86_64: '33c2c9b306737c26dc7a27a3f3c9b4c4eb9a3fdf99c3665c2c917ffe85978beb'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
