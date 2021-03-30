require 'package'

class Nethogs < Package
  description "NetHogs is a small 'net top' tool."
  homepage 'https://github.com/raboof/nethogs'
  version '0.8.6-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/raboof/nethogs/archive/v0.8.6.tar.gz'
  source_sha256 '317c1d5235d4be677e494e931c41d063a783ac0ac51e35e345e621d261c2e5a0'

  depends_on 'libpcap'

  def self.build
    system "env CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw \
            PREFIX=#{CREW_PREFIX} \
            make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
