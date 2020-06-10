require 'package'

class Iso_codes < Package
  description 'Provides lists of various ISO standards (countries, languages, language scripts, and currency names)'
  homepage 'https://salsa.debian.org/iso-codes-team/iso-codes'
  version '4.1'
  compatibility 'all'
  source_url 'https://salsa.debian.org/iso-codes-team/iso-codes/uploads/049ce6aac94d842be809f4063950646c/iso-codes-4.1.tar.xz'
  source_sha256 '67117fb76f32c8fb5e37d2d60bce238f1f8e865cc7b569a57cbc3017ca15488a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/iso_codes-4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/iso_codes-4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/iso_codes-4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/iso_codes-4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3842e352264375e1b331bc14e4bdfceb56c27978e4ca96b0572c96db980266c0',
     armv7l: '3842e352264375e1b331bc14e4bdfceb56c27978e4ca96b0572c96db980266c0',
       i686: '61d56299e86b904fec2595653853dbbc1029631867b335896834d6cc3c65f9bb',
     x86_64: '5491ddcffd603df2cecdaa60f4ea498f290f117cf1202aa1bfc85af35e19772c',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
