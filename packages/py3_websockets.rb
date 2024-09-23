require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version '13.1-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac819d630f783b37ffa8ae1583b57dab3f0ef98ef2085376bf0c0792b60a4546',
     armv7l: 'ac819d630f783b37ffa8ae1583b57dab3f0ef98ef2085376bf0c0792b60a4546',
       i686: '824055b4212f8b06e203cf4ffc88d8f3fc308e9f07cbb366c1712c8b9f9eb557',
     x86_64: '16167e4018f250a3842c10cb7f6dcf8d048ee651fbc6fc8b6caf88aeffe64ee0'
  })

  depends_on 'python3' # L
  depends_on 'glibc' # R

  no_source_build
end
