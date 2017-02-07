require 'package'

class Bz2 < Package
  version '1.0.6'
  source_url 'http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz'
  source_sha1 '3f89f861209ce81a6bab1fd1998c0ef311712002'

  depends_on 'diffutils' => :build

  def self.build
    system "make -f Makefile-libbz2_so"
  end

  def self.install
    # bz2 Makefile doesn't have DESTDIR, so we need several tricks
    # to make it install files correctly.

    # Modify Makefile from "ln -s $(PREFIX)/bin/xxx $(PREFIX)/bin/yyy" to
    # "ln -s xxx $(PREFIX)/bin/yyy"
    system "sed", "-i", "Makefile", "-e", "/ln -s/s:$(PREFIX)/bin/::"

    # Use PREFIX instead of DESTDIR
    system "make", "PREFIX=#{CREW_DEST_DIR}/usr/local", "install"
  end

  def self.check
    system "make", "test"
  end
end
