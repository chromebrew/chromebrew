require 'package'

class Libxdamage < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  @_ver = '1.1.5'
  version @_ver
  compatibility 'all'
  source_url "https://www.x.org/archive/individual/lib/libXdamage-#{@_ver}.tar.gz"
  source_sha256 '630ec53abb8c2d6dac5cd9f06c1f73ffb4a3167f8118fdebd77afd639dbc2019'

  depends_on 'libxfixes'
  depends_on 'libx11'


  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
  
  def self.check
    system 'make', 'check'
  end
end
