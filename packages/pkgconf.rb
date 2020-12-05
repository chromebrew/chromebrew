require 'package'

class Pkgconf < Package
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '1.7.3'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf/archive/pkgconf-1.7.3.tar.gz'
  source_sha256 '8f2c6e9f08adc5773d7fa3c1db1ed03f5fa02ceed037a537ce1195f7c93700ed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconf-1.7.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconf-1.7.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconf-1.7.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconf-1.7.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7dba3ff97aa46e3eb5ca3a3874b10d0d7952cbbd655c94d090da59827f3c05c3',
     armv7l: '7dba3ff97aa46e3eb5ca3a3874b10d0d7952cbbd655c94d090da59827f3c05c3',
       i686: 'fb51ba2693426e45f973cac8f053556c27864e0e1c4b3a08f29f054a77dac800',
     x86_64: '014ca1e27dae6c162677a12ed73138631bb81f3749cfe093987208f84eaebcf1',
  })

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
