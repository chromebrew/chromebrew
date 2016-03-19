require 'package'

class Mpc < Package
  version '1.0.3'
  source_url 'http://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz'
  source_sha1 'b8be66396c726fdc36ebb0f692ed8a8cca3bcc66'
  
  def self.build
    system "./configure CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
