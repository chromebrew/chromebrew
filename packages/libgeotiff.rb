require 'package'

class Libgeotiff < Package
  description 'GeoTIFF is based on the TIFF format and is used as an interchange format for georeferenced raster imagery.'
  homepage 'https://github.com/OSGeo/libgeotiff'
  version '1.7.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/OSGeo/libgeotiff/releases/download/1.7.1/libgeotiff-1.7.1.tar.gz'
  source_sha256 '05ab1347aaa471fc97347d8d4269ff0c00f30fa666d956baba37948ec87e55d6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgeotiff/1.7.1_armv7l/libgeotiff-1.7.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgeotiff/1.7.1_armv7l/libgeotiff-1.7.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgeotiff/1.7.1_i686/libgeotiff-1.7.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgeotiff/1.7.1_x86_64/libgeotiff-1.7.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ca3b82c76afdc8f1b296ee5db782aceb947b78f6ccfd19093a881291bb7239af',
     armv7l: 'ca3b82c76afdc8f1b296ee5db782aceb947b78f6ccfd19093a881291bb7239af',
       i686: '1ba477f5bd5dec79dd0da7be7ce5ab11f09dcb7aa1e4d4f65ebd234a8b744017',
     x86_64: 'c570d1d56a1255e569be9052135ad46b24e7f68886a8a98c7365a25a1ca664fe'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libtiff' # R
  depends_on 'proj4' # R

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DCMAKE_INSTALL_DOCDIR=#{CREW_PREFIX}/share/doc \
        -DBUILD_SHARED_LIBS=true \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc", "#{CREW_DEST_PREFIX}/share/"
    return unless ARCH == 'x86_64'

    FileUtils.mv "#{CREW_DEST_PREFIX}/lib", "#{CREW_DEST_PREFIX}/lib64"
  end
end
