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
       i686: 'b7542c04ff5cc2e42f3171c57175321748d079395c5e91f7fc23b4ed5618de52',
     x86_64: '36fa6a12ca18389285cdd74b2e46fc6289a75835256f1eedae7e74fb79acc5e6'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'py3_importlib_metadata'
  depends_on 'python3' => :build

  no_source_build
end
