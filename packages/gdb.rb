require 'package'

class Gdb < Package
  description 'GDB, the GNU Project debugger, allows you to see what is going on \'inside\' another program while it executes -- or what another program was doing at the moment it crashed.'
  homepage 'https://www.gnu.org/software/gdb/'
  version '8.1'
  source_url 'https://ftpmirror.gnu.org/gdb/gdb-8.1.tar.xz'
  source_sha256 'af61a0263858e69c5dce51eab26662ff3d2ad9aa68da9583e8143b5426be4b34'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0487578f13f93e89ad87ec45a1468e057055465a83de7ee8a1cd27a4b467732b',
     armv7l: '0487578f13f93e89ad87ec45a1468e057055465a83de7ee8a1cd27a4b467732b',
       i686: 'e4078ff2566028ca81aa00ee3b47bfc4723fa8d75422fc80b463e8273844aef0',
     x86_64: '8e7f25bb702e9bdf3b1d657aee7cf79e6de0cfdcf6bb512159818c02e39e2593',
  })

  depends_on "ncurses"
  depends_on "texinfo"

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
