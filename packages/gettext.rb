require 'package'

class Gettext < Package
  version '0.19.8.1'
  source_url 'ftp://ftp.gnu.org/gnu/gettext/gettext-0.19.8.1.tar.xz'
  source_sha1 'e0fe90ede22f7f16bbde7bdea791a835f2773fc9'

  depends_on 'diffutils' => :build
  depends_on 'ncurses'
  depends_on 'libxml2'

  def self.build
    system "./configure", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
    system "find . -name '*.so.*' -print | xargs strip -S"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system "make", "check"
  end
end
