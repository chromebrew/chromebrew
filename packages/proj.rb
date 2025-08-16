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
    aarch64: 'cea001d600720b88b5b32e0327e59e1e3d9a4a0993654f708e31b9b04789b669',
     armv7l: 'cea001d600720b88b5b32e0327e59e1e3d9a4a0993654f708e31b9b04789b669',
     x86_64: '624b3019565b583b3de7f4b1ab9688910bfc63714ab4549b269dfe0f78cee5bd'
  })

  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libtiff' # R
  depends_on 'python3' # R
  depends_on 'sqlite' # R
end
