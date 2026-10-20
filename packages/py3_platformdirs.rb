require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.13.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d43c9ab27a221cc66f655c4c20eb1293781fd44a14a7bbc6441f993452ac4da',
     armv7l: '2d43c9ab27a221cc66f655c4c20eb1293781fd44a14a7bbc6441f993452ac4da',
       i686: 'c2159839002cd08f369ba72bf3cfc4b34f726ae7dcfaf819d25a23c5dfdf0529',
     x86_64: '4cea275dea4e8f13264d1d1b650d55f4955c6cfa1db1a9a3e792faa0957f2cad'
  })

  depends_on 'python3' => :logical

  no_source_build
end
