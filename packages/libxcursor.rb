require 'package'

class Libxcursor < Package
  description 'X.org X Cursor management library'
  homepage 'http://www.x.org'
  @_ver = '1.2.0'
  version @_ver
  compatibility 'all'
  source_url "https://www.x.org/archive/individual/lib/libXcursor-#{@_ver}.tar.gz"
  source_sha256 'ad5b2574fccaa4c3fa67b9874fbed863d29ad230c784e9a08b20692418f6a1f8'

  depends_on 'libxrender'
  depends_on 'libxfixes'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
