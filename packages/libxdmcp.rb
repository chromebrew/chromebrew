require 'package'

class Libxdmcp < Package
  description 'The libXdmcp package contains a library implementing the X Display Manager Control Protocol.'
  homepage 'http://www.x.org'
  version '1.1.2'
  source_url 'https://www.x.org/pub/individual/lib/libXdmcp-1.1.2.tar.bz2'
  source_sha256 '81fe09867918fff258296e1e1e159f0dc639cb30d201c53519f25ab73af4e4e2'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on "util_macros" => :build
  depends_on "xproto" => :build


  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
