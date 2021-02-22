require 'package'

class Motti < Package
  description 'GNU Motti is a simple multiplayer strategy game.'
  homepage 'https://www.gnu.org/software/motti/'
  version '3.1.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/motti/motti-3.1.1.tar.gz'
  source_sha256 '632d9a84d3b2e3eee4c9d9199d66d42576516ea6c291058c01830ae2fb7de429'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/motti-3.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/motti-3.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/motti-3.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/motti-3.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2773d91fa2e004a96e46a82a909cb3bb3af82dcfe437d0feccb05401d61b3567',
     armv7l: '2773d91fa2e004a96e46a82a909cb3bb3af82dcfe437d0feccb05401d61b3567',
       i686: 'bb156e2e032e0db9cae3a7de2eb2b532b05b4d61279a9c9cf8a2ed4b0d4ce8c6',
     x86_64: '233b9eb4c881e4fc13920c5b991b7017789513f95cc670363c925f7dbbc6ceb6',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
