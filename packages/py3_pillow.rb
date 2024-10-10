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
    aarch64: '0f6de269b0bc8643ad5a843f0514595363a54b6c6044a9f483b741f7b02c8721',
     armv7l: '0f6de269b0bc8643ad5a843f0514595363a54b6c6044a9f483b741f7b02c8721',
     x86_64: '8ad2839dde613c060eb261e0fb3435f45cc0361cbbdcd91e740fb874dfc7c2c4'
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
