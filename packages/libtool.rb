require 'package'

class Libtool < Package
  version '2.4.6'
  source_url 'http://ftpmirror.gnu.org/libtool/libtool-2.4.6.tar.gz'
  source_sha1 '25b6931265230a06f0fc2146df64c04e5ae6ec33'

  depends_on 'buildessential'

  def self.build
      system "./configure"  #--libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
