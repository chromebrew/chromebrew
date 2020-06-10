require 'package'

class Ondir < Package
  description 'On Dir is a program that automatically executes scripts as you traverse directories at a terminal.'
  homepage 'https://swapoff.org/ondir.html'
  version '0.2.2'
  compatibility 'all'
  source_url 'https://swapoff.org/files/ondir/ondir-0.2.2.tar.gz'
  source_sha256 '475fe7bd447756b4effde87c8aa67e063d805b775785b9f39858422dc244aef2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ondir-0.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ondir-0.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ondir-0.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ondir-0.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd8b3ea69345a1a88511b5adf7005befa9c53a90c7df43e5a9be47ee4294faf6a',
     armv7l: 'd8b3ea69345a1a88511b5adf7005befa9c53a90c7df43e5a9be47ee4294faf6a',
       i686: '45b1160ad68b3942db66057e74a6b4ef2dce30fd1c75e665561e1bcb40403b5b',
     x86_64: '1e52a3786e60afcc222911f6c143b9747238e6263f027030bd5862a8674ad99c',
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "CONF=#{CREW_PREFIX}/etc/ondirrc", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "install -Dm644 ondirrc.eg #{CREW_DEST_PREFIX}/etc/ondirrc.eg"
  end
end
