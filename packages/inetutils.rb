require 'package'

class Inetutils < Package
  description 'Inetutils - GNU network utilities is a collection of common network programs.'
  homepage 'https://www.gnu.org/software/inetutils/'
  version '1.9.4'
  source_url 'http://ftp.gnu.org/gnu/inetutils/inetutils-1.9.4.tar.gz'
  source_sha1 'defae98a27c0e9516c4ef2321a374a3645adb3b9'

  depends_on 'buildessential'
  
  def self.build
    system "./configure"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end         
end
