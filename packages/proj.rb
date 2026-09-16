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
    aarch64: '90088a432a0e5cf00ffb0e531b05c88d1f628a914fe51a2f9b46d2afd4bdcb16',
     armv7l: '90088a432a0e5cf00ffb0e531b05c88d1f628a914fe51a2f9b46d2afd4bdcb16',
     x86_64: '1dd5d6b8cc8a02302af065dad2a95f9a9b2587a6bcf4900410618060376c11f8'
  })

  depends_on 'curl' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libtiff' => :library
  depends_on 'sqlite' => :library
end
