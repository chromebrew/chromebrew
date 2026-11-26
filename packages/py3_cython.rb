require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.3.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8891b26ed60dcf51416bba48c414b860bda6cf5b9869dabac88f9b3b66d5579',
     armv7l: 'f8891b26ed60dcf51416bba48c414b860bda6cf5b9869dabac88f9b3b66d5579',
       i686: '66be16afbf8a1e4d4517c35e511147afd2c434c99a4f951d6adcb40bc30a352a',
     x86_64: 'e6f263a81541b6dcb736e4dcb7be98bdc51b708106542ebeed859b3d265f4a44'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
