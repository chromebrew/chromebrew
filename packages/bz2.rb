require 'package'

class Bz2 < Package
  description 'bzip2 is a freely available, patent free (see below), high-quality data compressor.'
  homepage 'http://www.bzip.org/'
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

    # Remove static library
    system "rm", "#{CREW_DEST_DIR}/usr/local/lib/libbz2.a"

    # Install bzip2 using shared library by hand
    system "cp", "-p", "bzip2-shared", "bzip2"
    system "cp", "-p", "bzip2", "#{CREW_DEST_DIR}/usr/local/bin/bzip2"
    system "ln", "-sf", "bzip2", "#{CREW_DEST_DIR}/usr/local/bin/bunzip2"
    system "ln", "-sf", "bzip2", "#{CREW_DEST_DIR}/usr/local/bin/bzcat"

    # Install shared library by hand
    system "mkdir", "-p", "#{CREW_DEST_DIR}#{CREW_LIB_PREFIX}"
    system "cp", "-p", "libbz2.so.1.0.6", "#{CREW_DEST_DIR}#{CREW_LIB_PREFIX}"
    system "ln", "-s", "libbz2.so.1.0.6", "#{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/libbz2.so.1.0"

    # Strip binaries and libraries
    system "strip #{CREW_DEST_DIR}/usr/local/bin/bzip2"
    system "strip #{CREW_DEST_DIR}/usr/local/bin/bzip2recover"
    system "strip -S #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/*"
  end

  def self.check
    system "make", "test"
  end
end
