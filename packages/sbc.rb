require 'package'

class Sbc < Package
  description 'SBC is a digital audio encoder and decoder used to transfer data to Bluetooth audio output devices.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/svn/multimedia/sbc.html'
  version '1.4'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/linux/bluetooth/sbc-1.4.tar.xz'
  source_sha256 '518bf46e6bb3dc808a95e1eabad26fdebe8a099c1e781c27ed7fca6c2f4a54c9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sbc-1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sbc-1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sbc-1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sbc-1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fe3e9e33021a107111cfe96762cf5e56fb4d664b241aedf5f98fd9d81bd1ba72',
     armv7l: 'fe3e9e33021a107111cfe96762cf5e56fb4d664b241aedf5f98fd9d81bd1ba72',
       i686: '6945685b5ddb903ab5545fd45f08b9ea08c75ea51741b3480f4e57bce749a2cc',
     x86_64: '539322bcdf3fe77c47f834e24c5d03ce42098f141e2820ddeb2e0aaa1d6dcec8',
  })

  depends_on 'libsndfile'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-high-precision',
           '--disable-static',
           '--enable-pie'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
