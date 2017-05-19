require 'package'

class Less < Package
  version '481'
  source_url 'ftp://ftp.gnu.org/gnu/less/less-481.tar.gz'
  source_sha1 '58e7e62a760a9ca3636349de8e3357f7102aea1d'
  binary_url ({
    armv7l: 'https://github.com/jam7/chromebrew/releases/download/binaries/less-481-chromeos-armv7l.tar.xz',
    i686:   'https://github.com/jam7/chromebrew/releases/download/binaries/less-481-chromeos-i686.tar.xz',
    x86_64: 'https://github.com/jam7/chromebrew/releases/download/binaries/less-481-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    armv7l: 'e1f25212f77cdfa68ebcad5184645933f0dc7362',
    i686:   '6773119761388c3b4e8d6ab94dee65588ade1304',
    x86_64: '6957825bd7e500b5eb65ae8dd9251d39a704105d',
  })

  depends_on 'buildessential'
  depends_on 'ncurses' 
  
  def self.build
    system "./configure"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end         
end
