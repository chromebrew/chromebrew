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
    aarch64: 'b336d378acb3f6e044babe77baf47764e9f805370c2e5cc77f6619df5b415124',
     armv7l: 'b336d378acb3f6e044babe77baf47764e9f805370c2e5cc77f6619df5b415124',
       i686: '95ebee8d85e9185758a1cea971935cefd0b0f2e6ad770232c74f09b6d856ba55',
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
