require 'buildsystems/cmake'

class Gdal < CMake
  description 'The Geospatial Data Abstraction Library is a translator for raster and vector geospatial data formats.'
  homepage 'https://gdal.org/'
  version '3.13.3'
  license 'BSD, Info-ZIP and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.osgeo.org/gdal/#{version}/gdal-#{version}.tar.xz"
  source_sha256 'a3348c2102dd91962290007d7c293b467bb1b0cd89f086f24bb97b9b653a9804'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b1dff7b7b8f2b7155717b23c9b0f44e55c6d6f0966cacda7cdddde01d7b32d8',
     armv7l: '3b1dff7b7b8f2b7155717b23c9b0f44e55c6d6f0966cacda7cdddde01d7b32d8',
     x86_64: '0f7ba51a7a8fa276c28992219004b7c56b3fba03fc01bfe777ca33a684c5a9fe'
  })

  depends_on 'curl' => :library
  depends_on 'expat' => :library
  depends_on 'freeimage' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'geos' => :library
  depends_on 'giflib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'hdf5' => :library
  depends_on 'json_c' => :library
  depends_on 'libaec' => :library
  depends_on 'libarchive' => :library
  depends_on 'libbsd' => :library
  depends_on 'libdeflate' => :library
  depends_on 'libheif' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libjxl' => :library
  depends_on 'libpng' => :library
  depends_on 'libwebp' => :library
  depends_on 'libxml2' => :library
  depends_on 'lz4' => :library
  depends_on 'mysql' => :library
  depends_on 'openexr' => :library
  depends_on 'openjpeg' => :library
  depends_on 'openssl' => :library
  depends_on 'pcre2' => :library
  depends_on 'poppler' => :library
  depends_on 'proj' => :library
  depends_on 'py3_numpy' => :build
  depends_on 'qhull' => :library
  depends_on 'sqlite' => :library
  depends_on 'swig' => :build
  depends_on 'unixodbc' => :library
  depends_on 'xercesc' => :library
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  cmake_options '-DGDAL_USE_TIFF_INTERNAL=ON \
    -DGDAL_USE_GEOTIFF_INTERNAL=ON'
end
