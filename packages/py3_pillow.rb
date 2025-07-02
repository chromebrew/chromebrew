require 'buildsystems/pip'

class Py3_pillow < Pip
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  version "11.3.0-#{CREW_PY_VER}"
  license 'HPND'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1efe7e4b3574594ccafb735edc9d7c1d383de6c28181daf19465dd8eae689ec5',
     armv7l: '1efe7e4b3574594ccafb735edc9d7c1d383de6c28181daf19465dd8eae689ec5',
     x86_64: 'c126f0c6d1f51900e6dd3ac03563c9615030eddfc340defdd5f6329f8d9032aa'
  })

  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo'
  depends_on 'libxcb'
  depends_on 'py3_lxml'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' => :build
  depends_on 'zlib' # R
  depends_on 'gcc_lib' # R

  no_source_build
end
