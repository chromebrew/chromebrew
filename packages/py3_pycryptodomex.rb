require 'buildsystems/pip'

class Py3_pycryptodomex < Pip
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.24.2-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f217b29bd1db2c15eca54ccf62a2bf505436014385212369b54be9d11212b9a',
     armv7l: '8f217b29bd1db2c15eca54ccf62a2bf505436014385212369b54be9d11212b9a',
       i686: 'b18917399fe0103362a37c09c4422368ea40b751f1713d282bc0a274dfe2762a',
     x86_64: 'd5c6eacdc777793c40bb05b27c321eedd1edb685b0692eb2c08b72b0cfb3aaf7'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
