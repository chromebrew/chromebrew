require 'package'

class Libgeotiff < Package
  description 'GeoTIFF is based on the TIFF format and is used as an interchange format for georeferenced raster imagery.'
  homepage 'https://github.com/OSGeo/libgeotiff'
  version '1.7.1-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/OSGeo/libgeotiff/releases/download/1.7.1/libgeotiff-1.7.1.tar.gz'
  source_sha256 '05ab1347aaa471fc97347d8d4269ff0c00f30fa666d956baba37948ec87e55d6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '37c527b38436f6313b6be20ed176d7f8be509f2dd2cb9e2fadcba16823b17331',
     armv7l: '37c527b38436f6313b6be20ed176d7f8be509f2dd2cb9e2fadcba16823b17331',
       i686: 'dabea0e5c4f43acabdd1de7b6c46f883a2c2734a0fefe502dd13c3bb4ee2d32e',
     x86_64: '14c3b9e715d8fb79247f8fb17b93a843219f4e064b6b71115a4d57f2ff81ed6b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libtiff' # R
  depends_on 'proj' # R

  def self.build
    system "cmake -B builddir -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DGEOTIFF_LIB_SUBDIR=#{CREW_LIB_PREFIX} \
        -DCMAKE_INSTALL_DOCDIR=#{CREW_PREFIX}/share/doc \
        -DBUILD_SHARED_LIBS=true"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc", "#{CREW_DEST_PREFIX}/share/"
  end
end
