require 'package'

class Libheif < Package
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  version '1.6.1'
  source_url 'https://github.com/strukturag/libheif/releases/download/v1.6.1/libheif-1.6.1.tar.gz'
  source_sha256 'a22611289464da08fa7e580c95ea5e1b1b522b96ee6807de9b3b4605efb621d1'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libde265'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libx265'

  def self.build
    system './configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
