require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "6.1.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '787f28d87324881acc34504fbe9386afaafffbe681bc3e3fe1b07a8ee02eeb96',
     armv7l: '787f28d87324881acc34504fbe9386afaafffbe681bc3e3fe1b07a8ee02eeb96',
       i686: 'f27c18887e02d982d9c4f35a7ff40a9688ef970283d1a8a99303e76bdffa7688',
     x86_64: '8fffd70d94d2a5af70dd8711e7c5d6c3c8c2e78258c8976176269529fe013a45'
  })

  depends_on 'glibc' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxslt' => :library
  depends_on 'py3_cython' => :build
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
