require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.13.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a476781faad6d8876ecf8f84872b95f080549201b57a34445a382072ce898576',
     armv7l: 'a476781faad6d8876ecf8f84872b95f080549201b57a34445a382072ce898576',
       i686: '7f1f187dc27d095196b4b43ce6accf9cfb6d38ef1c659bfa7f670a66d46414a1',
     x86_64: '7c45a8c5e58586e5447658589ccb2fd18ab92cdf07652430b682ce2065b828d8'
  })

  depends_on 'python3' => :logical

  no_source_build
end
