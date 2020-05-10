require 'package'

class Uchardet < Package
  description 'uchardet is an encoding detector library, which takes a sequence of bytes in an unknown character encoding without any additional information, and attempts to determine the encoding of the text.'
  homepage 'https://www.freedesktop.org/wiki/Software/uchardet/'
  version '0.0.6'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/uchardet/releases/uchardet-0.0.6.tar.xz'
  source_sha256 '8351328cdfbcb2432e63938721dd781eb8c11ebc56e3a89d0f84576b96002c61'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/uchardet-0.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/uchardet-0.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/uchardet-0.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/uchardet-0.0.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3e3e33899d7c3752750fc9b71a43fe46728a2cc9b129ef2a66141c4db61f32f3',
     armv7l: '3e3e33899d7c3752750fc9b71a43fe46728a2cc9b129ef2a66141c4db61f32f3',
       i686: 'd212dd9da6356ed8a8f85f0cb969e81266ff7dd0b3922fee0f5968d701f95362',
     x86_64: '75d94151c984a1b983e765fdfe33f767c84170c0b95724671665d4a8f80cb4be',
  })

  def self.build
    system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_BUILD_TYPE=Release && make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
