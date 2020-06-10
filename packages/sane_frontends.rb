require 'package'

class Sane_frontends < Package
  description 'Scanner Access Now Easy - Frontends'
  homepage 'http://www.sane-project.org/'
  version 'c3e739'
  compatibility 'all'
  source_url 'https://gitlab.com/sane-project/frontends/-/archive/c3e739702f965f635319e0407c5a1e0b17dd7b42/frontends-c3e739702f965f635319e0407c5a1e0b17dd7b42.tar.bz2'
  source_sha256 'eb38d1ff3cc074a5db2538c523e654db1946f6e96593e252e433467ebab8a525'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sane_frontends-c3e739-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sane_frontends-c3e739-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sane_frontends-c3e739-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sane_frontends-c3e739-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2867edb5d4a2ce0d6dca6ce7794d407900b9e3841fe42dd722a6fabdbddd8021',
     armv7l: '2867edb5d4a2ce0d6dca6ce7794d407900b9e3841fe42dd722a6fabdbddd8021',
       i686: '6bc6e0a417fe5aed435c1acee5796729a241ff6584930c66f49ebd65f8fc1ad7',
     x86_64: '7404a4f07aeaee09f4610faafa40251f6f22c93b92cce5eeed267305dd9e8576',
  })

  depends_on 'sane_backends'
  depends_on 'sommelier'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
