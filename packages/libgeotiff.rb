require 'buildsystems/autotools'

class Libgeotiff < Autotools
  description 'GeoTIFF is based on the TIFF format and is used as an interchange format for georeferenced raster imagery.'
  homepage 'https://github.com/OSGeo/libgeotiff'
  version '1.7.4'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/OSGeo/libgeotiff/releases/download/#{version}/libgeotiff-#{version}.tar.gz"
  source_sha256 'c598d04fdf2ba25c4352844dafa81dde3f7fd968daa7ad131228cd91e9d3dc47'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '706bbd4c76350383b12307a6ec90fc602b0474408ee5a7a3f950f674c03dd252',
     armv7l: '706bbd4c76350383b12307a6ec90fc602b0474408ee5a7a3f950f674c03dd252',
     x86_64: '5f9dd0071d66adfd6876280501e1c2448e78fa08ef61496b934a2dd1c49bf078'
  })

  depends_on 'glibc' # R
  depends_on 'jbigkit' # R
  depends_on 'libdeflate' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'proj' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R
  depends_on 'sqlite' # R
end
