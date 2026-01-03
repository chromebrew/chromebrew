require 'buildsystems/pip'

class Py3_pillow < Pip
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  version "12.1.0-#{CREW_PY_VER}"
  license 'HPND'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27ce5662c31564ec424b42cb97cf703245415148e031d7b39c970447875b9419',
     armv7l: '27ce5662c31564ec424b42cb97cf703245415148e031d7b39c970447875b9419',
     x86_64: 'cfa7ace83e4e721ceed7e1da4ce4a1f56fe60d1deaed6d5be42e7395c3fe56f9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo'
  depends_on 'libxcb'
  depends_on 'py3_lxml'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' => :build
  depends_on 'zlib' # R

  no_source_build
end
