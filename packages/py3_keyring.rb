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
    aarch64: '805bf9d9b8e7a3251ad2380f376b71c6b1c25d51577b5cd6bf7167d4639d9fd1',
     armv7l: '805bf9d9b8e7a3251ad2380f376b71c6b1c25d51577b5cd6bf7167d4639d9fd1',
       i686: '334f457cd0aa2b29cd947d7bb547e304433e0ef1cf6d34b936fef4b2fa4c00e3',
     x86_64: 'eca0361e13e9de420585fe94ab50bdf6fdd6535230156b06098ac53ad2bc797e'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'py3_importlib_metadata'
  depends_on 'python3' => :build

  no_source_build
end
