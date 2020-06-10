require 'package'

class Parted < Package
  description 'Create, destroy, resize, check, copy partitions and file systems.'
  homepage 'https://www.gnu.org/software/parted'
  version '3.2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/parted/parted-3.2.tar.xz'
  source_sha256 '858b589c22297cacdf437f3baff6f04b333087521ab274f7ab677cb8c6bb78e4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/parted-3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/parted-3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/parted-3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/parted-3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ee5ebf4d5ad94c8845253b6ad79d7c295918ec02532aa39af6e35552d119863b',
     armv7l: 'ee5ebf4d5ad94c8845253b6ad79d7c295918ec02532aa39af6e35552d119863b',
       i686: '60127a02617336101f252388725f3dc472432f7e6bdbb6c8b97344ab051cf08d',
     x86_64: 'c5972a1b389e4a9454a6e6ea0e4eb2d30f5f294131d3bb97ccaff523fdbe08f9',
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
