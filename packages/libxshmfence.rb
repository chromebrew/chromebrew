require 'package'

class Libxshmfence < Package
  description 'A library that exposes a event API on top of Linux futexes'
  homepage 'http://t2sde.org/packages/libxshmfence.html'
  version '1.2'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/releases/individual/lib/libxshmfence-1.2.tar.bz2'
  source_sha256 'd21b2d1fd78c1efbe1f2c16dae1cb23f8fd231dcf891465b8debe636a9054b0c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxshmfence-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxshmfence-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxshmfence-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxshmfence-1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e61a8cd679d4337f4f9e2fbf9ed1987e20e524032a9578ac654bc21619848a64',
     armv7l: 'e61a8cd679d4337f4f9e2fbf9ed1987e20e524032a9578ac654bc21619848a64',
       i686: '3974fb4cfdb33db51ecafad7197676df52907a087f41022629f72610d90b08c1',
     x86_64: 'd015681e769125f9b28f9abaeeb7dee8b83dde1678dba8709933cb7ebcbcca89',
  })

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
