require 'buildsystems/cmake'

class Gdal < CMake
  description 'The Geospatial Data Abstraction Library is a translator for raster and vector geospatial data formats.'
  homepage 'https://gdal.org/'
  version '3.10.2'
  license 'BSD, Info-ZIP and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.osgeo.org/gdal/#{version}/gdal-#{version}.tar.xz"
  source_sha256 '67b4e08acd1cc4b6bd67b97d580be5a8118b586ad6a426b09d5853898deeada5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b1dff7b7b8f2b7155717b23c9b0f44e55c6d6f0966cacda7cdddde01d7b32d8',
     armv7l: '3b1dff7b7b8f2b7155717b23c9b0f44e55c6d6f0966cacda7cdddde01d7b32d8',
     x86_64: '0f7ba51a7a8fa276c28992219004b7c56b3fba03fc01bfe777ca33a684c5a9fe'
  })

  depends_on 'curl' # R
  depends_on 'expat' # R
  depends_on 'freeimage' => :build
  depends_on 'gcc_lib' # R
  depends_on 'geos' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'hdf5' # R
  depends_on 'json_c' # R
  depends_on 'libarchive' # R
  depends_on 'libdeflate' # R
  depends_on 'libheif' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libjxl' # R
  depends_on 'libpng' # R
  depends_on 'libwebp' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'openexr' # R
  depends_on 'openjpeg' # R
  depends_on 'openssl' # R
  depends_on 'pcre2' # R
  depends_on 'poppler' # R
  depends_on 'proj' # R
  depends_on 'py3_numpy' => :build
  depends_on 'qhull' # R
  depends_on 'sqlite' # R
  depends_on 'swig' => :build
  depends_on 'unixodbc' # R
  depends_on 'xercesc' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  cmake_options '-DGDAL_USE_TIFF_INTERNAL=ON \
    -DGDAL_USE_GEOTIFF_INTERNAL=ON'
end
