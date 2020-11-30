require 'package'

class Tint2 < Package
  description 'A lightweight panel/taskbar for Linux and BSD'
  homepage 'https://gitlab.com/o9000/tint2'
  version '16.7'
  compatibility 'all'
  source_url 'https://gitlab.com/o9000/tint2/-/archive/v16.7/tint2-v16.7.tar.gz'
  source_sha256 '74962c1dd111be9955319a133a790b24fe5a8ef0315a1bcdabc58c1157c1fb26'
    
  depends_on 'imlib2'
  depends_on 'gdk_pixbuf'
    
  ENV['CFLAGS'] = "-lX11 -lXau"


  def self.build
   Dir.mkdir 'build'
   Dir.chdir 'build' do
     system "cmake .. -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX}"
     system 'make'
   end
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
