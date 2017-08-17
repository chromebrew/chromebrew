require 'package'

class Cdrkit < Package
  description 'cdrkit is a suite of programs for recording CDs and DVDs, blanking CD-RW media, creating ISO-9660 filesystem images, extracting audio CD data, and more.'
  homepage 'https://launchpad.net/cdrkit'
  version '1.1.11'
  source_url 'https://downloads.sourceforge.net/project/wodim/cdrkit/cdrkit_1.1.11.orig.tar.gz'
  source_sha256 'd1c030756ecc182defee9fe885638c1785d35a2c2a297b4604c0e0dcc78e47da'

  depends_on 'cmake'
  depends_on 'libcap'

  def self.build
    system 'make clean'
    system 'make CFLAGS=-I/usr/local/include LDFLAGS=-L/usr/local/lib'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
