require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.3.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78d63a6f8038d5066e1ca464791a212c756029a8a4fb0be3fe7a9e0087f25b89',
     armv7l: '78d63a6f8038d5066e1ca464791a212c756029a8a4fb0be3fe7a9e0087f25b89',
       i686: '12e7e0088027e92592048700901c65f54b468ddbc86d51962084bbfc0892bf1a',
     x86_64: '968d3432299ab7cbd277c73949a6f2c86c7c520d2424aefeb1c380f15e98d752'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
