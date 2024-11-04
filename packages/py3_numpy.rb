require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.1.3-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b4af2f634908ce20e89146d4eff0892ea5d77668f23a71bdffea03148fb0ae7',
     armv7l: '0b4af2f634908ce20e89146d4eff0892ea5d77668f23a71bdffea03148fb0ae7',
       i686: '1acdcc7a080e838b4792874d6de608b6578cd635e3e880fc47ee685752c16d43',
     x86_64: '34811d0ce0570c3afd7348809bc50e3844e64c4800f3a4531da3448b761ee185'
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
