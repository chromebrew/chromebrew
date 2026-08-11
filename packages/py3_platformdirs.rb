require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.11.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a60fc2f0e7e362be3683a0b6e57d6b86b034853fde70b22ea9e40057f92dc8e9',
     armv7l: 'a60fc2f0e7e362be3683a0b6e57d6b86b034853fde70b22ea9e40057f92dc8e9',
       i686: '92e9a876f459104a025d1d08a037865ea5ce0df3f77657add5c23f617105b26b',
     x86_64: 'f3ffbc3fd3ec209fc8186ea2e7e11dcc31d0abc94e4528e27dcb06fe773f3047'
  })

  depends_on 'python3' => :logical

  no_source_build
end
