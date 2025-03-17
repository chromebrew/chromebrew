require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.2.4-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af019bf867e414ee9cd495aff0cf03534e9c00392580eee9de0a3273f2751678',
     armv7l: 'af019bf867e414ee9cd495aff0cf03534e9c00392580eee9de0a3273f2751678',
       i686: '2549c3f2726db0b51944fa1a3d4f8abb7be4b0d832566b50e11d169b459b6dc8',
     x86_64: '68295378b0ce836de62a22799e5cc7e5bf3e832ff0cbabdfd4b3271671f62d50'
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
