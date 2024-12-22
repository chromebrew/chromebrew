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
       i686: '907ed4ccf038a5070f13b8956fe765a9a8fd7a792a84feb2eb1494c7b1a53e7c',
     x86_64: 'f74a73a0e54b4c6693afea276007fca5b354a4aa5e13d0615a5d1f8d65e8ecd5'
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
