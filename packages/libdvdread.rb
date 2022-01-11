require 'package'

class Libdvdread < Package
  description 'libdvdnav is a library that allows easy use of sophisticated DVD navigation features such as DVD menus, multiangle playback and even interactive DVD games.'
  homepage 'http://dvdnav.mplayerhq.hu/'
  version '6.1.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://get.videolan.org/libdvdread/6.1.2/libdvdread-6.1.2.tar.bz2'
  source_sha256 'cc190f553758ced7571859e301f802cb4821f164d02bfacfd320c14a4e0da763'

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
