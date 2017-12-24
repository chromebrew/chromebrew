require 'package'

class Expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.2.5'
  source_url 'https://downloads.sourceforge.net/project/expat/expat/2.2.5/expat-2.2.5.tar.bz2'
  source_sha256 'd9dc32efba7e74f788fcc4f212a43216fc37cf5f23f4c2339664d473353aedf6'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
