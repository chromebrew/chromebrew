require 'package'

class Libxfce4ui < Package
  description 'Replacement of the old libxfcegui4 library'
  homepage 'https://xfce.org/'
  version '4.16.0'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/libxfce4ui/4.16/libxfce4ui-#{version}.tar.bz2"
  source_sha256 '8b06c9e94f4be88a9d87c47592411b6cbc32073e7af9cbd64c7b2924ec90ceaa'

  depends_on 'gtk3'
  depends_on 'gtk2'
  depends_on 'pygtk' # For gtk+
  depends_on 'xfconf'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
