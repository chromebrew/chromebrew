require 'buildsystems/pip'

class Py3_pillow < Pip
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  version "13.0.0-#{CREW_PY_VER}"
  license 'HPND'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bdc70784043281baa19cf5782c801cd30e2d016916908eb6c39284140255ab16',
     armv7l: 'bdc70784043281baa19cf5782c801cd30e2d016916908eb6c39284140255ab16',
     x86_64: 'd0b54e8ec0270adea83c90d961dc346e464a60dec927ae56aeb7c1bf964952b2'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libxcb' => :library
  depends_on 'py3_lxml'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
