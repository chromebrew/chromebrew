require 'buildsystems/cmake'

class Proj < CMake
  description 'PROJ is a generic coordinate transformation software that transforms geospatial coordinates from one coordinate reference system (CRS) to another.'
  homepage 'https://proj.org'
  version '9.8.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.osgeo.org/proj/proj-#{version}.tar.gz"
  source_sha256 'a8395f9696338ffd46b0feb603edbb730fad6746fba77753c77f7f997345e3d3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6915311c4950addedfc2d98ec33c83f77f7fe8b03f5684f4cb41b7a165389f8e',
     armv7l: '6915311c4950addedfc2d98ec33c83f77f7fe8b03f5684f4cb41b7a165389f8e',
     x86_64: '587982adcaaf9d1964eb030d2a2c4aab7815be50eeca8bcbf8c4603bdca7d4be'
  })

  depends_on 'curl' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libtiff' => :library
  depends_on 'sqlite' => :library
end
