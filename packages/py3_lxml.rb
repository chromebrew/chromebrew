require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "6.1.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c4252d72cded55ba3fbd396b89e15842e66d10549d1ae78859ffeba572ebfd5',
     armv7l: '9c4252d72cded55ba3fbd396b89e15842e66d10549d1ae78859ffeba572ebfd5',
       i686: 'a1e4150c15e0e4fe6f7a30c8caf6b850ac0437e9b6acfba5e19a4d928131ac74',
     x86_64: '7168174a986ae1542620c33c6090116827c0128e2bdcd9d58a643e798babebb4'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxslt' => :library
  depends_on 'py3_cython' => :build
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
