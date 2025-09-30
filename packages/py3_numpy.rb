require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.3.3-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd03ddf444236f575e1723282e813f7ef0ad3d34fe0f11b1531e7e8bcb7cbf237',
     armv7l: 'd03ddf444236f575e1723282e813f7ef0ad3d34fe0f11b1531e7e8bcb7cbf237',
       i686: 'c9e8e0e6439939cb7168900231d68d9f88acea6ebafefb29104a0a34dbc36653',
     x86_64: '33aac772cfe7dbf1bd87c109f3216ddd178c5e4fc20039b6c734554ec5ddeb37'
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
