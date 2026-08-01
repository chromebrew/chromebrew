require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "17.0.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60b35873397acf29bf2831adaff0c1b06ad04b17f7d083e0bcb4ce7ce3218451',
     armv7l: '60b35873397acf29bf2831adaff0c1b06ad04b17f7d083e0bcb4ce7ce3218451',
       i686: '9fb2f40bfb78915f157a1679c106e2725e7ca7a3413ea50908add294f46182f7',
     x86_64: '55cf2364a5e242cd5e8a2d04c5a4516f180b7a88a15cf9298249ab5892b2551f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
