require 'package'

class Neofetch < Package
  description 'A fast, highly customizable system info script'
  homepage 'https://github.com/dylanaraps/neofetch'
  version '3.3.0'
  source_url 'https://github.com/dylanaraps/neofetch/archive/3.3.0.tar.gz'
  source_sha256 '4808e76bd81da3602cb5be7e01dfed8223b1109e2792755dd0d54126014ee696'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/neofetch-3.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/neofetch-3.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/neofetch-3.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/neofetch-3.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dd1d1bc23fcadf54c74a6800cc5a6824300f82d2965d0810079e5f589d3ae1cf',
     armv7l: 'dd1d1bc23fcadf54c74a6800cc5a6824300f82d2965d0810079e5f589d3ae1cf',
       i686: '7e0385951fd9a982eec5d3b6223ce83efa94501b4f0b74536ff55a129e2e33ea',
     x86_64: 'f3ffcb5a6b7c3c5e5f663293db150fd6fde371b65067cc5dc3306a449e8eca75',
  })

  def self.build
    system "sed -i 's,PREFIX ?= /usr,PREFIX = #{CREW_PREFIX},' Makefile"
    system "sed -i 's,SYSCONFDIR ?= /etc,SYSCONFDIR ?= #{CREW_PREFIX}/etc,' Makefile"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
