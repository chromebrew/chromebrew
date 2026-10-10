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
    aarch64: '3f8cfab929357680094c9727cb7b1c620e61f077dcb19ac7d195ffffc0fc114a',
     armv7l: '3f8cfab929357680094c9727cb7b1c620e61f077dcb19ac7d195ffffc0fc114a',
       i686: '5037817226c0bd8e09488004f96f21b18c9fea4393b783e93d35be7c648f8fa0',
     x86_64: 'ccea48402676ec8be025124dc90583ae4d1d0d23cf60b14ad35cf98cac4af8e9'
  })

  depends_on 'py3_importlib_metadata'
  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'python3' => :logical

  no_source_build
end
