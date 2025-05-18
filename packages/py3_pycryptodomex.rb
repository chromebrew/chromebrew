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
     x86_64: '816ccf0dc105f352ba35c05c319a23a36d5ce5a127f2595b21c40fd16c7b0ac1'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  no_source_build
end
