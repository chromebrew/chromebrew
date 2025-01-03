require 'buildsystems/pip'

class Py3_pillow < Pip
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  version "11.1.0-#{CREW_PY_VER}"
  license 'HPND'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0556388525664e4a1bd8d3bb24e7b1c87f3c90e11521b0f3005df062557a12c9',
     armv7l: '0556388525664e4a1bd8d3bb24e7b1c87f3c90e11521b0f3005df062557a12c9',
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
