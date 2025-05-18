require 'buildsystems/pip'

class Py3_pycryptodomex < Pip
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.23.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '261dcee097557512d7460d94000d56156066c4e16672c60bfa2f952939a542c6',
     armv7l: '261dcee097557512d7460d94000d56156066c4e16672c60bfa2f952939a542c6',
       i686: 'd847ae4913e9ceec2c180fd69732bbd100b2390d51b1edbe4cf8d941325814fa',
     x86_64: '2697903540d41086b3352249fd374e4736dbf9cda647c4fbdff46c91459bc435'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  no_source_build
end
