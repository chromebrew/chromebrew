require 'package'

class Chicken < Package
  description 'CHICKEN is practical and portable scheme system.'
  homepage 'https://code.call-cc.org/'
  version '4.13.0'
  source_url 'https://code.call-cc.org/releases/4.13.0/chicken-4.13.0.tar.gz'
  source_sha256 'add549619a31363d6608b39e0cf0e68b9d5e6ff2a719b5691ddeba57229c6c43'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-4.13.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-4.13.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-4.13.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-4.13.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bfc9280f5d2c3e079f7bdc1819e71243c6464e0e855878bbcb8f05f4f033ae20',
     armv7l: 'bfc9280f5d2c3e079f7bdc1819e71243c6464e0e855878bbcb8f05f4f033ae20',
       i686: '431b8e207f33561da047c373f38904c54aa8680d258c2b4788f327461243e776',
     x86_64: 'fff1ca9617ebf651e31f552fb68c916d38a0278521f188956cdf2d284e7f5d61',
  })

  def self.build
    system "make", "PLATFORM=linux"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install", "PLATFORM=linux"
  end
end
