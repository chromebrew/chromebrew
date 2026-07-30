require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "17.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4637a33693ca87d9e3bbfe987e56256d65ad81d9ec764ee8b01d2f7c78d3c18',
     armv7l: 'c4637a33693ca87d9e3bbfe987e56256d65ad81d9ec764ee8b01d2f7c78d3c18',
       i686: 'f59da77d756aa4658808901f302c7027343f1cd39ff5d06828c69db10a93fdba',
     x86_64: 'a8a6b020b3d07e13cad239fccb3c31bc17db85d65013b7e958bf29833ef6bf37'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
