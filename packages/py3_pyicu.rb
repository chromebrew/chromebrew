require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version "2.15.2-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33115a343cd7f5899eaa6c34baebf18df0e5e0dbf1aaba2eeea266b79d56f20b',
     armv7l: '33115a343cd7f5899eaa6c34baebf18df0e5e0dbf1aaba2eeea266b79d56f20b',
       i686: 'b1f496de760cecc66351570ba061aa94e41b7ea5cf4f3ec843dde30c7f114cf1',
     x86_64: 'fb464855fa1cd7e067408b1c96a041894416b887fac1683fe8dc62af8ea00cde'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R

  no_source_build
end
