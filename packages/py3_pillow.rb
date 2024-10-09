require 'buildsystems/pip'

class Py3_pillow < Pip
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  version "10.4.0-#{CREW_PY_VER}"
  license 'HPND'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '199bbd66c5455cff375c106d7df4c1e203db880fef2347004802fa624cb96ea1',
     armv7l: '199bbd66c5455cff375c106d7df4c1e203db880fef2347004802fa624cb96ea1',
     x86_64: 'd6053f521459376c89784be014798c9d4f7b515dde792f477b2ff3bc7bf01118'
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
