require 'buildsystems/autotools'

class Libraw < Autotools
  description 'Raw image decoder library'
  homepage 'https://www.libraw.org'
  version '0.22.3'
  license 'LGPL-2.1 and CDDL'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.libraw.org/data/LibRaw-#{version}.tar.gz"
  source_sha256 '789f3c33466210a1a0907f747a97c715d21bbf4af712f257fcbbd90111b227e4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '32102d4d097f7977a55fea0cd3a80a1e70abe327feb96abf6abb9b2a8f2d9c96',
     armv7l: '32102d4d097f7977a55fea0cd3a80a1e70abe327feb96abf6abb9b2a8f2d9c96',
     x86_64: 'a784e7696636db644f016772bd2c197fa3c948ba0b3720baed7080d2b08174dd'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'jasper'
  depends_on 'lcms' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'openmp'
  depends_on 'zlib' => :library
end
