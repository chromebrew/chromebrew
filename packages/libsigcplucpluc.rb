require 'package'

class Libsigcplusplus < Package
  description 'http://libsigc.sourceforge.net/'
  homepage 'libsigc++ implements a typesafe callback system for standard C++.'
  version '2.10.0'
  source_url 'http://ftp.gnome.org/pub/GNOME/sources/libsigc++/2.10/libsigc++-2.10.0.tar.xz'
  source_sha256 'f843d6346260bfcb4426259e314512b99e296e8ca241d771d21ac64f28298d81'

  depends_on 'pkgconfig' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
