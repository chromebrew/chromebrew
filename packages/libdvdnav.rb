require 'package'

class Libdvdnav < Package
  description 'libdvdnav is a library that allows easy use of sophisticated DVD navigation features such as DVD menus, multiangle playback and even interactive DVD games.'
  homepage 'http://dvdnav.mplayerhq.hu/'
  version '6.1.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://get.videolan.org/libdvdnav/6.1.1/libdvdnav-6.1.1.tar.bz2'
  source_sha256 'c191a7475947d323ff7680cf92c0fb1be8237701885f37656c64d04e98d18d48'

  depends_on 'libdvdread'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
