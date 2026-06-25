require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.2.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '86106376276bcf668e9b3e980f9e7bd29894fdc4455c2def66470af09edbe37d',
     armv7l: '86106376276bcf668e9b3e980f9e7bd29894fdc4455c2def66470af09edbe37d',
       i686: '33474ee15de63f33d60ad95b39eacf7d3f28e6c7a7d66012e171639cff6bca99',
     x86_64: '79ed7dfdcbf707a086cc78625b17e46bbd997cd1f0a35998d875427217b85b0d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
