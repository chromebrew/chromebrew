require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.14.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d9789050c1c6d3c4e0a0742e56c9875ec6b0e6596798e2e766de9c3317eba3d',
     armv7l: '8d9789050c1c6d3c4e0a0742e56c9875ec6b0e6596798e2e766de9c3317eba3d',
       i686: 'ae8473b3dd7e3baa9e3af323a49850fa75f89c5c862cb2e62e03099d8fae1726',
     x86_64: '22560dd716036fc8864366b4abbe40db5cf350d634750a7938acc34bbc19b108'
  })

  depends_on 'python3' => :logical

  no_source_build
end
