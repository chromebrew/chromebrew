require 'package'

class Nethack4 < Package
  # "nethack4" fork of nethack with a few patches and a modern build system
  version '4.3.0-beta2'
  source_url 'http://nethack4.org/media/releases/nethack4-4.3-beta2.tar.gz'
  source_sha1 'e261c0ac618589a47e63525ed56eb17e72b14754'

  depends_on 'buildessential'
  depends_on 'ncurses'
  depends_on 'bison'
  depends_on 'flex'
  depends_on 'perl'

  
  def self.build
    target=CREW_BREW_DIR+"nethack4-4.3-beta2/build"
    system "mkdir -p " + target
    Dir.chdir target  do
      #build with rpath pointing at /usr/local
      system "/usr/local/bin/perl ../aimake --config-only -i /usr/local/ --directory-layout=prefix --without=gui"  
      system "/usr/local/bin/perl ../aimake"
    end
  end
  
  def self.install
    target=CREW_BREW_DIR+"nethack4-4.3-beta2/build"
    Dir.chdir target  do
      #install in destdir so package manager can keep track
      system "/usr/local/bin/perl ../aimake --install-only -i #{CREW_DEST_DIR}/usr/local/ --directory-layout=prefix --without=gui"  
    end
  end
end
