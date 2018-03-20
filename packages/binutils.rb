require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools. http://www.gnu.org/software/binutils/'
  homepage 'https://ftp.gnu.org/gnu/binutils/'
  version '2.30'
  source_url 'https://ftp.gnu.org/gnu/binutils/binutils-2.30.tar.xz'
  source_sha256 '6e46b8aeae2f727a36f0bd9505e405768a72218f1796f0d09757d45209871ae6'

  depends_on 'zlibpkg'
  depends_on 'glib'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
