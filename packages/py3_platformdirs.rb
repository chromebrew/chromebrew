require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.14.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6f100f0cdd8f18e1d85d5adc5e759f355d79951f4d0c8daa28052a4414482b5',
     armv7l: 'f6f100f0cdd8f18e1d85d5adc5e759f355d79951f4d0c8daa28052a4414482b5',
       i686: 'a342734636416fd736d8ccf0e64749bdb162a3652e45baf2529edd6c8a1fefee',
     x86_64: 'b0ec17a68d9f589e2c39364378aa2c83d200554502bdfa77aa0302682ca852ce'
  })

  depends_on 'python3' => :logical

  no_source_build
end
