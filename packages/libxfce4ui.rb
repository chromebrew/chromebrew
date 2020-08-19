require 'package'

class Libxfce4ui < Package
  description 'Replacement of the old libxfcegui4 library'
  homepage "https://xfce.org/"
  version '4.15.3'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/libxfce4ui/4.15/libxfce4ui-4.15.3.tar.bz2"
  source_sha256 'ce89419720da0fa84a3bb46bc447564c5800057c026c272ae0b016918c0a9307'
    
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
