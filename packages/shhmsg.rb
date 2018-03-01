require 'package'

class Shhmsg < Package
  description 'C-functions for error messages, verbose messages and \'normal\' messages in terminal-based programs.'
  homepage 'http://shh.thathost.com/pub-unix/#sshmsg'
  version '1.4.2-1'
  source_url 'http://shh.thathost.com/pub-unix/files/shhmsg-1.4.2.tar.gz'
  source_sha256 '88c69e3f0b920b1ef93f6c10f354786f171d7cb3ab170a463bb9ab8bbf13a02b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/shhmsg-1.4.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/shhmsg-1.4.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/shhmsg-1.4.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/shhmsg-1.4.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f510ed281584b1eaa1a3ef81f6b33ed70d3dbf337146a13dcf1f07fbb532891',
     armv7l: '8f510ed281584b1eaa1a3ef81f6b33ed70d3dbf337146a13dcf1f07fbb532891',
       i686: '40421382202fd4a786f26e7c7ef95ebf5436709b3400200b59a381a7904023a7',
     x86_64: 'd7cb7e3b459a501b2c745d26458a3ecb20664df46a043134651a29d307a06857',
  })

  def self.build
    system "make"
  end

  def self.install
    system "make", "INSTBASEDIR=#{CREW_DEST_PREFIX}", "install"
  end
end
