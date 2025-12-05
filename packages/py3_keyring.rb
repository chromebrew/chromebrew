require 'buildsystems/pip'

class Py3_keyring < Pip
  description 'Keyring stores and accesses your passwords safely.'
  homepage 'https://github.com/jaraco/keyring/'
  version "25.7.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e67b3c0e1247d98c5706f0004cae1f5c0c2214fa3a546fd25430e16d68d8d7eb',
     armv7l: 'e67b3c0e1247d98c5706f0004cae1f5c0c2214fa3a546fd25430e16d68d8d7eb',
       i686: '608812d51f9bcbd5d921329193c153b0fbd910756431e29390d1f6ec9a407688',
     x86_64: '216fd7b6f04d3b20ef157d4dd74b0293d482b42ceb5e5f3330cd12f1c9e6fd04'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'py3_importlib_metadata'
  depends_on 'python3' => :build

  no_source_build
end
