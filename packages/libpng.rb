require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.37'
  source_url 'https://downloads.sourceforge.net/project/libpng/libpng16/1.6.37/libpng-1.6.37.tar.xz'
  source_sha256 '505e70834d35383537b6491e7ae8641f1a4bed1876dbfe361201fc80868d88ca'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'zlibpkg'

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking',
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
