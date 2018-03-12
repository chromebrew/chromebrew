require 'package'

class Libiconv < Package
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.15'
  source_url 'https://mirror.ibcp.fr/pub/gnu/libiconv/libiconv-1.15.tar.gz'
  source_sha256 'ccf536620a45458d26ba83887a983b96827001e92a13847b45e4925cc8913178'
  
  depends_on 'glibc'
  depends_on 'manpages'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
