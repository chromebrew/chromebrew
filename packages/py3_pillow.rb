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
    aarch64: '3325c9c204e5c0dabbcb0a7e4d49e7a3023ea8cdeae454ace1ae1cbf40a9c33b',
     armv7l: '3325c9c204e5c0dabbcb0a7e4d49e7a3023ea8cdeae454ace1ae1cbf40a9c33b',
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
