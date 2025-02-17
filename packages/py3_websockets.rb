require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "15.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '66a38b0800f1a251609fd9b7d958c0dd9b1eccc669ef9a9f83197f9dd77354e3',
     armv7l: '66a38b0800f1a251609fd9b7d958c0dd9b1eccc669ef9a9f83197f9dd77354e3',
       i686: 'f63b02951a259833219022a0a4198497ad2c0cc27ab57bb1ef275922d7fd574d',
     x86_64: '3fdad2db8cf0c24671d708b3acfd9618d413e8f877ca20bd800a7ad9a4db750d'
  })

  depends_on 'python3' # L
  depends_on 'glibc' # R

  no_source_build
end
