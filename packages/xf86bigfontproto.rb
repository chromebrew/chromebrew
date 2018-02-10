require 'package'

class Xf86bigfontproto < Package
  description 'X.org XF86BigFont protocol headers'
  homepage 'http://www.x.org'
  version '1.2.0'
  source_url 'https://www.x.org/archive/individual/proto/xf86bigfontproto-1.2.0.tar.gz'
  source_sha256 'd190e6462b2bbbac6ee9a007fb8eccb9ad9f5f70544154f388266f031d4bbb23'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
