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
    aarch64: 'b6449ace1cd37f0f27e67720394978e66c3c7f18cbbbe05923207bc05104b1b2',
     armv7l: 'b6449ace1cd37f0f27e67720394978e66c3c7f18cbbbe05923207bc05104b1b2',
       i686: '8aa57d5be7ef044837b4e2a7f3875888e1d82dca361acbc0d97ee840abc2d296',
     x86_64: '27fc81727940171284539c95f8da25e4181e6f06bd6dcd2a07942db9fd1fe3b4'
  })

  depends_on 'python3' => :build

  no_source_build
end
