require 'package'

class Xclock < Package
  description 'The xclock package contains a simple clock application which is used in the default xinit configuration.'
  homepage 'https://www.x.org/archive/X11R6.8.1/doc/xclock.1.html'
  version '1.0.9'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/app/xclock-1.0.9.tar.bz2'
  source_sha256 'cf461fb2c6f2ac42c54d8429ee2010fdb9a1442a370adfbfe8a7bfaf33c123bb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xclock-1.0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xclock-1.0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xclock-1.0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xclock-1.0.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b70ff42097e49252e239a56873c7c1422da7bb545a4828b62997561735bbbd39',
     armv7l: 'b70ff42097e49252e239a56873c7c1422da7bb545a4828b62997561735bbbd39',
       i686: 'a67eeb8b77425bcd0b90e43ac8d7f9b9ae0a441712238b63ea172addd33bfb35',
     x86_64: 'd1af7fe7bf45b9a2b9ea6c58882d40c377603dd82f700e894971125d3ec4c905',
  })

  depends_on 'xorg_lib'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
