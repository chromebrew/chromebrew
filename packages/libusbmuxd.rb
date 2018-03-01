require 'package'

class Libusbmuxd < Package
  description 'USB Multiplex Daemon'
  homepage 'http://www.libimobiledevice.org/'
  version '1.0.9'
  source_url 'http://www.libimobiledevice.org/downloads/libusbmuxd-1.0.9.tar.bz2'
  source_sha256 '2e3f708a3df30ad7832d2d2389eeb29f68f4e4488a42a20149cc99f4f9223dfc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libusbmuxd-1.0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libusbmuxd-1.0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libusbmuxd-1.0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libusbmuxd-1.0.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd47e325523f0167e598638cc889058c4dbaae0d2277d867b1ee86cc5b2285b1b',
     armv7l: 'd47e325523f0167e598638cc889058c4dbaae0d2277d867b1ee86cc5b2285b1b',
       i686: '85cc5ad75e883f17e1ea5b6de634c7db4cbd390b62b0f8d75950ee494cf28eb6',
     x86_64: 'b9b4ba031ce059483b3e72abf300534f121f37b2759352c87c87fe3595ac83b2',
  })

  depends_on 'glib'
  depends_on 'libplist'

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

  def self.check
    system 'make', 'check'
  end
end
