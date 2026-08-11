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
    aarch64: 'e5cce472affaa168e315f9bca0153d1fb2424ec4e98c41129ecec4a0ef4ffe2f',
     armv7l: 'e5cce472affaa168e315f9bca0153d1fb2424ec4e98c41129ecec4a0ef4ffe2f',
       i686: '8759bf94ef1684e62a5058eddf4696f30974aef08d09d21277c5eb873209eb5d',
     x86_64: '486c772e03308b08ee49037598e9382e03a7f6a6f893092ae16445828ad2c77b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
