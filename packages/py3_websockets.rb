require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version '13.0.1-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eba73daa824783ddf36a2b226b3d3d4673e07f08fd62d10e8f621d0a52d39446',
     armv7l: 'eba73daa824783ddf36a2b226b3d3d4673e07f08fd62d10e8f621d0a52d39446',
       i686: '250d6888ceeb105803587a92811cf84dd0c27f2904d9202df45e7b0d12bcc256',
     x86_64: '25178a22e21f811fb955285e6bc3c00f009b6d1d094c71b5d83a6a6e18b2739d'
  })

  depends_on 'python3' # L
  depends_on 'glibc' # R

  no_source_build
end
