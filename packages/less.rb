require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '487'
  source_url 'http://www.greenwoodsoftware.com/less/less-487.tar.gz'
  source_sha1 '8a5c4be2a51f11543793defec7ccb77c525f007e'

  depends_on 'buildessential' => :build
  depends_on 'ncurses'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system "make", "check"
  end
end
