require 'package'

class Xprop < Package
  description 'Xprop is a property displayer for X.'
  homepage 'https://www.x.org/'
  version '1.2.5'
  compatibility 'all'
  source_url 'https://x.org/releases/individual/app/xprop-1.2.5.tar.bz2'
  source_sha256 '9b92ed0316bf2486121d8bac88bd1878f16b43bd335f18009b1f941f1eca93a1'

  depends_on 'xorg_lib'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
