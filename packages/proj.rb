require 'buildsystems/cmake'

class Proj < CMake
  description 'PROJ is a generic coordinate transformation software that transforms geospatial coordinates from one coordinate reference system (CRS) to another.'
  homepage 'https://proj.org'
  version '9.9.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.osgeo.org/proj/proj-#{version}.tar.gz"
  source_sha256 '791a0610547eeabb17006cfd49cdbd2034f3240f47ed5e88a1031811f4e2bcf3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc4ff075542bda65fbfb5bb17944841df8016ab152f580fe029176523562555e',
     armv7l: 'fc4ff075542bda65fbfb5bb17944841df8016ab152f580fe029176523562555e',
     x86_64: 'be786f49c3549f94672196b8b044ffd6c0273fe61f29f6898ca54826a3233486'
  })

  depends_on 'curl' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libtiff' => :library
  depends_on 'sqlite' => :library
end
