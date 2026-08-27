require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "17.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b71a2fe66f23ea696f2b8a130eb92312be7d1b66dafac16114a913c34225ebb5',
     armv7l: 'b71a2fe66f23ea696f2b8a130eb92312be7d1b66dafac16114a913c34225ebb5',
       i686: '55dcdaed3b1709e1e602ffa4547f687eae2470bb5508a559e2466ed89f22e61c',
     x86_64: '731a5af0e2f448972322be5dd5b648db493eec40f8ac6e9596003dfb5b9cb314'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
