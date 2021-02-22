require 'package'

class Gettext_tiny < Package
  description 'gettext-tiny provides lightweight replacements for tools typically used from the GNU gettext suite.'
  homepage 'https://github.com/sabotage-linux/gettext-tiny'
  version '0.3.2'
  compatibility 'all'
  source_url 'https://ftp.barfooze.de/pub/sabotage/tarballs/gettext-tiny-0.3.2.tar.xz'
  source_sha256 'a9a72cfa21853f7d249592a3c6f6d36f5117028e24573d092f9184ab72bbe187'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gettext_tiny-0.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gettext_tiny-0.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gettext_tiny-0.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gettext_tiny-0.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9d39913a3848c22756d4251ac805eead5f2337fbc173766a442bfedd1a46ccf0',
     armv7l: '9d39913a3848c22756d4251ac805eead5f2337fbc173766a442bfedd1a46ccf0',
       i686: '4790961c57b8e32388002ffa1c661aae1269bf36812e4c00afadd46fbb2042f0',
     x86_64: '9435867e7adfa4f9906a89de80288cc59d014ee7dab19ef764ce18c2a7ad7fcd',
  })

  def self.preinstall
    abort "gettext already installed. gettext_tiny conflicts with gettext.".lightred if File.exist? "#{CREW_PREFIX}/bin/msgcomm"
  end

  def self.build
    system "make", "LIBINTL=NONE"
  end

  def self.install
    system "make", "LIBINTL=NONE", "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", "libdir=#{CREW_LIB_PREFIX}", "install"
  end
end
