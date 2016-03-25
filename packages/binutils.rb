require 'package'

class Binutils < Package
  version '2.9.1'
  source_url 'http://ftp.gnu.org/gnu/binutils/binutils-2.9.1.tar.gz'
  source_sha1 '9df3cdcd34f81118ee403f8794b277ad28a57e14'
  
  def self.build
    system "./configure CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
  
end
