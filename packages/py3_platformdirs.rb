require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.5.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7de05f54deb55ae56893cb8c141bf8e4c58a487fef30bf892b2e795d5d1f7ef4',
     armv7l: '7de05f54deb55ae56893cb8c141bf8e4c58a487fef30bf892b2e795d5d1f7ef4',
       i686: '20d3fa75aecac0ad7241733e14207e5b2958db5612ff3cce7333a96012d9b3b5',
     x86_64: '204e3dccd39c301f31a880fd91635112cadde305a7e197387413b79f2fe4f31c'
  })

  depends_on 'python3' => :build

  no_source_build
end
