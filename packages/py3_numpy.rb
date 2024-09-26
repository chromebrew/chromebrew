require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.1.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a906ed1fa02deebb03132a4efa47f6956aa03b62993a07bf698b773cf1e91ce',
     armv7l: '6a906ed1fa02deebb03132a4efa47f6956aa03b62993a07bf698b773cf1e91ce',
       i686: '9c3b79b2b88496e532a5baaf12d03c9e4bf753dadcbf37ffe883a2275c153093',
     x86_64: '6c2186c7238fb15bcf63adf3145cfdb939d5d2d9573231da0422f6e8c3bb7dec'
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
