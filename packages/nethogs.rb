require 'package'

class Nethogs < Package
  description "NetHogs is a small 'net top' tool."
  homepage 'https://github.com/raboof/nethogs'
  version '0.8.6'
  compatibility 'all'
  source_url 'https://github.com/raboof/nethogs/archive/v0.8.6.tar.gz'
  source_sha256 '317c1d5235d4be677e494e931c41d063a783ac0ac51e35e345e621d261c2e5a0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nethogs-0.8.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nethogs-0.8.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nethogs-0.8.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nethogs-0.8.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '60471aea008d2c85e0cbd5986830141c8aa0bdf81d7543fc8d14f002efbdf719',
     armv7l: '60471aea008d2c85e0cbd5986830141c8aa0bdf81d7543fc8d14f002efbdf719',
       i686: '75c9da9bc2d40133aff0293346065412360f83cbe378c4f4d4bbab144292e3b2',
     x86_64: '420ed356066fa1c0593778999c2037adcb85988e226833753dd812e62b9b7632',
  })

  depends_on 'libpcap'

  def self.build
    ENV['PREFIX'] = CREW_PREFIX
    ENV['CPPFLAGS'] = "-I#{CREW_PREFIX}/include/ncursesw"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
