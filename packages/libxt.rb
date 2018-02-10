require 'package'

class Libxt < Package
  description 'X.org X Toolkit Library'
  homepage 'http://www.x.org'
  version '1.1.5'
  source_url 'https://www.x.org/archive/individual/lib/libXt-1.1.5.tar.gz'
  source_sha256 'b59bee38a9935565fa49dc1bfe84cb30173e2e07e1dcdf801430d4b54eb0caa3'

  depends_on 'kbproto'
  depends_on 'libsm'
  depends_on 'libx11'
  depends_on 'util_macros'  
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end