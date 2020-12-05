require 'package'

class Pkgconf < Package
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '1.7.3'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf/archive/pkgconf-1.7.3.tar.gz'
  source_sha256 '8f2c6e9f08adc5773d7fa3c1db1ed03f5fa02ceed037a537ce1195f7c93700ed'

  depends_on 'glibc'

# Can be enabled for packages by setting
# ENV['PKG_CONFIG'] = "#{CREW_PREFIX}/bin/pkgconf"

def self.build
    system "./autogen.sh"
    system "./configure #{CREW_OPTIONS} \
    --with-system-libdir=#{CREW_LIB_PREFIX} \
    --with-system-includedir=#{CREW_PREFIX}/include"
    system "make"
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
