require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.3.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aea0f78d4678ea076fe54ee548fb7d66c6ae51e0b7adf7b7bc44988a5ae12faa',
     armv7l: 'aea0f78d4678ea076fe54ee548fb7d66c6ae51e0b7adf7b7bc44988a5ae12faa',
       i686: '2b3349842293c11c6f3d3e35106b1b24d0836d90d7f843b7924ede959ae2f468',
     x86_64: '6356036b1799dff0309bbdc18e8fc3be0e2cc235e8ed6cd0bcd2d22b17097e46'
  })

  depends_on 'python3' => :build

  no_source_build
end
