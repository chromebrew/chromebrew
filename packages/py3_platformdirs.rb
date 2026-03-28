require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.9.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2f522fb80fb6aebfc05a3f8b119219c1df6ff41b5c47890192bbf83459a70a3',
     armv7l: 'f2f522fb80fb6aebfc05a3f8b119219c1df6ff41b5c47890192bbf83459a70a3',
       i686: '63d42d62597f3a0b3b6ba9cb94d41127fc25ebc149e546c052996b1c97cd066a',
     x86_64: '7e89b32f3bf34d15fc4274fb0ff8995bbf3c8a25c5aabf2cfa51cdf63ebd3ac4'
  })

  depends_on 'python3' => :logical

  no_source_build
end
