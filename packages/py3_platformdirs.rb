require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.12.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ca52c0a24a3fc5463d1d90169c2088ef79c746a0fd570ba3a9c656699a7f964',
     armv7l: '9ca52c0a24a3fc5463d1d90169c2088ef79c746a0fd570ba3a9c656699a7f964',
       i686: 'c69c51e277d4e6b9bf0a2797c013c6d15e0027c66ec7cdd0c1437604654cc54f',
     x86_64: '40cf0626f89b34c8ee8e515c3171e849c368a435b6c58888319eae63d3739b6b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
