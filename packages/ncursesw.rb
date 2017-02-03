require 'package'

class Ncursesw < Package
  version '6.0'
  source_url 'ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz'
  source_sha1 'acd606135a5124905da770803c05f1f20dd3b21c'

  depends_on "diffutils"

  def self.build
    system './configure ' \
	    'CFLAGS=" -fPIC" ' \
	    '--without-debug ' \
	    '--prefix=/usr/local ' \
	    '--with-shared ' \
	    '--with-cxx-shared ' \
	    '--enable-widec'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
