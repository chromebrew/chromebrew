require 'buildsystems/pip'

class Py3_pycryptodomex < Pip
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.22.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b54e032c88f2d5685709cf5b523df8fb92b3a363638e8e8aadddda14445bf60',
     armv7l: '4b54e032c88f2d5685709cf5b523df8fb92b3a363638e8e8aadddda14445bf60',
       i686: 'd847ae4913e9ceec2c180fd69732bbd100b2390d51b1edbe4cf8d941325814fa',
     x86_64: '2697903540d41086b3352249fd374e4736dbf9cda647c4fbdff46c91459bc435'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  no_source_build
end
