require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.3.5-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06a30e5efc0ec5fb13ee0c8503ec35cf975c26b2a6f613cddc96587704683a5e',
     armv7l: '06a30e5efc0ec5fb13ee0c8503ec35cf975c26b2a6f613cddc96587704683a5e',
       i686: 'ba460bad71eef8ddc60f4829db403d7a9d80147745ab1404c589b384830afe84',
     x86_64: '0cdc18eceeb4c14c019cac26cd23f3da1acef3cf50213ca8774745c918407e4b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lapack' => :build
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R

  no_source_build
end
