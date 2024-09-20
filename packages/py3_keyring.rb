require 'buildsystems/pip'

class Py3_keyring < Pip
  description 'Keyring stores and accesses your passwords safely.'
  homepage 'https://github.com/jaraco/keyring/'
  version '25.4.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c9a772f1d2faeade4bcefc4a91d18281bd5de524494b4650d844f35f4952a65',
     armv7l: '3c9a772f1d2faeade4bcefc4a91d18281bd5de524494b4650d844f35f4952a65',
       i686: '2f6662f8abe594c866125012e7ff434e12e1df8b03181eea45eb15fed05d23d0',
     x86_64: 'a1d32d18dc44aba7ab6c306b956d6c9c240be8ac04ebb69d23134c78220643c4'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'py3_importlib_metadata'
  depends_on 'python3' => :build

  no_source_build
end
