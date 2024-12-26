require 'buildsystems/pip'

class Py3_keyring < Pip
  description 'Keyring stores and accesses your passwords safely.'
  homepage 'https://github.com/jaraco/keyring/'
  version "25.6.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7464f73c8b8f029d730a0339917809088d18d277cdb68599d5b4bc5794718184',
     armv7l: '7464f73c8b8f029d730a0339917809088d18d277cdb68599d5b4bc5794718184',
       i686: '334f457cd0aa2b29cd947d7bb547e304433e0ef1cf6d34b936fef4b2fa4c00e3',
     x86_64: 'eca0361e13e9de420585fe94ab50bdf6fdd6535230156b06098ac53ad2bc797e'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'py3_importlib_metadata'
  depends_on 'python3' => :build

  no_source_build
end
