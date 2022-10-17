require 'package'

class Gdal < Package
  description 'The Geospatial Data Abstraction Library is a translator for raster and vector geospatial data formats.'
  homepage 'http://www.gdal.org/'
  version '3.5.2'
  license 'BSD, Info-ZIP and MIT'
  compatibility 'all'
  source_url 'https://download.osgeo.org/gdal/3.5.2/gdal-3.5.2.tar.xz'
  source_sha256 '0874dfdeb9ac42e53c37be4184b19350be76f0530e1f4fa8004361635b9030c2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdal/3.5.2_armv7l/gdal-3.5.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdal/3.5.2_armv7l/gdal-3.5.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdal/3.5.2_i686/gdal-3.5.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdal/3.5.2_x86_64/gdal-3.5.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '97817ef4a8c5a4f006a327d9c4cf5fedaf9bda63b0fe6133357ffdb6c51f2969',
     armv7l: '97817ef4a8c5a4f006a327d9c4cf5fedaf9bda63b0fe6133357ffdb6c51f2969',
       i686: '3d64d3e78e9d8a16941f052a5a574a147337091229f0c6ef1c6fddfe45b0f15b',
     x86_64: '4f75750a53750a78ff43625ab073afe457045387106074537cb294ee38d51bac'
  })

  depends_on 'openjpeg'
  depends_on 'libcurl'
  depends_on 'geos'
  depends_on 'hdf5'
  depends_on 'proj4'
  depends_on 'qhull'
  depends_on 'libgeotiff'
  depends_on 'libxml2'
  depends_on 'xercesc'
  depends_on 'expat' # R
  depends_on 'gcc' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'jsonc' # R
  depends_on 'libdeflate' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'pcre2' # R
  depends_on 'sqlite' # R
  depends_on 'unixodbc' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    system 'filefix'
    system "./configure \
      --with-curl=#{CREW_PREFIX}/bin/curl-config \
      --with-geos=#{CREW_PREFIX}/bin/geos-config \
      --with-python \
      --with-proj"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
