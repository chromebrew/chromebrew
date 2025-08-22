require 'buildsystems/cmake'

class Proj < CMake
  description 'PROJ is a generic coordinate transformation software that transforms geospatial coordinates from one coordinate reference system (CRS) to another.'
  homepage 'https://proj.org'
  version '9.6.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.osgeo.org/proj/proj-#{version}.tar.gz"
  source_sha256 'a8395f9696338ffd46b0feb603edbb730fad6746fba77753c77f7f997345e3d3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '183d8c3b8e9ce1930ae5e308e5196d81492fd974b62b6a7e96db4c8a9a566aa2',
     armv7l: '183d8c3b8e9ce1930ae5e308e5196d81492fd974b62b6a7e96db4c8a9a566aa2',
     x86_64: 'c30d708c449a08ac046a482dab7195ebde490b31ea398b5184a4e9faac561150'
  })

  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libtiff' # R
  depends_on 'sqlite' # R
end
