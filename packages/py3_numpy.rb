require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.2.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '598a625b8fdd7a0ed52bc8c35e6b1cc9d09b2920510ca7663f929451410c6c9e',
     armv7l: '598a625b8fdd7a0ed52bc8c35e6b1cc9d09b2920510ca7663f929451410c6c9e',
       i686: '143169b196dc245ffb953e3ba1aefb4c91e4a60212da9d9d7e0c7d31e6a24d39',
     x86_64: 'c026dd97a3486f2f2077fc1f46a821a5d3fd4afeb11a7cfe0d7a0bf44aebb907'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lapack' => :build
  depends_on 'openblas' # R
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :build
  depends_on 'zlib' # R

  pre_configure_options CREW_ENV_OPTIONS.gsub('mold', 'gold')

  no_source_build
end
