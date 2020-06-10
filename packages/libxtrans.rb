require 'package'

class Libxtrans < Package
  description 'transpot library for the X window system'
  homepage 'https://x.org'
  version '1.4.0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/xtrans-1.4.0.tar.bz2'
  source_sha256 '377c4491593c417946efcd2c7600d1e62639f7a8bbca391887e2c4679807d773'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxtrans-1.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxtrans-1.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxtrans-1.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxtrans-1.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '85980bd143e9f4e68fa5ce02ab684acf4c982b2ec1c187395136c286a46fb966',
     armv7l: '85980bd143e9f4e68fa5ce02ab684acf4c982b2ec1c187395136c286a46fb966',
       i686: '18c80adc947824ea4222f53d4790e1d01fb747c3c4086211c8902ef79d6d6f3b',
     x86_64: '71e27f8f9fd0f03bd71e10def7d1efb7b7ee0f453d2579dce5acbc43dc6dcaae',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
