require 'package'

class Bz2 < Package
  description 'bzip2 is a freely available, patent free, high-quality data compressor.'
  homepage 'http://www.bzip.org/'
  version '1.0.6-1'
  source_url 'https://fossies.org/linux/misc/bzip2-1.0.6.tar.xz'
  source_sha256 '4bbea71ae30a0e5a8ddcee8da750bc978a479ba11e04498d082fa65c2f8c1ad5'

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
    system "make", "PREFIX=#{CREW_DEST_PREFIX}", "install"

    # Remove static library
    system "rm", "#{CREW_DEST_PREFIX}/lib/libbz2.a"

    # Install bzip2 using shared library by hand
    system "cp", "-p", "bzip2-shared", "bzip2"
    system "cp", "-p", "bzip2", "#{CREW_DEST_PREFIX}/bin/bzip2"
    system "ln", "-sf", "bzip2", "#{CREW_DEST_PREFIX}/bin/bunzip2"
    system "ln", "-sf", "bzip2", "#{CREW_DEST_PREFIX}/bin/bzcat"

    # Install shared library by hand
    system "mkdir", "-p", "#{CREW_DEST_LIB_PREFIX}"
    system "cp", "-p", "libbz2.so.1.0.6", "#{CREW_DEST_LIB_PREFIX}"
    system "ln", "-s", "libbz2.so.1.0.6", "#{CREW_DEST_LIB_PREFIX}/libbz2.so.1.0"
    system "ln", "-s", "libbz2.so.1.0", "#{CREW_DEST_LIB_PREFIX}/libbz2.so.1"
  end

  def self.check
    system "make", "test"
  end
end
