require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.2.5-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '275c13d340ec85148c80fbb88a938905bc6c28e99c6d8dbfc704839c1a0bcd16',
     armv7l: '275c13d340ec85148c80fbb88a938905bc6c28e99c6d8dbfc704839c1a0bcd16',
       i686: '95ebee8d85e9185758a1cea971935cefd0b0f2e6ad770232c74f09b6d856ba55',
     x86_64: '3ac8d08fe3f6afc066efc3c24c082f3d10e12416c1c50ac5fdb54ad01fec4a3f'
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
