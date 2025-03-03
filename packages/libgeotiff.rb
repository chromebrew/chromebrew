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
    aarch64: 'd2f582b4ee393dc0eca53805098b354efc68a766a32b2277fad26033a4bc1258',
     armv7l: 'd2f582b4ee393dc0eca53805098b354efc68a766a32b2277fad26033a4bc1258',
     x86_64: '622a92ff1bb9711422ba33d37a7635245adc0c1ba5f60cfb7a3aa7b150956682'
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
end
