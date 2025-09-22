require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.1.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb90553cf2eb9dd5c2566378f5e0ae1defe2b80c796ccd0744c82ff4bc0280d9',
     armv7l: 'bb90553cf2eb9dd5c2566378f5e0ae1defe2b80c796ccd0744c82ff4bc0280d9',
       i686: '1d6278a2fb7c2ffd6d6621d9d3a8016e73b922ef21739014d0834f2d1e8fd54a',
     x86_64: '8e98ed8ac92cfa8bdcd3285368fb7fcf2c16763269b25689fad58ca64c1ae851'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
