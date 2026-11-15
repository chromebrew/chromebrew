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
    aarch64: '2e501bbce2ab788543a5a0b9caf1957b8ff54c7862dec0b343e391e404f51c73',
     armv7l: '2e501bbce2ab788543a5a0b9caf1957b8ff54c7862dec0b343e391e404f51c73',
     x86_64: '4d4a5733ea2d3a808feaf0cee10cecbb482c64e8b71cb53e6cd3a285ef968e10'
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
