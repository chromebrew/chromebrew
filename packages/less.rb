require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '487-1'
  source_url 'http://www.greenwoodsoftware.com/less/less-487.tar.gz'
  source_sha256 'f3dc8455cb0b2b66e0c6b816c00197a71bf6d1787078adeee0bcf2aea4b12706'

  depends_on 'buildessential' => :build
  depends_on 'ncurses'
  depends_on 'pcre'

  def self.build
    system "./configure --with-regex=posix"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
