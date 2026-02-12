require 'buildsystems/pip'

class Py3_pillow < Pip
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  version "12.1.1-#{CREW_PY_VER}"
  license 'HPND'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b0ca3a39c2838ee7a6d6fcdf251f117e7f2364f98ef7f03a3169b0fb2272f26',
     armv7l: '4b0ca3a39c2838ee7a6d6fcdf251f117e7f2364f98ef7f03a3169b0fb2272f26',
     x86_64: '92c0402853e69b9ef5d04509880ce5720ccc464a3436ad5fa33de5dddc36c837'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libxcb' # R
  depends_on 'py3_lxml'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' # R
  depends_on 'zlib' # R

  no_source_build
end
