require 'package'

class Gcc < Package
  version '5.3.0'
  source_url 'http://ftp.gnu.org/gnu/gcc/gcc-5.3.0/gcc-5.3.0.tar.gz'
  source_sha1 '39ebff8a873181728b02db3689215557628eed9d'
  
  depends_on 'binutils'
  depends_on 'gmp'
  depends_on 'mpc'
  depends_on 'mpfr'
  depends_on 'glibc'

  def self.build
    system "./configure CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
