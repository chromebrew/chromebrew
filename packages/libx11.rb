require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.6.5'
  source_url 'https://www.x.org/archive/individual/lib/libX11-1.6.5.tar.gz'
  source_sha256 '3abce972ba62620611fab5b404dafb852da3da54e7c287831c30863011d28fb3'

  depends_on 'kbproto'
  depends_on 'libxcb'
  depends_on 'xproto'
  depends_on 'inputproto'
  depends_on 'xextproto'
  depends_on 'libxtrans'
  depends_on 'libxau'
  depends_on 'pthread_stubs'
  
  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
