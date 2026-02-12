require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.6.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68722725dbdfdbf5f3b7af7c5bb847c647cb17b6b9053a2b04157cbe39f61e4c',
     armv7l: '68722725dbdfdbf5f3b7af7c5bb847c647cb17b6b9053a2b04157cbe39f61e4c',
       i686: '47d9e55834722ecfc7f37cf2f91585b9069fcc93fc62b4fdeced6c3bc9e48a80',
     x86_64: 'ae3d1b25b44bcaad177419d03f32a6d78cb62db227e948cf3d22e73dfd7cbebe'
  })

  depends_on 'python3' => :build

  no_source_build
end
