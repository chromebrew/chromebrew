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
    aarch64: '592525d7720931882da1fd91c518398f0a351a7ca1038d4ae2f7753e595d1119',
     armv7l: '592525d7720931882da1fd91c518398f0a351a7ca1038d4ae2f7753e595d1119',
       i686: '74da369a73bf4838cdb458d5eb49b114fec66ebfab4144ee97d70ad4344a6efc',
     x86_64: '332fa0c4c6f12f1c33af1ab5283cbc01edbe7c77a4f840314be14dc4fb29330b'
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
