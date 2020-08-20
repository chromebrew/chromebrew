require 'package'

class Xfconf < Package
    description 'Xfce hierarchical (tree-like) configuration system'
    homepage "https://xfce.org/"
  version '4.14.3'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/xfconf/4.14/xfconf-4.14.3.tar.bz2"
  source_sha256 '589052a0efc6151c5fb5f438da463502a4fd91848cae7b9376d417be4c5a0c02'
    
  depends_on 'gobject_introspection' # For --enable-gsettings-backend
  depends_on 'libxfce4util' 
 
  def self.build
     system "./configure #{CREW_OPTIONS} --enable-gsettings-backend"
     system "make -j#{CREW_NPROC}"
  end
  def self.install
     system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
