require 'package'

class Libxxf86vm < Package
  description 'X.org the client library for the XFree86-VidMode X extension.'
  homepage 'http://www.x.org'
  version '1.1.4'
  source_url 'https://www.x.org/archive//individual/lib/libXxf86vm-1.1.4.tar.gz'
  source_sha256 '5108553c378a25688dcb57dca383664c36e293d60b1505815f67980ba9318a99'

  depends_on 'xf86vidmodeproto'
  depends_on 'libxext'
  depends_on 'libx11'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end