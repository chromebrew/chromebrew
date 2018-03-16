require 'package'

class Neofetch < Package
  description 'A fast, highly customizable system info script'
  homepage 'https://github.com/dylanaraps/neofetch'
  version '3.3.0'
  source_url 'https://github.com/dylanaraps/neofetch/archive/3.3.0.tar.gz'
  source_sha256 '4808e76bd81da3602cb5be7e01dfed8223b1109e2792755dd0d54126014ee696'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sed -i 's,PREFIX ?= /usr,PREFIX = #{CREW_PREFIX},' Makefile"
    system "sed -i 's,SYSCONFDIR ?= /etc,SYSCONFDIR ?= #{CREW_PREFIX}/etc,' Makefile"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
