require 'buildsystems/pip'

class Py3_iniconfig < Pip
  description 'Iniconfig provides simple config-ini parsing.'
  homepage 'https://github.com/pytest-dev/iniconfig/'
  version "2.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26a72c86edc3d1d7b3592869e409e52746dc5bdb0865903ec29a80c7a916f1f4',
     armv7l: '26a72c86edc3d1d7b3592869e409e52746dc5bdb0865903ec29a80c7a916f1f4',
       i686: 'ea7fe2dfa476581cbe47f35941546492dfdd8915b9f77a4a4e1da8f920ec735e',
     x86_64: 'eccf8c9425c203e90d727db66d4c8e66da371a82b8ea3a484f3d4e4403b7c845'
  })

  depends_on 'python3' => :build

  no_source_build
end
