require 'package'

class Parted < Package
  description 'Create, destroy, resize, check, copy partitions and file systems. https://www.gnu.org/software/parted'
  homepage 'https://ftp.gnu.org/gnu/parted/'
  version '3.2'
  source_url 'https://ftp.gnu.org/gnu/parted/parted-3.2.tar.xz'
  source_sha256 '858b589c22297cacdf437f3baff6f04b333087521ab274f7ab677cb8c6bb78e4'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'lvm2'
  depends_on 'ncurses'
  depends_on 'readline'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
