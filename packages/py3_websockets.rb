require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "14.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '357d76658debe2203a0f7ca0689f32cebb0a4050cd61b25a2b4d66d9e8a00dbb',
     armv7l: '357d76658debe2203a0f7ca0689f32cebb0a4050cd61b25a2b4d66d9e8a00dbb',
       i686: '0c5b35666116b37ed4666e45569a3771f22127dc78221b293fb6471f9da56431',
     x86_64: 'b33ae6129bd2d593cd5af1b4c256dce1c6cd7066c3b071bd7c0315cbf50f9c81'
  })

  depends_on 'python3' # L
  depends_on 'glibc' # R

  no_source_build
end
