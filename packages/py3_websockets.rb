require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "13.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd57ecb0322e97ee1acf4b5cdbbfabc7baad9bdc470f96cf086fff69406ac0cc',
     armv7l: 'bd57ecb0322e97ee1acf4b5cdbbfabc7baad9bdc470f96cf086fff69406ac0cc',
       i686: 'fddb2877130776ce8641567509754f5e007604dde4d75428ab1b366d25883325',
     x86_64: '387fa6d945ee09b4bf2f9b3565267c1bc0f2d2037b8221fb6a05777c66b1fb32'
  })

  depends_on 'python3' # L
  depends_on 'glibc' # R

  no_source_build
end
