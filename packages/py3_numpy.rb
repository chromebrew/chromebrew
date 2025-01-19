require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.2.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '04a1ac8aa0b131b06cd0aba85fc349e986b61733a4ff86c5e71d122c9bbcf16a',
     armv7l: '04a1ac8aa0b131b06cd0aba85fc349e986b61733a4ff86c5e71d122c9bbcf16a',
       i686: '5e70d85132d36eca7c2fa2edd32e0bb212e182453daf8c2feb8bf2db09de1665',
     x86_64: '2a16ef76ca751c2e222456dc0fd66939252022ed1b32a8dfdbe1ad7ce6ed5493'
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
