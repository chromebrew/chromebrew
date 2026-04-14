require 'buildsystems/pip'

class Py3_zipp < Pip
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  version "3.23.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '710a65f853b74e5d54a7098152cca78766463c435be3ea382e4b97b2cc765c88',
     armv7l: '710a65f853b74e5d54a7098152cca78766463c435be3ea382e4b97b2cc765c88',
       i686: 'fbcec0f04547f8e1683aba1b2bc28cd2e72ccc4fd5054883d9912eb90c5124bb',
     x86_64: '0491e0c120ead9ad23644797009a3fa1bf45971d4fa86cb32bcd323795419727'
  })

  depends_on 'python3' => :logical

  no_source_build
end
