require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.1.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a2d1735c19e7284b40b33c26f155135a15e1a25ddd03f50e1f7af98f07d2e3f',
     armv7l: '5a2d1735c19e7284b40b33c26f155135a15e1a25ddd03f50e1f7af98f07d2e3f',
       i686: 'd34232efd97bd87353ef6fabb788e68a16fb3c6c9889428b7de33722dc7a82c4',
     x86_64: 'a85f0b899299ee01812545eee4b2ce703956a6600f23da0bd834ad9d9e5a5be8'
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
