require 'buildsystems/pip'

class Py3_decorator < Pip
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  version "5.3.1-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '12eeb4c9772dc115afab9e157fe1c6231e417f46d7296073f511d0f14645e0da',
     armv7l: '12eeb4c9772dc115afab9e157fe1c6231e417f46d7296073f511d0f14645e0da',
       i686: '7200785cb5b1fb46f2feb02ac103af5a6f23d38c047688dc3ef97739cf5a2c2d',
     x86_64: '905276b9c655d1a63183dde9a2917152a0c8a00d981553a964f524e6a4444e64'
  })

  depends_on 'python3' => :logical

  no_source_build
end
