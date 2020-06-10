require 'package'

class Xscreensaver < Package
  description 'XScreenSaver is the standard screen saver collection shipped on most Linux and Unix systems running the X11 Window System.'
  homepage 'https://www.jwz.org/xscreensaver/download.html'
  version '5.40'
  compatibility 'all'
  source_url 'https://www.jwz.org/xscreensaver/xscreensaver-5.40.tar.gz'
  source_sha256 '30a0908d4164cf780ef034f87ba884316296b308af2484261ccde86be0c95ae0'

  depends_on 'glfw'
  depends_on 'freeglut'
  depends_on 'sommelier'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} install"
  end
end
