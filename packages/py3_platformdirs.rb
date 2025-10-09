require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3381e88e841ad0585623ca0c6da36352dee776ed299bfc89c66ec954970f721a',
     armv7l: '3381e88e841ad0585623ca0c6da36352dee776ed299bfc89c66ec954970f721a',
       i686: '610ae3a4f01d1b55b66c09ac96fe69943366dcd8bebfc6c281b843f3a3dfcc79',
     x86_64: 'e3b21f66fefb8550ec4a11197a3a603656fd195f60d79631517e9c785172cae5'
  })

  depends_on 'python3' => :build

  no_source_build
end
