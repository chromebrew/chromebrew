require 'buildsystems/pip'

class Py3_pillow < Pip
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  version "12.2.0-#{CREW_PY_VER}"
  license 'HPND'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ab8dbe2ad43c9034e507500f255c0356115a35f42aceac2a06819bc1de59ac6',
     armv7l: '3ab8dbe2ad43c9034e507500f255c0356115a35f42aceac2a06819bc1de59ac6',
     x86_64: 'd0f81b84c3e50ce576f1fa3601a6a5e016e8250757454c4d81a61afe58ff22a7'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libjpeg_turbo' # R
  depends_on 'libxcb' # R
  depends_on 'py3_lxml'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
