require 'buildsystems/pip'

class Py3_typing_extensions < Pip
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version "4.13.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed55288a3c3926bc7775aab43c392340db9eb7886546283ff683919ab078e8c7',
     armv7l: 'ed55288a3c3926bc7775aab43c392340db9eb7886546283ff683919ab078e8c7',
       i686: '55f4c8894d27674b415f7916e3d96873c85df0b530d48199804308f262f18d61',
     x86_64: '10bcdfaf15bf67909403c559ca8251a6779150f22acbff835b7684ac0cb761df'
  })

  depends_on 'python3' => :build

  no_source_build
end
