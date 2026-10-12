require 'buildsystems/pip'

class Py3_pycryptodomex < Pip
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.24.1-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8829be9126f30b51b5443b090b4ca1fb55f1928180834e97ee13061062945237',
     armv7l: '8829be9126f30b51b5443b090b4ca1fb55f1928180834e97ee13061062945237',
       i686: '35886fca0fd6118949cd96e4ebcf586db731e2824918e774421613a5e3282d4e',
     x86_64: 'e84f88ef950a3c36c4f525a42574c1c8c2627658d2fecdfa88dc24f671ef4be5'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
