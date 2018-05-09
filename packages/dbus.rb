require 'package'

class Dbus < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.13.4'
  source_url 'https://dbus.freedesktop.org/releases/dbus/dbus-1.13.4.tar.gz'
  source_sha256 '8a8f0b986ac6214da9707da521bea9f49f09610083c71fdc8eddf8b4c54f384b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dee478f7df2d50ddb8eac1637a7d359e5d1ba1e7d81d091b31ac3f7463ebb11b',
     armv7l: 'dee478f7df2d50ddb8eac1637a7d359e5d1ba1e7d81d091b31ac3f7463ebb11b',
       i686: '60b9dd5fc3b754dad79f83ffec8bfeb6e7cf0263b477f12ee505b6db0d03e72e',
     x86_64: '2c4049f13366a42f07a397a62fbbacf19ffb779a853f2367743a65e2f7013b8e',
  })

  depends_on 'expat'

  def self.build
    system "./configure \
    --prefix=#{CREW_PREFIX} \
    --libdir=#{CREW_LIB_PREFIX} \
    --disable-static \
    --disable-doxygen-docs \
    --disable-xml-docs"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
