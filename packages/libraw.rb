require 'buildsystems/autotools'

class Libraw < Autotools
  description 'Raw image decoder library'
  homepage 'https://www.libraw.org'
  version '0.22.2'
  license 'LGPL-2.1 and CDDL'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.libraw.org/data/LibRaw-#{version}.tar.gz"
  source_sha256 'de86b035655accff8d4010f1a221fdf50d353cb7b1422ba26f14a0db92612cfa'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e76ea68b2b0411fa84e81dcdbd6d5a9c5a6d0d05379c6e5b212924fbfa5b0067',
     armv7l: 'e76ea68b2b0411fa84e81dcdbd6d5a9c5a6d0d05379c6e5b212924fbfa5b0067',
     x86_64: '848f56c2d17585c7d9fdc2408e9e6753535a0efd9ceb513e685a2ce0a3f1d438'
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
