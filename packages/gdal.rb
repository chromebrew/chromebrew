require 'package'

class Gdal < Package
  description 'The Geospatial Data Abstraction Library is a translator for raster and vector geospatial data formats.'
  homepage 'http://www.gdal.org/'
  version '3.6.3'
  license 'BSD, Info-ZIP and MIT'
  compatibility 'all'
  source_url 'https://download.osgeo.org/gdal/3.6.3/gdal-3.6.3.tar.xz'
  source_sha256 '3cccbed883b1fb99b913966aa3a650ad930e7c3afc714f5823f9754176ee49ea'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdal/3.6.3_armv7l/gdal-3.6.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdal/3.6.3_armv7l/gdal-3.6.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdal/3.6.3_i686/gdal-3.6.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdal/3.6.3_x86_64/gdal-3.6.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '07803c1d895f07923b3a4de611aae93302d5fcbb772db4209be19d8bd654b582',
     armv7l: '07803c1d895f07923b3a4de611aae93302d5fcbb772db4209be19d8bd654b582',
       i686: '6816f286833651fc1201dfe25d571355ff728f0eae15e7f23097b53c4f6f149c',
     x86_64: '3b5505ae58c8d72eeb7c58125cac5ad340543ec5c6caba62454effeea17fee73'
  })

  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'geos' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'hdf5' => :build
  depends_on 'jsonc' # R
  depends_on 'curl' # R
  depends_on 'libdeflate' # R
  depends_on 'libgeotiff' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'openjpeg' # R
  depends_on 'openssl' # R
  depends_on 'pcre2' # R
  depends_on 'proj4' # R
  depends_on 'qhull' # R
  depends_on 'sqlite' # R
  depends_on 'unixodbc' # R
  depends_on 'xercesc' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    system "mold -run cmake -B builddir #{CREW_CMAKE_OPTIONS} \
        -Wno-dev \
        -G Ninja"
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
