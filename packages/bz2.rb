require 'package'

class Bz2 < Package
  description 'bzip2 is a freely available, patent free (see below), high-quality data compressor.'
  homepage 'http://www.bzip.org/'
  version '1.0.6'
  source_url 'http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz'
  source_sha256 'a2848f34fcd5d6cf47def00461fcb528a0484d8edef8208d6d2e2909dc61d9cd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7b41f602ad83ecf36b72907ed86d739daaf8d177625f31d9205f7788e0cc9b5d',
     armv7l: '7b41f602ad83ecf36b72907ed86d739daaf8d177625f31d9205f7788e0cc9b5d',
       i686: '39e8e5157a5b645c7af0b65f36d765ae16304781fbdcecde1f34f15eed798633',
     x86_64: '3808a7cba103b79efe35a7f131873b99d4253640715ab05b374db384272735eb',
  })

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
  end

  def self.check
    system "make", "test"
  end
end
