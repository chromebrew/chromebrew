require 'package'

class Libxpresent < Package
  description 'XPresent extension C library'
  homepage 'https://cgit.freedesktop.org/xorg/lib/libXpresent/'
  version '1.0.0'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libXpresent-1.0.0.tar.gz'
  source_sha256 '92f1bdfb67ae2ffcdb25ad72c02cac5e4912dc9bc792858240df1d7f105946fa'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxpresent-1.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxpresent-1.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxpresent-1.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxpresent-1.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4cd080d977c53e1134a3fd3b90d9c5b557474baa31d01cfded8cfac45da9ed81',
     armv7l: '4cd080d977c53e1134a3fd3b90d9c5b557474baa31d01cfded8cfac45da9ed81',
       i686: 'b05f699372ec32348998b01209c6a857f87127d5260733078de97b23bb3c5e01',
     x86_64: '49a362f1000bdc0b4d815417f7ce497413987414ab3cbf16bb1435333b80a160',
  })

  depends_on 'libxfixes'
  depends_on 'libxrandr'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
