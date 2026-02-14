require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.7.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c0588eddef68840d671bcf0e4654be74e5c5f5731b41b469e9334fde93ea55ef',
     armv7l: 'c0588eddef68840d671bcf0e4654be74e5c5f5731b41b469e9334fde93ea55ef',
       i686: '144da383b56aef7bb5f0f882d595f3c5668eb20dc39a350008e77a53bc1950d1',
     x86_64: 'fe65cd3d27ec4379c4977eacf03203b90e011fe535c692117f3b43658c2f9a5a'
  })

  depends_on 'python3' => :build

  no_source_build
end
