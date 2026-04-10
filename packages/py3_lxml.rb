require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "6.0.3-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0bbb5e0b15e017237c54c697f31749282242090755e459f914b6808fa7b0bfe7',
     armv7l: '0bbb5e0b15e017237c54c697f31749282242090755e459f914b6808fa7b0bfe7',
       i686: '2116d631789fd1862a665556f5a16d33c65e31233322b7af3c8fd8d5f9792808',
     x86_64: '136bdcc44cf82cf7771f549aac4f714b838a3dd9124d24f00708744c478317d7'
  })

  depends_on 'glibc' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxml2_autotools' => :library
  depends_on 'libxslt' => :library
  depends_on 'py3_cython' => :build
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
