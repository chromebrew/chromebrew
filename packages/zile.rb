require 'package'

class Zile < Package
  description 'A small, fast, and powerful Emacs clone'
  homepage 'http://www.gnu.org/software/zile/'
  version '2.4.14'
  source_url 'https://ftp.gnu.org/gnu/zile/zile-2.4.14.tar.gz'
  source_sha256 '7a78742795ca32480f2bab697fd5e328618d9997d6f417cf1b14e9da9af26b74'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'acl'
  depends_on 'bdwgc'
  depends_on 'help2man' => :build
  depends_on 'ncurses'

  def self.build
    system "./configure",
	    "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses -I#{CREW_PREFIX}/include/ncursesw",
	    "--prefix=#{CREW_PREFIX}",
	    '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
