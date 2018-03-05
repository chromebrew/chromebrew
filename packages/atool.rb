require 'package'

class Atool < Package
  description 'A script for managing file archives of various types. http://www.nongnu.org/atool/'
  homepage 'http://download.savannah.gnu.org/releases/atool/'
  version '0.39'
  source_url 'http://download.savannah.gnu.org/releases/atool/atool-0.39.0.tar.gz'
  source_sha256 'aaf60095884abb872e25f8e919a8a63d0dabaeca46faeba87d12812d6efc703b'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'perl'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
