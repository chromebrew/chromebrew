require 'package'

class Xf86driproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.1.1'
  source_url 'https://www.x.org/archive/individual/proto/xf86driproto-2.1.1.tar.gz'
  source_sha256 '18ff8de129b89fa24a412a1ec1799f8687f96c186c655b44b1a714a3a5d15d6c'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
