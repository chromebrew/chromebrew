require 'package'

class Libxxf86dga < Package
  description 'X.org the client library for the XFree86-DGA extension'
  homepage 'http://www.x.org'
  version '1.1'
  source_url 'https://www.x.org/archive/individual/lib/libXxf86dga-1.1.tar.gz'
  source_sha256 'b3b7eab9b0b55d41526a5abf9a0b4e104cf2114e6b8adf7c7807b92e848c7d73'

  depends_on 'xf86dgaproto'
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