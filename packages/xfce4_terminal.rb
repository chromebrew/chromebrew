require 'package'
    
class Xfce4_terminal < Package
 description 'Modern terminal emulator primarly for the Xfce desktop environment'
 homepage "https://xfce.org/"
 version '0.8.9'
 compatibility 'all'
 source_url "https://archive.xfce.org/src/apps/xfce4-terminal/0.8/xfce4-terminal-0.8.9.tar.bz2"
 source_sha256 '247683a51a964cfaa6b1e92030afe9f782efebfcb550a464170b53eb94216795'
    
 depends_on 'desktop_file_utilities'
 depends_on 'gtkvte' => :build
 depends_on 'exo' => :build
 depends_on 'hicolor_icon_theme'
    
  def self.build
      system "./configure #{CREW_OPTIONS}"
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
