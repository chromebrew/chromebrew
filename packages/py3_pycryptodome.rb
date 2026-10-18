require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "4.0.1-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2a7c278d798436538188f35b2096bef3e6368c544d783eb65c123510bd9929c',
     armv7l: 'e2a7c278d798436538188f35b2096bef3e6368c544d783eb65c123510bd9929c',
       i686: '3fd34c2f6422bb156760576ee88e526fa5d32d2d09c7ac82f6a588b813171c9b',
     x86_64: '94eea4dc81e85feca6c2e6f365d1f32c10b6ef4b22fa8c2ff209328d9899ddc7'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
