require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "4.6.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bea0e793a5121df186c8c2a7da67c5a9eef1f5fb4695aded18c6a213d833e793',
     armv7l: 'bea0e793a5121df186c8c2a7da67c5a9eef1f5fb4695aded18c6a213d833e793',
       i686: 'ec656ad613ba7d224530584f14d239e88904f223fc3768fe1d316511496c4184',
     x86_64: 'd8f82e697faf3a6dd8f04bd656617fdd746c5815016d7ae36c98898d0b9c9dac'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
