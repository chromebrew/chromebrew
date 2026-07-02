require 'buildsystems/pip'

class Py3_pillow < Pip
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  version "12.3.0-#{CREW_PY_VER}"
  license 'HPND'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd63aacfa97df693364cbd4a3234ef14937b4c841f38e6b573470ae96b4eebadf',
     armv7l: 'd63aacfa97df693364cbd4a3234ef14937b4c841f38e6b573470ae96b4eebadf',
     x86_64: '3fd230ed5b8db21c22f9cc607d409a4c800eb4eba9fad2c193a9b0df01bc9a54'
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
