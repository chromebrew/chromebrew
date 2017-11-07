require 'package'

class Libxext < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.3.3'
  source_url 'https://www.x.org/archive/individual/lib/libXext-1.3.3.tar.gz'
  source_sha256 'eb0b88050491fef4716da4b06a4d92b4fc9e76f880d6310b2157df604342cfe5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxext-1.3.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxext-1.3.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxext-1.3.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxext-1.3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f4e046706d584c771c83fffa39119fd4cd80fc37d2458d8e463fc96673ee7bc8',
     armv7l: 'f4e046706d584c771c83fffa39119fd4cd80fc37d2458d8e463fc96673ee7bc8',
       i686: 'b4bd14f11c295928d7fc31a0b7b4141d37232430531739e934b6b22f796bc95a',
     x86_64: 'da9b7fa9ce4be448535d083504317879b00b61e6f981a749d5dc01e4d0818c9a',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
