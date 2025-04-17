require 'buildsystems/pip'

class Py3_pillow < Pip
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  version "11.2.1-#{CREW_PY_VER}"
  license 'HPND'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '88db73ecdddf9926b43fa8763cb914ace661c91fc6f3cb6f055e71977d9c684e',
     armv7l: '88db73ecdddf9926b43fa8763cb914ace661c91fc6f3cb6f055e71977d9c684e',
     x86_64: '55f9e406fcaabd232358012c37a9fc55f54b23baa1749fb37bef48e933cf7c3b'
  })

  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'lcms' # R
  depends_on 'libjpeg_turbo'
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'libxcb'
  depends_on 'openjpeg' # R
  depends_on 'py3_lxml'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' => :build
  depends_on 'zlib' # R

  no_source_build
end
