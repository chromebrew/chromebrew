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
       i686: 'cd3ff064a7a3fd3611b5da807d8b5b6afc1e830b6a68e3ac32b05ee93d0c655b',
     x86_64: '9ab83a2bb29c61f68ae40b97594693c0842b7549d5e5848bdfcd173e1904f732'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'py3_importlib_metadata'
  depends_on 'python3' => :build

  no_source_build
end
