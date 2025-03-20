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
       i686: '75840b6dc6229d9e0cae915b6061d4b57d1e55af48aa254684a0bc16ec83b5f7',
     x86_64: 'affe2856094244e00505c11fc03a28d7090bd6a1199a6461713e2bb5e4fc59b8'
  })

  depends_on 'python3' => :build

  no_source_build
end
