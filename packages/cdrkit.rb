require 'package'

class Cdrkit < Package
  description 'cdrkit is a suite of programs for recording CDs and DVDs, blanking CD-RW media, creating ISO-9660 filesystem images, extracting audio CD data, and more.'
  homepage 'https://launchpad.net/cdrkit'
  version '1.1.11'
  source_url 'https://downloads.sourceforge.net/project/wodim/cdrkit/cdrkit_1.1.11.orig.tar.gz'
  source_sha1 '3f7ddc06db0272942e1a4cd98c3c96462df77387'

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
