require 'package'

class Libxscrnsaver < Package
  description 'X.org the X11 Screen Saver extension client library'
  homepage 'http://www.x.org'
  version '1.2.2'
  source_url 'https://www.x.org/archive//individual/lib/libXScrnSaver-1.2.2.tar.gz'
  source_sha256 'e12ba814d44f7b58534c0d8521e2d4574f7bf2787da405de4341c3b9f4cc8d96'

  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'xextproto'
  depends_on 'scrnsaverproto'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
